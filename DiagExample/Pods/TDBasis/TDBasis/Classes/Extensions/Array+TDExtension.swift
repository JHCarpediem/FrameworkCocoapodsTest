//
//  Array+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

@objc public extension NSArray {
    @objc func td_jsonString(prettify: Bool = false) -> String? {
        (self as Array).jsonString(prettify: prettify)
    }
    
    @objc var td_jsonString: String? {
        td_jsonString()
    }
}


public extension Array {
    /// 将数组元素按照指定键分组为字典
    /// - Parameter keyForValue: 生成分组键的闭包
    /// - Returns: 分组后的字典 [Key: [Element]]
    func groupedToDictionary<Key: Hashable>(by keyForValue: (Element) -> Key) -> [Key: [Element]] {
        return Dictionary(grouping: self, by: keyForValue)
    }
    
    /// 将数组元素按照指定键分组为二维数组（保持首次出现的键的顺序）
    /// - Parameter keyForValue: 生成分组键的闭包
    /// - Returns: 分组后的二维数组 [[Element]]
    func grouped<Key: Hashable>(by keyForValue: (Element) -> Key) -> [[Element]] {
        let groupedDict = Dictionary(grouping: self, by: keyForValue)
        
        // 保持原始分组顺序（按元素首次出现的顺序）
        var orderedKeys: [AnyHashable] = []
        var uniqueKeys: Set<AnyHashable> = []
        
        for element in self {
            let key = keyForValue(element)
            if !uniqueKeys.contains(key) {
                orderedKeys.append(key)
                uniqueKeys.insert(key)
            }
        }
        
        return orderedKeys.compactMap { key in
            groupedDict.first(where: {
                if !($0.key is (any Hashable)) {
                    return false
                }
                return $0.key as AnyHashable == key
            })?.value
        }
    }
    
    /// 将数组元素按照指定键分组为二维数组（带排序选项）
    /// - Parameters:
    ///   - keyForValue: 生成分组键的闭包
    ///   - sortGroups: 对分组进行排序的闭包（可选）
    /// - Returns: 分组后的二维数组 [[Element]]
    func grouped<Key: Hashable>(
        by keyForValue: (Element) -> Key,
        sortedBy sortGroups: (Key, Key) -> Bool
    ) -> [[Element]] {
        let groupedDict = Dictionary(grouping: self, by: keyForValue)
        let sortedKeys = groupedDict.keys.sorted(by: sortGroups)
        return sortedKeys.compactMap { groupedDict[$0] }
    }
}

public extension Array {
    
    func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
    var jsonString: String? {
        jsonString()
    }
    
    /// 筛除数组中不重复的值  去掉数组中的重复元素
    /// - Parameter filter: filter 规则
    /// - Returns: 筛选之后的数组
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}


//MARK ~ 数组安全 取下标
/**
 let arr = [0, 1, 2]  let a = arr[3~] ; let b = arr[1...4~]  数组越界了  返回 nil 不会崩溃
 
 用法： var array = [0, 1, 2]
 array[2~] = 1
 array[3~] = 1
 
 let a = array[4~] 返回nil  越界了 但是不会崩溃
 let newArr = array[1...5~]返回一个nil  越界但是不会崩溃
 
 */
postfix operator ~
public postfix func ~ (value: Int?) -> HFSafeInt? {
    return HFSafeInt(value: value)
}
public postfix func ~ (value: Swift.Range<Int>?) -> HFSafeRange? {
    return HFSafeRange(value: value)
}
public postfix func ~ (value: CountableClosedRange<Int>?) -> HFSafeRange? {
    guard let value = value else {
        return nil
    }
    return HFSafeRange(value: Swift.Range<Int>(value))
}

// Struct
public struct HFSafeInt {
    var index: Int
    init?(value: Int?) {
        guard let value = value else {
            return nil
        }
        self.index = value
    }
}

public struct HFSafeRange {
    var range: Swift.Range<Int>
    init?(value: Swift.Range<Int>?) {
        guard let value = value else {
            return nil
        }
        self.range = value
    }
}

// Core
public extension Array {
    subscript(index: HFSafeInt?) -> Element? {
        get {
            if let index = index?.index {
                return (self.startIndex..<self.endIndex).contains(index) ? self[index] : nil
            }
            return nil
        }
        set {
            if let index = index?.index, let newValue = newValue {
                if (self.startIndex ..< self.endIndex).contains(index) {
                    self[index] = newValue
                }
            }
        }
    }

    subscript(bounds: HFSafeRange?) -> ArraySlice<Element>? {
        get {
            if let range = bounds?.range {
                return self[range.clamped(to: self.startIndex ..< self.endIndex)]
            }
            return nil
        }
        set {
            if let range = bounds?.range, let newValue = newValue {
                self[range.clamped(to: self.startIndex ..< self.endIndex)] = newValue
            }
        }
    }
}

