//
//  LogUploadManager.swift
//  TopdonLog
//
//  Created by xinwenliu on 2023/11/25.
//

import Foundation

// MARK: - LogUploadManagerDelegate

public protocol LogUploadManagerDelegate: AnyObject {
    
    /// completion: true success
    func upload(_ model: LogUploadModel, completion: ((Bool)-> Void)?)
    
}

// MARK: - LogUploadManager

final public class LogUploadManager {
    
    public static let shared = LogUploadManager()
    
    public weak var delegate: LogUploadManagerDelegate?
    
    static var lastUploadLogTime: TimeInterval = 0.0
    
    public private(set) var feedbackDelegate = Delegate<Bool, Void>()
    
    private var operationQueue: DispatchQueue = .init(label: "com.topdonlog.UploadManager")
    
    private init() {}
    
    @discardableResult
    public func config(_ log: TopdonLog.Type) -> Self {
        
        return self
    }
    
    public func setup(delegate: LogUploadManagerDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    // MARK: - 上传反馈日志
    
    /// 诊断上传反馈, 使用 uploadInterface, 有事car为空, inDiag = true 标识诊断内反馈
    public func feedbackLogUplaod(car: Car? = nil, inDiag: Bool = false, uploadInterface: LogUploadInterface) {
        
        LogColletionManager.shared.fetchFeedbackLog(with: car ?? Car(brand: "", strType: "", logType: "AppLog"), inDiag: inDiag, uploadInterface: uploadInterface) { uploadModel in
            
            guard let uploadModel = uploadModel else {
                return
            }
            
            self.upload([uploadModel]) {
                self.doubleCheck(car: car, uploadInterface: uploadInterface)
            }
            
        }
        
    }
    
    /// 普通App上传反馈, 当上传接口调用成功后，请调用LogUploadManager.feedbackDelegate.call(true or false)  inDiag = true 标识诊断内反馈
    public func feedbackLogUpload(uploadInterface: LogUploadInterface, inDiag: Bool = false, handler: @escaping (LogUploadModel?, LogUploadManager) -> Void) {
        
        let model = LogColletionManager.shared.syncFetchFeedbackLog(inDiag: inDiag, uploadInterface: uploadInterface)
        
        feedbackDelegate.delegate(on: self) { (self, isSuccess) in
            
            guard let model = model else { return }
            
            if isSuccess { AppFile.removeFile(atPath: model.zipPath) }
            
        }
        
        handler(model, self)
        
    }
    
    // 上传完后二次校验
    private func doubleCheck(car: Car? = nil, uploadInterface: LogUploadInterface) {
        LogColletionManager.shared.checkAutoUploadFeedbackZipIfNeeded(car: car, uploadInterface: uploadInterface) { models in
            self.upload(models) {
                
            }
        }
    }
    
}

// MARK: - Upload

extension LogUploadManager {
    
    /// 上传接口，统一走这个
    func upload(_ models: [LogUploadModel], completion: (()-> Void)?) {
        let group = DispatchGroup()
        
        for model in models {
            group.enter()
            
            uploadSingle(model) { _ in group.leave() }
        }
        
        group.notify(queue: .main) {
            
            completion?()
        }
        
    }
    
    func uploadSingle(_ model: LogUploadModel, completion: ((Bool)-> Void)?) {
        delegate?.upload(model, completion: { isSuccess in
            if isSuccess {
                AppFile.removeFile(atPath: model.zipPath)
                RecordManager.shared.removeRecord(with: model.zipPath)
                //                switch model.uploadType {
                //                case .autoVinLog: // TODO 接入侧需要自动附带反馈 [TDEntertheVehicleModel feedBackRequest:fileSecret];
                //                    ()
                //                }
            }
            
            completion?(isSuccess)
        })
    }
    
}

// MARK: - DiagStart & DiagStop

public extension LogUploadManager {
    
    func diagStart(car: Car) {
        TopdonLog.globalQueue.async {
            
            let enterCarTime = Date.current().string(withFormatter: TopdonLog.appInfo.launchDateFormatter)
            let para = TopdonLog.buildParam(subPath: car.brand, launchTime: enterCarTime)
            
            /// 1. 记录进车
            RecordManager.shared.enter(car: car, logFile: para.fullLogPath)
            
            /// 2. 日志收集保存进车
            LogColletionManager.shared.enter(car: .init(brand: car.brand, strType: car.strType, logType: car.logType))
            
            /// 3. log 重定向到 carBrand 日志
            TopdonLog.redirectionTo(param: para)
        }
    }
    
    func diagStop(car: Car, fixFields: FixupFields? = nil) {
        TopdonLog.globalQueue.async {
            /// 0. 消除副作用
            TopdonLog.eliminateSideEffectsOnDiagStopCar()
            
            let exitCarTime = Date.current().string(withFormatter: TopdonLog.appInfo.launchDateFormatter)
            let para = TopdonLog.buildParam(launchTime: exitCarTime)
            
            /// 1. 记录退出
            RecordManager.shared.exit(car: car, logFile: para.fullLogPath)
            
            /// 2. 日志收集清除进车
            LogColletionManager.shared.stop(car: car)
            
            LogColletionManager.shared.fetchEnterDiagLog(fixFields: fixFields, completion: { models in
                if models.isEmpty { return }
                self.upload(models) {
                    
                }
            })
            
            /// 3. log 重定向到 Log 日志
            TopdonLog.redirectionTo(param: para)
        }
    }
    
}

// MARK: - v1.20

extension LogUploadManager {
    
    /// 启动的时候调用
    public func uploadLogsIfNeeded() {
        
        _uploadLogsIfNeeded {
            DispatchQueue.main.async { // back to main 防止 isCrashFilesGenerated 条件竞争
                guard TopdonLog.isCrashFilesGenerated else {
                   innerLogger("not upload crash file while isCrashFilesGenerated is false.")
                    return
                }
                self._uploadCrashFileIfNeeded {}
            }
        }
    }
    
    func _uploadLogsIfNeeded(completion: @escaping ()->Void) {
        let collectMgr = LogColletionManager.shared
        func handleEnterDiag(completion: @escaping ()->Void) {
            collectMgr.fetchEnterDiagLog() { models in
                guard !models.isEmpty else {
                    completion()
                    return
                }
                self.upload(models) {
                    completion()
                }
            }
        }
        
        // 1. 临时文件夹中失败的 zip 和 上传文件夹中的 zip
        handleEarlierZips(collectMgr: collectMgr) {
            // 2. appLogs (启动日志 或者 退车日志)
            collectMgr.fetchLaunchOrExitDiagLog { appModels in
                if appModels.isEmpty {
                    // 3. enter car logs
                    handleEnterDiag(completion: completion)
                } else {
                    self.upload(appModels) {
                        // 3. enter car logs
                        handleEnterDiag(completion: completion)
                    }
                }
            }
        }
        
    }
    
    func _uploadCrashFileIfNeeded(completion: @escaping ()->Void) {
        
        LogColletionManager.shared.fetchCrashLog { models in
            guard !models.isEmpty else {
                completion()
                return
            }
            
            self.upload(models, completion: completion)
        }
        
    }
    
    private func handleEarlierZips(collectMgr: LogColletionManager, completion: @escaping ()->Void) {
        
        func handleUploadDir() {
            collectMgr.checkingUploadDir { models in
                guard !models.isEmpty else {
                    completion()
                    return
                }
                self.upload(models) { completion() }
            }
        }
        
        collectMgr.checkingUploadTempDir { tModels in
            guard !tModels.isEmpty else {
                handleUploadDir()
                return
            }
            self.upload(tModels) {
                handleUploadDir()
            }
            
        }
    }
    
}
