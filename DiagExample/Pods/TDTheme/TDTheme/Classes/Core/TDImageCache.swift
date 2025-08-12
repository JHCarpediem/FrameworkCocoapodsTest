//
//  TDImageCache.swift
//  TDTheme
//
//  Created by fench on 2023/7/17.
//

import UIKit

// MARK: ImageCache

public protocol TDImageCacheProtocol {
    /// 将图片加入到缓存中
    func add(_ image: UIImage, withIdentifier identifier: String)

    /// 从缓存中移除图片
    func removeImage(withIdentifier identifier: String) -> Bool

    /// 从缓存中移除所有图片
    @discardableResult
    func removeAllImages() -> Bool

    /// 获取图片
    func image(withIdentifier identifier: String) -> UIImage?
}


// MARK: -

open class TDImageCace: TDImageCacheProtocol {
    class CachedImage {
        let image: UIImage
        let identifier: String
        let totalBytes: UInt64
        var lastAccessDate: Date

        init(_ image: UIImage, identifier: String) {
            self.image = image
            self.identifier = identifier
            lastAccessDate = Date()

            totalBytes = {
                #if os(iOS) || os(tvOS) || os(watchOS)
                let size = CGSize(width: image.size.width * image.scale, height: image.size.height * image.scale)
                #elseif os(macOS)
                let size = CGSize(width: image.size.width, height: image.size.height)
                #endif

                let bytesPerPixel: CGFloat = 4.0
                let bytesPerRow = size.width * bytesPerPixel
                let totalBytes = UInt64(bytesPerRow) * UInt64(size.height)

                return totalBytes
            }()
        }

        func accessImage() -> UIImage {
            lastAccessDate = Date()
            return image
        }
    }

    // MARK: Properties

    /// 当前已使用的内存大小
    open var memoryUsage: UInt64 {
        var memoryUsage: UInt64 = 0
        synchronizationQueue.sync(flags: [.barrier]) { memoryUsage = self.currentMemoryUsage }

        return memoryUsage
    }
    
    public static var shared: TDImageCace = TDImageCace()

    /// 总内存大小
    public let memoryCapacity: UInt64

    /// 清除后的首选内存使用情况(以字节为单位)。
    public let preferredMemoryUsageAfterPurge: UInt64

    private let synchronizationQueue: DispatchQueue
    private var cachedImages: [String: CachedImage]
    private var currentMemoryUsage: UInt64

    // MARK: Initialization

    /// 初始化  `AutoPurgingImageCache` 给定的内存容量和清除限制后的首选内存使用情况
    ///
    /// 请注意，清除后的内存容量必须始终大于或等于首选内存使用量。
    ///
    /// - parameter memoryCapacity:                 内存大小 默认`100 MB`
    /// - parameter preferredMemoryUsageAfterPurge: 清除后的首选内存使用情况(以字节为单位)。默认 `60 MB`
    ///
    /// - returns: The new `AutoPurgingImageCache` instance.
    public init(memoryCapacity: UInt64 = 100_000_000, preferredMemoryUsageAfterPurge: UInt64 = 60_000_000) {
        self.memoryCapacity = memoryCapacity
        self.preferredMemoryUsageAfterPurge = preferredMemoryUsageAfterPurge

        precondition(memoryCapacity >= preferredMemoryUsageAfterPurge,
                     "The `memoryCapacity` must be greater than or equal to `preferredMemoryUsageAfterPurge`")

        cachedImages = [:]
        currentMemoryUsage = 0

        synchronizationQueue = {
            let name = String(format: "org.alamofire.autopurgingimagecache-%08x%08x", arc4random(), arc4random())
            return DispatchQueue(label: name, attributes: .concurrent)
        }()

        #if os(iOS) || os(tvOS)
        let notification = UIApplication.didReceiveMemoryWarningNotification

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(TDImageCace.removeAllImages),
                                               name: notification,
                                               object: nil)
        #endif
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: 将图片加入到缓存中
    
    /// 将图片加入到内存缓存中
    ///
    /// - parameter image:      需要加入缓存的图片
    /// - parameter identifier: 内存缓存的ID
    open func add(_ image: UIImage, withIdentifier identifier: String) {
        synchronizationQueue.async(flags: [.barrier]) {
            let cachedImage = CachedImage(image, identifier: identifier)

            if let previousCachedImage = self.cachedImages[identifier] {
                self.currentMemoryUsage -= previousCachedImage.totalBytes
            }

            self.cachedImages[identifier] = cachedImage
            self.currentMemoryUsage += cachedImage.totalBytes
        }

        synchronizationQueue.async(flags: [.barrier]) {
            if self.currentMemoryUsage > self.memoryCapacity {
                let bytesToPurge = self.currentMemoryUsage - self.preferredMemoryUsageAfterPurge

                var sortedImages = self.cachedImages.map { $1 }

                sortedImages.sort {
                    let date1 = $0.lastAccessDate
                    let date2 = $1.lastAccessDate

                    return date1.timeIntervalSince(date2) < 0.0
                }

                var bytesPurged = UInt64(0)

                for cachedImage in sortedImages {
                    self.cachedImages.removeValue(forKey: cachedImage.identifier)
                    bytesPurged += cachedImage.totalBytes

                    if bytesPurged >= bytesToPurge {
                        break
                    }
                }

                self.currentMemoryUsage -= bytesPurged
            }
        }
    }

    // MARK: 从内存缓存中移除图片

    /// 根据ID移除缓存中的图片
    ///
    /// - parameter identifier: 图片的ID
    ///
    /// - returns: 移除成功返回`true` 如果缓存中不存在该ID的图片 返回`false`
    @discardableResult
    open func removeImage(withIdentifier identifier: String) -> Bool {
        var removed = false

        synchronizationQueue.sync(flags: [.barrier]) {
            if let cachedImage = self.cachedImages.removeValue(forKey: identifier) {
                self.currentMemoryUsage -= cachedImage.totalBytes
                removed = true
            }
        }

        return removed
    }

    /// 移除所有缓存的图片
    ///
    /// - returns: 移除成功返回`true`否则返回`false`
    @discardableResult @objc
    open func removeAllImages() -> Bool {
        var removed = false

        synchronizationQueue.sync(flags: [.barrier]) {
            if !self.cachedImages.isEmpty {
                self.cachedImages.removeAll()
                self.currentMemoryUsage = 0

                removed = true
            }
        }

        return removed
    }

    // MARK: 从缓存中获取图片


    /// 根据缓存的ID获取图片
    ///
    /// - parameter identifier: 图片ID
    ///
    /// - returns: The image if it is stored in the cache, `nil` otherwise.
    open func image(withIdentifier identifier: String) -> UIImage? {
        var image: UIImage?

        synchronizationQueue.sync(flags: [.barrier]) {
            if let cachedImage = self.cachedImages[identifier] {
                image = cachedImage.accessImage()
            }
        }

        return image
    }

}
