//
//  LogHelperModels.swift
//  TopdonLog
//
//  Created by xinwenliu on 2023/11/25.
//

import Foundation

@objc (TDRedirectionParameters)
@objcMembers
public class RedirectionParameters: NSObject {
    
    let appName: String
    
    var subPath: String
    
    var launchTime: String
    let launchDateFormatter: DateFormatter
    
    let logName: String
    
    let fullLogPath: String
    
    public init(appName: String, subPath: String, launchTime: String, launchDateFormatter: DateFormatter, logDirectDir: String) {
        self.appName = appName
        self.subPath = subPath
        self.launchTime = launchTime
        self.launchDateFormatter = launchDateFormatter
        
        self.logName = "\(appName)_\(subPath)_\(launchTime)_\(TopdonLogFileManager.kLogSuffix)"
        self.fullLogPath = logDirectDir.ns.appendingPathComponent(self.logName)
    }
    
}

// MARK: - DiagCarLogPathComponent

enum DiagCarLogPathComponent {
    case type
    case brand
    case fileName
}

// MARK: - DiagCarLogDir

public struct DiagCarLogDir {
    
    let rootDir: String
    
    let type: String
    let brand: String
    
    var path: String {
        return rootDir
            .ns.appendingPathComponent(type)
            .ns.appendingPathComponent(brand)
    }
    
    var isValid: Bool {
        return !type.isEmpty && !brand.isEmpty
    }
    
}

// MARK: - LogUploadType

public enum LogUploadType {
    
    /// Crash
    public static let customTypeCrash: Int = 0x8badf00d
    
    //0 上传app日志 默认
    //1 上传车型日志
    //2 反馈上传日志
    //3 自动上传车型日志
    //4 autoVin失败静默feedback
    case appLog
    case diagCarLog
    case feedbackLog
    case diagCarLogAuto
    case autoVinLog
    /// type 传 5以上
    /// 0x8badf00d -- Crash
    case custom(type: Int)
    
    
    init(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .appLog
        case 1:
            self = .diagCarLog
        case 2:
            self = .feedbackLog
        case 3:
            self = .diagCarLogAuto
        case 4:
            self = .autoVinLog
        default:
            self = .custom(type: rawValue)
        }
    }
    
    var rawValue: Int {
        switch self {
        case .appLog:
            return 0
        case .diagCarLog:
            return 1
        case .feedbackLog:
            return 2
        case .diagCarLogAuto:
            return 3
        case .autoVinLog:
            return 4
        case .custom(let type):
            return type
        }
    }
}

// MARK: - LogUploadModel

public extension TopdonLog {
    
    struct LogUploadModel: LogFileUploadable {
        
        public var zipPath: String
        public var feedBackZipPath: String
        public var uploadType: LogUploadType = .appLog
        public var carType: String
        public var carBrand: String
        /// yyyy-MM-dd HH:mm:ss
        public var createTime: String
        public var carInfo: Car?
        
        /// 反馈操作失败原因
        public var failContent: String = ""
        
        public var dbPath: String
        
        public var sn: String = ""
        
        public var topdonId: String = ""
        /// 附加信息
        public var appendex: String = ""
        /// -1 代表无意义
        public var autoVinEntryType: Int = -1
        
        // MARK: - LogFileUploadable
        
        public var lfuSn: String = ""
        
        public var lfuCarType: String = ""
        
        public var lfuProblem: String = ""
        
        public var lfuOtherDescription: String = ""
        
        public var lfuLogGenerationTime: String = ""
        
        public var lfuSubmitUserName: String = ""
        
        public var lfuRemark: String = ""
        
        public var lfuCarSoftCode: String = ""
        
        public var lfuCarBrandName: String = ""
        
        public var lfuCarModelPath: String = ""
        
        public var lfuCarLanguageId: String = ""
        
        public var lfuCarModelSourceVersion: String = ""
        
        public var lfuMainCarVersion: String = ""
        
        public var lfuLinkCarVersion: String = ""
        
        public var lfuVin: String = ""
        
        public var lfuPhoneBrandName: String = ""
        
        public var lfuPhoneModelName: String = ""
        
        public var lfuPhoneSystemVersion: String = ""
        
        public var lfuPhoneSystemLanguageId: String = ""
        
        public var lfuFirmwareVersion: String = ""
        
        public var lfuBootVersion: String = ""
        
        public var lfuHardwareVersion: String = ""
        
        public var lfuUploadType: String = ""
        
        public var lfuLogType: String = ""
        
        public var lfuAppVersion: String = ""
        
        public var lfuPhoneSystemLanguageName: String = ""
        
        public var lfuAppInfo: String = ""
        
        mutating func update(from dbRecord: LogFileUploadable) {
            lfuSn = dbRecord.lfuSn
            lfuCarType = dbRecord.lfuCarType
            lfuProblem = dbRecord.lfuProblem
            lfuOtherDescription = dbRecord.lfuOtherDescription
            //lfuLogGenerationTime = dbRecord.lfuLogGenerationTime
            if let appLogRecord = dbRecord as? NewAppLogRecordDBModel {
                lfuLogGenerationTime = appLogRecord.createTimeForServer
            } else if let enterCarLogRecord = dbRecord as? EnterDiagLogRecordDBModel {
                lfuLogGenerationTime = enterCarLogRecord.createTimeForServer
            } else {
                lfuLogGenerationTime = dbRecord.lfuLogGenerationTime
            }
            lfuSubmitUserName = dbRecord.lfuSubmitUserName
            lfuRemark = dbRecord.lfuRemark
            lfuCarSoftCode = dbRecord.lfuCarSoftCode
            lfuCarBrandName = dbRecord.lfuCarBrandName
            lfuCarModelPath = dbRecord.lfuCarModelPath
            lfuCarLanguageId = dbRecord.lfuCarLanguageId
            lfuCarModelSourceVersion = dbRecord.lfuCarModelSourceVersion
            lfuMainCarVersion = dbRecord.lfuMainCarVersion
            lfuLinkCarVersion = dbRecord.lfuLinkCarVersion
            lfuVin = dbRecord.lfuVin
            lfuPhoneBrandName = dbRecord.lfuPhoneBrandName
            lfuPhoneModelName = dbRecord.lfuPhoneModelName
            lfuPhoneSystemVersion = dbRecord.lfuPhoneSystemVersion
            lfuPhoneSystemLanguageId = dbRecord.lfuPhoneSystemLanguageId
            lfuFirmwareVersion = dbRecord.lfuFirmwareVersion
            lfuBootVersion = dbRecord.lfuBootVersion
            lfuHardwareVersion = dbRecord.lfuHardwareVersion
            lfuUploadType = dbRecord.lfuUploadType
            lfuLogType = dbRecord.lfuLogType
            lfuAppVersion = dbRecord.lfuAppVersion
            lfuPhoneSystemLanguageName = dbRecord.lfuPhoneSystemLanguageName
            lfuAppInfo = dbRecord.lfuAppInfo
        }
        
        mutating func update(from dbRecord: LogUploadInterface) {
            uploadType = dbRecord.lfuLogUploadType
            lfuSn = dbRecord.lfuSn
            lfuCarType = dbRecord.lfuCarType
            lfuProblem = dbRecord.lfuProblem
            lfuOtherDescription = dbRecord.lfuOtherDescription
            lfuLogGenerationTime = dbRecord.lfuLogGenerationTime
            lfuSubmitUserName = dbRecord.lfuSubmitUserName
            lfuRemark = dbRecord.lfuRemark
            lfuCarSoftCode = dbRecord.lfuCarSoftCode
            lfuCarBrandName = dbRecord.lfuCarBrandName
            lfuCarModelPath = dbRecord.lfuCarModelPath
            lfuCarLanguageId = dbRecord.lfuCarLanguageId
            lfuCarModelSourceVersion = dbRecord.lfuCarModelSourceVersion
            lfuMainCarVersion = dbRecord.lfuMainCarVersion
            lfuLinkCarVersion = dbRecord.lfuLinkCarVersion
            lfuVin = dbRecord.lfuVin
            lfuPhoneBrandName = dbRecord.lfuPhoneBrandName
            lfuPhoneModelName = dbRecord.lfuPhoneModelName
            lfuPhoneSystemVersion = dbRecord.lfuPhoneSystemVersion
            lfuPhoneSystemLanguageId = dbRecord.lfuPhoneSystemLanguageId
            lfuFirmwareVersion = dbRecord.lfuFirmwareVersion
            lfuBootVersion = dbRecord.lfuBootVersion
            lfuHardwareVersion = dbRecord.lfuHardwareVersion
            lfuUploadType = dbRecord.lfuUploadType
            lfuLogType = dbRecord.lfuLogType
            lfuAppVersion = dbRecord.lfuAppVersion
            lfuPhoneSystemLanguageName = dbRecord.lfuPhoneSystemLanguageName
            lfuAppInfo = dbRecord.lfuAppInfo
        }
        
    }
    
}

public typealias LogUploadModel = TopdonLog.LogUploadModel

@objc(TDFileUpload)
@objcMembers
open class FileUpload: NSObject, LogUploadInterface {
    
    public var lfuLogUploadType: LogUploadType = .appLog
    
    public var lfuSn: String = ""
    
    public var lfuCarType: String = ""
    
    public var lfuProblem: String = ""
    
    public var lfuOtherDescription: String = ""
    
    public var lfuLogGenerationTime: String = ""
    
    public var lfuSubmitUserName: String = ""
    
    public var lfuRemark: String = ""
    
    public var lfuCarSoftCode: String = ""
    
    public var lfuCarBrandName: String = ""
    
    public var lfuCarModelPath: String = ""
    
    public var lfuCarLanguageId: String = ""
    
    public var lfuCarModelSourceVersion: String = ""
    
    public var lfuMainCarVersion: String = ""
    
    public var lfuLinkCarVersion: String = ""
    
    public var lfuVin: String = ""
    
    public var lfuPhoneBrandName: String = ""
    
    public var lfuPhoneModelName: String = ""
    
    public var lfuPhoneSystemVersion: String = ""
    
    public var lfuPhoneSystemLanguageId: String = ""
    
    public var lfuFirmwareVersion: String = ""
    
    public var lfuBootVersion: String = ""
    
    public var lfuHardwareVersion: String = ""
    
    public var lfuUploadType: String = ""
    
    public var lfuLogType: String = ""
    
    public var lfuAppVersion: String = ""
    
    public var lfuPhoneSystemLanguageName: String = ""
    
    public var lfuAppInfo: String = ""
    
    public init(lfuSn: String, lfuCarType: String, lfuProblem: String, lfuOtherDescription: String, lfuLogGenerationTime: String, lfuSubmitUserName: String, lfuRemark: String, lfuCarSoftCode: String, lfuCarBrandName: String, lfuCarModelPath: String, lfuCarLanguageId: String, lfuCarModelSourceVersion: String, lfuMainCarVersion: String, lfuLinkCarVersion: String, lfuVin: String, lfuPhoneBrandName: String, lfuPhoneModelName: String, lfuPhoneSystemVersion: String, lfuPhoneSystemLanguageId: String, lfuFirmwareVersion: String, lfuBootVersion: String, lfuHardwareVersion: String, lfuUploadType: String, lfuLogType: String, lfuAppVersion: String, lfuPhoneSystemLanguageName: String, lfuAppInfo: String) {
        self.lfuSn = lfuSn
        self.lfuCarType = lfuCarType
        self.lfuProblem = lfuProblem
        self.lfuOtherDescription = lfuOtherDescription
        self.lfuLogGenerationTime = lfuLogGenerationTime
        self.lfuSubmitUserName = lfuSubmitUserName
        self.lfuRemark = lfuRemark
        self.lfuCarSoftCode = lfuCarSoftCode
        self.lfuCarBrandName = lfuCarBrandName
        self.lfuCarModelPath = lfuCarModelPath
        self.lfuCarLanguageId = lfuCarLanguageId
        self.lfuCarModelSourceVersion = lfuCarModelSourceVersion
        self.lfuMainCarVersion = lfuMainCarVersion
        self.lfuLinkCarVersion = lfuLinkCarVersion
        self.lfuVin = lfuVin
        self.lfuPhoneBrandName = lfuPhoneBrandName
        self.lfuPhoneModelName = lfuPhoneModelName
        self.lfuPhoneSystemVersion = lfuPhoneSystemVersion
        self.lfuPhoneSystemLanguageId = lfuPhoneSystemLanguageId
        self.lfuFirmwareVersion = lfuFirmwareVersion
        self.lfuBootVersion = lfuBootVersion
        self.lfuHardwareVersion = lfuHardwareVersion
        self.lfuUploadType = lfuUploadType
        self.lfuLogType = lfuLogType
        self.lfuAppVersion = lfuAppVersion
        self.lfuPhoneSystemLanguageName = lfuPhoneSystemLanguageName
        self.lfuAppInfo = lfuAppInfo
        
        super.init()
    }
    
    static var empty: FileUpload {
        .init(lfuSn: "", lfuCarType: "", lfuProblem: "", lfuOtherDescription: "", lfuLogGenerationTime: "", lfuSubmitUserName: "", lfuRemark: "", lfuCarSoftCode: "", lfuCarBrandName: "", lfuCarModelPath: "", lfuCarLanguageId: "", lfuCarModelSourceVersion: "", lfuMainCarVersion:"", lfuLinkCarVersion: "", lfuVin: "", lfuPhoneBrandName: "", lfuPhoneModelName: "", lfuPhoneSystemVersion: "", lfuPhoneSystemLanguageId: "", lfuFirmwareVersion: "", lfuBootVersion: "", lfuHardwareVersion: "", lfuUploadType: "", lfuLogType: "", lfuAppVersion: "", lfuPhoneSystemLanguageName: "", lfuAppInfo: "")
    }
    
}

// MARK: - ZipModel

struct ZipModel {
    /// 标准7个，有可能含有，extra(那就是8个）
    static var componentsCount: Int = 7
    static var seperator = "-"
    
    /// TopGuru
    var appName: String
    
    /// iOS
    var platform: String = "iOS"
    
    /// V2.21
    var appVersion: String
    
    var vciSN: String
    
    var vin: String
    
    /// DIAG IMMO ...
    var type: String
    
    /// yyyyMMddHHmmss
    var createTime: String
    
    /// VM LANDROVER ..
    var brand: String
    
    /// Car.logType
    var logType: String = ""
    
    /// 最终文件地址
    var filePath: String
    
    var dbPath: String
    
    /// 反馈失败内容
    var failContent: String = ""
    
    /// 额外扩展用
    var extra: String = ""
    
    var zipName: String {
        
        var sequence: [String] = [
            appName,
            platform,
            "V\(appVersion)",
            vciSN,
            type,
            createTime,
            brand
        ]
        
        if !extra.isEmpty { sequence.append(extra) }
        
        let zip = sequence.joined(separator: Self.seperator).appending(".zip")
        return zip
    }
    
    /// 选择日志 zip 包
    var feedbackZipName: String {
        let name = brand.isEmpty ? "CAR" : brand
//        let logType = self.logType.isEmpty ? "AppLog" : self.logType // 外部要保证这个字段有值
        var feedBackSuffixStr = "\(name)-\(vin)-\(createTime).zip".replacingOccurrences(of: " ", with: "")
        if vin.isEmpty {
            feedBackSuffixStr = "\(name)-\(createTime).zip".replacingOccurrences(of: " ", with: "")
        }
        
        return feedBackSuffixStr
    }
    
    init(appName: String,
         platform: String,
         appVersion: String,
         vciSN: String,
         vin: String,
         type: String,
         createTime: String,
         brand: String,
         extra: String = "",
         filePath: String,
         dbPath: String) {
        self.appName = appName
        self.platform = platform
        self.appVersion = appVersion
        self.vciSN = vciSN
        self.vin = vin
        self.type = type
        self.createTime = createTime
        self.brand = brand
        self.extra = extra
        self.filePath = filePath
        self.dbPath = dbPath
    }
    
    func convertToUploadModel(_ uploadType: LogUploadType, feedBackZipPath: String = "") -> LogUploadModel {
        let type = self.type
        let brand = self.brand
        
        var model = LogUploadModel(zipPath: filePath,
                                   feedBackZipPath: feedBackZipPath,
                                   uploadType: uploadType,
                                   carType: type,
                                   carBrand: brand, createTime: Self.convertToUploadTime(createTime),
                                   dbPath: dbPath)
        model.lfuCarType = type
        model.lfuCarBrandName = brand
        
        model.failContent = failContent
        
        return model
    }
    
    static func convertToUploadTime(_ createTime: String) -> String {
        let now = Date().string(withFormat: TopdonDateFormat.kUploadTime)
        guard !createTime.isEmpty else {
            return now
        }
        
        guard let date = createTime.date(with: TopdonDateFormat.kZipName) else {
            return now
        }
        
        return date.string(withFormat: TopdonDateFormat.kUploadTime)
    }
    
    static func validZipName(_ zipPath: String, dbPath: String) -> ZipModel? {
        let upppercasePath = zipPath.uppercased()
        let suffix = ".ZIP"
        guard upppercasePath.hasSuffix(suffix) else { return nil }
        
        let components = upppercasePath.ns.components(separatedBy: "/")
        guard components.count > 0 else { return nil }
        
        let zipName = (components.last!).removeSuffix(suffix)
        let zipNameComponents = zipName.components(separatedBy: Self.seperator).map{ String.init($0)}
        
        guard zipNameComponents.count >= 7 else { return nil }
        
        var extra: String = ""
        if zipNameComponents.count > 7 {
            extra = zipNameComponents[7]
        }
        
        let model = ZipModel(appName: zipNameComponents[0],
                             platform: zipNameComponents[1],
                             appVersion: zipNameComponents[2],
                             vciSN: zipNameComponents[3],
                             vin: "",
                             type: zipNameComponents[4],
                             createTime: zipNameComponents[5],
                             brand: zipNameComponents[6],
                             extra: extra,
                             filePath: zipPath,
                             dbPath: dbPath
        )
        return model
    }
    
    
}

// 这里用到 AutoVin 失败时候处理
public class FixupFields {
    
    public var car: Car = .init(brand: "NoExist", strType: "NoExist", logType: "AppLog")
    
    // MARK: - 以下这些字段，如果需要修正就传入修正的值，如果不修正就传 nil。内部只会判 nil，不要不要不要传类似空字符串这种 ""
    
    /// 这里需要外部传 是autoVinLog还是diagCarLog
    public var uploadType: LogUploadType?
    
    public var problem: String?
    
    public var vin: String?
    
    public var carModelPath: String?
    
    // MARK: - 固件升级
    
    /// 固件版本号
    public var firmwareVersion: String?
    /// boot版本号
    public var bootVersion: String?
    /// 硬件版本号
    public var hardwareVersion: String?
    /// 附加信息
    public var otherDescription: String?
    /// AppInfo JSON
    
    public var appInfo: String?
   
    public var fixUpload: (any LogUploadInterface)?
    
    public convenience init(car: Car, uploadType: LogUploadType? = nil, problem: String? = nil, vin: String? = nil, carModelPath: String? = nil, firmwareVersion: String? = nil, bootVersion: String? = nil, hardwareVersion: String? = nil, otherDescription: String? = nil, appInfo: String? = nil) {
        self.init()
        self.car = car
        self.uploadType = uploadType
        self.problem = problem
        self.vin = vin
        self.carModelPath = carModelPath
        
        self.firmwareVersion = firmwareVersion
        self.bootVersion = bootVersion
        self.hardwareVersion = hardwareVersion
        self.otherDescription = otherDescription
        
        self.appInfo = appInfo
    }
    
    public convenience init(car: Car, uploadType: LogUploadType? = nil, fixUpload: (any LogUploadInterface)? = nil) {
        self.init()
        self.car = car
        self.uploadType = uploadType
        self.fixUpload = fixUpload
    }
    
    func update(record: EnterDiagLogRecordDBModel) -> Bool {
        if let fixUpload {
            return sync(record: record, for: fixUpload)
        }
        return sync(record: record)
    }
    
    private func sync(record: EnterDiagLogRecordDBModel, for uploadModel: any LogUploadInterface) -> Bool {
        var hasChanged = false
        
        if record.lfuSn != uploadModel.lfuSn {
            record.lfuSn = uploadModel.lfuSn
            hasChanged = true
        }
        if record.lfuCarType != uploadModel.lfuCarType {
            record.lfuCarType = uploadModel.lfuCarType
            hasChanged = true
        }
        if record.lfuProblem != uploadModel.lfuProblem {
            record.lfuProblem = uploadModel.lfuProblem
            hasChanged = true
        }
        if record.lfuOtherDescription != uploadModel.lfuOtherDescription {
            record.lfuOtherDescription = uploadModel.lfuOtherDescription
            hasChanged = true
        }
        if record.lfuLogGenerationTime != uploadModel.lfuLogGenerationTime {
            record.lfuLogGenerationTime = uploadModel.lfuLogGenerationTime
            hasChanged = true
        }
        if record.lfuSubmitUserName != uploadModel.lfuSubmitUserName {
            record.lfuSubmitUserName = uploadModel.lfuSubmitUserName
            hasChanged = true
        }
        if record.lfuRemark != uploadModel.lfuRemark {
            record.lfuRemark = uploadModel.lfuRemark
            hasChanged = true
        }
        if record.lfuCarSoftCode != uploadModel.lfuCarSoftCode {
            record.lfuCarSoftCode = uploadModel.lfuCarSoftCode
            hasChanged = true
        }
        if record.lfuCarBrandName != uploadModel.lfuCarBrandName {
            record.lfuCarBrandName = uploadModel.lfuCarBrandName
            hasChanged = true
        }
        if record.lfuCarModelPath != uploadModel.lfuCarModelPath {
            record.lfuCarModelPath = uploadModel.lfuCarModelPath
            hasChanged = true
        }
        if record.lfuCarLanguageId != uploadModel.lfuCarLanguageId {
            record.lfuCarLanguageId = uploadModel.lfuCarLanguageId
            hasChanged = true
        }
        if record.lfuCarModelSourceVersion != uploadModel.lfuCarModelSourceVersion {
            record.lfuCarModelSourceVersion = uploadModel.lfuCarModelSourceVersion
            hasChanged = true
        }
        if record.lfuMainCarVersion != uploadModel.lfuMainCarVersion {
            record.lfuMainCarVersion = uploadModel.lfuMainCarVersion
            hasChanged = true
        }
        if record.lfuLinkCarVersion != uploadModel.lfuLinkCarVersion {
            record.lfuLinkCarVersion = uploadModel.lfuLinkCarVersion
            hasChanged = true
        }
        if record.lfuVin != uploadModel.lfuVin {
            record.lfuVin = uploadModel.lfuVin
            hasChanged = true
        }
        if record.lfuPhoneBrandName != uploadModel.lfuPhoneBrandName {
            record.lfuPhoneBrandName = uploadModel.lfuPhoneBrandName
            hasChanged = true
        }
        if record.lfuPhoneModelName != uploadModel.lfuPhoneModelName {
            record.lfuPhoneModelName = uploadModel.lfuPhoneModelName
            hasChanged = true
        }
        if record.lfuPhoneSystemVersion != uploadModel.lfuPhoneSystemVersion {
            record.lfuPhoneSystemVersion = uploadModel.lfuPhoneSystemVersion
            hasChanged = true
        }
        if record.lfuPhoneSystemLanguageId != uploadModel.lfuPhoneSystemLanguageId {
            record.lfuPhoneSystemLanguageId = uploadModel.lfuPhoneSystemLanguageId
            hasChanged = true
        }
        if record.lfuFirmwareVersion != uploadModel.lfuFirmwareVersion {
            record.lfuFirmwareVersion = uploadModel.lfuFirmwareVersion
            hasChanged = true
        }
        if record.lfuBootVersion != uploadModel.lfuBootVersion {
            record.lfuBootVersion = uploadModel.lfuBootVersion
            hasChanged = true
        }
        if record.lfuHardwareVersion != uploadModel.lfuHardwareVersion {
            record.lfuHardwareVersion = uploadModel.lfuHardwareVersion
            hasChanged = true
        }
        if record.lfuUploadType != uploadModel.lfuUploadType {
            record.lfuUploadType = uploadModel.lfuUploadType
            hasChanged = true
        }
        if record.lfuLogType != uploadModel.lfuLogType {
            record.lfuLogType = uploadModel.lfuLogType
            hasChanged = true
        }
        if record.lfuAppVersion != uploadModel.lfuAppVersion {
            record.lfuAppVersion = uploadModel.lfuAppVersion
            hasChanged = true
        }
        if record.lfuPhoneSystemLanguageName != uploadModel.lfuPhoneSystemLanguageName {
            record.lfuPhoneSystemLanguageName = uploadModel.lfuPhoneSystemLanguageName
            hasChanged = true
        }
        if record.lfuAppInfo != uploadModel.lfuAppInfo {
            record.lfuAppInfo = uploadModel.lfuAppInfo
            hasChanged = true
        }
        
        return hasChanged
    }
    
    private func sync(record: EnterDiagLogRecordDBModel) -> Bool {
        let safeFixFields = self
        var needUpdate: Bool = false
        if let problem = safeFixFields.problem {
            record.lfuProblem = problem
            needUpdate = true
        }
        
        if let uploadType = safeFixFields.uploadType {
            record.uploadType = uploadType.rawValue
            needUpdate = true
        }
        
        if let vin = safeFixFields.vin {
            record.lfuVin = vin
            needUpdate = true
        }
        
        if let carModelPath = safeFixFields.carModelPath {
            record.lfuCarModelPath = carModelPath
            needUpdate = true
        }
        
        if let firmwareVersion = safeFixFields.firmwareVersion {
            record.lfuFirmwareVersion = firmwareVersion
            needUpdate = true
        }
        
        if let bootVersion = safeFixFields.bootVersion {
            record.lfuBootVersion = bootVersion
            needUpdate = true
        }
        
        if let hardwareVersion = safeFixFields.hardwareVersion {
            record.lfuHardwareVersion = hardwareVersion
            needUpdate = true
        }
        
        if let otherDescription = safeFixFields.otherDescription {
            record.lfuOtherDescription = otherDescription
            needUpdate = true
        }
        
        if let appInfo = safeFixFields.appInfo {
            record.lfuAppInfo = appInfo
            needUpdate = true
        }
        
        return needUpdate
    }
    
}

// MARK: - UserDefatults

@propertyWrapper
public struct UserDefault<T: Codable> {
    
    public let key: String
    public let defaultValue: T
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
}

// MARK: - Delegate, copy from kf

extension TopdonLog {
    
    public class Delegate<Input, Output> {
        public init() {}
        
        private var block: ((Input) -> Output?)?
        public func delegate<T: AnyObject>(on target: T, block: ((T, Input) -> Output)?) {
            self.block = { [weak target] input in
                guard let target = target else { return nil }
                return block?(target, input)
            }
        }
        
        public func call(_ input: Input) -> Output? {
            return block?(input)
        }
        
        public func callAsFunction(_ input: Input) -> Output? {
            return call(input)
        }
    }
    
}

public typealias Delegate = TopdonLog.Delegate

extension Delegate where Input == Void {
    public func call() -> Output? {
        return call(())
    }
    
    public func callAsFunction() -> Output? {
        return call()
    }
}

extension Delegate where Input == Void, Output: OptionalProtocol {
    public func call() -> Output {
        return call(())
    }
    
    public func callAsFunction() -> Output {
        return call()
    }
}

extension Delegate where Output: OptionalProtocol {
    public func call(_ input: Input) -> Output {
        if let result = block?(input) {
            return result
        } else {
            return Output._createNil
        }
    }
    
    public func callAsFunction(_ input: Input) -> Output {
        return call(input)
    }
}

public protocol OptionalProtocol {
    static var _createNil: Self { get }
}
extension Optional : OptionalProtocol {
    public static var _createNil: Optional<Wrapped> {
        return nil
    }
}

// MARK: - InnerLogger
internal func innerLogger(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    print("[TopdonLog] ", terminator: "")
    print(items, separator: separator, terminator: terminator)
}
