//
//  LogManager.swift
//  TopdonLog
//
//  Created by xinwenliu on 2023/11/21.
//

import Foundation
import SSZipArchive
import TDWCDB
import WCDBSwift

// MARK: - Interface
public protocol LogColletionManagerDelegate: AnyObject {
    
    func getVciSN() -> String
    
    /// 获取 topdonId
    func getTopdonId() -> String
    
    /// 获取附件信息
    func getAppendexInfos() -> String

    /// 获取上传接口字段信息
    func getUploadInterface(car: Car?, uploadType: LogUploadType) -> LogUploadInterface
}

//extension TopdonLog {

    public protocol LogUploadInterface: AnyObject {
        
        var lfuLogUploadType: LogUploadType {get set}
        
        var lfuSn: String { get set}
        /// 车型
        var lfuCarType: String { get set}
        
        var lfuProblem: String { get set}
        
        var lfuOtherDescription: String { get set}
        
        /// 2020-5-20 05:202:00, 外部传不会用到了，如果是查表的zip使用建表时间，如果是反馈的这种使用外部传时间
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
    
//}

// MARK: - LogColletionManager
/// 日志收集管理类
final public class LogColletionManager {
    
    public static let shared = LogColletionManager()
    
    /// 反馈选日志过滤类型
    public var feedbackFilterBrands: [String] = ["iOSFramework", "iOSBlueTooth", "Battery"]
    
    private(set) var launchTime: String = TopdonLog.appInfo.launchTime {
        didSet {
            appLog.launchTime = launchTime
            carLog.launchTime = launchTime
            diagCarLog.launchTime = launchTime
        }
    }
    
    weak var delegate: LogColletionManagerDelegate?
    
    /// 是否，自动上传需要带上`appLog`和`carLog`
    @UserDefault(key: "kisStopAutoUploadLog", defaultValue: false)
    public var isStopAutoUploadLog: Bool {
        didSet {
            logger?.writeLogEnable = !isStopAutoUploadLog
        }
    }
    
    @UserDefault(key: "kTopdonLogDeviceSN", defaultValue: "Unknown_SN")
    public var deviceSN: String
    
    private var logger: TopdonLog.Type?
    
    private var vciInfo: VCIInfo {
        let sn = delegate?.getVciSN() ?? ""
        return VCIInfo(sn: sn)
    }
    
    private lazy var appInfo: AppInfo = TopdonLog.appInfo
    private var kiOSLog = "iOSLog".uppercased()
    
    // MARK: - Dir
    
    // Path
    public private(set) var topDir: String  = "TD"
    public private(set) var diagDir: String = "AD200"
    
    // System Dir Path
    private lazy var documentsDir: String  = AppFile.documentPath
    
    // /Documents/Log
    private lazy var appLogDir: String     = AppFile.childrenDir(parentDir: documentsDir, componet: "Log", intermediateDirectories: true)
    
    /// 诊断库日志路径： /Documents/TD/AD200/DataLog
    private lazy var diagCarLogDir: String = getDiagCarLogDir(topDir: topDir, diagDir: diagDir)
    
    /// App 启动上传日志临时目录
    private lazy var launchUploadLogsTempDir: String = getLaunchUploadLogsTempDir(topDir: topDir, diagDir: diagDir)
    /// App 启动上传zip目录
    private lazy var launchUploadingDir: String = getLaunchUploadingDir(topDir: topDir, diagDir: diagDir)
    
    /// 反馈上传临时目录
    private lazy var feedbackTempDir: String = getFeedbackTempDir(topDir: topDir, diagDir: diagDir)
    
    /// 上传临时目录 /Documents/TD/AD200/updataLogsTemp/
    private lazy var uploadTempDir: String = getUploadTempDir(topDir: topDir, diagDir: diagDir)
    
    /// 上传目录   /Documents/TD/AD200/updateLogs
    private lazy var uploadLogsDir: String = getUpdateLogsDir(topDir: topDir, diagDir: diagDir)
    
    // MARK: - Log
    
    private lazy var appLog: AppLog = .init(logDir: appLogDir, launchTime: launchTime)
    
    private lazy var carLog: CarLog = .init(logDir: appLogDir, launchTime: launchTime)
    
    private lazy var diagCarLog: DiagCarLog = .init(logDir: diagCarLogDir, launchTime: launchTime)
    
    var dbPath: String { DBStore.dbPath }
    
    // MARK: - Queue
    
    private var operationQueue: DispatchQueue = .init(label: "com.topdonlog.manager")
    
    private var syncSemaphore = DispatchSemaphore(value: 0)
    
    private init() {
        setupDB()
    }
    
    @discardableResult
    public func config(_ log: TopdonLog.Type) -> Self {
        logger = log
        
        self.launchTime = TopdonLog.appInfo.launchTime
        
        log.onCreateLogFile = { newLogFileName in
            self.onCreateLogFile(newLogFileName)
        }
        log.onRenameLogFile = { oldName, newName in
            self.onRenameLogFile(oldName: oldName, newName: newName)
        }
        return self
    }
    
    public func setup(delegate: LogColletionManagerDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    public func setup(feedbackFilterBrands: [String]) -> Self {
        self.feedbackFilterBrands = feedbackFilterBrands
        return self
    }
    
    /// 不建议使用
    public func update(topDir: String, diagDir: String) -> Self {
        
        diagCarLogDir = getDiagCarLogDir(topDir: topDir, diagDir: diagDir)
        uploadTempDir = getUploadTempDir(topDir: topDir, diagDir: diagDir)
        uploadLogsDir = getUpdateLogsDir(topDir: topDir, diagDir: diagDir)
        
        return self
    }
    
    /// 获取反馈 log 日志路径
    public func getFeedbackLogsPath(sn: String) -> String {
        if sn.isEmpty { return "" }
        
        let snTempDir = AppFile.childrenDir(parentDir: self.feedbackTempDir, componet: sn)
        guard FileManager.default.fileExists(atPath: snTempDir) else {
            return ""
        }
        
        return snTempDir
    }
    
    /// 进车
    func enter(car: Car) {
        
        carLog.car = car
        
        /// 记录进车时间
        let enterCarTime = Date.current().string(withFormatter: TopdonLog.appInfo.launchDateFormatter)
        launchTime = enterCarTime
    }
    
    /// 退车
    func stop(car: Car) {
        
        carLog.car = nil
        
        // 恢复为启动时间
        launchTime = TopdonLog.appInfo.launchTime
        
    }
    
    /// 获取反馈日志：xxx.zip, 使用 uploadInterface, 有事car为空； inDiag = true 标识诊断内反馈
    public func fetchFeedbackLog(with car: Car, inDiag: Bool = false, uploadInterface: LogUploadInterface, completion: @escaping (LogUploadModel?)->Void) {
        operationQueue.async {
            
            var type: String  = car.strType.uppercased()
            let kiOSLog = self.kiOSLog
            if type.isEmpty { type = kiOSLog } // 此时拿不到车型日志
            
            var brand: String = car.brand.uppercased()
            if brand.isEmpty { brand = kiOSLog }
            
            let current = Date.current()
            let millionSeconds = current.millionSeconds
            
            // 0. 创建临时目录
            let currentUploadTempDir = AppFile.childrenDir(parentDir: self.feedbackTempDir,
                                                           componet: "\(Int64(millionSeconds))/\(brand)",
                                                           intermediateDirectories: true)
            let toRemoveDir = AppFile.childrenDir(parentDir: self.feedbackTempDir,
                                                  componet: "\(Int64(millionSeconds))",
                                                  intermediateDirectories: false)
            
            guard FileManager.default.fileExists(atPath: currentUploadTempDir) else {
#if DEBUG
                innerLogger("创建 dir: \(currentUploadTempDir) 失败.")
#endif
                completion(nil)
                return
            }
            
            // 提前声明zip for DB
            var zipModel = ZipModel(appName: self.appInfo.appName,
                                    platform: self.appInfo.platform,
                                    appVersion: self.appInfo.version,
                                    vciSN: self.vciInfo.wrapperSN,
                                    vin: uploadInterface.lfuVin,
                                    type: type,
                                    createTime: current.string(),
                                    brand: brand,
                                    filePath: "",
                                    dbPath: self.dbPath
            )
            
            let zipName   = zipModel.zipName
            
            AppFile.isDirectoryExist(atPath: self.launchUploadingDir, isCreate: true)
            let zipPath   = self.launchUploadingDir.ns.appendingPathComponent(zipName)
            zipModel.filePath = zipPath
            
            var failLogCount: Int = 0
            var failContent: String = ""
            
            // 1. a. app日志 /log/log
            // 复制app日志到反馈临时文件夹
            // 诊断内不需要 app日志
            let appLogs: [String] = inDiag ? [] : self.appLog.collectionLogs()
            for log in appLogs {
                
                let logName = log.ns.lastPathComponent
                let desPath = currentUploadTempDir.ns.appendingPathComponent(logName)
                
                let error = AppFile.copyFile(atPath: log, toPath: desPath)
                
                let hasError = error != nil
                if hasError {
                    failLogCount += 1
                }
                
            }
            
            failContent = failLogCount > 0 ? "AppLog总\(appLogs.count)个, \(failLogCount)个上传失败" : ""
            
            failLogCount = 0
            // b. carLog /log/VW
            let carLogs = self.carLog.collectionLogs()
            for log in carLogs {
                
                let logName = log.ns.lastPathComponent
                let desPath = currentUploadTempDir.ns.appendingPathComponent(logName)
                
                let error = AppFile.copyFile(atPath: log, toPath: desPath)
                
                if error != nil {
                    failLogCount += 1
                }
                
            }
            
            if failLogCount > 0 {
                failContent += "\n AppCarLog总\(carLogs.count)个，\(failLogCount)个上传失败"
            } else if carLogs.count > 0 {
                failContent += "\n AppCarLog总\(carLogs.count)个，0个上传失败"
            }
            failLogCount = 0
            
            // 2. 诊断车型日志
            let diagCarLogsPath = AppFile.childrenDir(parentDir: self.diagCarLogDir, componet: "\(type)/\(brand)")
            
            let diagCarUploadTempLogsPath = AppFile.childrenDir(parentDir: currentUploadTempDir, componet: "\(brand)", intermediateDirectories: false)
            
            // 有车型日志
            if (AppFile.fileExists(atPath: diagCarLogsPath)) {
                
                let error = AppFile.copyFile(atPath: diagCarLogsPath, toPath: diagCarUploadTempLogsPath)
                if let err = error {
                    switch err {
                    case .pathEmtpy:
                        innerLogger("Copy \(diagCarLogsPath) to \(diagCarUploadTempLogsPath) failed, path empty")
                    case .undderlying(let underError):
                        let nsError = underError as NSError
                        switch nsError.code {
                        case NSFileNoSuchFileError:
                            innerLogger("Copy \(diagCarLogsPath) to \(diagCarUploadTempLogsPath) failed. Source file does not exist.")
                        case NSFileWriteOutOfSpaceError:
                            innerLogger("Copy \(diagCarLogsPath) to \(diagCarUploadTempLogsPath) failed. Not enough space to copy the file.")
                        case NSFileWriteNoPermissionError:
                            innerLogger("Copy \(diagCarLogsPath) to \(diagCarUploadTempLogsPath) failed. No permission to write to the destination.")
                        case NSFileWriteFileExistsError:
                            innerLogger("Copy \(diagCarLogsPath) to \(diagCarUploadTempLogsPath) failed. File already exists at the destination.")
                        default:
                            innerLogger("An unknown error occurred: \(nsError)")
                        }
                     
                    case .custom(let string):
                        innerLogger("Copy \(diagCarLogsPath) to \(diagCarUploadTempLogsPath) failed, err: \(string)")
                    }
                }
                if error != nil {
                    failContent += "\n车型日志上传失败"
                }
                
            } else {
                failContent += "\n无车型日志"
            }
            
            zipModel.failContent = failContent
            
            let feedBackZipPath = "\(self.feedbackTempDir)/\(self.vciInfo.wrapperSN)/\(zipModel.feedbackZipName)"
            let snTempDir = AppFile.childrenDir(parentDir: self.feedbackTempDir, componet: self.vciInfo.wrapperSN, intermediateDirectories: true)
            guard FileManager.default.fileExists(atPath: snTempDir) else {
    #if DEBUG
                innerLogger("创建 dir: \(snTempDir) 失败.")
    #endif
                completion(nil)
                return
            }
            // 3. 创建zip
            let isSuccess = self.createZipFile(atPath: feedBackZipPath, withContentsOfDirectory: currentUploadTempDir)

            // 移除时间戳临时文件夹
            AppFile.removeFile(atPath: toRemoveDir)
            
            innerLogger("\(feedBackZipPath), isSuccess: \(isSuccess)")
            // 4. 保存一份到本地反馈日志
            if isSuccess {
                self.setFileTag(filePath: feedBackZipPath, tagName: car.logType)
                self.handleFeedbackLogLimit()
                if let error = AppFile.copyFile(atPath: feedBackZipPath, toPath: zipPath) {
                    innerLogger("\(error)")
                }
                    
            }
            
            guard isSuccess else {
                completion(nil)
                return
            }
            
            var uploadModel = zipModel.convertToUploadModel(uploadInterface.lfuLogUploadType, feedBackZipPath: feedBackZipPath)
            uploadModel.update(from: uploadInterface) // 更新外部传值
            
            completion(uploadModel)
        }
        
    }
    
    @discardableResult
    private func setFileTag(filePath: String, tagName: String) -> Bool {
        let filePathCStr = (filePath as NSString).fileSystemRepresentation
        let tagCStr = tagName.cString(using: .utf8)
        
        let result = setxattr(filePathCStr, "topdonLog.tag", tagCStr, strlen(tagCStr!), 0, 0)
        return (result == 0)
    }
    
    private func getFileTag(filePath: String) -> String? {
        let filePathCStr = (filePath as NSString).fileSystemRepresentation
        var buffer = [CChar](repeating: 0, count: 256)
        
        let result = getxattr(filePathCStr, "topdonLog.tag", &buffer, buffer.count, 0, 0)
        if result > 0 {
            return String(cString: buffer)
        } else {
            return nil
        }
    }
    
    /// 保存本地最新的 20 条反馈数据 zip
    private func handleFeedbackLogs(zipModel: ZipModel, logType: String) {
        let brand = zipModel.brand.uppercased()
        let filters = feedbackFilterBrands.map { $0.uppercased() }
        if filters.contains(brand) { return }
        
        if self.vciInfo.sn.isEmpty { return }
        // 1.创建 sn 反馈文件夹
        let copyPath = zipModel.filePath
        // let feedbackZipDir = "\(self.feedbackTempDir)/\(self.vciInfo.wrapperSN)"
        let feedbazkZipPath = "\(self.feedbackTempDir)/\(self.vciInfo.wrapperSN)/\(zipModel.feedbackZipName)"
        let snTempDir = AppFile.childrenDir(parentDir: self.feedbackTempDir, componet: self.vciInfo.wrapperSN, intermediateDirectories: true)
        guard FileManager.default.fileExists(atPath: snTempDir) else {
#if DEBUG
            innerLogger("创建 dir: \(snTempDir) 失败.")
#endif
            return
        }
        
        let error = AppFile.copyFile(atPath: copyPath, toPath: feedbazkZipPath)
        if error != nil {
            return
        }
        
        self.setFileTag(filePath: feedbazkZipPath, tagName: logType)
        handleFeedbackLogLimit()
    }
    
    private func handleFeedbackLogLimit() {
        let feedbackZipDir = "\(self.feedbackTempDir)/\(self.vciInfo.wrapperSN)"
        // 2.移除多余文件
        let fileManager = FileManager.default
        let folderURL = URL(fileURLWithPath: feedbackZipDir) // 文件夹路径
        
        do {
            let contents = try fileManager.contentsOfDirectory(atPath: feedbackZipDir)
            
            // 如果文件个数超过 20，删除第一个文件
            if contents.count > 20 {
                
                // 获取文件夹内文件的创建日期
                var earliestDate = Date()
                var earliestFileURL: URL?
                
                for file in contents {
                    let fileURL = folderURL.appendingPathComponent(file)
                    let attributes = try fileManager.attributesOfItem(atPath: fileURL.path)
                    if let creationDate = attributes[.creationDate] as? Date, creationDate < earliestDate {
                        earliestDate = creationDate
                        earliestFileURL = fileURL
                    }
                }
                
                // 删除时间最早的文件
                if let fileURL = earliestFileURL {
                    try fileManager.removeItem(at: fileURL)
                    innerLogger("已删除时间最早的文件：\(fileURL.lastPathComponent)")
                }
            }
        } catch {
            innerLogger("获取文件夹内容失败：\(error)")
        }
    }
    /// 同步获取反馈日志；inDiag = true 标识诊断内反馈
    public func syncFetchFeedbackLog(with car: Car? = nil, inDiag: Bool = false, uploadInterface: LogUploadInterface) -> LogUploadModel? {
        let innerCar: Car = car ?? Car(brand: "", strType: "", logType: "AppLog")
        
        var result: LogUploadModel?
        fetchFeedbackLog(with: innerCar, inDiag: inDiag, uploadInterface: uploadInterface) { model in
            result = model
            
            self.syncSemaphore.signal()
        }
        
        syncSemaphore.wait()
        
        return result
    }
    
    public func fetchDBPath() -> String {
        return DBStore.db.path
    }
    
    internal func diagCarDirFrom(car: Car) -> DiagCarLogDir {
        DiagCarLogDir(rootDir: diagCarLogDir, type: car.zipType, brand: car.brand)
    }
    
}

// MARK: - Check

extension LogColletionManager {
    
    func checkAutoUploadFeedbackZipIfNeeded(car: Car? = nil, uploadInterface: LogUploadInterface, completion: @escaping ([LogUploadModel]) -> Void) {
        
        checkingUploadTempDirForUploading(car: car, uploadInterface: uploadInterface) { _ in
            
            self.checingUploadDir { zipModels in
                
                let uploadModels = zipModels.map {
                    var uploadModel = $0.convertToUploadModel(.feedbackLog)
                    uploadModel.update(from: uploadInterface)
                    return uploadModel
                }
                
                DispatchQueue.main.async { completion(uploadModels) }
                
            }
            
        }
        
    }
    
    private func checkingUploadTempDirForUploading(car: Car? = nil, uploadInterface: LogUploadInterface,completion: ((Bool)->Void)?) {
        
        operationQueue.async {
            let files = AppFile.flatFiles(atPath: self.uploadTempDir)
            
            guard !files.isEmpty else {
                /// 回调没有文件
                DispatchQueue.main.async { completion?(false) }
                return
            }
            
            for file in files {
                let uppercaseFile = file.uppercased()
                
                if uppercaseFile.hasSuffix(".ZIP") { // 1. 有未上传的 .zip
                    
                    guard var zipModel = ZipModel.validZipName(file, dbPath: self.dbPath) else {
                        continue
                    }
                    
                    // 处理 Record zip
                    guard var record = RecordManager.shared.queryRecord(with: file) else {
                        
                        let filename = file.ns.lastPathComponent
                        let uploadPath = self.uploadLogsDir.ns.appendingPathComponent(filename)
                        
                        // 移动到待上传的文件夹
                        let _ = AppFile.moveFile(atPath: file, toPath: uploadPath)
                        
                        return
                    }
                    
                    // 操作
                    let filename = file.ns.lastPathComponent
                    let uploadPath = self.uploadLogsDir.ns.appendingPathComponent(filename)
                    // 移动到待上传的文件夹
                    let error = AppFile.moveFile(atPath: file, toPath: uploadPath)
                    
                    guard error == nil else {
                        continue
                    }
                    
                    // 模型
                    zipModel.filePath = uploadPath
                    
                    // 更新数据库
                    record.zipPath = uploadPath.removeDocumentsPath
                    if let diagRecord = record as? EnterDiagLogRecordDBModel {
                        diagRecord.newAppLogRecord?.zipPath = uploadPath.removeDocumentsPath
                        diagRecord.updateIntoDB()
                    } else {
                        record.updateIntoDB()
                    }
                    
                } else if uppercaseFile.hasSuffix(".TXT") || uppercaseFile.hasSuffix(".LOG") { // 2. 有未压缩的日志文件
                    let suffixPaths = file.ns.components(separatedBy: "updataLogsTemp/")
                    // Diag/SN/时间戳/VW(车型)/...txt
                    guard suffixPaths.count > 1 else {
                        continue
                    }
                    
                    let pathComponents = suffixPaths.last!.ns.components(separatedBy: "/")
                    guard pathComponents.count == 5 else {
                        continue
                    }
                    
                    //xxx/updataLogsTemp/Diag/SN/时间戳/VW(车型)
                    let prePath = file.ns.deletingLastPathComponent
                    
                    let type      = pathComponents[0]
                    let vciSN     = pathComponents[1]
                    let timestamp = pathComponents[2]
                    let carBrand  = pathComponents[3]
                    
                    let createTime: String = (timestamp.ns.doubleValue.millisecondDate ?? Date.current()).string()
                    
                    var zipModel = ZipModel(appName: self.appInfo.appName,
                                            platform: self.appInfo.platform,
                                            appVersion: self.appInfo.version,
                                            vciSN: vciSN,
                                            vin: uploadInterface.lfuVin,
                                            type: type,
                                            createTime: createTime,
                                            brand: carBrand,
                                            filePath: "",
                                            dbPath: self.dbPath)
                    
                    let zipName = zipModel.zipName
                    let zipPath = prePath.ns.appendingPathComponent(zipName)
                    zipModel.filePath = zipPath
                    
                    // 创建 zip
                    let isSuccess = self.createZipFile(atPath: zipPath, withContentsOfDirectory: prePath)
                    guard isSuccess else {
#if DEBUG
                        innerLogger("创建 zip \(zipPath) 失败")
#endif
                        continue
                    }
                    
                    // 移动到上传文件夹
                    let uploadZipPath = self.uploadLogsDir.ns.appendingPathComponent(zipName)
                    let error = AppFile.moveFile(atPath: zipPath, toPath: uploadZipPath)
                    
                    guard nil == error else {
#if DEBUG
                        innerLogger("移动 zip \(zipPath) 到 \(uploadZipPath) 失败")
#endif
                        continue
                    }
                    
                    // 清理车型临时目录
                    AppFile.removeFile(atPath: prePath)
                    
                }
                
            }
            
            /// 回调有文件
            DispatchQueue.main.async { completion?(true) }
        }
        
    }
    
    private func checingUploadDir(completion: (([ZipModel])->Void)?) {
        operationQueue.async {
            
            let zipFiles = AppFile.flatFiles(atPath: self.uploadLogsDir)
            var zips: [ZipModel] = []
            
            for file in zipFiles {
                let uppercaseFile = file.uppercased()
                guard uppercaseFile.hasSuffix(".ZIP") else {
                    continue
                }
                
                guard let zipModel = ZipModel.validZipName(file, dbPath: self.dbPath) else {
                    continue
                }
                
                guard RecordManager.shared.queryRecord(with: file) == nil else {
                    continue
                }
                
                zips.append(zipModel)
            }
            
            /// 回调
            DispatchQueue.main.async {
                completion?(zips)
            }
            
        }
        
    }
    
    
    
}

// MARK: - Helper & Types

extension LogColletionManager {
    
    
    /// 根据路经获取 文件地止目录 eg: /Documents/TD/AD200/DataLog/DIAG/VW/a.txt
    ///   - Parameters:
    ///   - path:  文件路经
    ///   - index: 文件级别 1 DIAG 2 VW 3 文件目录 a.txt
    static func diagCarLogPath(_ path: String, component: DiagCarLogPathComponent) -> String? {
        let components = path.ns.components(separatedBy: "/")
        guard components.count >= 3 else {
#if DEBUG
            innerLogger("error: components cout: \(components.count)")
#endif
            return nil
        }
        
        switch component {
        case .fileName:
            return components.last
        case .brand:
            return components[(components.count - 2)]
        case .type:
            return components[(components.count - 3)]
        }
        
    }
    
}

// MARK: - Create Directory

extension LogColletionManager {
    
    
    private func getDiagCarLogDir(topDir: String, diagDir: String) -> String {
        AppFile.childrenDir(parentDir: documentsDir, componet: "\(topDir)/\(diagDir)/DataLog")
    }
    
    private func getUploadTempDir(topDir: String, diagDir: String) -> String {
        AppFile.childrenDir(parentDir: documentsDir, componet: "\(topDir)/\(diagDir)/updataLogsTemp", intermediateDirectories: true)
    }
    
    private func getUpdateLogsDir(topDir: String, diagDir: String) -> String {
        AppFile.childrenDir(parentDir: documentsDir, componet: "\(topDir)/\(diagDir)/updateLogs", intermediateDirectories: true)
    }
    
    private func getFeedbackTempDir(topDir: String, diagDir: String) -> String {
        AppFile.childrenDir(parentDir: documentsDir, componet: "\(topDir)/\(diagDir)/feedbackTemp", intermediateDirectories: true)
    }
    
    private func getLaunchUploadLogsTempDir(topDir: String, diagDir: String) -> String {
        AppFile.childrenDir(parentDir: documentsDir, componet: "\(topDir)/\(diagDir)/launchUploadLogsTemp" , intermediateDirectories: true)
    }
    
    private func getLaunchUploadingDir(topDir: String, diagDir: String) -> String {
        AppFile.childrenDir(parentDir: documentsDir, componet: "\(topDir)/\(diagDir)/launchUploading" , intermediateDirectories: true)
    }
}

// MARK: - DB

extension LogColletionManager {
    
    private func setupDB() {
        let _ = DBStore.shared
        // try? DBStore.db.create(table: AppLogRecordDBModel.tableName, of: AppLogRecordDBModel.self)
        try? DBStore.db.create(table: EnterDiagLogRecordDBModel.tableName, of: EnterDiagLogRecordDBModel.self)
        try? DBStore.db.create(table: NewAppLogRecordDBModel.tableName, of: NewAppLogRecordDBModel.self)
    }
    
    /// 保存上传状态
    //    func update(_ model: LogUploadModel, uploadStatus: UInt) {
    //        try? AppLogDBModel.update(on: [AppLogDBModel.Properties.uploadStatus],
    //                                  with: [uploadStatus],
    //                                  where: AppLogDBModel.Properties.ownedZip == model.zipPath)
    //    }
    
}

// MARK: - Clear

extension LogColletionManager {
    
    @discardableResult
    public func clearLog(isAll: Bool = false) -> Self {
        
        AppFile.removeFile(atPath: launchUploadingDir)
        guard !isAll else {
            AppFile.removeFile(atPath: appLogDir)
            _ = AppFile.childrenDir(parentDir: documentsDir, componet: "Log", intermediateDirectories: true)
            return self
        }
        
        DispatchQueue.global().async {
            /// 250M
            let maxSize: UInt64 = 250 * 1024 * 1024
            
            let filePath = self.appLogDir
            
            var fileSize = filePath.dirFileSize
            
            if fileSize > maxSize {
                
                var pathes = AppFile.flatFiles(atPath: filePath)
                
                pathes = AppFile.sortFiles(pathes, asc: true)
                
                for fileName in pathes {
                    
                    let size = fileName.dirFileSize
                    
                    AppFile.removeFile(atPath: fileName)
                    
                    fileSize -= size
                    
                    if fileSize < maxSize {
                        break
                    }
                    
                }
                
            }
            
        }
        
        // clear DB
        var current = Date.current()
        current.add(.day, value: -7) // 7天
        let oneWeekTimestamp = current.timeIntervalSince1970
        //AppLogRecordDBModel.delete(old: oneWeekTimestamp)
        NewAppLogRecordDBModel.delete(old: oneWeekTimestamp)
        EnterDiagLogRecordDBModel.delete(old: oneWeekTimestamp)
        
        return self
    }
    
}

// MARK: - OnCreateLogFile

private extension LogColletionManager {
    
    func onCreateLogFile(_ newLogFileName: String) {
        createRecord(newLogFileName)
    }
    
    func createRecord(_ newLogFileName: String) {
        
        let recordMgr = RecordManager.shared
        if let car = recordMgr.car {
            recordMgr.insertCarLog(newLogFileName, car: car)
        } else {
            recordMgr.insertAppLog(newLogFileName)
        }
        
    }
    
    func onRenameLogFile(oldName: String, newName: String) {
        
        let recordMgr = RecordManager.shared
        if let car = recordMgr.car {
            recordMgr.updateCarLog(oldName, newFile: newName, car: car)
        } else {
            recordMgr.updateAppLog(oldName, newFile: newName)
        }
        
    }
    
}

// MARK: - v1.20.000

extension LogColletionManager {
    
    // 1. 收集 app 日志（启动日志和退车日志记录）
    func fetchLaunchOrExitDiagLog(completion: @escaping ([LogUploadModel]) -> Void) {
        operationQueue.async {
            let records = RecordManager.shared.queryLaunchOrExitDiagRecord()
            guard !records.isEmpty else {
                DispatchQueue.main.async { completion([]) }
                return
            }
            
            var models: [LogUploadModel] = []
            
            // TODO: - 是否采用 cp 更好些 上传成功后再删除
            
            for record in records where (!record.isEmpty) {
                
                var type: String  = record.carType.uppercased()
                if type.isEmpty { type = self.kiOSLog }
                
                var brand: String = record.carBrand.uppercased()
                if brand.isEmpty { brand = self.kiOSLog }
                
                var sn: String = record.sn
                if sn.isEmpty { sn = "Unknown_SN" }
                let SnForPath = sn.removeNonAlphanumericCharacters()
                
                let current = Date.current()
                let millionSeconds = current.millionSeconds
                
                // 0. 创建临时目录
                let currentUploadTempDir = AppFile.childrenDir(parentDir: self.uploadTempDir,
                                                               componet: "\(type)/\(SnForPath)/\(Int64(millionSeconds))",
                                                               intermediateDirectories: true)
                
                guard FileManager.default.fileExists(atPath: currentUploadTempDir) else {
#if DEBUG
                    innerLogger("创建 dir: \(currentUploadTempDir) 失败.")
#endif
                    continue
                }
                
                // 提前声明zip for DB
                var zipModel = ZipModel(appName: self.appInfo.appName,
                                        platform: self.appInfo.platform,
                                        appVersion: self.appInfo.version,
                                        vciSN: SnForPath,
                                        vin: record.lfuVin,
                                        type: type,
                                        createTime: current.string(),
                                        brand: brand,
                                        filePath: "",
                                        dbPath: self.dbPath
                )
                
                let zipName   = zipModel.zipName
                let zipPath = currentUploadTempDir.ns.appendingPathComponent(zipName)
                zipModel.filePath = zipPath
                
                let moveDir = currentUploadTempDir
                
                let logFiles = record.filenames.components(separatedBy: ",").filter { !$0.isEmpty }
                if logFiles.isEmpty {
                    continue
                }
                
                var notExistFiles: [String] = []
                for logFile in logFiles {
                    let logPath = logFile.fixLogPath
                    let logName = logPath.ns.lastPathComponent
                    let movePath = moveDir.ns.appendingPathComponent(logName)
                    let error = AppFile.moveFile(atPath: logPath, toPath: movePath)
                    if let err = error {
#if DEBUG
                        innerLogger("copy \(logPath) to \(movePath) failure: \(err)")
#endif
                        if !AppFile.fileExists(atPath: logPath) {
                            notExistFiles.append(logPath)
                        }
                    }
                    
                }
                
                if notExistFiles.count == logFiles.count {
                    
#if DEBUG
                    innerLogger("record \(record) has no exist logFiles")
#endif
                    // 更新数据库
                    record.status = RecordStatusType.collected.rawValue
                    record.updateIntoDB()
                    
                    // 删除临时文件夹内容
                    let _ = AppFile.removeFile(atPath: currentUploadTempDir)
                    
                    continue
                }
                
                // 3. 创建zip
                let isSuccess = self.createZipFile(atPath: zipPath, withContentsOfDirectory: currentUploadTempDir)
                
                guard isSuccess else {
#if DEBUG
                    innerLogger("createZipFile \(zipPath) with dir \(currentUploadTempDir) failed")
#endif
                    // 更新数据库
                    record.status = RecordStatusType.collected.rawValue
                    record.updateIntoDB()
                    
                    // 删除临时文件夹内容
                    let _ = AppFile.removeFile(atPath: currentUploadTempDir)
                    
                    continue
                }
                
                // 更新zip到数据库
                record.zipPath = zipPath.removeDocumentsPath
                record.status = RecordStatusType.collected.rawValue
                record.lfuLogGenerationTime = ZipModel.convertToUploadTime(zipModel.createTime)
                record.updateIntoDB()
                
                // 保存一份到反馈目录
                zipModel.logType = "AppLog"
                self.handleFeedbackLogs(zipModel: zipModel, logType: "AppLog")
                
                // 4.0 移动到上传文件目录
                let uploadZipPath = self.uploadLogsDir.ns.appendingPathComponent(zipName)
                let error = AppFile.moveFile(atPath: zipPath, toPath: uploadZipPath)
                
                guard error == nil else {
                    continue
                }
                
                guard (AppFile.fileSize(atPath: uploadZipPath) ?? 0) > 0 else {
                    continue
                }
                
                // 删除临时文件夹内容
                let _ = AppFile.removeFile(atPath: currentUploadTempDir)
                
                // 更新zip路径
                zipModel.filePath = uploadZipPath
                
                // 更新 record 记录
                record.zipPath = uploadZipPath.removeDocumentsPath
                record.updateIntoDB()
                
                // 上传模型
                var uploadModel = zipModel.convertToUploadModel(LogUploadType(rawValue: record.uploadType))
                
                uploadModel.sn = sn
                uploadModel.topdonId = record.topdonId
                uploadModel.appendex = record.extraInfo
                uploadModel.update(from: record)
                
                models.append(uploadModel)
            }
            
            DispatchQueue.main.async { completion(models) }
        }
    }
    
    // 2. 收集 进车 日志 （进车日志记录），车型日志 200M 限制
    func fetchEnterDiagLog(fixFields: FixupFields? = nil, completion: @escaping ([LogUploadModel]) -> Void) {
        operationQueue.async {
            let records = RecordManager.shared.queryEnterDiagRecord()
            guard !records.isEmpty else {
                DispatchQueue.main.async { completion([]) }
                return
            }
            var mFixFields = fixFields
            var models: [LogUploadModel] = []
            
            // TODO: - 是否采用 cp 更好些 上传成功后再删除
            
            for record in records where (!record.isEmpty) {
                
                // fixups
                if let safeFixFields = mFixFields,
                   safeFixFields.car.brand.uppercased() == record.carBrand.uppercased(),
                   safeFixFields.car.strType.uppercased() == record.carType.uppercased() {
                    
                    var needUpdate: Bool = safeFixFields.update(record: record)
                    
                    if needUpdate {
                        record.updateIntoDB()
                    }
                    
                    mFixFields = nil // 清空
                }
                
                var type: String  = record.carType.uppercased()
                if type.isEmpty { type = self.kiOSLog }
                
                var brand: String = record.carBrand.uppercased()
                if brand.isEmpty { brand = self.kiOSLog }
                
                var sn: String = record.sn
                if sn.isEmpty { sn = "Unknown_SN" }
                let SnForPath = sn.removeNonAlphanumericCharacters()
                
                let current = Date.current()
                let millionSeconds = current.millionSeconds
                
                // 0. 创建临时目录
                let currentUploadTempDir = AppFile.childrenDir(parentDir: self.uploadTempDir,
                                                               componet: "\(type)/\(SnForPath)/\(Int64(millionSeconds))",
                                                               intermediateDirectories: true)
                
                guard FileManager.default.fileExists(atPath: currentUploadTempDir) else {
#if DEBUG
                    innerLogger("创建 dir: \(currentUploadTempDir) 失败.")
#endif
                    continue
                }
                
                // 提前声明zip for DB
                var zipModel = ZipModel(appName: self.appInfo.appName,
                                        platform: self.appInfo.platform,
                                        appVersion: self.appInfo.version,
                                        vciSN: SnForPath,
                                        vin: record.lfuVin,
                                        type: type,
                                        createTime: current.string(),
                                        brand: brand,
                                        filePath: "",
                                        dbPath: self.dbPath
                )
                
                let zipName   = zipModel.zipName
                let zipPath = currentUploadTempDir.ns.appendingPathComponent(zipName)
                zipModel.filePath = zipPath
                
                let moveDir = currentUploadTempDir
                
                // 0. appLogs
                let appLogRecord = RecordManager.shared.queryAssociatedAppLogRecord(with: record.appLogRecordId)
                var hasAppLog = false
                if let appLogRecord {
                    let logFiles = appLogRecord.filenames.components(separatedBy: ",").filter { !$0.isEmpty }
                    var notExistFiles: [String] = []
                    hasAppLog = !logFiles.isEmpty
                    for logFile in logFiles {
                        let logPath = logFile.fixLogPath
                        let logName = logPath.ns.lastPathComponent
                        let movePath = moveDir.ns.appendingPathComponent(logName)
                        let error = AppFile.moveFile(atPath: logPath, toPath: movePath)
                        if let err = error {
#if DEBUG
                            innerLogger("copy \(logPath) to \(movePath) failure: \(err)")
#endif
                            if !AppFile.fileExists(atPath: logPath) {
                                notExistFiles.append(logPath)
                            }
                        }
                        
                        if notExistFiles.count == logFiles.count {
#if DEBUG
                            innerLogger("record \(record) has no exist logFiles")
#endif
                            appLogRecord.filenames = ""
                        }
                        // 更新数据库
                        appLogRecord.status = RecordStatusType.collected.rawValue
                        appLogRecord.updateIntoDB()
                    }
                }
                
                // 1.carLogs
                let logFiles = record.filenames.components(separatedBy: ",").filter { !$0.isEmpty }
                //                guard (!logFiles.isEmpty || hasAppLog) else {
                //
                //                    // 删除临时文件夹内容
                //                    let _ = AppFile.removeFile(atPath: currentUploadTempDir)
                //
                //                    continue
                //                }
                
                var notExistFiles: [String] = []
                for logFile in logFiles {
                    let logPath = logFile.fixLogPath
                    let logName = logPath.ns.lastPathComponent
                    let movePath = moveDir.ns.appendingPathComponent(logName)
                    let error = AppFile.moveFile(atPath: logPath, toPath: movePath)
                    if let err = error {
#if DEBUG
                        innerLogger("copy \(logPath) to \(movePath) failure: \(err)")
#endif
                        if !AppFile.fileExists(atPath: logPath) {
                            notExistFiles.append(logPath)
                        }
                    }
                    
                }
                
                if notExistFiles.count == logFiles.count {
                    
#if DEBUG
                    innerLogger("record \(record) has no exist logFiles")
#endif
                    // 更新数据库
                    record.filenames = ""
                    record.status = RecordStatusType.collected.rawValue
                    record.updateIntoDB()
                    
                }
                
                // 2. diagLogs 诊断车型日志
                let diagCarLogsPath = AppFile.childrenDir(parentDir: self.diagCarLogDir, componet: "\(type)/\(brand)")
                
                let diagCarUploadTempLogsPath = AppFile.childrenDir(parentDir: currentUploadTempDir, componet: "\(brand)", intermediateDirectories: true)
                
                let isDiagCarLogsPathExist =  AppFile.fileExists(atPath: diagCarLogsPath)
                let noDiagLog = AppFile.isDirectoryEmpty(atPath: diagCarLogsPath)
                
                if !hasAppLog && logFiles.isEmpty && (!isDiagCarLogsPathExist || noDiagLog){
#if DEBUG
                    innerLogger("record \(record) has no one logFiles")
#endif
                    continue
                }
                
                var error: AppFile.Error?
                if isDiagCarLogsPathExist {
                    error = AppFile.sortFilesByDateDscAndMove(atPath: diagCarLogsPath,
                                                              toPath: diagCarUploadTempLogsPath,
                                                              isDeleteOutLimit: true,
                                                              limitSize: 209715200)
                }
                
                if error != nil {
                    
                    // return
                }
                
                
                // 3. 创建zip
                let isSuccess = self.createZipFile(atPath: zipPath, withContentsOfDirectory: currentUploadTempDir)
                
                guard isSuccess else {
                    
#if DEBUG
                    innerLogger("createZipFile \(zipPath) with dir \(currentUploadTempDir) failed")
#endif
                    // 更新数据库
                    record.status = RecordStatusType.collected.rawValue
                    record.updateIntoDB()
                    
                    // 删除临时文件夹内容
                    let _ = AppFile.removeFile(atPath: currentUploadTempDir)
                    
                    // 删除诊断车临时日志
                    let _ = AppFile.removeFile(atPath: diagCarUploadTempLogsPath)
                    
                    continue
                }
                
                // 更新zip到数据库
                record.zipPath = zipPath.removeDocumentsPath
                record.status = RecordStatusType.collected.rawValue
                record.lfuLogGenerationTime = ZipModel.convertToUploadTime(zipModel.createTime)
                record.updateIntoDB()
                
                // 4. 保存一份到本地反馈日志
                zipModel.logType = record.dispalyLogType
                self.handleFeedbackLogs(zipModel: zipModel, logType: record.dispalyLogType)
                
                // 删除诊断车临时日志
                let _ = AppFile.removeFile(atPath: diagCarUploadTempLogsPath)
                
                // 5.0 移动到上传文件目录
                let uploadZipPath = self.uploadLogsDir.ns.appendingPathComponent(zipName)
                error = AppFile.moveFile(atPath: zipPath, toPath: uploadZipPath)
                
                guard error == nil else {
                    continue
                }
                
                guard (AppFile.fileSize(atPath: uploadZipPath) ?? 0) > 0 else {
                    continue
                }
                
                // 删除临时文件夹内容
                let _ = AppFile.removeFile(atPath: currentUploadTempDir)
                
                // 更新zip路径
                zipModel.filePath = uploadZipPath
                
                // 更新 record 记录
                record.zipPath = uploadZipPath.removeDocumentsPath
                
                appLogRecord?.status = record.status
                appLogRecord?.zipPath = uploadZipPath.removeDocumentsPath
                appLogRecord?.updateIntoDB()
                
                record.updateIntoDB()
                
                // 上传模型
                var uploadModel = zipModel.convertToUploadModel(LogUploadType(rawValue: record.uploadType))
                
                uploadModel.sn = sn
                uploadModel.topdonId = record.topdonId
                uploadModel.appendex = record.extraInfo
                uploadModel.autoVinEntryType = record.autoVinEntryType
                uploadModel.update(from: record)
                
                models.append(uploadModel)
            }
            
            DispatchQueue.main.async { completion(models) }
        }
    }
    
    // 3. 收集 Crash 文件
    func fetchCrashLog(completion: @escaping ([LogUploadModel]) -> Void) {
        operationQueue.async {
            guard let fileDir = try? TDCrashInstallationFileOpts.defaultDir() else {
                innerLogger("TDCrashReports is not exist")
                completion([])
                return
            }
            
            let files = AppFile.files(atPath: fileDir).lazy.filter { $0.hasSuffix(kAppleCrashFileSuffix) }.lazy.map { fileDir.ns.appendingPathComponent($0) }
            guard !files.isEmpty else {
                innerLogger("There has no crash file.")
                completion([])
                return
            }
            guard let interface = self.delegate?.getUploadInterface(car: nil, uploadType: .custom(type: LogUploadType.customTypeCrash)) else {
                innerLogger("Error LogColletionManager delegate func getUploadInterface not impl")
                completion([])
                return
            }
            
            let carType = "IOSCRASH"
            var models: [LogUploadModel] = []
            
            for file in files {
                let createTime: String = String.getFileCreateTime(for: file) ?? Date().string(withFormat: TopdonDateFormat.kUploadTime)
                var uploadModel = LogUploadModel(zipPath: file,
                                                 feedBackZipPath: "",
                                                 carType: carType,
                                                 carBrand: carType,
                                                 createTime: createTime,
                                                 dbPath: DBStore.dbPath)
                uploadModel.update(from: interface)
                
                /// 强制为崩溃日志
                uploadModel.carType         = carType
                uploadModel.carBrand        = carType
                uploadModel.lfuCarType      = carType
                uploadModel.lfuCarBrandName = carType
                uploadModel.lfuUploadType   = "2"
                
                models.append(uploadModel)
            }
            
            completion(models)
        }
    }
    
}

// MARK: - 处理之前残存的zip包

extension LogColletionManager {
    
    func checkingUploadTempDir(completion: @escaping ([LogUploadModel]) -> Void) {
        operationQueue.async {
            let files = AppFile.flatFiles(atPath: self.uploadTempDir)
            guard !files.isEmpty else {
                /// 回调没有文件
                DispatchQueue.main.async { completion([]) }
                return
            }
            
            var models: [LogUploadModel] = []
            
            for file in files where file.uppercased().hasSuffix(".ZIP") {
                
                // 查表
                guard var zipModel = ZipModel.validZipName(file, dbPath: self.dbPath) else {
                    continue
                }
                
                guard var record = RecordManager.shared.queryRecord(with: file) else {
                    continue
                }
                
                // 操作
                let filename = file.ns.lastPathComponent
                let uploadPath = self.uploadLogsDir.ns.appendingPathComponent(filename)
                // 移动到待上传的文件夹
                let error = AppFile.moveFile(atPath: file, toPath: uploadPath)
                
                guard error == nil else {
                    continue
                }
                
                guard (AppFile.fileSize(atPath: uploadPath) ?? 0) > 0 else {
                    // 删除空包
                    AppFile.removeFile(atPath: uploadPath)
                    
                    continue
                }
                
                // 模型
                zipModel.filePath = uploadPath
                var uploadModel: LogUploadModel
                
                // 更新数据库
                record.zipPath = uploadPath.removeDocumentsPath
                if let diagRecord = record as? EnterDiagLogRecordDBModel {
                    diagRecord.newAppLogRecord?.zipPath = uploadPath.removeDocumentsPath
                    diagRecord.updateIntoDB()
                    
                    uploadModel = zipModel.convertToUploadModel(LogUploadType(rawValue: diagRecord.uploadType))
                } else {
                    record.updateIntoDB()
                    
                    let type: LogUploadType
                    if let record = record as? NewAppLogRecordDBModel {
                        type = LogUploadType(rawValue: record.uploadType)
                    } else {
                        type = .appLog
                    }
                    uploadModel = zipModel.convertToUploadModel(type)
                }
                
                uploadModel.update(from: record)
                
                models.append(uploadModel)
                
            }
            
            DispatchQueue.main.async { completion(models) }
        }
    }
    
    func checkingUploadDir(completion: @escaping ([LogUploadModel]) -> Void) {
        operationQueue.async {
            
            let zipFiles = AppFile.flatFiles(atPath: self.uploadLogsDir)
            var models: [LogUploadModel] = []
            
            for file in zipFiles where file.uppercased().hasSuffix(".ZIP") {
                
                guard let zipModel = ZipModel.validZipName(file, dbPath: self.dbPath) else {
                    continue
                }
                
                guard let record = RecordManager.shared.queryRecord(with: file) else {
                    continue
                }
                
                guard (AppFile.fileSize(atPath: file) ?? 0) > 0 else {
                    // 删除空包
                    AppFile.removeFile(atPath: file)
                    
                    continue
                }
                
                var uploadModel: LogUploadModel
                if let record = record as? EnterDiagLogRecordDBModel {
                    uploadModel = zipModel.convertToUploadModel(LogUploadType(rawValue: record.uploadType))
                } else {
                    let type: LogUploadType
                    if let record = record as? NewAppLogRecordDBModel {
                        type = LogUploadType(rawValue: record.uploadType)
                    } else {
                        type = .appLog
                    }
                    uploadModel = zipModel.convertToUploadModel(type)
                }
                
                uploadModel.update(from: record)
                
                models.append(uploadModel)
            }
            
            /// 回调
            DispatchQueue.main.async { completion(models) }
        }
    }
    
}

// MARK: - Create Zip

extension LogColletionManager {
    
    func createZipFile(atPath zipPath: String, withContentsOfDirectory dirPath: String) -> Bool {
        guard !zipPath.isEmpty else {
            innerLogger("createZipFile Failed. zipPath is Empty")
            return false
        }
        return SSZipArchive.createZipFile(atPath: zipPath, withContentsOfDirectory: dirPath)
    }
    
}
