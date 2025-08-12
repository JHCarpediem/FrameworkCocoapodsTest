//
//  URL+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

@objc public extension NSURL {
    
}

extension TDBasisWrap where Base == URL {
    /// 去掉URL中的参数
    public var urlStringWithoutQuery: String {
        guard let result = base.absoluteString.td.nsString.components(separatedBy: "?").first else {
            return base.absoluteString
        }
        return result
    }
    
    public var decoded: URL {
        guard let decodeStr = base.absoluteString.removingPercentEncoding else {
            return base
        }
        return URL(string: decodeStr) ?? base
         
    }
    
    public var fileSize: UInt64? {
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: base.path)
            if let fileSize = fileAttributes[.size] as? UInt64 {
                return fileSize
            }
        } catch {
            print("Error retrieving file size: \(error)")
        }
        return nil
    }
}
