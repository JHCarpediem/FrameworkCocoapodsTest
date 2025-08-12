//
//  TDCrypto.swift
//  TDBasis
//
//  Created by fench on 2023/7/15.
//

import UIKit
import CommonCrypto


/**
    @code
 CCCrypt(kCCDecrypt,  //kCCDecrypt是解密，kCCEncrypt是加密
 kCCAlgorithmAES128,   //算法 ase128
 kCCOptionPKCS7Padding | kCCOptionECBMode,   //填充模式，比如使用ase128算法，要求数据最小长度是128bit，当数据没达到长度是的填充数据策略
 keyPtr, //密钥
 kCCBlockSizeAES128,  //密钥大小
 NULL,   //偏移量
 [self bytes], dataLength,   //数据和数据长度
 buffer, bufferSize,  &numBytesDecrypted);  返回数据
    @endcode
*/

@objc public extension NSString {
    @objc var td_AES128Encrypt: String? {
        return (self as String).td.AES128Encrypt
    }
    
    @objc var td_AES128Decrypt: String? {
        return (self as String).td.AES128Decrypt
    }
    
    @objc var td_AESLocalEncrypt: String? {
        return (self as String).td.AESLocalEncrypt
    }
    
    
    @objc var td_MD5:String {
        return (self as String).td.MD5
    }
    
    @objc var td_SHA256: String {
        return (self as String).td.SHA256
    }
    
    @objc var td_macSHA256: String {
        return (self as String).td.macSHA256
    }
}

extension TDBasisWrap where Base == String {
    
    /// 字符串MD5加密
    public var MD5: String {
        let utf8 = base.cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
    
    /// 字符串SHA265 加密
    public var SHA256: String {
        let utf8 = base.cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
    
    /// 字符串`macSHA256`加密 用于密码初级加密
    public var macSHA256: String {
        TDHAESEncryption.td_hmacSHA256(withContent: base)
    }
    
    /// 字符串 `AES128`加密 用于服务器密码加密
    public var AES128Encrypt: String? {
        TDHAESEncryption.td_AES128ParmEncrypt(withContent: base)
    }
    
    /// 字符串 `AES128`解密
    public var AES128Decrypt: String? {
        TDHAESEncryption.td_AES128ParmDecrypt(withContent: base)
    }
    
    public var AESLocalEncrypt: String? {
        TDHAESEncryption.td_AESLocalEncryption(withContent: base)
    }
    
    /// 字符串URL 编码
    public var encoded: String {
        let temp = base.utf8.map { c in
            if (c >= 48 && c <= 57) || (c >= 97 && c <= 122) || (c >= 65 && c <= 90) || (c == 45) || (c == 95){
                return String(format: "%c", c)
            } else {
                return String(format: "%%%02X", c)
            }
        }
        return temp.reduce("") { partialResult, res in
            return partialResult + res 
        }
    }
    
    public var decoded: String {
        CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, base as CFString, "" as CFString) as! String
    }
}
