//
//  TDUUID.swift
//  TDBasis
//
//  Created by Fench on 2025/6/19.
//

import Foundation
import Security

import Foundation
import UIKit
import Security
import CloudKit

public class TDUUID {
    
    // MARK: - Constants
    
    public static let uuidsOfUserDevicesDidChangeNotification = Notification.Name("FCUUIDsOfUserDevicesDidChangeNotification")
    
    private let uuidForInstallationKey = "fc_uuidForInstallation"
    private let uuidForDeviceKey = "fc_uuidForDevice"
    private let uuidsOfUserDevicesKey = "fc_uuidsOfUserDevices"
    private let uuidsOfUserDevicesToggleKey = "fc_uuidsOfUserDevicesToggle"
    private let uuidServiceKey = "com.topdon.uuid.service"
    
    // MARK: - Singleton
    
    public static let shared = TDUUID()
    
    // MARK: - Properties
    
    private var _uuidForKey: [AnyHashable: String] = [:]
    private var _uuidForSession: String?
    private var _uuidForInstallation: String?
    private var _uuidForVendor: String?
    private var _uuidForDevice: String?
    private var _uuidsOfUserDevices: String?
    private var _uuidsOfUserDevices_iCloudAvailable = false
    
    // MARK: - Initialization
    
    private init() {
        uuidsOfUserDevices_iCloudInit()
    }
    
    // MARK: - UUID Generation
    
    public func uuid() -> String {
        let uuid = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        return uuid
    }
    
    public func uuid(forKey key: AnyHashable) -> String {
        if let existingUUID = _uuidForKey[key] {
            return existingUUID
        }
        
        let newUUID = uuid()
        _uuidForKey[key] = newUUID
        return newUUID
    }
    
    public func uuidForSession() -> String {
        if _uuidForSession == nil {
            _uuidForSession = uuid()
        }
        return _uuidForSession!
    }
    
    // MARK: - Installation UUID
    
    public func uuidForInstallation() -> String {
        if _uuidForInstallation == nil {
            _uuidForInstallation = getOrCreateValue(forKey: uuidForInstallationKey,
                                                    defaultValue: nil,
                                                    userDefaults: true,
                                                    keychain: false,
                                                    service: nil,
                                                    accessGroup: nil,
                                                    synchronizable: false)
        }
        return _uuidForInstallation!
    }
    
    // MARK: - Vendor UUID
    
    public func uuidForVendor() -> String {
        if _uuidForVendor == nil {
            _uuidForVendor = UIDevice.current.identifierForVendor?.uuidString.lowercased().replacingOccurrences(of: "-", with: "") ?? ""
        }
        return _uuidForVendor!
    }
    
    // MARK: - Device UUID
    
    private func uuidForDevice_update(with value: String) {
        _uuidForDevice = value
        setValue(value,
                forKey: uuidForDeviceKey,
                userDefaults: true,
                keychain: true,
                service: uuidServiceKey,
                 accessGroup: TDGlobalKey.kGroupId,
                synchronizable: false)
    }
    
    public func uuidForDevice() -> String {
        if _uuidForDevice == nil {
            _uuidForDevice = getOrCreateValue(forKey: uuidForDeviceKey,
                                              defaultValue: nil,
                                              userDefaults: true,
                                              keychain: true,
                                              service: uuidServiceKey,
                                              accessGroup: TDGlobalKey.kGroupId,
                                              synchronizable: false)
        }
        return _uuidForDevice!
    }
    
    public func uuidForDevice(migratingValue value: String, commitMigration: Bool) -> String? {
        guard uuidValueIsValid(value) else {
            fatalError("Invalid uuid to migrate: uuid value should be a string of 32 or 36 characters.")
        }
        
        let oldValue = uuidForDevice()
        let newValue = value
        
        if oldValue == newValue {
            return oldValue
        }
        
        if commitMigration {
            uuidForDevice_update(with: newValue)
            
            var uuidsOfUserDevicesSet = OrderedSet(uuidsOfUserDevices())
            uuidsOfUserDevicesSet.append(newValue)
            uuidsOfUserDevicesSet.remove(oldValue)
            
            uuidsOfUserDevices_update(with: Array(uuidsOfUserDevicesSet))
            uuidsOfUserDevices_iCloudSync()
            
            return uuidForDevice()
        } else {
            return oldValue
        }
    }
    
    public func uuidForDevice(migratingValueForKey key: String, service: String? = nil, accessGroup: String? = nil, commitMigration: Bool) -> String? {
        let uuidToMigrate = getValue(forKey: key,
                                    userDefaults: true,
                                    keychain: true,
                                    service: service,
                                    accessGroup: accessGroup)
        return uuidForDevice(migratingValue: uuidToMigrate ?? "", commitMigration: commitMigration)
    }
    
    // MARK: - User Devices Management
    
    private func uuidsOfUserDevices_iCloudInit() {
        _uuidsOfUserDevices_iCloudAvailable = false
        
        let iCloud = NSUbiquitousKeyValueStore.default
        
        _uuidsOfUserDevices_iCloudAvailable = true
        
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(uuidsOfUserDevices_iCloudChange(_:)),
                                             name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
                                             object: nil)
        
        uuidsOfUserDevices_iCloudSync()
    }
    
    @objc private func uuidsOfUserDevices_iCloudChange(_ notification: Notification) {
        guard _uuidsOfUserDevices_iCloudAvailable else { return }
        
        var uuidsSet = OrderedSet(uuidsOfUserDevices())
        let uuidsCount = uuidsSet.count
        
        let iCloud = NSUbiquitousKeyValueStore.default
        let iCloudDict = iCloud.dictionaryRepresentation
        
        for (key, value) in iCloudDict {
            guard let uuidKey = key as? String,
                  uuidKey.hasPrefix(uuidForDeviceKey),
                  let uuidValue = value as? String,
                  uuidKey.contains(uuidValue),
                  uuidValueIsValid(uuidValue) else {
                continue
            }
            
            uuidsSet.append(uuidValue)
        }
        
        if uuidsSet.count > uuidsCount {
            uuidsOfUserDevices_update(with: Array(uuidsSet))
            
            let userInfo: [String: Any] = ["uuidsOfUserDevices": uuidsOfUserDevices()]
            NotificationCenter.default.post(name: TDUUID.uuidsOfUserDevicesDidChangeNotification,
                                          object: self,
                                          userInfo: userInfo)
        }
    }
    
    private func uuidsOfUserDevices_iCloudSync() {
        guard _uuidsOfUserDevices_iCloudAvailable else { return }
        
        let iCloud = NSUbiquitousKeyValueStore.default
        
        for uuidOfUserDevice in uuidsOfUserDevices() {
            let uuidOfUserDeviceAsKey = "\(uuidForDeviceKey)_\(uuidOfUserDevice)"
            
            if iCloud.string(forKey: uuidOfUserDeviceAsKey) != uuidOfUserDevice {
                iCloud.set(uuidOfUserDevice, forKey: uuidOfUserDeviceAsKey)
            }
        }
        
        iCloud.set(!iCloud.bool(forKey: uuidsOfUserDevicesToggleKey), forKey: uuidsOfUserDevicesToggleKey)
        iCloud.synchronize()
    }
    
    private func uuidsOfUserDevices_update(with value: [String]) {
        _uuidsOfUserDevices = value.joined(separator: "|")
        setValue(_uuidsOfUserDevices,
                forKey: uuidsOfUserDevicesKey,
                userDefaults: true,
                keychain: true,
                service: nil,
                accessGroup: nil,
                synchronizable: true)
    }
    
    public func uuidsOfUserDevices() -> [String] {
        if _uuidsOfUserDevices == nil {
            _uuidsOfUserDevices = getOrCreateValue(forKey: uuidsOfUserDevicesKey,
                                                 defaultValue: uuidForDevice(),
                                                 userDefaults: true,
                                                 keychain: true,
                                                 service: nil,
                                                 accessGroup: nil,
                                                 synchronizable: true)
        }
        return _uuidsOfUserDevices?.components(separatedBy: "|") ?? []
    }
    
    public func uuidsOfUserDevicesExcludingCurrentDevice() -> [String] {
        var uuids = uuidsOfUserDevices()
        if let index = uuids.firstIndex(of: uuidForDevice()) {
            uuids.remove(at: index)
        }
        return uuids
    }
    
    // MARK: - Validation
    
    public func uuidValueIsValid(_ uuidValue: String?) -> Bool {
        guard let uuidValue = uuidValue else { return false }
        
        let uuidPattern = "^[0-9a-f]{32}|[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$"
        let regex = try? NSRegularExpression(pattern: uuidPattern, options: .caseInsensitive)
        
        let range = NSRange(location: 0, length: uuidValue.utf16.count)
        if let matchRange = regex?.rangeOfFirstMatch(in: uuidValue, options: [], range: range),
           matchRange.location != NSNotFound {
            return uuidValue == (uuidValue as NSString).substring(with: matchRange)
        }
        
        return false
    }
    
    // MARK: - Storage Helpers
    
    private func getOrCreateValue(forKey key: String,
                                defaultValue: String?,
                                userDefaults: Bool,
                                keychain: Bool,
                                service: String?,
                                accessGroup: String?,
                                synchronizable: Bool) -> String {
        var value = getValue(forKey: key,
                           userDefaults: userDefaults,
                           keychain: keychain,
                           service: service,
                           accessGroup: accessGroup)
        
        if value == nil {
            value = defaultValue ?? uuid()
        }
        
        setValue(value,
                forKey: key,
                userDefaults: userDefaults,
                keychain: keychain,
                service: service,
                accessGroup: accessGroup,
                synchronizable: synchronizable)
        
        return value!
    }
    
    private func getValue(forKey key: String,
                         userDefaults: Bool,
                         keychain: Bool,
                         service: String?,
                         accessGroup: String?) -> String? {
        if keychain {
            var query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecReturnData as String: kCFBooleanTrue!,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]
            
            if let service = service {
                query[kSecAttrService as String] = service
            }
            
            if let accessGroup = accessGroup {
                query[kSecAttrAccessGroup as String] = accessGroup
            }
            
            var dataTypeRef: AnyObject?
            let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
            
            if status == errSecSuccess, let data = dataTypeRef as? Data, let value = String(data: data, encoding: .utf8) {
                return value
            }
        }
        
        if userDefaults {
            return UserDefaults.standard.string(forKey: key)
        }
        
        return nil
    }
    
    private func setValue(_ value: String?,
                         forKey key: String,
                         userDefaults: Bool,
                         keychain: Bool,
                         service: String?,
                         accessGroup: String?,
                         synchronizable: Bool) {
        guard let value = value else { return }
        
        if userDefaults {
            UserDefaults.standard.set(value, forKey: key)
            UserDefaults.standard.synchronize()
        }
        
        if keychain {
            var query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: value.data(using: .utf8)!,
                kSecAttrSynchronizable as String: synchronizable ? kCFBooleanTrue! : kCFBooleanFalse!
            ]
            
            if let service = service {
                query[kSecAttrService as String] = service
            }
            
            if let accessGroup = accessGroup {
                query[kSecAttrAccessGroup as String] = accessGroup
            }
            
            // First try to update existing item
            var status = SecItemUpdate(query as CFDictionary,
                                       [kSecValueData as String: value.data(using: .utf8)!] as CFDictionary)
            
            // If item doesn't exist, add it
            if status == errSecItemNotFound {
                status = SecItemAdd(query as CFDictionary, nil)
            }
            
            if status != errSecSuccess {
                print("Error saving to keychain: \(status)")
            }
        }
    }
}

// Helper ordered set implementation
private struct OrderedSet<Element: Hashable> {
    private var array: [Element]
    private var set: Set<Element>
    
    init(_ elements: [Element] = []) {
        self.array = []
        self.set = Set()
        for element in elements {
            append(element)
        }
    }
    
    var count: Int { return array.count }
    
    mutating func append(_ element: Element) {
        if !set.contains(element) {
            array.append(element)
            set.insert(element)
        }
    }
    
    mutating func remove(_ element: Element) {
        if let index = array.firstIndex(of: element) {
            array.remove(at: index)
            set.remove(element)
        }
    }
    
    func contains(_ element: Element) -> Bool {
        return set.contains(element)
    }
    
    func toArray() -> [Element] {
        return array
    }
}

extension OrderedSet: Collection {
    typealias Index = Int
    
    var startIndex: Index { return array.startIndex }
    var endIndex: Index { return array.endIndex }
    
    subscript(index: Index) -> Element {
        return array[index]
    }
    
    func index(after i: Index) -> Index {
        return array.index(after: i)
    }
}


extension UIDevice {
    private static let uuidQueue = DispatchQueue(
        label: "com.topdon.deviceID.queue",
        qos: .userInitiated,
        attributes: .concurrent
    )
    
    private static var _cachedDeviceID: String?
    private static var _isLoading = false
    
    public var deviceId: String { Self.deviceId }
    
    /// 线程安全的设备ID获取
    public static var deviceId: String {
        // 快速通道：已有缓存
        if let cachedID = uuidQueue.sync(execute: { _cachedDeviceID }) {
            return cachedID
        }
        
        // 使用信号量控制并发初始化
        let semaphore = DispatchSemaphore(value: 0)
        var resultID = ""
        
        uuidQueue.async(flags: .barrier) {
            // 双重检查
            if let existingID = _cachedDeviceID {
                resultID = existingID
                semaphore.signal()
                return
            }
            
            // 防止重复初始化
            guard !_isLoading else {
                semaphore.signal()
                return
            }
            
            _isLoading = true
            
            // Keychain操作
            var deviceID = TDUUID.shared.uuidForDevice()
            
            // 验证有效性
            if deviceID.isEmpty || !TDUUID.shared.uuidValueIsValid(deviceID) {
                deviceID = generateFallbackUUID()
            }
            
            // 更新缓存
            _cachedDeviceID = deviceID
            resultID = deviceID
            _isLoading = false
            
            semaphore.signal()
        }
        
        semaphore.wait()
        return resultID.td.default(with: generateFallbackUUID())
    }
    
    // 内部生成备用ID的方法
    private static func generateFallbackUUID() -> String {
        if let vendorID = UIDevice.current.identifierForVendor?.uuidString {
            return vendorID
                .lowercased()
                .replacingOccurrences(of: "-", with: "")
        }
        return TDUUID.shared.uuid()
    }
}
