//
//  String+Ex.swift
//  TDUIProvider
//
//  Created by Fench on 2025/1/9.
//

import Foundation
import TDBasis

public extension String {
    func size(`with` font: UIFont) -> CGSize {
        let label = UILabel(text: self, textColor: UIColor.black, font: font)
        label.sizeToFit()
        return label.frame.size
    }
}

extension TDBasisWrap where Base == String {
    public var localized: String {
        func replaceTopdon(_ text: String) -> String {
            var result = text
            guard UIProvider.isNeutral else { return result }
            
            // 使用正则表达式匹配所有 "topdon" (不论大小写)
            let pattern = "(?i)topdon" // (?i) 表示不区分大小写
            if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
                result = regex.stringByReplacingMatches(in: text, options: [], range: NSRange(text.startIndex..., in: text), withTemplate: "")
            }
            
            return result
        }
        
        func defaultValue(key: String, lan: String = "en") -> String {
            guard let enPath = Bundle.current.path(forResource: "TDUIProvider.bundle/Localized/" + lan, ofType: "lproj") else {
                return key
            }
            let enDefaultStr = Bundle(path: enPath)?.localizedString(forKey: key, value: nil, table: nil)
            guard let enDefaultStr = enDefaultStr, enDefaultStr.count > 0 else {
                return key
            }
            return replaceTopdon(enDefaultStr)
        }
        
        let key = base
        let lan = TDLanguage.current.lproj
        guard let path = Bundle.current.path(forResource: "TDUIProvider.bundle/Localized/" + lan, ofType: "lproj") else {
            return defaultValue(key: key)
        }
        let localStr = Bundle(path: path)?.localizedString(forKey: key, value: nil, table: nil)
        guard let localStr = localStr, localStr.count > 0 else {
            return defaultValue(key: key)
        }
        
        return replaceTopdon(localStr)
    }
}

extension TDBasisWrap where Base == Optional<String> {
    public var localized: String? {
        switch base {
        case .none:
            return nil
        case .some(let key):
            return key.td.localized
        }
        
    }
}

@objc public extension NSString {
    @objc public var tdLocalized: NSString {
        (self as String).td.localized.td.nsString
    }
}
