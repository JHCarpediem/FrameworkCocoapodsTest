//
//  TDGlobalKey.swift
//  TDNetwork
//
//  Created by fench on 2023/7/12.
//

import UIKit

@objc(TDBasisInfo)
public class BasisInfo: NSObject {
    /// 获取 basis 版本号
    @objc public static var currentVersion: String { "5.00.022" }
    
    /// V4.40 新增接口 初始化需要传入 App 软件编码 用于登录隔离
    @objc public static var softCode: String = ""
    
    
    private static var _userDBSoftCode: String?
    /// 用户模型数据库中存入的 软件编码 不传默认取 softCode 如果是 TopScan / Topscan-VAG 这个字段传同一个值
    @objc public static var userDBSoftCode: String {
        get {
            guard let _userDBSoftCode = _userDBSoftCode, !_userDBSoftCode.isEmpty else {
                self._userDBSoftCode = softCode
                return softCode
            }
            return _userDBSoftCode
        }
        set {
            _userDBSoftCode = newValue
        }
    }
    
    /// 初始化方法，接入日志库 V1.20.025 版本之后的版本 必须初始化此方法
    /// 此方法必须在 AppDelegate didFinishLaunch *最前面* 初始化
    @objc public static func setup(softCode: String, groupId: String) {
        Self.softCode = softCode
        TDGlobalKey.kGroupId = groupId
    }
}

//MARK: - block 自定义
public struct Block {
    public typealias VoidBlock = () -> Void
    public typealias ParameterBlock<ParameterType> = (ParameterType) -> Void
    public typealias ReturnBlock<ReturnType> = () -> ReturnType
    public typealias MutiParameterBlock<Type1, Type2> = (Type1, Type2) -> Void
}

//MARK: - UI 全局宏
public struct UI {
    public static let SCREEN_BOUNDS = UIScreen.main.bounds
//    public static let SCREEN_WIDTH = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
//    public static let SCREEN_HEIGHT = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    
    public static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    public static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

    public static let IS_IPHONE_6_OR_Less = SCREEN_MAX_LENGTH <= 667.0
    public static let SCREEN_MAX_LENGTH  = max(SCREEN_WIDTH, SCREEN_HEIGHT)
    public static let IS_IPHONE_4_OR_LESS = SCREEN_MAX_LENGTH < 568.0
    public static let IS_IPHONE_5 = SCREEN_MAX_LENGTH == 568.0
    public static let IS_IPHONE_6 = SCREEN_MAX_LENGTH == 667.0
    public static let IS_IPHONE_6P = SCREEN_MAX_LENGTH == 736.0
    public static let IS_IPHONE_X = SCREEN_MAX_LENGTH == 812.0
    public static let IS_IPHONE_Xr = SCREEN_MAX_LENGTH == 896.0
    public static let IS_IPHONE_Xs_Max = SCREEN_MAX_LENGTH == 896.0
    
    public static let IS_IPhoneXAll = SCREEN_MAX_LENGTH >= 812.0
    
    public static var STATUS_NAV_BAR_HEIGHT:CGFloat { return STATUSBAR_HEIGHT + 44.0}
    public static let TABBAR_HEIGHT:CGFloat = IS_IPhoneXAll == true ? 83.0 : 49.0
    public static var BOTTOM_HEIGHT:CGFloat {
        if #available(iOS 11.0, *) {
            return UI.keyWindow?.safeAreaInsets.bottom ?? 0.0
        } else {
            return IS_IPhoneXAll == true ? 34.0 : 0.0
        }
    }
    private static var _statusBarHeight: CGFloat?
    public static var STATUSBAR_HEIGHT:CGFloat {
        if let _statusBarHeight = _statusBarHeight , _statusBarHeight != 0{
            return _statusBarHeight
        }
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let statusBarManager = windowScene.statusBarManager else { return 0 }
            statusBarHeight = statusBarManager.statusBarFrame.height
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        _statusBarHeight = statusBarHeight
        return statusBarHeight
    }
    
    public static var widthScale: CGFloat {
        let base = 375.0
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let width = min(screenWidth, screenHeight)
        return width / base
    }
    
    public static var heightScale: CGFloat {
        let base = 667.0
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let height = max(screenWidth, screenHeight)
        return height / base
    }
    
    public static var heightScale812: CGFloat {
        let base = 812.0
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let height = max(screenWidth, screenHeight)
        return height / base
    }
    
    private static func topViewController(with topRootViewController: UIViewController?) -> UIViewController? {
        if topRootViewController == nil {
            return nil
        }
        
        if topRootViewController?.presentedViewController != nil {
            return self.topViewController(with:topRootViewController?.presentedViewController!)
        }
        else if topRootViewController is UITabBarController {
            return self.topViewController(with:(topRootViewController as! UITabBarController).selectedViewController)
        }
        else if topRootViewController is UINavigationController {
            return self.topViewController(with:(topRootViewController as! UINavigationController).visibleViewController)
        }
        else {
            return topRootViewController
        }
        
    }
    
    // MARK: - 获取当前屏幕显示的viewcontroller
    public static var topViewController: UIViewController? {
        var window = UIApplication.shared.keyWindow
        //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
        if window == nil {
            return nil
        }
        if window!.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for tmpWin: UIWindow in windows {
                if tmpWin.windowLevel == UIWindow.Level.normal {
                    window = tmpWin
                }
            }
        }
        
        return self.topViewController(with: window?.rootViewController)
    }
    
    public static var keyWindow: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    public static var resolution: String {
        let scale = UIScreen.main.scale
        return "\(Int(SCREEN_WIDTH * scale))x\(Int(SCREEN_HEIGHT * scale))"
    }
    
    public static var phoneSize: CGFloat {
        let scale = UIScreen.main.scale
        let ppi = scale * (UIDevice.current.userInterfaceIdiom == .pad ? 132 : 163)
        let width = UI.SCREEN_WIDTH * scale
        let height = UI.SCREEN_HEIGHT * scale
        let horizotal = width / ppi
        let vertical = height / ppi
        return sqrt(pow(horizotal, 2) + pow(vertical, 2))
    }
}

extension UI {
    public struct HD {
        public static var horizontalScale: CGFloat {
            let orientation = UIApplication.shared.statusBarOrientation
            let base = orientation.isLandscape ? 1024.0 : 768.0
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            let deviceLength = orientation.isLandscape ? max(screenWidth, screenHeight) : min(screenHeight, screenWidth)
            return deviceLength / base
        }
        
        public static var verticalScale: CGFloat {
            let orientation = UIApplication.shared.statusBarOrientation
            let base = !orientation.isLandscape ? 1024.0 : 768.0
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            let deviceLength = !orientation.isLandscape ? max(screenWidth, screenHeight) : min(screenHeight, screenWidth)
            return deviceLength / base
        }
    }
}

//MARK: - 沙盒目录
public struct Sandbox {
    /// 沙盒文档目录
    public static let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? ""
    /// 沙盒缓存目录
    public static let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last ?? ""
    /// 沙盒临时目录
    public static let tmpPath = NSTemporaryDirectory()
    /// 偏好设置文件目录
    public static let preferencePath = NSSearchPathForDirectoriesInDomains(.preferencePanesDirectory, .userDomainMask, true).last
    /// 沙盒主目录
    public static let homePath = NSHomeDirectory()
    
    /// 在缓存目录中创建 子目录
    public static func cache(with subPath: String, createDir: Bool = false) -> String {
        getPath(mainPath: cachePath, subPath: subPath, creatDir: createDir)
    }
    
    /// 根据子目录获取文档目录
    public static func document(with subPath: String, createDir: Bool = false) -> String {
        getPath(mainPath: documentPath, subPath: subPath, creatDir: createDir)
    }
    
    /// 根据子目录获取临时文件目录
    public static func tmp(with subPath: String, createDir: Bool = false) -> String {
        getPath(mainPath: tmpPath, subPath: subPath, creatDir: createDir)
    }
    
    public static func getPath(mainPath: String, subPath: String, creatDir: Bool = false) -> String {
        let path = (mainPath as NSString).appendingPathComponent(subPath)
        if creatDir {
            var isDir = ObjCBool(booleanLiteral: false)
            let _ = FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
            if !isDir.boolValue {
                try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
            }
            
        }
        return path
    }
}

//MARK: - APP info
public struct AppInfo {
    
    /// 获取App的版本号
    public static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
    /// 获取App的build 版本号
    public static let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

    /// app名称
    public static let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
    
    public static let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as! String
    
    /// 当前regionCode
    public static let regionCode = Locale.current.regionCode ?? "cn"
    
    /// 当前设备的设备名
    public static let deviceName = UIDevice.deviceMode
    
    /// 当前设备的语言
    public static let languageCode = Locale.current.languageCode ?? "zh"
    
    public static let bundleId = Bundle.main.bundleIdentifier ?? ""
    
    public static var serviceDelta: TimeInterval?
    
    public static var serviceTimestamp: TimeInterval {
        var reslut = Date().timeIntervalSince1970
        if let serviceDelta = serviceDelta {
            let cpuDate = Date(timeIntervalSince1970: systemUpTime)
            let realCurDate = cpuDate.addingTimeInterval(-serviceDelta)
            let realCurTime = realCurDate.timeIntervalSince1970
            reslut = realCurTime
        }
        return reslut
    }
    
    /// 获取一个本地时间与本机重启时间的差值
    static var systemUpTime: TimeInterval {
        var bootTime = timeval()
        var mib = [CTL_KERN, KERN_BOOTTIME]
        var size: Int = MemoryLayout<timeval>.size
        let result = sysctl(&mib, 2, &bootTime, &size, nil, 0)
        
        var now = timeval()
        var tz = timezone()
        
        gettimeofday(&now, &tz)
        
        var uptime = -1
        if result != -1 , bootTime.tv_sec != 0 {
            uptime = now.tv_sec - bootTime.tv_sec
        }
        
        return TimeInterval(uptime)
    }
    
    /// 服务器时间 格式化之后的 string `yyyy-MM-dd HH:mm:ss`
    public static var serviceTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date(timeIntervalSince1970: serviceTimestamp))
    }
}

//MARK: - 全局key 
public struct TDGlobalKey {
    
    public static var kGroupId = "group.topdon.apps"
    
    public static let kUserId = "kUserID"
    
    public static let kTopdonId = "kTopdonId"
    
    public static let kRememberPwd = "kRememberPassWord"
    
    public static let kRememberEmail = "kRememberEmail"
    
    public static let kSecret = "thanks,lenkor123"
    
    public static let kSecretLocal = "hkr123hkr123,^&*"
    
    public static let kUpdateTokenTime = "kLastUpdatedTokenTime"
    
    public static let kSavedAvatarData = "kFaceImage"
    
    public static let kSavedAvatarUrl = "kFaceID"
    
    public static let kCustomServeUrl = "kUserCustomURL"
    
    public static let kCurrentEnvironment = "kCurrentEnvironment"
    
    public static let kCurrentLanguage = "AppleLMSHLanguages"
    
    public static let kSavedAppleUid = "kSavedAppleUid"
}

public enum iPhoneModel : String {
    
    //Simulator
    case simulator     = "simulator/sandbox",
         //iPhone
         iPhone4            = "iPhone 4",
         iPhone4S           = "iPhone 4S",
         iPhone5            = "iPhone 5",
         iPhone5S           = "iPhone 5S",
         iPhone5C           = "iPhone 5C",
         iPhone6            = "iPhone 6",
         iPhone6Plus        = "iPhone 6 Plus",
         iPhone6S           = "iPhone 6S",
         iPhone6SPlus       = "iPhone 6S Plus",
         iPhoneSE           = "iPhone SE",
         iPhone7            = "iPhone 7",
         iPhone7Plus        = "iPhone 7 Plus",
         iPhone8            = "iPhone 8",
         iPhone8Plus        = "iPhone 8 Plus",
         iPhoneX            = "iPhone X",
         iPhoneXS           = "iPhone XS",
         iPhoneXSMax        = "iPhone XS Max",
         iPhoneXR           = "iPhone XR",
         iPhone11           = "iPhone 11",
         iPhone11Pro        = "iPhone 11 Pro",
         iPhone11ProMax     = "iPhone 11 Pro Max",
         iPhoneSE2          = "iPhone SE 2nd gen",
         iPhone12Mini       = "iPhone 12 Mini",
         iPhone12           = "iPhone 12",
         iPhone12Pro        = "iPhone 12 Pro",
         iPhone12ProMax     = "iPhone 12 Pro Max",
         iPhone13Mini       = "iPhone 13 Mini",
         iPhone13           = "iPhone 13",
         iPhone13Pro        = "iPhone 13 Pro",
         iPhone13ProMax     = "iPhone 13 Pro Max",
         iPhoneSE3          = "iPhone SE 3",
         iPhone14           = "iPhone 14",
         iPhone14Puls       = "iPhone 14 Plus",
         iPhone14Pro        = "iPhone 14 Pro",
         iPhone14ProMax     = "iPhone 14 Pro Max",
         iPhone15           = "iPhone 15",
         iPhone15Plus       = "iPhone 15 Plus",
         iPhone15Pro        = "iPhone 15 Pro",
         iPhone15ProMax     = "iPhone 15 Pro Max",
    
         unrecognized       = "?unrecognized?"
    
    var value: CGFloat {

            switch self {
            case .simulator:
                return 1.0
            case .iPhone4: fallthrough
            case .iPhone4S:
                return 3.0
            case .iPhone5: fallthrough
            case .iPhone5S: fallthrough
            case .iPhone5C:
                return 4.0
            case .iPhone6: fallthrough
            case .iPhone6Plus: fallthrough
            case .iPhone6S: fallthrough
            case .iPhone6SPlus: fallthrough
            case .iPhoneSE:
                return 5.0
            case .iPhone7: fallthrough
            case .iPhone7Plus:
                return 6.0
            case .iPhone8: fallthrough
            case .iPhone8Plus:
                return 7.0
            case .iPhoneX: fallthrough
            case .iPhoneXS: fallthrough
            case .iPhoneXSMax: fallthrough
            case .iPhoneXR:
                return 8.0
            case .iPhone11: fallthrough
            case .iPhone11Pro: fallthrough
            case .iPhone11ProMax: fallthrough
            case .iPhoneSE2:
                return 9.0
            case .iPhone12Mini: fallthrough
            case .iPhone12: fallthrough
            case .iPhone12Pro: fallthrough
            case .iPhone12ProMax:
                return 10.0
            case .iPhone13Mini: fallthrough
            case .iPhone13: fallthrough
            case .iPhone13Pro: fallthrough
            case .iPhone13ProMax: fallthrough
            case .iPhoneSE3:
                return 11.0
            case .iPhone14: fallthrough
            case .iPhone14Puls: fallthrough
            case .iPhone14Pro: fallthrough
            case .iPhone14ProMax:
                return 12.0
            case .iPhone15, .iPhone15Plus, .iPhone15Pro, .iPhone15ProMax:
                return 13.0
            case .unrecognized:
                return .greatestFiniteMagnitude
            }

        }
}


public extension UIDevice {
    
    static let _diskSpaceQueue = DispatchQueue(label: "com.topdon.diskSpace")
    /// 可用磁盘空间
    static var freeDiskSpace: UInt64 {
        
        func getFreeSize() -> UInt64 {
            var freeSize: UInt64 = 0
            if let dict = try? FileManager.default.attributesOfFileSystem(forPath: Sandbox.documentPath), let free = dict[.systemFreeSize] as? UInt64 {
                return free
            }
            return freeSize
        }

        return _diskSpaceQueue.sync {
            if #available(iOS 11.0, *) {
                let fileUrl = URL(fileURLWithPath: NSTemporaryDirectory())
                do {
                    let attribute = try fileUrl.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
                    if let totalSize = attribute.volumeAvailableCapacityForImportantUsage {
                        let size = UInt64(totalSize)
                        return size
                    }
                } catch {
                    debugPrint("获取磁盘空间失败\(error)")
                }
            }
            let size = getFreeSize()
            return size
        }
    }
    
    private static var _totalDiskSpace: UInt64?
    /// 手机总存储大小
    static var totalDiskSpace: UInt64 {
        if let _totalDiskSpace = _totalDiskSpace {
            return _totalDiskSpace
        }
        var totalSpace: UInt64 = 0
        guard let dict = try? FileManager.default.attributesOfFileSystem(forPath: Sandbox.documentPath) else {
            return 0
        }
        if let totalSize = dict[.systemSize] as? UInt64 {
           totalSpace = totalSize
        }
        _totalDiskSpace = totalSpace
        return totalSpace
    }
    
    /// 手机型号
    var type: iPhoneModel {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }
        
        let modelMap : [String: iPhoneModel] = [
            
            //iPhone
            "iPhone3,1" : .iPhone4,
            "iPhone3,2" : .iPhone4,
            "iPhone3,3" : .iPhone4,
            "iPhone4,1" : .iPhone4S,
            "iPhone5,1" : .iPhone5,
            "iPhone5,2" : .iPhone5,
            "iPhone5,3" : .iPhone5C,
            "iPhone5,4" : .iPhone5C,
            "iPhone6,1" : .iPhone5S,
            "iPhone6,2" : .iPhone5S,
            "iPhone7,1" : .iPhone6Plus,
            "iPhone7,2" : .iPhone6,
            "iPhone8,1" : .iPhone6S,
            "iPhone8,2" : .iPhone6SPlus,
            "iPhone8,4" : .iPhoneSE,
            "iPhone9,1" : .iPhone7,
            "iPhone9,3" : .iPhone7,
            "iPhone9,2" : .iPhone7Plus,
            "iPhone9,4" : .iPhone7Plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,4" : .iPhone8,
            "iPhone10,2" : .iPhone8Plus,
            "iPhone10,5" : .iPhone8Plus,
            "iPhone10,3" : .iPhoneX,
            "iPhone10,6" : .iPhoneX,
            "iPhone11,2" : .iPhoneXS,
            "iPhone11,4" : .iPhoneXSMax,
            "iPhone11,6" : .iPhoneXSMax,
            "iPhone11,8" : .iPhoneXR,
            "iPhone12,1" : .iPhone11,
            "iPhone12,3" : .iPhone11Pro,
            "iPhone12,5" : .iPhone11ProMax,
            "iPhone12,8" : .iPhoneSE2,
            "iPhone13,1" : .iPhone12Mini,
            "iPhone13,2" : .iPhone12,
            "iPhone13,3" : .iPhone12Pro,
            "iPhone13,4" : .iPhone12ProMax,
            "iPhone14,4" : .iPhone13Mini,
            "iPhone14,5" : .iPhone13,
            "iPhone14,2" : .iPhone13Pro,
            "iPhone14,3" : .iPhone13ProMax,
            "iPhone14,6" : .iPhoneSE3,
            "iPhone14,7" : .iPhone14,
            "iPhone14,8" : .iPhone14Puls,
            "iPhone15,2" : .iPhone14Pro,
            "iPhone15,3" : .iPhone14ProMax,
            "iPhone15,4" : .iPhone15,
            "iPhone15,5" : .iPhone15Plus,
            "iPhone16,1" : .iPhone15Pro,
            "iPhone16,2" : .iPhone15ProMax,
        ]
        
        if let model = modelMap[modelCode!] {
            if model == .simulator {
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    if let simModel = modelMap[simModelCode] {
                        return simModel
                    }
                }
            }
            return model
        }
        return iPhoneModel.unrecognized
    }
    
    /// 获取手机可用内存
    static var usageComparison: Double {
        var taskInfo = task_vm_info_data_t()
        var count = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size) / 4
        let result: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
            }
        }
        
        var used: UInt64 = 0
        if result == KERN_SUCCESS {
            used = UInt64(taskInfo.phys_footprint)
        }
        
        let total = ProcessInfo.processInfo.physicalMemory
        return Double(total - used)
    }
    
    /// CPU型号
    private static var _cpuType: String?
    static var cpuType: String {
        if let _cpuType = _cpuType {
            return _cpuType
        }
        let HOST_BASIC_INFO_COUNT = MemoryLayout<host_basic_info>.stride/MemoryLayout<integer_t>.stride
        var size = mach_msg_type_number_t(HOST_BASIC_INFO_COUNT)
        var hostInfo = host_basic_info()
        let result = withUnsafeMutablePointer(to: &hostInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity:Int(size)){
                host_info(mach_host_self(), Int32(HOST_BASIC_INFO), $0, &size)
            }
        }
        var cpuType = ""
        switch hostInfo.cpu_type {
        case CPU_TYPE_ARM:
            cpuType = "CPU_TYPE_ARM"
        case CPU_TYPE_ARM64:
            cpuType = "CPU_TYPE_ARM64"
        case CPU_TYPE_ARM64_32:
            cpuType = "CPU_TYPE_ARM64_32"
        case CPU_TYPE_X86:
            cpuType = "CPU_TYPE_X86"
        case CPU_TYPE_X86_64:
            cpuType = "CPU_TYPE_X86_64"
        case CPU_TYPE_ANY:
            cpuType = "CPU_TYPE_ANY"
        case CPU_TYPE_VAX:
            cpuType = "CPU_TYPE_VAX"
        case CPU_TYPE_MC680x0:
            cpuType = "CPU_TYPE_MC680x0"
        case CPU_TYPE_I386:
            cpuType = "CPU_TYPE_I386"
        case CPU_TYPE_MC98000:
            cpuType = "CPU_TYPE_MC98000"
        case CPU_TYPE_HPPA:
            cpuType = "CPU_TYPE_HPPA"
        case CPU_TYPE_MC88000:
            cpuType = "CPU_TYPE_MC88000"
        case CPU_TYPE_SPARC:
            cpuType = "CPU_TYPE_SPARC"
        case CPU_TYPE_I860:
            cpuType = "CPU_TYPE_I860"
        case CPU_TYPE_POWERPC:
            cpuType = "CPU_TYPE_POWERPC"
        case CPU_TYPE_POWERPC64:
            cpuType = "CPU_TYPE_POWERPC64"
        default:
            cpuType =  ""
        }
        _cpuType = cpuType
        return cpuType
    }
    
    /// 获取当前设备的cpu核数
    private static var _cpuCount: Int?
    static var cpuCount: Int {
        if let _cpuCount = _cpuCount {
            return _cpuCount
        }
        var ncpu: UInt = UInt(0)
        var len: size_t = MemoryLayout.size(ofValue: ncpu)
        sysctlbyname("hw.ncpu", &ncpu, &len, nil, 0)
        _cpuCount = Int(ncpu)
        return Int(ncpu)
    }
    
    /// 获取当前设备的IP地址
    static var ip: String {
        var addresses = [String]()
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        if let ipStr = addresses.first {
            return ipStr
        } else {
            return ""
        }
    }
    
    static var _deviceIdentifier: String?
    /// 获取设备的 identifier eg: iPhone16,2
    var deviceIdentifier: String {
        if let identifier = UIDevice._deviceIdentifier {
            return identifier
        }
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children
            .compactMap { $0.value as? Int8 }
            .map { String(UnicodeScalar(UInt8($0))) }
            .joined()
            .trimmingCharacters(in: .controlCharacters)
        
        UIDevice._deviceIdentifier = identifier
        
        return identifier
    }
    
    /// deviceMode 获取设备的型号 eg: iPhone 15 Pro Max
    var deviceMode: String {
        return UIDevice.deviceMap[deviceIdentifier] ?? deviceIdentifier
    }
    
    /// 获取当前设备的设备型号 eg: iPhone 15 Pro Max
    static var deviceMode: String {
        let identifier = UIDevice.current.deviceIdentifier
        return UIDevice.deviceMap[identifier] ?? identifier
    }
    
    /// https://gist.github.com/adamawolf/3048717
    static let deviceMap: [String: String] = [
        "i386" : "iPhone Simulator",
        "x86_64" : "iPhone Simulator",
        "arm64" : "iPhone Simulator",
        "iPhone1,1" : "iPhone",
        "iPhone1,2" : "iPhone 3G",
        "iPhone2,1" : "iPhone 3GS",
        "iPhone3,1" : "iPhone 4",
        "iPhone3,2" : "iPhone 4 GSM Rev A",
        "iPhone3,3" : "iPhone 4 CDMA",
        "iPhone4,1" : "iPhone 4S",
        "iPhone5,1" : "iPhone 5 (GSM)",
        "iPhone5,2" : "iPhone 5 (GSM+CDMA)",
        "iPhone5,3" : "iPhone 5C (GSM)",
        "iPhone5,4" : "iPhone 5C (Global)",
        "iPhone6,1" : "iPhone 5S (GSM)",
        "iPhone6,2" : "iPhone 5S (Global)",
        "iPhone7,1" : "iPhone 6 Plus",
        "iPhone7,2" : "iPhone 6",
        "iPhone8,1" : "iPhone 6s",
        "iPhone8,2" : "iPhone 6s Plus",
        "iPhone8,4" : "iPhone SE (GSM)",
        "iPhone9,1" : "iPhone 7",
        "iPhone9,2" : "iPhone 7 Plus",
        "iPhone9,3" : "iPhone 7",
        "iPhone9,4" : "iPhone 7 Plus",
        "iPhone10,1" : "iPhone 8",
        "iPhone10,2" : "iPhone 8 Plus",
        "iPhone10,3" : "iPhone X Global",
        "iPhone10,4" : "iPhone 8",
        "iPhone10,5" : "iPhone 8 Plus",
        "iPhone10,6" : "iPhone X GSM",
        "iPhone11,2" : "iPhone XS",
        "iPhone11,4" : "iPhone XS Max",
        "iPhone11,6" : "iPhone XS Max Global",
        "iPhone11,8" : "iPhone XR",
        "iPhone12,1" : "iPhone 11",
        "iPhone12,3" : "iPhone 11 Pro",
        "iPhone12,5" : "iPhone 11 Pro Max",
        "iPhone12,8" : "iPhone SE 2nd Gen",
        "iPhone13,1" : "iPhone 12 Mini",
        "iPhone13,2" : "iPhone 12",
        "iPhone13,3" : "iPhone 12 Pro",
        "iPhone13,4" : "iPhone 12 Pro Max",
        "iPhone14,2" : "iPhone 13 Pro",
        "iPhone14,3" : "iPhone 13 Pro Max",
        "iPhone14,4" : "iPhone 13 Mini",
        "iPhone14,5" : "iPhone 13",
        "iPhone14,6" : "iPhone SE 3rd Gen",
        "iPhone14,7" : "iPhone 14",
        "iPhone14,8" : "iPhone 14 Plus",
        "iPhone15,2" : "iPhone 14 Pro",
        "iPhone15,3" : "iPhone 14 Pro Max",
        "iPhone15,4" : "iPhone 15",
        "iPhone15,5" : "iPhone 15 Plus",
        "iPhone16,1" : "iPhone 15 Pro",
        "iPhone16,2" : "iPhone 15 Pro Max",
        "iPhone17,1" : "iPhone 16 Pro",
        "iPhone17,2" : "iPhone 16 Pro Max",
        "iPhone17,3" : "iPhone 16",
        "iPhone17,4" : "iPhone 16 Plus",
        
        "iPod1,1" : "1st Gen iPod",
        "iPod2,1" : "2nd Gen iPod",
        "iPod3,1" : "3rd Gen iPod",
        "iPod4,1" : "4th Gen iPod",
        "iPod5,1" : "5th Gen iPod",
        "iPod7,1" : "6th Gen iPod",
        "iPod9,1" : "7th Gen iPod",
        
        "iPad1,1" : "iPad",
        "iPad1,2" : "iPad 3G",
        "iPad2,1" : "2nd Gen iPad",
        "iPad2,2" : "2nd Gen iPad GSM",
        "iPad2,3" : "2nd Gen iPad CDMA",
        "iPad2,4" : "2nd Gen iPad New Revision",
        "iPad3,1" : "3rd Gen iPad",
        "iPad3,2" : "3rd Gen iPad CDMA",
        "iPad3,3" : "3rd Gen iPad GSM",
        "iPad2,5" : "iPad mini",
        "iPad2,6" : "iPad mini GSM+LTE",
        "iPad2,7" : "iPad mini CDMA+LTE",
        "iPad3,4" : "4th Gen iPad",
        "iPad3,5" : "4th Gen iPad GSM+LTE",
        "iPad3,6" : "4th Gen iPad CDMA+LTE",
        "iPad4,1" : "iPad Air (WiFi)",
        "iPad4,2" : "iPad Air (GSM+CDMA)",
        "iPad4,3" : "1st Gen iPad Air (China)",
        "iPad4,4" : "iPad mini Retina (WiFi)",
        "iPad4,5" : "iPad mini Retina (GSM+CDMA)",
        "iPad4,6" : "iPad mini Retina (China)",
        "iPad4,7" : "iPad mini 3 (WiFi)",
        "iPad4,8" : "iPad mini 3 (GSM+CDMA)",
        "iPad4,9" : "iPad Mini 3 (China)",
        "iPad5,1" : "iPad mini 4 (WiFi)",
        "iPad5,2" : "4th Gen iPad mini (WiFi+Cellular)",
        "iPad5,3" : "iPad Air 2 (WiFi)",
        "iPad5,4" : "iPad Air 2 (Cellular)",
        "iPad6,3" : "iPad Pro (9.7 inch, WiFi)",
        "iPad6,4" : "iPad Pro (9.7 inch, WiFi+LTE)",
        "iPad6,7" : "iPad Pro (12.9 inch, WiFi)",
        "iPad6,8" : "iPad Pro (12.9 inch, WiFi+LTE)",
        "iPad6,11" : "iPad (2017)",
        "iPad6,12" : "iPad (2017)",
        "iPad7,1" : "iPad Pro 2nd Gen (WiFi)",
        "iPad7,2" : "iPad Pro 2nd Gen (WiFi+Cellular)",
        "iPad7,3" : "iPad Pro 10.5-inch 2nd Gen",
        "iPad7,4" : "iPad Pro 10.5-inch 2nd Gen",
        "iPad7,5" : "iPad 6th Gen (WiFi)",
        "iPad7,6" : "iPad 6th Gen (WiFi+Cellular)",
        "iPad7,11" : "iPad 7th Gen 10.2-inch (WiFi)",
        "iPad7,12" : "iPad 7th Gen 10.2-inch (WiFi+Cellular)",
        "iPad8,1" : "iPad Pro 11 inch 3rd Gen (WiFi)",
        "iPad8,2" : "iPad Pro 11 inch 3rd Gen (1TB, WiFi)",
        "iPad8,3" : "iPad Pro 11 inch 3rd Gen (WiFi+Cellular)",
        "iPad8,4" : "iPad Pro 11 inch 3rd Gen (1TB, WiFi+Cellular)",
        "iPad8,5" : "iPad Pro 12.9 inch 3rd Gen (WiFi)",
        "iPad8,6" : "iPad Pro 12.9 inch 3rd Gen (1TB, WiFi)",
        "iPad8,7" : "iPad Pro 12.9 inch 3rd Gen (WiFi+Cellular)",
        "iPad8,8" : "iPad Pro 12.9 inch 3rd Gen (1TB, WiFi+Cellular)",
        "iPad11,1" : "iPad mini 5th Gen (WiFi)",
        "iPad11,2" : "iPad mini 5th Gen",
        "iPad11,3" : "iPad Air 3rd Gen (WiFi)",
        "iPad11,4" : "iPad Air 3rd Gen",
        "iPad11,6" : "iPad 8th Gen (WiFi)",
        "iPad11,7" : "iPad 8th Gen (WiFi+Cellular)",
        "iPad12,1" : "iPad 9th Gen (WiFi)",
        "iPad12,2" : "iPad 9th Gen (WiFi+Cellular)",
        "iPad13,1" : "iPad Air 4th Gen (WiFi)",
        "iPad13,2" : "iPad Air 4th Gen (WiFi+Cellular)",
        "iPad14,1" : "iPad mini 6th Gen (WiFi)",
        "iPad14,2" : "iPad mini 6th Gen (WiFi+Cellular)",
        "iPad13,4" : "iPad Pro 11 inch 5th Gen (WiFi)",
        "iPad13,5" : "iPad Pro 11 inch 5th Gen (WiFi+Cellular)",
        "iPad13,6" : "iPad Pro 11 inch 5th Gen (China)",
        "iPad13,7" : "iPad Pro 11 inch 5th Gen (China)",
        "iPad13,8" : "iPad Pro 12.9 inch 5th Gen (WiFi)",
        "iPad13,9" : "iPad Pro 12.9 inch 5th Gen (WiFi+Cellular)",
        "iPad13,10" : "iPad Pro 12.9 inch 5th Gen (China)",
        "iPad13,11" : "iPad Pro 12.9 inch 5th Gen (China)",
        
        "Watch1,1" : "Apple Watch 38mm case",
        "Watch1,2" : "Apple Watch 42mm case",
        "Watch2,6" : "Apple Watch Series 1 38mm case",
        "Watch2,7" : "Apple Watch Series 1 42mm case",
        "Watch2,3" : "Apple Watch Series 2 38mm case",
        "Watch2,4" : "Apple Watch Series 2 42mm case",
        "Watch3,1" : "Apple Watch Series 3 38mm case (GPS+Cellular)",
        "Watch3,2" : "Apple Watch Series 3 42mm case (GPS+Cellular)",
        "Watch3,3" : "Apple Watch Series 3 38mm case (GPS)",
        "Watch3,4" : "Apple Watch Series 3 42mm case (GPS)",
        "Watch4,1" : "Apple Watch Series 4 40mm case (GPS)",
        "Watch4,2" : "Apple Watch Series 4 44mm case (GPS)",
        "Watch4,3" : "Apple Watch Series 4 40mm case (GPS+Cellular)",
        "Watch4,4" : "Apple Watch Series 4 44mm case (GPS+Cellular)",
        "Watch5,1" : "Apple Watch Series 5 40mm case (GPS)",
        "Watch5,2" : "Apple Watch Series 5 44mm case (GPS)",
        "Watch5,3" : "Apple Watch Series 5 40mm case (GPS+Cellular)",
        "Watch5,4" : "Apple Watch Series 5 44mm case (GPS+Cellular)",
        "Watch6,1" : "Apple Watch SE 40mm case (GPS)",
        "Watch6,2" : "Apple Watch SE 44mm case (GPS)",
        "Watch6,3" : "Apple Watch SE 40mm case (GPS+Cellular)",
        "Watch6,4" : "Apple Watch SE 44mm case (GPS+Cellular)",
        "Watch6,6" : "Apple Watch Series 6 40mm case (GPS)",
        "Watch6,7" : "Apple Watch Series 6 44mm case (GPS)",
        "Watch6,8" : "Apple Watch Series 6 40mm case (GPS+Cellular)",
        "Watch6,9" : "Apple Watch Series 6 44mm case (GPS+Cellular)",
        "Watch6,10" : "Apple Watch Series 7 41mm case (GPS)",
        "Watch6,11" : "Apple Watch Series 7 45mm case (GPS)",
        "Watch6,12" : "Apple Watch Series 7 41mm case (GPS+Cellular)",
        "Watch6,13" : "Apple Watch Series 7 45mm case (GPS+Cellular)",
        "Watch6,14" : "Apple Watch Ultra",
        "Watch6,15" : "Apple Watch Ultra 2",
        
        // Apple TV
        "AppleTV1,1" : "1st Gen Apple TV",
        "AppleTV2,1" : "2nd Gen Apple TV",
        "AppleTV3,1" : "3rd Gen Apple TV",
        "AppleTV3,2" : "3rd Gen Apple TV (Rev A)",
        "AppleTV5,3" : "4th Gen Apple TV",
        "AppleTV6,2" : "Apple TV 4K",
        "AppleTV11,1" : "Apple TV 4K (2nd Gen)",
        "AppleTV14,1" : "Apple TV 4K (3rd Gen)",
    ]
}

extension Notification.Name {
    public static let loginStatusChanged = Notification.Name(rawValue: "loginStatusChanged")
    public static let userInfoChanged = Notification.Name(rawValue: "userInfoChanged")
}
