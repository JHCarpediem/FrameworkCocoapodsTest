//
//  VCIInfo.swift
//  TopdonLog
//
//  Created by xinwenliu on 2023/11/21.
//

import Foundation

final public class VCIInfo {
    
    var sn: String
    
    init(sn: String) {
        self.sn = sn
    }
    
    var wrapperSN: String {
        let cleanSN = sn.removeNonAlphanumericCharacters()
        return cleanSN.isEmpty ? "Unknown_SN" : cleanSN
    }
    
}

internal extension String {
    
    /// TC 设备出现 SN = "02\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
    func removeNonAlphanumericCharacters() -> String {
        let string = self
        let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9]", options: [])
        let range = NSRange(location: 0, length: string.utf16.count)
        let cleanString = regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: "")
        return cleanString
    }
    
}
