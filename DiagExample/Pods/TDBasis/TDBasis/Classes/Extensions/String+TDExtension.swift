//
//  String+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit
import CommonCrypto

public extension TDBasisWrap where Base == String {
    
    /// Integer value from string (if applicable).
    ///
    ///        "101".int -> 101
    ///
    var int: Int? {
        return Int(base)
    }
    
    /// Bool value from string (if applicable).
    ///
    ///        "1".bool -> true
    ///        "False".bool -> false
    ///        "Hello".bool = nil
    ///
    var bool: Bool? {
        let selfLowercased = base.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch selfLowercased {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    /// NSString from a string.
    var nsString: NSString {
        return NSString(string: base)
    }
    
    /// NSString lastPathComponent.
    var lastPathComponent: String {
        return (base as NSString).lastPathComponent
    }

    /// NSString pathExtension.
    var pathExtension: String {
        return (base as NSString).pathExtension
    }

    /// NSString deletingLastPathComponent.
    var deletingLastPathComponent: String {
        return (base as NSString).deletingLastPathComponent
    }

    /// NSString deletingPathExtension.
    var deletingPathExtension: String {
        return (base as NSString).deletingPathExtension
    }

    /// NSString pathComponents.
    var pathComponents: [String] {
        return (base as NSString).pathComponents
    }

    /// 对手机加密 手机: 134****4325
    var securetPhoneNum: String { (base as NSString).td_securetPhoneNum as String }
    
    /// 对邮箱加密 邮箱 123****@qq.com
    var securetEmail: String { (base as NSString).td_securetEmail as String }
    
    /// 将账号加密  手机: 134****4325  邮箱 123****@qq.com
    var securetAccount: String { (base as NSString).td_securetAccount as String }
    
    /// 是否为有效邮箱  邮箱正则匹配
    var isValidateEmail:  Bool { (base as NSString).td_isValidateEmail }
        
    /// 是否为有效手机号 手机号正则匹配
    var isValidateMobile: Bool { (base as NSString).td_isValidateMobile }
    
    /// 检测手机号 只检测11位
    var isValidateVagueMobile: Bool { base.count == 11 }
    
    /// 是否为大写
    var isUppercase: Bool { (base as NSString).td_isUppercase }
    
    /// 是否为小写
    var isLowercase: Bool { (base as NSString).td_isLowercase }
    
    /// 是否为数字或者英文字符
    var isNumberOrLetter: Bool { (base as NSString).td_isNumberOrLetter }
    
    /// 是否为数字+ 英文字符
    var isNumberAndLetter: Bool { (base as NSString).td_isNumberAndLetter }
    
    /// 是否是URL
    var isUrl: Bool { (base as NSString).td_isUrl }
    
    //大小写英文字母阿拉伯数字 8-30位
    var isValidPassword: Bool { (base as NSString).td_isValidPassword }
    
    //大小写英文字母阿拉伯数字
    var isValidCasePassword:  Bool { (base as NSString).td_isValidCasePassword }

    //8-30位
    var isValidLenthPassword:  Bool { (base as NSString).td_isValidLenthPassword }
    
    /// 是否是有效的wifi密码
    var isWiFiPassword: Bool { (base as NSString).td_isWiFiPassword }
    
    /// 是否是ASCII码
    var isAscii: Bool { (base as NSString).td_isAscii }
    
    /// url from string
    var url: URL? {
        return URL(string: base)
    }
    
    ///  Check if string contains one or more emojis.
    ///
    ///        "Hello 😀".containEmoji -> true
    ///
    var containEmoji: Bool {
        guard let firstProperties = base.unicodeScalars.first?.properties else {
            return false
        }
        if #available(iOS 10.2, *) {
            var hasEmoji = false
            for scalar in base.unicodeScalars {
                if scalar.properties.isEmojiPresentation || scalar.properties.generalCategory == .otherSymbol {
                    hasEmoji = true
                    break
                }
            }
            return hasEmoji
        } else {
            return base.unicodeScalars.contains { scaler in
                // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
                switch scaler.value {
                case 0x1F600...0x1F64F, // Emoticons
                0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                0x1F680...0x1F6FF, // Transport and Map
                0x1F1E6...0x1F1FF, // Regional country flags
                0x2600...0x26FF, // Misc symbols
                0x2700...0x27BF, // Dingbats
                0xE0020...0xE007F, // Tags
                0xFE00...0xFE0F, // Variation Selectors
                0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                127000...127600, // Various asian characters
                65024...65039, // Variation selector
                9100...9300, // Misc items
                8400...8447: // Combining Diacritical Marks for Symbols
                    return true
                default:
                    return false
                }
            }
        }
    }
    
    func doubleValue(retain: Int? = nil, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Double? {
        let strs = base.components(separatedBy: ".")
        let digit = strs.count > 1 ? strs.last?.count ?? 0 : 0
        
        let doubleValue = Double(base)
        return doubleValue?.rounded(decimalPlaces: retain ?? digit, rule: rule)
    }
    
    /// 是否为纯数字
    var isIntNumber: Bool { (base as NSString).td_isIntNumber }
    
    /// 字符串转字典
    var jsonDictionay: [AnyHashable: Any]? {
        guard let data = base.data(using: .utf8), let jsonDict = try? JSONSerialization.jsonObject(with: data) as? [AnyHashable: Any] else {
            return nil
        }
        return jsonDict
    }
    
    /// 字符串转数组
    var jsonArray: [Any]? {
        guard let data = base.data(using: .utf8), let jsonArray = try? JSONSerialization.jsonObject(with: data) as? [Any] else {
            return nil
        }
        return jsonArray
    }
    
    /// NSString appendingPathComponent(str: String)
    ///
    /// - Note: This method only works with file paths (not, for example, string representations of URLs.
    ///   See NSString [appendingPathComponent(_:)](https://developer.apple.com/documentation/foundation/nsstring/1417069-appendingpathcomponent)
    /// - Parameter str: the path component to append to the receiver.
    /// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
    func appendingPathComponent(_ str: String) -> String {
        return (base as NSString).appendingPathComponent(str)
    }

    /// NSString appendingPathExtension(str: String)
    ///
    /// - Parameter str: The extension to append to the receiver.
    /// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
    func appendingPathExtension(_ str: String) -> String? {
        return (base as NSString).appendingPathExtension(str)
    }
    
    /// Date object from string of date format.
    ///
    ///        "2017-01-15".td.date(withFormat: "yyyy-MM-dd") -> Date set to Jan 15, 2017
    ///        "not date string".td.date(withFormat: "yyyy-MM-dd") -> nil
    ///
    /// - Parameter format: date format.
    /// - Returns: Date object from string (if applicable).
    func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: base)
    }
    /// Removes spaces and new lines in beginning and end of string.
    ///
    ///        var str = "  \n Hello World \n\n\n"
    ///        str.td.trim()
    ///        print(str) // prints "Hello World"
    ///
    @discardableResult
    mutating func trim() -> String {
        return base.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Convert URL string to readable string.
    ///
    ///        var str = "it's%20easy%20to%20decode%20strings"
    ///        str.td.urlDecode()
    ///        print(str) // prints "it's easy to decode strings"
    ///
    @discardableResult
    mutating func urlDecode() -> String {
        if let decoded = base.removingPercentEncoding {
            base = decoded
        }
        return base
    }
    
    /// Escape string.
    ///
    ///        var str = "it's easy to encode strings"
    ///        str.td.urlEncode()
    ///        print(str) // prints "it's%20easy%20to%20encode%20strings"
    ///
    @discardableResult
    mutating func urlEncode() -> String {
        if let encoded = base.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            base = encoded
        }
        return base
    }
    
    /// Verify if string matches the regex pattern.
    ///
    /// - Parameter pattern: Pattern to verify.
    /// - Returns: true if string matches the pattern.
    func matches(pattern: String) -> Bool {
        return base.range(of: pattern, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /// Removes given prefix from the string.
    ///
    ///   "Hello, World!".removingPrefix("Hello, ") -> "World!"
    ///
    /// - Parameter prefix: Prefix to remove from the string.
    /// - Returns: The string after prefix removing.
    func removingPrefix(_ prefix: String) -> String {
        guard base.hasPrefix(prefix) else { return base }
        return String(base.dropFirst(prefix.count))
    }

    /// Removes given suffix from the string.
    ///
    ///   "Hello, World!".removingSuffix(", World!") -> "Hello"
    ///
    /// - Parameter suffix: Suffix to remove from the string.
    /// - Returns: The string after suffix removing.
    func removingSuffix(_ suffix: String) -> String {
        guard base.hasSuffix(suffix) else { return base }
        return String(base.dropLast(suffix.count))
    }

    /// Adds prefix to the string.
    ///
    ///     "www.apple.com".td.withPrefix("https://") -> "https://www.apple.com"
    ///
    /// - Parameter prefix: Prefix to add to the string.
    /// - Returns: The string with the prefix prepended.
    func withPrefix(_ prefix: String) -> String {
        // https://www.hackingwithswift.com/articles/141/8-useful-swift-extensions
        guard !base.hasPrefix(prefix) else { return base }
        return prefix + base
    }
    
    /// Create a new random string of given length.
    ///
    ///        String.td.random(length: 10) -> "gY8r3MHvlQ"
    ///        String.td.random(length: 10, base: "01223456789") -> "5963157803"
    ///
    /// - Parameter length: number of characters in string.
    static func random(length: Int, base: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
        guard length > 0 else {
            return ""
        }
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        return randomString
    }
    
    /// 获取文本高度
    /// - Parameters:
    ///   - font: 文本字体
    ///   - maxWidth: 文本最大宽度
    /// - Returns: 文本高度
    func height(with font: UIFont, maxWidth: CGFloat) -> CGSize {
        (base as NSString).td_height(with: font, maxWidth: maxWidth)
    }
    
    /// 获取字符串的size
    /// - Parameters:
    ///   - font: 字体大小
    ///   - maxSize: 最大size
    ///   - options: 绘制options
    /// - Returns: 字符串size
    func size(font: UIFont, maxSize: CGSize) -> CGSize {
        (base as NSString).td_size(with: font, maxSize: maxSize)
    }
    
    /// 获取从0到index的子字符串
    public func subString(to index: Int) -> String {
        (base as NSString).substring(to: index)
    }
    
    /// 获取from-to的子字符串
    func subString(from fIndex: Int, to tIndex: Int? = nil) -> String {
        var tIndex = tIndex ?? base.count
        tIndex = min(tIndex, base.count)
        guard fIndex <= tIndex else {
            return base
        }
        let startIndex = base.index(base.startIndex, offsetBy: fIndex)
        let endIndex = base.index(base.startIndex, offsetBy: tIndex)
        return String(base[startIndex..<endIndex])
    }
    
    /// Float value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Float value from given string.
    func float(locale: Locale = .current) -> Float? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: base)?.floatValue
    }
    /// Double value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Double value from given string.
    func double(locale: Locale = .current) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: base)?.doubleValue
    }
    /// CGFloat value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional CGFloat value from given string.
    func cgFloat(locale: Locale = .current) -> CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .decimal
        formatter.allowsFloats = true
        return formatter.number(from: base) as? CGFloat
    }
    /// Array of strings separated by new lines.
    ///
    ///        "Hello\ntest".td.lines() -> ["Hello", "test"]
    ///
    /// - Returns: Strings separated by new lines.
    func lines() -> [String] {
        var result = [String]()
        base.enumerateLines { line, _ in
            result.append(line)
        }
        return result
    }
    
    func `default`(with value: String = "") -> String {
        if base.isEmpty {
            return value
        }
        return base
    }
    
    /// 为字符串添加高亮子串
    /// - Parameters:
    ///   - subString: 需要高亮的字串
    ///   - hilightColor: 高亮颜色
    ///   - normalColor: 字符串颜色
    ///   - compareOptions: 需要高亮子串的匹配规则 如果需要从后面开始匹配 可以传`.backwards`
    ///   - lineSpacing: 文本的行间距
    /// - Returns: 富文本
    func setHilight(`of` subString: String?,
                    hilightColor: UIColor,
                    normalColor: UIColor = .white,
                    normalFont: UIFont? = nil,
                    highlightFont: UIFont? = nil,
                    compareOptions: NSString.CompareOptions = [],
                    lineSpacing: CGFloat? = nil) -> NSAttributedString{
        let tempString = NSMutableAttributedString.init(string: base)
        if let space = lineSpacing {
            let paraGraph = NSMutableParagraphStyle()
            paraGraph.lineSpacing = space
            paraGraph.alignment = .left
            let range = NSRange(location: 0, length: base.count )
            tempString.addAttributes([NSAttributedString.Key.paragraphStyle: paraGraph], range: range)
        }
        // 如果传入的子文本为空 则返回原文本的富文本
        guard let subString = subString else {
            return tempString as NSAttributedString
        }
        
        // 如果设置的高亮文本不在父文本中 返回原文本的富文本
        guard let _ = base.lowercased().range(of: subString.lowercased()) else {
            return tempString as NSAttributedString
        }
        // 设置普通文本颜色
        var normal: [NSAttributedString.Key: Any] = [.foregroundColor : normalColor]
        if let normalFont = normalFont {
            normal[.font] = normalFont
        }
        let nRange = nsString.range(of: base)
        tempString.addAttributes(normal, range: nRange)
        // 设置文本高亮
        var att: [NSAttributedString.Key: Any] = [.foregroundColor : hilightColor]
        if let highlightFont = highlightFont {
            att[.font] = highlightFont
        }
        let nsRange = nsString.range(of: subString, options: compareOptions)
        tempString.addAttributes(att, range: nsRange)
        return tempString as NSAttributedString
    }
    
    /// 富文本设置 字体大小 行间距 字间距 缩进
    func setAttributedString(font: UIFont,
                          textColor: UIColor,
                          alignment: NSTextAlignment = .center,
                          lineSpaceing: CGFloat,
                          wordSpaceing: CGFloat = 0,
                          headIndent: CGFloat = 0) -> NSMutableAttributedString {
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpaceing
        style.alignment = alignment
        style.headIndent = headIndent
        
        let attributes = [
                NSAttributedString.Key.font             : font,
                NSAttributedString.Key.foregroundColor  : textColor,
                NSAttributedString.Key.paragraphStyle   : style,
                NSAttributedString.Key.kern             : wordSpaceing]
            
            as [NSAttributedString.Key : Any]
        let attrStr = NSMutableAttributedString.init(string: base, attributes: attributes)
        return attrStr
    }
    
    /// 去掉文本中的emoji
    func removingEmojis() -> String {
        base.filter { !$0.isEmoji }
    }
    
    // 获取当前路径的文件\文件夹大小
    var fileSize: UInt64 {
        var size: UInt64 = 0
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        let isExists = fileManager.fileExists(atPath: base, isDirectory: &isDir)
        // 判断文件存在
        if isExists {
            // 是否为文件夹
            if isDir.boolValue {
                // 迭代器 存放文件夹下的所有文件名
                let enumerator = fileManager.enumerator(atPath: base)
                for subPath in enumerator! {
                    // 获得全路径
                    let fullPath = base.appending("/\(subPath)")
                    do {
                        let attr = try fileManager.attributesOfItem(atPath: fullPath)
                        size += attr[FileAttributeKey.size] as! UInt64
                    } catch  {
                        print("error :\(error)")
                    }
                }
            } else {    // 单文件
                do {
                    let attr = try fileManager.attributesOfItem(atPath: base)
                    size += attr[FileAttributeKey.size] as! UInt64
                    
                } catch  {
                    print("error :\(error)")
                }
            }
        }
        return size
    }
    
    /// 文件大小 格式化之后的字符串 MB GB TB ...
    var fileSizeFormatter: String {
        var fileSize = Double(fileSize)
        var index = 0
        let tokens = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
        while fileSize > 1024, index < tokens.count - 1 {
            fileSize /= 1024
            index += 1
        }
        return fileSize.string(retain: 2) + " " + tokens[index]
    }
}

@objc public extension NSString {
    @objc var string: String {
        self as String
    }
    
    @objc var td_Url: URL? {
        return (self as String).td.url
    }
    
    @objc func `default`(with value: String = "") -> String {
        return (self as String).td.default(with: value)
    }
    
    /// 对手机加密 手机: 134****4325
    @objc var td_securetPhoneNum: NSString{
        if self.length != 11 {
            return self
        }
        return self.replacingCharacters(in: NSRange(location: 3, length: 4), with: "****") as NSString
    }
    
    /// 对邮箱加密 邮箱 123****@qq.com
    @objc var td_securetEmail: NSString {
        if !self.td_isValidateEmail {
            return self
        }
        let coms = self.components(separatedBy: "@")
        guard coms.count >= 2 else {
            return self
        }
        var firstCom = ""
        if coms[0].count == 1 {
            firstCom = "****" + coms[0]
        } else if coms[0].count == 2 {
            firstCom = "****" + coms[0]
        } else {
            firstCom = coms[0].td.subString(to: 1) + "****" + coms[0].td.subString(from: coms[0].count - 1, to: coms[0].count)
        }
        return (firstCom + "@" + coms[1]) as NSString
    }
    
    /// 将账号加密  手机: 134****4325  邮箱 123****@qq.com
    @objc var td_securetAccount: NSString{
        if self.td_isValidateEmail {
            return self.td_securetEmail
        }
        if self.td_isValidateMobile {
            return self.td_securetPhoneNum
        }
        return self
    }
    
    @objc var td_isValidateEmail:  Bool{
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    @objc var td_isValidateMobile: Bool {
        let phoneRegex: String = "^(13|15|17|16|19|18|14)[0-9]{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    @objc var td_isUppercase: Bool {
        let emailRegex: String = "^[A-Z]+$"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    @objc var td_isLowercase: Bool {
        let emailRegex: String = "^[a-z]+$"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    @objc var td_isNumberOrLetter: Bool {
        //由数字或26个英文字母组成的字符串：
        let emailRegex: String = "^[A-Za-z0-9]+$"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    @objc var td_isNumberAndLetter: Bool {
        //由数字和26个英文字母组成的字符串：
        let letterRegex: String = "[A-Za-z]+"
        let letterTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", letterRegex)
        if letterTest.evaluate(with: self) {
            let numberRegex: String = "[0-9]+"
            let numberTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
            return numberTest.evaluate(with: self)
        }else{
            return false
        }
    }
    
    @objc var td_isUrl: Bool {
        do {
            let dataDetector: NSDataDetector = try NSDataDetector.init(types: NSTextCheckingResult.CheckingType.link.rawValue)
            
            let stringRange = NSMakeRange(0, (self as NSString).length)
            let notFoundRange = NSMakeRange(NSNotFound, 0)
            
            let linkRange = dataDetector.rangeOfFirstMatch(in: self as String, options: NSRegularExpression.MatchingOptions(rawValue: UInt(0)), range: stringRange)
            
            if (!NSEqualRanges(notFoundRange, linkRange) && NSEqualRanges(stringRange, linkRange)) {
                return true;
            }
            
            return false
        } catch {
            NSLog("String is not an URL")
            return false
        }
    }
    
    //大小写英文字母阿拉伯数字 8-30位
    @objc var td_isValidPassword: Bool {
        return td_isValidCasePassword && td_isValidLenthPassword
    }
    
    //大小写英文字母阿拉伯数字
    @objc var td_isValidCasePassword: Bool {
        let specialCharacters = "@$!%*#_~?&.-"
        
        let uppercaseRegex = "[A-Z]"
        let lowercaseRegex = "[a-z]"
        let digitRegex = "\\d"
        let specialCharRegex = "[\(specialCharacters)]"
        let invalidCharRegex = "[^A-Za-z0-9\(specialCharacters)]" // 不允许的特殊字符
        
        // 1. 检查是否包含无效字符
        let invalidCharTest = try! NSRegularExpression(pattern: invalidCharRegex)
        if invalidCharTest.firstMatch(in: string, range: NSRange(location: 0, length: string.utf16.count)) != nil {
            return false
        }
        
        // 2. 检查至少两种字符类型
        let patterns = [uppercaseRegex, lowercaseRegex, digitRegex, specialCharRegex]
        
        // 统计匹配到的字符类别数量
        let matchedCategories = patterns.filter { pattern in
            let regex = try! NSRegularExpression(pattern: pattern)
            return regex.firstMatch(in: string, range: NSRange(location: 0, length: string.utf16.count)) != nil
        }.count
        
        return matchedCategories >= 2
    }
    
    //8-30位
    @objc var td_isValidLenthPassword: Bool {
        return length.td.isBetween(8...30)
    }
    
    /// 是否是有效的wifi密码
    @objc var td_isWiFiPassword: Bool {
        let emailRegex: String = "^[\\x00-\\xff]{8,}$"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
        
    }
    
    /// 是否是ASCII码
    @objc var td_isAscii: Bool {
        let regex: String = "^[\\x00-\\xff]+$"
        let pre: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return pre.evaluate(with: self)
    }
    
    @objc var td_isEmpty: Bool {
        return self.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "").count == 0
    }
    
    ///  Check if string contains one or more emojis.
    ///
    ///        "Hello 😀".containEmoji -> true
    ///
    var td_containEmoji: Bool {
        string.td.containEmoji
    }
    
    @objc var td_isIntNumber: Bool {
        var res = self.trimmingCharacters(in: .decimalDigits)
        res = res.trimmingCharacters(in: .whitespaces)
        return res.count <= 0
    }
    
    @objc func td_height(with font: UIFont, maxWidth: CGFloat) -> CGSize {
        td_size(with: font, maxSize: CGSize(width: maxWidth, height: .greatestFiniteMagnitude))
    }
    
    @objc func td_size(with font: UIFont, maxSize: CGSize) -> CGSize {
        boundingRect(with: maxSize,
                     options: .usesLineFragmentOrigin,
                     attributes: [NSAttributedString.Key.font : font], context: nil)
        .size
    }
    
    @objc func td_substring(from fromIndex: Int, to toIndex: Int) -> NSString {
        (self as String).td.subString(from: fromIndex, to: toIndex) as NSString
    }
    
    @objc func td_date(withFormat format: String) -> Date? {
        self.string.td.date(withFormat: format)
    }
    
    @discardableResult
    @objc func td_urlDecode() -> String {
        if let decoded = self.removingPercentEncoding {
            return decoded
        }
        return self.string
    }
    
    /// Escape string.
    ///
    ///        var str = "it's easy to encode strings"
    ///        str.urlEncode()
    ///        print(str) // prints "it's%20easy%20to%20encode%20strings"
    ///
    @discardableResult
    @objc func td_urlEncode() -> String {
        if let encoded = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return encoded
        }
        return self.string
    }
    
    func removingEmojis() -> String {
        string.td.removingEmojis()
    }
}

extension Character {
    var isEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmojiPresentation || scalar.properties.generalCategory == .otherSymbol
    }
}


