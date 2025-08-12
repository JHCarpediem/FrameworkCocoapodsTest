//
//  Data+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit
import CommonCrypto

enum CryptError: Error {
    case noIV
    case cryptFailed
    case notConvertTypeToData
}

@objc public extension NSData {
    
    @objc var td_jsonDict: NSDictionary? {
        (self as Data).td.jsonDict as? NSDictionary
    }
    
    @objc var td_jsonArray: NSArray? {
        (self as Data).td.jsonArray as? NSArray
    }
    
    func td_jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self as Data, options: options)
    }
}

public extension TDBasisWrap where Base == Data {
    
    var jsonDict: [AnyHashable: Any]? {
        try? jsonObject() as? [AnyHashable: Any]
    }
    
    var jsonArray: [Any]? {
        try? jsonObject() as? [Any]
    }
    
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: base, options: options)
    }
}
