//
//  RecordManager.swift
//  TopdonLog
//
//  Created by xinwenliu on 2024/6/13.
//

import Foundation
import TDWCDB
import WCDBSwift

final class RecordManager {
    
    static let shared = RecordManager()
    
    /// 回滚记录数量
    let maxCount: Int = 5
    private(set) var car: Car?
    
    private let collectMgr: LogColletionManager
    
    let lock: NSRecursiveLock = NSRecursiveLock()
    
    private init() {
        collectMgr = .shared
    }
    
    // MARK: - 实时获取信息
    
    var vciInfo: VCIInfo {
        var sn = collectMgr.delegate?.getVciSN() ?? ""
        if sn.isEmpty {
            sn = collectMgr.deviceSN
        }
        return VCIInfo(sn: sn)
    }
    
    var topdonId: String {
        collectMgr.delegate?.getTopdonId() ?? ""
    }
    
    var appendexInfos: String {
        collectMgr.delegate?.getAppendexInfos() ?? ""
    }
    
    // MARK: - Remove
    func removeRecord(with zipPath: String) {
        NewAppLogRecordDBModel.delete(with: zipPath)
        EnterDiagLogRecordDBModel.delete(with: zipPath)
    }
    
}

// MARK: - AppLogRecord

extension RecordManager {
    
    /// 启动的时候生成一条启动记录
    public func initialLaunchRecord() {
        let launchRecord = createLaunchOrExitDiagRecord(with: nil)
        launchRecord.insertToDB()
    }
    
    /// 保存最多5份记录
    func insertAppLog(_ logFile: String) {
        let logFile = logFile.removeDocumentsPath
        guard let oldRecord = NewAppLogRecordDBModel.queryLastRecord() else {
            
            let newRecord = createLaunchOrExitDiagRecord(with: nil)
            newRecord.filenames = logFile
            newRecord.insertToDB()
            
            return
        }
        
        var oldFiles = oldRecord.filenames.components(separatedBy: ",").map { $0.removeDocumentsPath }
        if oldFiles.contains(logFile) {
            
            oldFiles.removeAll(where: {$0 == logFile})
            
            oldFiles.insert(logFile, at: 0)
            // 存储
            oldRecord.filenames = oldFiles.joined(separator: ",")
            oldRecord.updateIntoDB()
            
            return
        }
        
        let oldFilesCount = oldFiles.count
        
        // 回滚
        let overflow = oldFilesCount - (maxCount - 1)
        if overflow > 0 {
            let deletedRecordIdx = max(0,(oldFilesCount - 1) - overflow)
           // let deleteRecord = oldFiles[deletedRecordIdx]
            
            // 转存到 Idle
           // let forIdleRecords = oldFiles[deletedRecordIdx...(oldFilesCount - 1)]
            // TODO: - Idle 处理
            //IdleLogRecordDBModel.insertOrReplace(models: forIdleRecords.map{$0.asIdle})
            
            // 删除过期的日志
            oldFiles.removeSubrange((deletedRecordIdx-1)..<(oldFilesCount-1))
            
            // 插入新的数据
            oldFiles.insert(logFile, at: 0)
            
        } else {
            // 插入新的数据
            oldFiles.insert(logFile, at: 0)
        }
        
        // 存储
        oldRecord.filenames = oldFiles.joined(separator: ",")
        oldRecord.updateIntoDB()
    }
    
    func updateAppLog(_ oldFile: String, newFile: String) {
        let oldFile = oldFile.removeDocumentsPath
        let newFile = newFile.removeDocumentsPath
        
        guard let oldRecord = NewAppLogRecordDBModel.queryLastRecord() else {
            return
        }
        var oldFiles = oldRecord.filenames.components(separatedBy: ",").filter{!$0.isEmpty}.map { $0.removeDocumentsPath }
        if let idx = oldFiles.firstIndex(where: { $0 == oldFile }) {
            oldFiles[idx] = newFile
        }
        // 存储
        oldRecord.filenames = oldFiles.joined(separator: ",")
        oldRecord.updateIntoDB()
    }
    /// 收集日志
    func queryLaunchOrExitDiagRecord() -> [NewAppLogRecordDBModel] {
        var records = NewAppLogRecordDBModel.queryNotHandleRecord() ?? []
        if !records.isEmpty {
            records.removeFirst() // 移除当次启动创建的
        }
        return records
    }
    
    func queryLaunchOrExitDiagRecord(with createTime: TimeInterval) -> NewAppLogRecordDBModel? {
        if createTime <= 0 { return nil }
        return NewAppLogRecordDBModel.queryLaunchOrExitDiagRecord(with: createTime)
    }
    
    private func createLaunchOrExitDiagRecord(with car: Car?, logFile: String? = nil) -> NewAppLogRecordDBModel {
        let newRecord = NewAppLogRecordDBModel()
        //newRecord.filenames = logFile
        newRecord.createTime = Date.current().timeIntervalSince1970
        newRecord.launchTime = TopdonLog.appInfo.launchTimestamp
        newRecord.type = (car != nil) ? RecordType.exit.rawValue : RecordType.appLog.rawValue
        
        if let logFile {
            newRecord.filenames = logFile.removeDocumentsPath
        }
        
        newRecord.uploadType = LogUploadType.appLog.rawValue
        newRecord.sn = vciInfo.wrapperSN
        newRecord.topdonId = topdonId
        newRecord.carType  = "iOSLog".uppercased()
        newRecord.carBrand = "iOSLog".uppercased()
        newRecord.lfuCarType = "iOSLog".uppercased()
        newRecord.lfuCarBrandName = "iOSLog".uppercased()
        newRecord.appVersion = TopdonLog.appInfo.version
        newRecord.extraInfo  = appendexInfos
        newRecord.zipPath    = ""
        
        if let uploadInterface = collectMgr.delegate?.getUploadInterface(car: car, uploadType: .appLog) {
            newRecord.update(from: uploadInterface)
        }
        
        return newRecord
    }
    
}

// MARK: - EnterDiagRecord

extension RecordManager {
    
    /// 生成进车数据库记录
    func enter(car: Car, logFile: String? = nil) {
        self.car = car
        
        //lock.lock()
        let newLog = createEnterDiagLogRecord(car, logFile: logFile)
        newLog.insertToDB()
       // lock.unlock()
    }
    
    func insertCarLog(_ logFile: String, car: Car) {
        
        /// 移除沙盒路径
        let logFile = logFile.removeDocumentsPath
        
        guard let oldRecord = EnterDiagLogRecordDBModel.queryLastRecord(by: car) else {
            let newLog = createEnterDiagLogRecord(car)
            newLog.filenames = logFile
            newLog.insertToDB()
            return
        }
        
        var oldFiles = oldRecord.filenames.components(separatedBy: ",").map { $0.removeDocumentsPath }
        if oldFiles.contains(logFile) {
            
            oldFiles.removeAll(where: {$0 == logFile})
            
            oldFiles.insert(logFile, at: 0)
            // 存储
            oldRecord.filenames = oldFiles.joined(separator: ",")
            oldRecord.updateIntoDB()
            
            return
        }
        
        let oldFilesCount = oldFiles.count
        
        let overflow = oldFilesCount - (maxCount - 1)
        if overflow > 0 {
            let deletedRecordIdx = max(0,(oldFilesCount - 1) - overflow)
           // let deleteRecord = oldFiles[deletedRecordIdx]
            
            // 转存到 Idle
            // let forIdleRecords = oldFiles[deletedRecordIdx...(oldFilesCount - 1)]
            // TODO: - Idle 处理
            //IdleLogRecordDBModel.insertOrReplace(models: forIdleRecords.map{$0.asIdle})
            
            // 删除过期的日志
            oldFiles.removeSubrange((deletedRecordIdx-1)..<(oldFilesCount-1))
            
            // 插入新的数据
            oldFiles.insert(logFile, at: 0)
            
        } else {
            // 插入新的数据
            oldFiles.insert(logFile, at: 0)
        }
        
        // 存储
        oldRecord.filenames = oldFiles.joined(separator: ",")
        oldRecord.updateIntoDB()
        
    }
    
    func updateCarLog(_ oldFile: String, newFile: String, car: Car) {

        let oldFile = oldFile.removeDocumentsPath
        let newFile = newFile.removeDocumentsPath
        
        guard let oldRecord = EnterDiagLogRecordDBModel.queryLastRecord(by: car) else {
            return
        }
        
        var oldFiles = oldRecord.filenames.components(separatedBy: ",").filter { !$0.isEmpty }.map { $0.removeDocumentsPath }
        if let idx = oldFiles.firstIndex(where: { $0 == oldFile }) {
            oldFiles[idx] = newFile
        }
        // 存储
        oldRecord.filenames = oldFiles.joined(separator: ",")
        oldRecord.updateIntoDB()
    }
    
    /// 收集日志
    func queryEnterDiagRecord() -> [EnterDiagLogRecordDBModel] {
        EnterDiagLogRecordDBModel.queryNotHandleRecord() ?? []
    }
    
    private func createEnterDiagLogRecord(_ car: Car, logFile: String? = nil) -> EnterDiagLogRecordDBModel {
        
        // 新建
        let newLog = EnterDiagLogRecordDBModel()
        
        // 退出记录或者APP启动记录作废，关联为进车日志记录
        if let appLogOrExitDiagRecord = NewAppLogRecordDBModel.queryLastRecord() {
            appLogOrExitDiagRecord.type = RecordType.carLog.rawValue
            appLogOrExitDiagRecord.updateIntoDB()
            
            newLog.appLogRecordId = appLogOrExitDiagRecord.createTime
        }
        if let logFile {
            newLog.filenames = logFile.removeDocumentsPath
        }
        newLog.createTime = Date.current().timeIntervalSince1970
        newLog.launchTime = TopdonLog.appInfo.launchTimestamp
        newLog.type = RecordType.carLog.rawValue
        
        newLog.sn = vciInfo.wrapperSN
        newLog.topdonId = topdonId
        newLog.extraInfo = appendexInfos
        
        newLog.carType = car.strType
        newLog.carBrand = car.brand
        newLog.lfuCarType = car.strType
        newLog.lfuCarBrandName = car.brand
        newLog.dispalyLogType = car.logType
        newLog.appVersion = TopdonLog.appInfo.version
        newLog.zipPath = ""
        newLog.status  = 0
        
        newLog.autoVinEntryType = car.autoVinEntryType
        
        if let uploadInterface = collectMgr.delegate?.getUploadInterface(car: car, uploadType: car.fileUpload.lfuLogUploadType) {
            newLog.update(from: uploadInterface)
        }
        
        return newLog
    }
    
    func queryAssociatedAppLogRecord(with createTime: TimeInterval) -> AppLogRecordDBModel? {
        guard createTime > 0 else { return nil }
        return EnterDiagLogRecordDBModel.queryAssociatedAppLogRecord(with: createTime)
    }
    
    func queryAssociatedNewAppLogRecord(with createTime: TimeInterval) -> NewAppLogRecordDBModel? {
        guard createTime > 0 else { return nil }
        return EnterDiagLogRecordDBModel.queryAssociatedNewAppLogRecord(with: createTime)
    }
    
}

// MARK: - ExitDiagRecord

extension RecordManager {
    
    /// 生成退车数据库记录
    func exit(car: Car, logFile: String? = nil) {
        self.car = nil
        
        //lock.lock()
        let exitLogRecord = createLaunchOrExitDiagRecord(with: car, logFile: logFile)
        exitLogRecord.insertToDB()
        //lock.unlock()
    }
    
}

// MARK: - Query with Zip

extension RecordManager {
    
    func queryRecord(with zipPath: String) -> (any LogRecordDBable & LogFileUploadable)? {
        if let enterDiagRecord = EnterDiagLogRecordDBModel.query(with: zipPath) {
            if let appRecord = queryAssociatedNewAppLogRecord(with: enterDiagRecord.appLogRecordId) {
                //enterDiagRecord.appLogRecord = appRecord
                enterDiagRecord.newAppLogRecord = appRecord
            }
            return enterDiagRecord
        }
        if let appRecord = NewAppLogRecordDBModel.query(with: zipPath) {
            return appRecord
        }
        return nil
    }
    
}

// MARK: - 数据库迁移

extension RecordManager {
    
    func migration() {
        
        do {
            let oldAppLogRecords = AppLogRecordDBModel.queryAllRecord() ?? []
            
            let newAppLogRecords: [NewAppLogRecordDBModel] = oldAppLogRecords.map {
                let model = NewAppLogRecordDBModel()
                model.migration(from: $0)
                return model
            }
            
            if (!newAppLogRecords.isEmpty) {
                NewAppLogRecordDBModel.insert(newAppLogRecords)
                
                /// 删除旧表
                AppLogRecordDBModel.dropTable()
            }
            
        } catch {
            innerLogger("迁移查询错误: ", error.localizedDescription)
        }
        
    }
    
}
