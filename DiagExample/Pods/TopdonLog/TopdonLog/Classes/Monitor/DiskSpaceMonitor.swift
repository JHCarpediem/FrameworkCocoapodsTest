//
//  DiskSpaceMonitor.swift
//  TopdonLog
//
//  Created by xinwenliu on 2024/6/17.
//

import Foundation

final internal class DiskSpaceMonitor {
    
    private var timer: DispatchSourceTimer?
    private let timeInterval: TimeInterval
    private let threshold: Int64
    private var overflowBlock: ((Bool) -> Void)?
    
    init(timeInterval: TimeInterval = 10.0, threshold: Int64 = 500 * 1000 * 1000, overflowBlock: ((Bool) -> Void)?) {
        self.timeInterval = timeInterval
        self.threshold = threshold
        self.overflowBlock = overflowBlock
        startMonitoring()
    }
    
    private func startMonitoring() {
        let queue = DispatchQueue.global(qos: .background)
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.schedule(deadline: .now(), repeating: timeInterval)
        timer?.setEventHandler { [weak self] in
            self?.checkDiskSpace()
        }
        timer?.resume()
    }
    
    private func freeDiskSpace() -> UInt64 {
        func getFreeSize() -> UInt64 {
            let freeSize: UInt64 = 0
            if let dict = try? FileManager.default.attributesOfFileSystem(forPath: AppFile.documentPath), let free = dict[.systemFreeSize] as? UInt64 {
                return free
            }
            return freeSize
        }
                 
        if #available(iOS 11.0, *) {
            let fileUrl = URL(fileURLWithPath: NSTemporaryDirectory())
            do {
                let attribute = try fileUrl.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
                if let totalSize = attribute.volumeAvailableCapacityForImportantUsage {
                    return UInt64(totalSize)
                }
            } catch {
                innerLogger("获取磁盘空间失败\(error)")
            }
        }
        
        return getFreeSize()
    }
    
    private func checkDiskSpace() {
        /*
        let fileManager = FileManager.default
        if let attributes = try? fileManager.attributesOfFileSystem(forPath: NSHomeDirectory()),
           let freeSpace = attributes[.systemFreeSize] as? Int64 {
            let isOverflow = freeSpace < threshold
            DispatchQueue.main.async {
                self.overflowBlock?(isOverflow)
            }
        }
         */
        
        let freeSpace = self.freeDiskSpace()
        let isOverflow = freeSpace < threshold
        DispatchQueue.main.async {
            self.overflowBlock?(isOverflow)
        }
    }
    
    deinit {
        timer?.cancel()
        timer = nil
    }
    
}

