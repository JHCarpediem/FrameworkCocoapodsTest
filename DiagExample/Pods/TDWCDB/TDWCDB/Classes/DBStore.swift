//
//  DBStore.swift
//  TopdonLog
//
//  Created by xinwenliu on 2023/11/27.
//

import Foundation
import WCDBSwift


fileprivate let insertSafeEnsureLock = DispatchSemaphore(value: 1)

private let _appVersion: String = {
    Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
}()

public protocol DBModelProtocol {
    
    static var tableName: String { get }
    
}

public protocol DBModelValidable: DBModelProtocol {
    
    /// 写入数据库时App版本
    var _insertSQLAppVersion: String { get set }
    
    /// 写入模型的时间
    var _insertSQLTime: TimeInterval { get set }
    
    /// 有效期
    var _SQLValidityTerm: TimeInterval { get }
    
    init()
    
    static func invalidAll() -> Bool
    
}

private enum ValidableCodingKeys<Root>: String, CodingTableKey where Root: TableCodableBase {
    
    static var objectRelationalMapping: TableBinding<Self> {
        TableBinding(ValidableCodingKeys.self)
    }
    
    case _insertSQLAppVersion
    
    case _insertSQLTime
    
}

extension DBModelValidable {
    
    public var currentAppVersion: String {
        _appVersion
    }
    
}

extension DBModelValidable where Self: TableCodable {
    
    @discardableResult
    public func insertToDB() -> Bool {
        Self.insert(self)
    }
    
    @discardableResult
    public func updateToDB(on propertyConvertibleList: [PropertyConvertible]) -> Bool {
        do {
            try DBStore.db.create(table: Self.tableName, of: Self.self)
            try DBStore.db.update(table: Self.tableName, on: propertyConvertibleList, with: self)
            return true
        } catch {
            return false
        }
    }
    
    public static func dbInsert(model: Self) throws {
        if (model.isAutoIncrement) {
            try DBStore.db.insert(model, intoTable: tableName)
        } else {
            try DBStore.db.insertOrReplace(model, intoTable: tableName)
        }
    }
    
    public static func dbInsert(models: [Self]) throws {
        guard !models.isEmpty else { return }
        
        let model = models[0]
        if (model.isAutoIncrement) {
            try DBStore.db.insert(models, intoTable: tableName)
        } else {
            try DBStore.db.insertOrReplace(models, intoTable: tableName)
        }
    }
    
    /// 默认的insert方法
    @discardableResult
    public static func baseInsert(_ model: Self) -> Bool {
        insertSafeEnsureLock.wait(); defer { insertSafeEnsureLock.signal() }
        do {
            var model = model
            model._insertSQLTime = Date().timeIntervalSince1970
            model._insertSQLAppVersion = _appVersion
            
            try DBStore.db.create(table: tableName, of: self)
            //try DBStore.db.insertOrReplace(model, intoTable: tableName)
            try dbInsert(model: model)
            
            return true
        } catch {
            return false
        }
        
    }
    
    /// 默认的insert方法
    @discardableResult
    public static func baseInsert(_ models: [Self]) -> Bool {
        insertSafeEnsureLock.wait(); defer { insertSafeEnsureLock.signal() }
        
        var models = models
        var index = 0
        while index < models.count {
            models[index]._insertSQLTime = Date().timeIntervalSince1970
            models[index]._insertSQLAppVersion = _appVersion
            index += 1
        }
        
        do {
            try DBStore.db.create(table: tableName, of: self)
            //try DBStore.db.insertOrReplace(models, intoTable: tableName)
            try dbInsert(models: models)
            
            return true
        } catch {
            return false
        }
        
    }
    
    /// 自定义的insert方法
    @discardableResult
    public static func insert(_ model: Self) -> Bool {
        baseInsert(model)
    }
    
    /// 自定义的insert方法
    @discardableResult
    public static func insert(_ models: [Self]) -> Bool {
        baseInsert(models)
    }
    
    /// 是否有效，有效期半个月 15 * 24 * 3600 秒
    public var isValid: Bool {
        if _insertSQLAppVersion != currentAppVersion { return false }
        let now: TimeInterval = Date().timeIntervalSince1970
        return now - _insertSQLTime <=  _SQLValidityTerm
    }
    
    @discardableResult
    public static func baseInvalidAll(obj: Self = Self.init()) -> Bool {
        do {
            var obj = obj
            try DBStore.db.create(table: tableName, of: self)
            obj._insertSQLTime = 0
            try DBStore.db.update(table: tableName, on: ValidableCodingKeys<Self>._insertSQLTime, with: obj)
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    public static func invalidAll() -> Bool {
        baseInvalidAll()
    }
    
}

extension DBModelProtocol {
    
    public static var tableName: String {
        let name = type(of: self)
        let nameStr = "\(name)".components(separatedBy: ".")[optional: 0]
        if let nameStr = nameStr {
            return nameStr
        } else {
            return "\(name)"
        }
    }
    
    public static func dropTable() {
        try? DBStore.db.drop(table: tableName)
    }
    
    
}

extension DBModelProtocol where Self: TableCodable {
    
    @discardableResult
    public static func baseDelete(where whereCondition: Condition?) -> Bool {
        do {
            try DBStore.db.delete(fromTable: tableName, where: whereCondition)
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    public func insertToDB() -> Bool {
        Self.insert(self)
    }
    
    @discardableResult
    public func updateToDB(on propertyConvertibleList: [PropertyConvertible]) -> Bool {
        do {
            try DBStore.db.create(table: Self.tableName, of: Self.self)
            try DBStore.db.update(table: Self.tableName, on: propertyConvertibleList, with: self)
            return true
        } catch {
            return false
        }
    }
    
    public static func dbInsert(model: Self) throws {
        if (model.isAutoIncrement) {
            try DBStore.db.insert(model, intoTable: tableName)
        } else {
            try DBStore.db.insertOrReplace(model, intoTable: tableName)
        }
    }
    
    public static func dbInsert(models: [Self]) throws {
        guard !models.isEmpty else { return }
        
        let model = models[0]
        if (model.isAutoIncrement) {
            try DBStore.db.insert(models, intoTable: tableName)
        } else {
            try DBStore.db.insertOrReplace(models, intoTable: tableName)
        }
    }
    
    /// 默认的insert方法
    @discardableResult
    public static func baseInsert(_ model: Self) -> Bool {
        insertSafeEnsureLock.wait(); defer { insertSafeEnsureLock.signal() }
        
        do {
            try DBStore.db.create(table: tableName, of: self)
            // try DBStore.db.insertOrReplace(model, intoTable: tableName)
            try dbInsert(model: model)
            return true
        } catch {
            return false
        }
        
    }
    
    /// 默认的insert方法
    @discardableResult
    public static func baseInsert(_ models: [Self]) -> Bool {
        insertSafeEnsureLock.wait(); defer { insertSafeEnsureLock.signal() }
        
        do {
            try DBStore.db.create(table: tableName, of: self)
            //try DBStore.db.insertOrReplace(models, intoTable: tableName)
            try dbInsert(models: models)
            return true
        } catch {
            return false
        }
        
    }
    
    /// 自定义的insert方法
    @discardableResult
    public static func insert(_ model: Self) -> Bool {
        baseInsert(model)
    }
    
    /// 自定义的insert方法
    @discardableResult
    public static func insert(_ models: [Self]) -> Bool {
        baseInsert(models)
    }
    
    public static func update(on propertyConvertibleList: [Self.Properties],
                              with row: [WCDBSwift.ColumnEncodable],
                              where condition: WCDBSwift.Condition? = nil,
                              orderBy orderList: [WCDBSwift.OrderBy]? = nil,
                              limit: WCDBSwift.Limit? = nil,
                              offset: WCDBSwift.Offset? = nil) throws {
        do {
            try DBStore.db.create(table: tableName, of: self)
            try DBStore.db.update(table: tableName, on: propertyConvertibleList,
                                  with: row,
                                  where: condition,
                                  orderBy: orderList,
                                  limit: limit,
                                  offset: offset)
        } catch {
            throw error
        }
    }
    
    
    
    // MARK: - Upgrade
    
    public static func upgradeTable() {
        try? DBStore.db.create(table: tableName, of: Self.self)
    }
    
}


extension Array where Element: DBModelProtocol, Element: TableCodable {
    
    @discardableResult
    public func insertToDB() -> Bool {
        allSatisfy {
            $0.insertToDB()
        }
    }
    
    
    @discardableResult
    public func updateToDB(on propertyConvertibleList: [PropertyConvertible]) -> Bool {
        allSatisfy {
            $0.updateToDB(on: propertyConvertibleList)
        }
    }
    
}

// MARK: - DBStore

public final class DBStore {
    
    public static let shared: DBStore = DBStore()
    
    public static var dbName = "/td_app_log_model.db"
    
    public static var db: Database { DBStore.shared.dbConnection }
    
    private(set) var dbConnection: Database
    
    public static var dbPath: String  {
        db.path
    }
    
    private init() {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if var url = urls[optional: 0] {
            url.appendPathComponent(Self.dbName)
            dbConnection = Database(at: url)
        } else {
            fatalError("Create database failed")
        }
     /*
#if DEBUG
        Database.globalTrace(ofSQL: { (tag, path, handleIdentifier, sql)  in print("SQL: \(sql)") })
#endif
      */
        
    }
    
}


// MARK: - Other Extension

public extension Collection {
    
    subscript(optional index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Array {
    
    subscript(optional range: Range<Index>) -> ArraySlice<Element>? {
        if range.endIndex > endIndex {
            if range.startIndex >= endIndex {
                return nil
            } else {
                return self[range.startIndex..<endIndex]
            }
        } else {
            return self[range]
        }
    }
}
