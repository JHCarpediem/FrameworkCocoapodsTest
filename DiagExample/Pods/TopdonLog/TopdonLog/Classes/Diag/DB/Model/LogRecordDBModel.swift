//
//  LogRecordDBModel.swift
//  TopdonLog
//
//  Created by xinwenliu on 2024/6/12.
//

import Foundation
import TDWCDB
import WCDBSwift
import ObjectiveC

protocol LogRecordable {
    
    /// 文件名：全路径 以,分割, 按createTime DESC
    var filenames: String {get set}
    
    /// 创建时间
    var createTime: TimeInterval {get set}
    
    /// 启动时间
    var launchTime: TimeInterval {get set}

    /// 记录类型（0启动、1.carLog、2.退车）
    var type: UInt {get set}
    
    /// SN号
    var sn: String {get set}
    
    /// 用户ID
    var topdonId: String {get set}
    
    /// IMMO / DIAG
    var carType: String {get set}
    /// VW / LANDROVER
    var carBrand: String {get set}
    
    var appVersion: String {get set}
    
    /// 额外附加信息
    var extraInfo: String {get set}
    
    /// 目标所属压缩包路径
    var zipPath: String {get set}
    
    /// 0-记录生成 1-已收集 2-已上传 3-已闲置（不会收集和上传）
    var status: UInt {get set}
    
    func updateIntoDB()
}

/// 对应文件上传接口字段 /api/v1/user/logFileUpload/uploading https://app.apifox.com/project/2188144
protocol LogFileUploadable {
    
    var lfuSn: String { get set}
    /// 车型
    var lfuCarType: String { get set}
    
    var lfuProblem: String { get set}
    
    var lfuOtherDescription: String { get set}
    
    /// 2020-5-20 05:202:00
    var lfuLogGenerationTime: String {get set}

    var lfuSubmitUserName: String { get set}
    
    var lfuRemark: String {get set}
    
    var lfuCarSoftCode: String { get set }
    
    var lfuCarBrandName: String { get set }
    
    var lfuCarModelPath: String {get set}
    
    var lfuCarLanguageId: String {get set}
    
    var lfuCarModelSourceVersion: String {get set}
    
    var lfuMainCarVersion: String {get set}
    
    var lfuLinkCarVersion: String {get set}
    
    var lfuVin: String {get set}
    
    var lfuPhoneBrandName: String {get set}
    
    var lfuPhoneModelName: String {get set}
    
    var lfuPhoneSystemVersion: String {get set}
    
    var lfuPhoneSystemLanguageId: String {get set}
    
    var lfuFirmwareVersion: String {get set}
    
    var lfuBootVersion: String {get set}
    
    var lfuHardwareVersion: String {get set}
    
    /// 上传类型 1静默上传 2崩溃日志 3用户反馈
    var lfuUploadType: String {get set}
   
    /// 日志类型 1汽车诊断 2.汽车防盗 3摩托车诊断 4.T-DARTS 5.ADAS 6其他
    var lfuLogType: String {get set}
    
    var lfuAppVersion: String {get set}
    
    var lfuPhoneSystemLanguageName: String {get set}

    var lfuAppInfo: String {get set}
}

typealias LogRecordDBable = LogRecordable & TableCodable & DBModelProtocol & DBModelValidable

enum RecordType: UInt {
    case appLog = 0
    case carLog = 1
    case exit   = 2
}

enum RecordStatusType: UInt {
    case generated = 0
    case collected = 1
    case upload    = 2
    case idle      = 3
}

// MARK: - NewAppLogRecord

final class NewAppLogRecordDBModel: LogRecordDBable, LogFileUploadable {
    
    var recordId: Int64 = 0

    /// 文件名：全路径 以,分割, logFile
    var filenames: String = ""
    
    /// 创建时间
    var createTime: TimeInterval = 0
    
    var launchTime: TimeInterval = 0
    
    /// 记录类型（0启动、1.carLog、2.退车), 对应RecordType
    var type: UInt = 0
    
    /// SN号
    var sn: String = ""
    
    /// 用户ID
    var topdonId: String = ""
    
    /// IMMO / DIAG
    var carType: String = "iOSLog".uppercased()
    /// VW / LANDROVER
    var carBrand: String = "iOSLog".uppercased()
    
    var appVersion: String = ""
    
    /// 额外附加信息
    var extraInfo: String = ""
    
    /// 目标所属压缩包路径
    var zipPath: String = ""
    
    /// 0-记录生成 1-已收集 2-已上传 3-已闲置（不会收集和上传），对应RecordStatusType
    var status: UInt = 0
    
    /// LogUploadType
    var uploadType: Int = 0
    
    // MARK: - LogFileUploadable
    
    var lfuSn: String = ""
    
    var lfuCarType: String = "iOSLog".uppercased()
    
    var lfuProblem: String = ""
    
    var lfuOtherDescription: String = ""
    
    var lfuLogGenerationTime: String = ""
    
    var lfuSubmitUserName: String = ""
    
    var lfuRemark: String = ""
    
    var lfuCarSoftCode: String = ""
    
    var lfuCarBrandName: String = "iOSLog".uppercased()
    
    var lfuCarModelPath: String = ""
    
    var lfuCarLanguageId: String = ""
    
    var lfuCarModelSourceVersion: String = ""
    
    var lfuMainCarVersion: String = ""
    
    var lfuLinkCarVersion: String = ""
    
    var lfuVin: String = ""
    
    var lfuPhoneBrandName: String = ""
    
    var lfuPhoneModelName: String = ""
    
    var lfuPhoneSystemVersion: String = ""
    
    var lfuPhoneSystemLanguageId: String = ""
    
    var lfuFirmwareVersion: String = ""
    
    var lfuBootVersion: String = ""
    
    var lfuHardwareVersion: String = ""
    
    var lfuUploadType: String = ""
    
    var lfuLogType: String = ""
    
    var lfuAppVersion: String = ""
    
    var lfuPhoneSystemLanguageName: String = ""
    
    var lfuAppInfo: String = ""
    
    // MARK: - Validable
    
    var _insertSQLAppVersion: String  = ""
    
    var _insertSQLTime: TimeInterval  = 0
    
    var _SQLValidityTerm: TimeInterval = 15 * 24 * 3600
    
    var createTimeForServer: String {
        return Date(timeIntervalSince1970: createTime).string(withFormat: TopdonDateFormat.kUploadTime)
    }
    
    // MARK: - CodingKeys
    
    var isAutoIncrement: Bool {
        return true
    }
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = NewAppLogRecordDBModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(recordId, isPrimary: true, isAutoIncrement: true)
            BindIndex(recordId.asIndex(orderBy: .descending), namedWith: "_descendingIndex")
        }
        
        case recordId = "record_id"
        case filenames
        case createTime = "create_time"
        case launchTime = "launch_time"
        case type
        
        case sn = "sn"
        case topdonId = "topdon_id"
        
        case carType = "car_type"
        case carBrand = "car_brand"
        
        case appVersion = "app_version"
        
        case extraInfo  = "extra_info"
        
        case zipPath = "zip_path"
        
        case status
        
        case uploadType = "upload_type"
        
        case lfuSn
        
        case lfuCarType
        
        case lfuProblem
        
        case lfuOtherDescription
        
        case lfuLogGenerationTime
        
        case lfuSubmitUserName
        
        case lfuRemark
        
        case lfuCarSoftCode
        
        case lfuCarBrandName
        
        case lfuCarModelPath
        
        case lfuCarLanguageId
        
        case lfuCarModelSourceVersion
        
        case lfuMainCarVersion
        
        case lfuLinkCarVersion
        
        case lfuVin
        
        case lfuPhoneBrandName
        
        case lfuPhoneModelName
        
        case lfuPhoneSystemVersion
        
        case lfuPhoneSystemLanguageId
        
        case lfuFirmwareVersion
        
        case lfuBootVersion
        
        case lfuHardwareVersion
        
        case lfuUploadType
        
        case lfuLogType
        
        case lfuAppVersion
        
        case lfuPhoneSystemLanguageName
        
        case lfuAppInfo
        
        case _insertSQLAppVersion
        case _insertSQLTime
        case _SQLValidityTerm
    }
    
    var asIdle: IdleLogRecordDBModel {
        let idle = IdleLogRecordDBModel()
        idle.filenames = filenames
        idle.createTime = createTime
        idle.launchTime = launchTime
        // idle.type
        idle.sn  = sn
        idle.topdonId = topdonId
        idle.carType = carType
        idle.carBrand = carBrand
        idle.appVersion = appVersion
        idle.extraInfo  = extraInfo
        idle.zipPath    = zipPath
        // idle.status
        return idle
    }
    
    var isEmpty: Bool {
        return filenames.isEmpty
    }
    
    func update(from model: LogUploadInterface) {
        uploadType = model.lfuLogUploadType.rawValue
        lfuSn = model.lfuSn
        lfuCarType = model.lfuCarType.isEmpty ? "iOSLog".uppercased() : model.lfuCarType.uppercased()
        lfuProblem = model.lfuProblem
        lfuOtherDescription = model.lfuOtherDescription
        lfuLogGenerationTime = model.lfuLogGenerationTime
        lfuSubmitUserName = model.lfuSubmitUserName
        lfuRemark = model.lfuRemark
        lfuCarSoftCode = model.lfuCarSoftCode
        lfuCarBrandName = model.lfuCarBrandName.isEmpty ? "iOSLog".uppercased() : model.lfuCarBrandName.uppercased()
        lfuCarModelPath = model.lfuCarModelPath
        lfuCarLanguageId = model.lfuCarLanguageId
        lfuCarModelSourceVersion = model.lfuCarModelSourceVersion
        lfuMainCarVersion = model.lfuMainCarVersion
        lfuLinkCarVersion = model.lfuLinkCarVersion
        lfuVin = model.lfuVin
        lfuPhoneBrandName = model.lfuPhoneBrandName
        lfuPhoneModelName = model.lfuPhoneModelName
        lfuPhoneSystemVersion = model.lfuPhoneSystemVersion
        lfuPhoneSystemLanguageId = model.lfuPhoneSystemLanguageId
        lfuFirmwareVersion = model.lfuFirmwareVersion
        lfuBootVersion = model.lfuBootVersion
        lfuHardwareVersion = model.lfuHardwareVersion
        lfuUploadType = model.lfuUploadType
        lfuLogType = model.lfuLogType
        lfuAppVersion = model.lfuAppVersion
        lfuPhoneSystemLanguageName = model.lfuPhoneSystemLanguageName
        lfuAppInfo = model.lfuAppInfo
    }
    
    func migration(from model: AppLogRecordDBModel) {
        filenames = model.filenames
        createTime = model.createTime
        launchTime = model.launchTime
        type = model.type
        sn  = model.sn
        topdonId = model.topdonId
        carType = model.carType
        carBrand = model.carBrand
        appVersion = model.appVersion
        extraInfo  = model.extraInfo
        zipPath    = model.zipPath
        status     = model.status
        uploadType = model.uploadType
        lfuSn = model.lfuSn
        lfuCarType = model.lfuCarType
        lfuProblem = model.lfuProblem
        lfuOtherDescription = model.lfuOtherDescription
        lfuLogGenerationTime = model.lfuLogGenerationTime   // 2020-5-20 05:202:00
        lfuSubmitUserName = model.lfuSubmitUserName
        lfuRemark = model.lfuRemark
        lfuCarSoftCode = model.lfuCarSoftCode
        lfuCarBrandName = model.lfuCarBrandName
        lfuCarModelPath = model.lfuCarModelPath
        lfuCarLanguageId = model.lfuCarLanguageId
        lfuCarModelSourceVersion = model.lfuCarModelSourceVersion
        lfuMainCarVersion = model.lfuMainCarVersion
        lfuLinkCarVersion = model.lfuLinkCarVersion
        lfuVin = model.lfuVin
        lfuPhoneBrandName = model.lfuPhoneBrandName
        lfuPhoneModelName = model.lfuPhoneModelName
        lfuPhoneSystemVersion = model.lfuPhoneSystemVersion
        lfuPhoneSystemLanguageId = model.lfuPhoneSystemLanguageId
        lfuFirmwareVersion = model.lfuFirmwareVersion
        lfuBootVersion = model.lfuBootVersion
        lfuHardwareVersion = model.lfuHardwareVersion
        lfuUploadType = model.lfuUploadType
        lfuLogType = model.lfuLogType
        lfuAppVersion = model.lfuAppVersion
        lfuPhoneSystemLanguageName = model.lfuPhoneSystemLanguageName
        lfuAppInfo = model.lfuAppInfo

        _insertSQLAppVersion = model._insertSQLAppVersion
        _insertSQLTime = model._insertSQLTime
        _SQLValidityTerm = model._SQLValidityTerm
    }
    
//    static func queryLastRecord(with type: RecordType = .appLog) -> AppLogRecordDBModel? {
//        try? DBStore.db.getObjects(on: AppLogRecordDBModel.Properties.all,
//                                   fromTable: AppLogRecordDBModel.tableName,
//                                   where: AppLogRecordDBModel.Properties.type == type.rawValue,
//                                   orderBy: [AppLogRecordDBModel.Properties.createTime.order(.descending)],
//                                   limit: 1).first
//    }
    
    
    func updateIntoDB() {
        //self.updateToDB(on: NewAppLogRecordDBModel.Properties.all)
         do {
             try DBStore.db.create(table: Self.tableName, of: Self.self)
             try DBStore.db.update(
                 table: Self.tableName,
                 on: NewAppLogRecordDBModel.Properties.all,
                 with: self,
                 where: Self.Properties.recordId == self.recordId // 添加 where 条件，确保更新目标
             )
         } catch {
             innerLogger("❌ 数据库更新失败：\(error)")
         }
    }
    
    /// 查询最新的记录 （app or exit car）
    static func queryLastRecord() -> NewAppLogRecordDBModel? {
        try? DBStore.db.getObjects(on: NewAppLogRecordDBModel.Properties.all,
                                   fromTable: NewAppLogRecordDBModel.tableName,
                                   where: NewAppLogRecordDBModel.Properties.type == RecordType.appLog.rawValue || NewAppLogRecordDBModel.Properties.type == RecordType.exit.rawValue,
                                   orderBy: [NewAppLogRecordDBModel.Properties.recordId.order(.descending)],
                                   limit: 1).first
    }
    
    /// 查询未处理的记录 （app or exit car）
    static func queryNotHandleRecord() -> [NewAppLogRecordDBModel]? {
        let condition: Condition = (NewAppLogRecordDBModel.Properties.type == RecordType.appLog.rawValue || NewAppLogRecordDBModel.Properties.type == RecordType.exit.rawValue) && NewAppLogRecordDBModel.Properties.status == RecordStatusType.generated.rawValue
        
        return try? DBStore.db.getObjects(on: NewAppLogRecordDBModel.Properties.all,
                                          fromTable: NewAppLogRecordDBModel.tableName,
                                          where: condition,
                                          orderBy: [NewAppLogRecordDBModel.Properties.recordId.order(.descending)])
    }
    
    static func queryLaunchOrExitDiagRecord(with createTime: TimeInterval) -> NewAppLogRecordDBModel? {
        
        let condition: Condition = (NewAppLogRecordDBModel.Properties.type == RecordType.appLog.rawValue || NewAppLogRecordDBModel.Properties.type == RecordType.exit.rawValue) && (NewAppLogRecordDBModel.Properties.status == RecordStatusType.generated.rawValue && NewAppLogRecordDBModel.Properties.createTime == createTime)
        
       return try? DBStore.db.getObjects(on: NewAppLogRecordDBModel.Properties.all,
                                   fromTable: NewAppLogRecordDBModel.tableName,
                                   where: condition,
                                   orderBy: [NewAppLogRecordDBModel.Properties.recordId.order(.descending)],
                                   limit: 1).first
    }
    
    static func query(with zipPath: String) -> NewAppLogRecordDBModel? {
        let removeDocumentsZipPath = zipPath.removeDocumentsPath
        
        let condition: Condition = (NewAppLogRecordDBModel.Properties.type == RecordType.appLog.rawValue || NewAppLogRecordDBModel.Properties.type == RecordType.exit.rawValue) && (NewAppLogRecordDBModel.Properties.status == RecordStatusType.collected.rawValue && NewAppLogRecordDBModel.Properties.zipPath == removeDocumentsZipPath)
        
       return try? DBStore.db.getObjects(on: NewAppLogRecordDBModel.Properties.all,
                                   fromTable: NewAppLogRecordDBModel.tableName,
                                   where: condition,
                                   orderBy: [NewAppLogRecordDBModel.Properties.recordId.order(.descending)],
                                   limit: 1).first
    }
    
//    static func deleteModels(by expireTime: TimeInterval) {
//        try? DBStore.db.delete(fromTable: AppLogRecordDBModel.tableName,
//                               where: AppLogRecordDBModel.Properties.createTime <= expireTime)
//    }
    
    static func delete(old timestamp: TimeInterval) {
        Self.baseDelete(where: NewAppLogRecordDBModel.Properties._insertSQLTime <= timestamp)
    }
    
    static func delete(with zipPath: String) {
        let fixZipPath = zipPath.removeDocumentsPath
        Self.baseDelete(where: NewAppLogRecordDBModel.Properties.zipPath == fixZipPath)
    }
    
}

// MARK: - AppLogRecord

final class AppLogRecordDBModel: LogRecordDBable, LogFileUploadable {

    /// 文件名：全路径 以,分割, logFile
    var filenames: String = ""
    
    /// 创建时间
    var createTime: TimeInterval = 0
    
    var launchTime: TimeInterval = 0
    
    /// 记录类型（0启动、1.carLog、2.退车), 对应RecordType
    var type: UInt = 0
    
    /// SN号
    var sn: String = ""
    
    /// 用户ID
    var topdonId: String = ""
    
    /// IMMO / DIAG
    var carType: String = "iOSLog".uppercased()
    /// VW / LANDROVER
    var carBrand: String = "iOSLog".uppercased()
    
    var appVersion: String = ""
    
    /// 额外附加信息
    var extraInfo: String = ""
    
    /// 目标所属压缩包路径
    var zipPath: String = ""
    
    /// 0-记录生成 1-已收集 2-已上传 3-已闲置（不会收集和上传），对应RecordStatusType
    var status: UInt = 0
    
    /// LogUploadType
    var uploadType: Int = 0
    
    // MARK: - LogFileUploadable
    
    var lfuSn: String = ""
    
    var lfuCarType: String = "iOSLog".uppercased()
    
    var lfuProblem: String = ""
    
    var lfuOtherDescription: String = ""
    
    var lfuLogGenerationTime: String = ""
    
    var lfuSubmitUserName: String = ""
    
    var lfuRemark: String = ""
    
    var lfuCarSoftCode: String = ""
    
    var lfuCarBrandName: String = "iOSLog".uppercased()
    
    var lfuCarModelPath: String = ""
    
    var lfuCarLanguageId: String = ""
    
    var lfuCarModelSourceVersion: String = ""
    
    var lfuMainCarVersion: String = ""
    
    var lfuLinkCarVersion: String = ""
    
    var lfuVin: String = ""
    
    var lfuPhoneBrandName: String = ""
    
    var lfuPhoneModelName: String = ""
    
    var lfuPhoneSystemVersion: String = ""
    
    var lfuPhoneSystemLanguageId: String = ""
    
    var lfuFirmwareVersion: String = ""
    
    var lfuBootVersion: String = ""
    
    var lfuHardwareVersion: String = ""
    
    var lfuUploadType: String = ""
    
    var lfuLogType: String = ""
    
    var lfuAppVersion: String = ""
    
    var lfuPhoneSystemLanguageName: String = ""
    
    var lfuAppInfo: String = ""
    
    // MARK: - Validable
    
    var _insertSQLAppVersion: String  = ""
    
    var _insertSQLTime: TimeInterval  = 0
    
    var _SQLValidityTerm: TimeInterval = 15 * 24 * 3600
    
    var createTimeForServer: String {
        return Date(timeIntervalSince1970: createTime).string(withFormat: TopdonDateFormat.kUploadTime)
    }
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = AppLogRecordDBModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(createTime, isPrimary: true)
            BindIndex(createTime.asIndex(orderBy: .descending), namedWith: "_descendingIndex")
        }
        
        case filenames
        case createTime = "create_time"
        case launchTime = "launch_time"
        case type
        
        case sn = "sn"
        case topdonId = "topdon_id"
        
        case carType = "car_type"
        case carBrand = "car_brand"
        
        case appVersion = "app_version"
        
        case extraInfo  = "extra_info"
        
        case zipPath = "zip_path"
        
        case status
        
        case uploadType = "upload_type"
        
        case lfuSn
        
        case lfuCarType
        
        case lfuProblem
        
        case lfuOtherDescription
        
        case lfuLogGenerationTime
        
        case lfuSubmitUserName
        
        case lfuRemark
        
        case lfuCarSoftCode
        
        case lfuCarBrandName
        
        case lfuCarModelPath
        
        case lfuCarLanguageId
        
        case lfuCarModelSourceVersion
        
        case lfuMainCarVersion
        
        case lfuLinkCarVersion
        
        case lfuVin
        
        case lfuPhoneBrandName
        
        case lfuPhoneModelName
        
        case lfuPhoneSystemVersion
        
        case lfuPhoneSystemLanguageId
        
        case lfuFirmwareVersion
        
        case lfuBootVersion
        
        case lfuHardwareVersion
        
        case lfuUploadType
        
        case lfuLogType
        
        case lfuAppVersion
        
        case lfuPhoneSystemLanguageName
        
        case lfuAppInfo
        
        case _insertSQLAppVersion
        case _insertSQLTime
        case _SQLValidityTerm
    }
    
    var asIdle: IdleLogRecordDBModel {
        let idle = IdleLogRecordDBModel()
        idle.filenames = filenames
        idle.createTime = createTime
        idle.launchTime = launchTime
        // idle.type
        idle.sn  = sn
        idle.topdonId = topdonId
        idle.carType = carType
        idle.carBrand = carBrand
        idle.appVersion = appVersion
        idle.extraInfo  = extraInfo
        idle.zipPath    = zipPath
        // idle.status
        return idle
    }
    
    var isEmpty: Bool {
        return filenames.isEmpty
    }
    
    func update(from model: LogUploadInterface) {
        uploadType = model.lfuLogUploadType.rawValue
        lfuSn = model.lfuSn
        lfuCarType = model.lfuCarType.isEmpty ? "iOSLog".uppercased() : model.lfuCarType.uppercased()
        lfuProblem = model.lfuProblem
        lfuOtherDescription = model.lfuOtherDescription
        lfuLogGenerationTime = model.lfuLogGenerationTime
        lfuSubmitUserName = model.lfuSubmitUserName
        lfuRemark = model.lfuRemark
        lfuCarSoftCode = model.lfuCarSoftCode
        lfuCarBrandName = model.lfuCarBrandName.isEmpty ? "iOSLog".uppercased() : model.lfuCarBrandName.uppercased()
        lfuCarModelPath = model.lfuCarModelPath
        lfuCarLanguageId = model.lfuCarLanguageId
        lfuCarModelSourceVersion = model.lfuCarModelSourceVersion
        lfuMainCarVersion = model.lfuMainCarVersion
        lfuLinkCarVersion = model.lfuLinkCarVersion
        lfuVin = model.lfuVin
        lfuPhoneBrandName = model.lfuPhoneBrandName
        lfuPhoneModelName = model.lfuPhoneModelName
        lfuPhoneSystemVersion = model.lfuPhoneSystemVersion
        lfuPhoneSystemLanguageId = model.lfuPhoneSystemLanguageId
        lfuFirmwareVersion = model.lfuFirmwareVersion
        lfuBootVersion = model.lfuBootVersion
        lfuHardwareVersion = model.lfuHardwareVersion
        lfuUploadType = model.lfuUploadType
        lfuLogType = model.lfuLogType
        lfuAppVersion = model.lfuAppVersion
        lfuPhoneSystemLanguageName = model.lfuPhoneSystemLanguageName
        lfuAppInfo = model.lfuAppInfo
    }
    
    func updateIntoDB() {
        insertToDB()
    }
    
    static func queryAllRecord() -> [AppLogRecordDBModel]? {
        try? DBStore.db.getObjects(on: AppLogRecordDBModel.Properties.all,
                                   fromTable: AppLogRecordDBModel.tableName)
    }
    
    /// 查询最新的记录 （app or exit car）
    static func queryLastRecord() -> AppLogRecordDBModel? {
        try? DBStore.db.getObjects(on: AppLogRecordDBModel.Properties.all,
                                   fromTable: AppLogRecordDBModel.tableName,
                                   where: AppLogRecordDBModel.Properties.type == RecordType.appLog.rawValue || AppLogRecordDBModel.Properties.type == RecordType.exit.rawValue,
                                   orderBy: [AppLogRecordDBModel.Properties.createTime.order(.descending)],
                                   limit: 1).first
    }
    
    /// 查询未处理的记录 （app or exit car）
    static func queryNotHandleRecord() -> [AppLogRecordDBModel]? {
        let condition: Condition = (AppLogRecordDBModel.Properties.type == RecordType.appLog.rawValue || AppLogRecordDBModel.Properties.type == RecordType.exit.rawValue) && AppLogRecordDBModel.Properties.status == RecordStatusType.generated.rawValue
        
        return try? DBStore.db.getObjects(on: AppLogRecordDBModel.Properties.all,
                                          fromTable: AppLogRecordDBModel.tableName,
                                          where: condition,
                                          orderBy: [AppLogRecordDBModel.Properties.createTime.order(.descending)])
    }
    
    static func queryLaunchOrExitDiagRecord(with createTime: TimeInterval) -> AppLogRecordDBModel? {
        
        let condition: Condition = (AppLogRecordDBModel.Properties.type == RecordType.appLog.rawValue || AppLogRecordDBModel.Properties.type == RecordType.exit.rawValue) && (AppLogRecordDBModel.Properties.status == RecordStatusType.generated.rawValue && AppLogRecordDBModel.Properties.createTime == createTime)
        
       return try? DBStore.db.getObjects(on: AppLogRecordDBModel.Properties.all,
                                   fromTable: AppLogRecordDBModel.tableName,
                                   where: condition,
                                   orderBy: [AppLogRecordDBModel.Properties.createTime.order(.descending)],
                                   limit: 1).first
    }
    
    static func query(with zipPath: String) -> AppLogRecordDBModel? {
        let removeDocumentsZipPath = zipPath.removeDocumentsPath
        
        let condition: Condition = (AppLogRecordDBModel.Properties.type == RecordType.appLog.rawValue || AppLogRecordDBModel.Properties.type == RecordType.exit.rawValue) && (AppLogRecordDBModel.Properties.status == RecordStatusType.collected.rawValue && AppLogRecordDBModel.Properties.zipPath == removeDocumentsZipPath)
        
       return try? DBStore.db.getObjects(on: AppLogRecordDBModel.Properties.all,
                                   fromTable: AppLogRecordDBModel.tableName,
                                   where: condition,
                                   orderBy: [AppLogRecordDBModel.Properties.createTime.order(.descending)],
                                   limit: 1).first
    }
    
//    static func deleteModels(by expireTime: TimeInterval) {
//        try? DBStore.db.delete(fromTable: AppLogRecordDBModel.tableName, 
//                               where: AppLogRecordDBModel.Properties.createTime <= expireTime)
//    }
    
    static func delete(old timestamp: TimeInterval) {
        Self.baseDelete(where: AppLogRecordDBModel.Properties._insertSQLTime <= timestamp)
    }
    
    static func delete(with zipPath: String) {
        let fixZipPath = zipPath.removeDocumentsPath
        Self.baseDelete(where: AppLogRecordDBModel.Properties.zipPath == fixZipPath)
    }
    
}

// MARK: - EnterDiagLogRecord

final class EnterDiagLogRecordDBModel: LogRecordDBable, LogFileUploadable {
    
    /// 关联的 AppLogRecordDBModel, createTime
    var appLogRecordId: TimeInterval = 0
    
    /// 文件名：全路径 carLogs
    var filenames: String = ""
    
    /// 创建时间
    var createTime: TimeInterval = 0
    
    var launchTime: TimeInterval = 0
    
    /// 记录类型（0启动、1.carLog、2.退车）
    var type: UInt = 1
    
    /// SN号
    var sn: String = ""
    
    /// 用户ID
    var topdonId: String = ""
    
    /// IMMO / DIAG
    var carType: String = ""
    /// VW / LANDROVER
    var carBrand: String = ""
    
    /// AUDI-汽车防盗-202408261101
    var dispalyLogType: String = ""
    
    var appVersion: String = ""
    
    /// 额外附加信息
    var extraInfo: String = ""
    
    /// 目标所属压缩包路径
    var zipPath: String = ""
    
    /// 0-记录生成 1-已收集 2-已上传 3-已闲置（不会收集和上传）
    var status: UInt = 0
    
    /// LogUploadType
    var uploadType: Int = 0
    
    /// -1 代表无意义
    var autoVinEntryType: Int = -1
    
    /// 查询暂存
    //var appLogRecord: AppLogRecordDBModel?
    var newAppLogRecord: NewAppLogRecordDBModel?
    
    // MARK: - LogFileUploadable
    
    var lfuSn: String = ""
    
    var lfuCarType: String = ""
    
    var lfuProblem: String = ""
    
    var lfuOtherDescription: String = ""
    
    var lfuLogGenerationTime: String = ""
    
    var lfuSubmitUserName: String = ""
    
    var lfuRemark: String = ""
    
    var lfuCarSoftCode: String = ""
    
    var lfuCarBrandName: String = ""
    
    var lfuCarModelPath: String = ""
    
    var lfuCarLanguageId: String = ""
    
    var lfuCarModelSourceVersion: String = ""
    
    var lfuMainCarVersion: String = ""
    
    var lfuLinkCarVersion: String = ""
    
    var lfuVin: String = ""
    
    var lfuPhoneBrandName: String = ""
    
    var lfuPhoneModelName: String = ""
    
    var lfuPhoneSystemVersion: String = ""
    
    var lfuPhoneSystemLanguageId: String = ""
    
    var lfuFirmwareVersion: String = ""
    
    var lfuBootVersion: String = ""
    
    var lfuHardwareVersion: String = ""
    
    var lfuUploadType: String = ""
    
    var lfuLogType: String = ""
    
    var lfuAppVersion: String = ""
    
    var lfuPhoneSystemLanguageName: String = ""
    
    var lfuAppInfo: String = ""
    
    // MARK: - Ex
    var isAutoVin: Bool {
        carBrand.uppercased() == "AUTOVIN"
    }
    
    var isEmpty: Bool {
        return filenames.isEmpty && appLogRecordId <= 0
    }
    
    // MARK: - Validable
    
    var _insertSQLAppVersion: String  = ""
    
    var _insertSQLTime: TimeInterval  = 0
    
    var _SQLValidityTerm: TimeInterval = 15 * 24 * 3600
    
    var createTimeForServer: String {
        return Date(timeIntervalSince1970: createTime).string(withFormat: TopdonDateFormat.kUploadTime)
    }
    
    func update(from model: LogUploadInterface) {
        uploadType = model.lfuLogUploadType.rawValue
        lfuSn = model.lfuSn
        lfuCarType = model.lfuCarType.uppercased()
        lfuProblem = model.lfuProblem
        lfuOtherDescription = model.lfuOtherDescription
        lfuLogGenerationTime = model.lfuLogGenerationTime
        lfuSubmitUserName = model.lfuSubmitUserName
        lfuRemark = model.lfuRemark
        lfuCarSoftCode = model.lfuCarSoftCode
        lfuCarBrandName = model.lfuCarBrandName.uppercased()
        lfuCarModelPath = model.lfuCarModelPath
        lfuCarLanguageId = model.lfuCarLanguageId
        lfuCarModelSourceVersion = model.lfuCarModelSourceVersion
        lfuMainCarVersion = model.lfuMainCarVersion
        lfuLinkCarVersion = model.lfuLinkCarVersion
        lfuVin = model.lfuVin
        lfuPhoneBrandName = model.lfuPhoneBrandName
        lfuPhoneModelName = model.lfuPhoneModelName
        lfuPhoneSystemVersion = model.lfuPhoneSystemVersion
        lfuPhoneSystemLanguageId = model.lfuPhoneSystemLanguageId
        lfuFirmwareVersion = model.lfuFirmwareVersion
        lfuBootVersion = model.lfuBootVersion
        lfuHardwareVersion = model.lfuHardwareVersion
        lfuUploadType = model.lfuUploadType
        lfuLogType = model.lfuLogType
        lfuAppVersion = model.lfuAppVersion
        lfuPhoneSystemLanguageName = model.lfuPhoneSystemLanguageName
        lfuAppInfo = model.lfuAppInfo
    }
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = EnterDiagLogRecordDBModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(createTime, isPrimary: true)
            BindIndex(createTime.asIndex(orderBy: .descending), namedWith: "_descendingIndex")
        }
        case appLogRecordId = "appLogRecord_id"
        case filenames  = "carLog_filenames"
        case createTime = "create_time"
        case launchTime = "launch_time"
        case type
        
        case sn = "sn"
        case topdonId = "topdon_id"
        
        case carType = "car_type"
        case carBrand = "car_brand"
        
        case appVersion = "app_version"
        
        case extraInfo  = "extra_info"
        
        case dispalyLogType = "dispaly_log_type"
        
        case zipPath = "zip_path"
        
        case status
        
        case uploadType = "upload_type"
        
        case lfuSn
        
        case lfuCarType
        
        case lfuProblem
        
        case lfuOtherDescription
        
        case lfuLogGenerationTime
        
        case lfuSubmitUserName
        
        case lfuRemark
        
        case lfuCarSoftCode
        
        case lfuCarBrandName
        
        case lfuCarModelPath
        
        case lfuCarLanguageId
        
        case lfuCarModelSourceVersion
        
        case lfuMainCarVersion
        
        case lfuLinkCarVersion
        
        case lfuVin
        
        case lfuPhoneBrandName
        
        case lfuPhoneModelName
        
        case lfuPhoneSystemVersion
        
        case lfuPhoneSystemLanguageId
        
        case lfuFirmwareVersion
        
        case lfuBootVersion
        
        case lfuHardwareVersion
        
        case lfuUploadType
        
        case lfuLogType
        
        case lfuAppVersion
        
        case lfuPhoneSystemLanguageName
        
        case lfuAppInfo
        
        case autoVinEntryType
        
        case _insertSQLAppVersion
        case _insertSQLTime
        case _SQLValidityTerm
    }
    
    func updateIntoDB() {
        insertToDB()
    }
    
    /// 获取最近一条未归集的进车记录
    static func queryLastRecord(by car: Car) -> EnterDiagLogRecordDBModel? {
        
        let condition: WCDBSwift.Condition = EnterDiagLogRecordDBModel.Properties.carType == car.strType
        && EnterDiagLogRecordDBModel.Properties.carBrand == car.brand
        && EnterDiagLogRecordDBModel.Properties.status == RecordStatusType.generated.rawValue
        && EnterDiagLogRecordDBModel.Properties.type == RecordType.carLog.rawValue
        
        return try? DBStore.db.getObjects(on: EnterDiagLogRecordDBModel.Properties.all,
                                          fromTable: EnterDiagLogRecordDBModel.tableName,
                                          where: condition,
                                          orderBy: [EnterDiagLogRecordDBModel.Properties.createTime.order(.descending)],
                                          limit: 1).first
    }
    
    static func queryNotHandleRecord() -> [EnterDiagLogRecordDBModel]? {
        let condition: Condition = (EnterDiagLogRecordDBModel.Properties.type == RecordType.carLog.rawValue) && EnterDiagLogRecordDBModel.Properties.status == RecordStatusType.generated.rawValue
        
        return try? DBStore.db.getObjects(on: EnterDiagLogRecordDBModel.Properties.all,
                                          fromTable: EnterDiagLogRecordDBModel.tableName,
                                          where: condition,
                                          orderBy: [EnterDiagLogRecordDBModel.Properties.createTime.order(.descending)])
    }
    
    static func query(with zipPath: String) -> EnterDiagLogRecordDBModel? {
        let removePath = zipPath.removeDocumentsPath
        
        let condition: Condition = (EnterDiagLogRecordDBModel.Properties.type == RecordType.carLog.rawValue) && (EnterDiagLogRecordDBModel.Properties.status == RecordStatusType.collected.rawValue && EnterDiagLogRecordDBModel.Properties.zipPath == removePath)
        
       return try? DBStore.db.getObjects(on: EnterDiagLogRecordDBModel.Properties.all,
                                   fromTable: EnterDiagLogRecordDBModel.tableName,
                                   where: condition,
                                   orderBy: [EnterDiagLogRecordDBModel.Properties.createTime.order(.descending)],
                                   limit: 1).first
    }
    
    static func queryAssociatedNewAppLogRecord(with createTime: TimeInterval) -> NewAppLogRecordDBModel? {
        
        let condition: Condition = (NewAppLogRecordDBModel.Properties.type == RecordType.carLog.rawValue) && (NewAppLogRecordDBModel.Properties.status == RecordStatusType.generated.rawValue && NewAppLogRecordDBModel.Properties.createTime == createTime)
        
       return try? DBStore.db.getObjects(on: NewAppLogRecordDBModel.Properties.all,
                                   fromTable: NewAppLogRecordDBModel.tableName,
                                   where: condition,
                                   orderBy: [NewAppLogRecordDBModel.Properties.recordId.order(.descending)],
                                   limit: 1).first
    }
    
    static func queryAssociatedAppLogRecord(with createTime: TimeInterval) -> AppLogRecordDBModel? {
        
        let condition: Condition = (AppLogRecordDBModel.Properties.type == RecordType.carLog.rawValue) && (AppLogRecordDBModel.Properties.status == RecordStatusType.generated.rawValue && AppLogRecordDBModel.Properties.createTime == createTime)
        
       return try? DBStore.db.getObjects(on: AppLogRecordDBModel.Properties.all,
                                   fromTable: AppLogRecordDBModel.tableName,
                                   where: condition,
                                   orderBy: [AppLogRecordDBModel.Properties.createTime.order(.descending)],
                                   limit: 1).first
    }
    
    static func delete(old timestamp: TimeInterval) {
        Self.baseDelete(where: EnterDiagLogRecordDBModel.Properties._insertSQLTime <= timestamp)
    }
    
    static func delete(with zipPath: String) {
        let fixZipPath = zipPath.removeDocumentsPath
        Self.baseDelete(where: EnterDiagLogRecordDBModel.Properties.zipPath == fixZipPath)
    }
    
}


// MARK: - IdleLogRecord

final class IdleLogRecordDBModel: LogRecordDBable {
    
    /// 文件名：全路径
    var filenames: String = ""
    
    /// 创建时间
    var createTime: TimeInterval = 0
    
    var launchTime: TimeInterval = 0
    
    /// 记录类型（0启动、1.carLog、2.退车）
    var type: UInt = 2
    
    /// SN号
    var sn: String = ""
    
    /// 用户ID
    var topdonId: String = ""
    
    /// IMMO / DIAG
    var carType: String = ""
    /// VW / LANDROVER
    var carBrand: String = ""
    
    var appVersion: String = ""
    
    /// 额外附加信息
    var extraInfo: String = ""
    
    /// 目标所属压缩包路径
    var zipPath: String = ""
    
    /// 0-记录生成 1-已收集 2-已上传 3-已闲置（不会收集和上传）
    var status: UInt = 3
    
    // MARK: - Validable
    
    var _insertSQLAppVersion: String  = ""
    
    var _insertSQLTime: TimeInterval  = 0
    
    var _SQLValidityTerm: TimeInterval = 15 * 24 * 3600
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = IdleLogRecordDBModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(createTime, isPrimary: true)
            BindIndex(createTime.asIndex(orderBy: .descending), namedWith: "_descendingIndex")
        }
        
        case filenames
        case createTime = "create_time"
        case launchTime = "launch_time"
        case type
        
        case sn = "sn"
        case topdonId = "topdon_id"
        
        case carType = "car_type"
        case carBrand = "car_brand"
        
        case appVersion = "app_version"
        
        case extraInfo  = "extra_info"
        
        case zipPath = "zip_path"
        
        case status
        
        case _insertSQLAppVersion
        case _insertSQLTime
        case _SQLValidityTerm
    }
    
    func updateIntoDB() {
        insertToDB()
    }
    
    static func queryAllByDesc() -> [IdleLogRecordDBModel]? {
        try? DBStore.db.getObjects(on: IdleLogRecordDBModel.Properties.all,
                                   fromTable: IdleLogRecordDBModel.tableName,
                                   orderBy: [IdleLogRecordDBModel.Properties.createTime.order(.descending)])
    }
    
    static func deleteModels(by expireTime: TimeInterval) {
        try? DBStore.db.delete(fromTable: IdleLogRecordDBModel.tableName,
                               where: IdleLogRecordDBModel.Properties.createTime <= expireTime)
    }
    
    static func insertOrReplace(models: [IdleLogRecordDBModel]) {
        try? DBStore.db.insertOrReplace(models, intoTable: IdleLogRecordDBModel.tableName)
    }
}
