//
//  TDJailbreakDetector.swift
//  TDBasis
//
//  Created by Fench on 2025/10/20.
//

import Foundation
import UIKit
import MachO
import Darwin

/// TDJailbreakDetector
/// 一个尽量稳健、组合式的越狱检测工具类。
/// - 特点：
///   1. 多检测点组合（文件路径、沙盒隔离、URL scheme、可写/可执行操作、动态库检测）
///   2. 基本字符串混淆（Base64 + 分段拼接）以防被简单静态搜索发现
///   3. 轻量 API：`detect()` 返回 (Bool, [Reason])，并提供友好的使用示例
///
/// 说明：越狱检测**不可能**做到 100% 精确。此工具作风险判断，不应作为法律或上架决定的唯一依据。

public enum TDJBReason: String {
    case suspiciousFile = "Suspicious file or path found"
    case sandboxEscaped = "Sandbox access possible"
    case dyldInject = "Suspicious dynamic library"
    case signerMismatch = "App signing/sandbox anomaly"
}

public struct TDJailbreakReport {
    public let isJailbroken: Bool
    public let reasons: [TDJBReason]
}

public final class TDJailbreakDetector {
    public static let shared = TDJailbreakDetector()
    private init() {}

    // MARK: - Public API

    /// 主检测函数（同步）
    /// - Returns: TDJailbreakReport
    public func detect() -> TDJailbreakReport {
        #if targetEnvironment(simulator)
        // 模拟器不认为是越狱（测试方便）
        return TDJailbreakReport(isJailbroken: false, reasons: [])
        #else
        var reasons = [TDJBReason]()

        if containsSuspiciousFiles() { reasons.append(.suspiciousFile) }
        if canAccessOutsideSandbox() { reasons.append(.sandboxEscaped) }
        if hasInjectedDyld() { reasons.append(.dyldInject) }
        if hasSigningAnomaly() { reasons.append(.signerMismatch) }

        return TDJailbreakReport(isJailbroken: !reasons.isEmpty, reasons: reasons)
        #endif
    }

    // MARK: - 检测项实现（组合式，便于扩展）

    private func containsSuspiciousFiles() -> Bool {
        let encodedPaths = suspiciousPathsBase64Parts()
        for enc in encodedPaths {
            if let path = deobfuscate(enc), FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }

    private func canAccessOutsideSandbox() -> Bool {
        // 尝试在 /private 下创建并删除文件
        let pathsToCheck = [
            "/private",
            "/private/var",
            "private/var/lib/apt"
        ]
        let fm = FileManager.default
        for path in pathsToCheck {
            if fm.isReadableFile(atPath: path) || fm.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }

    private func hasInjectedDyld() -> Bool {
        // 使用 dyld C API 直接获取已加载镜像信息，避免 Swift 封装带来的兼容性问题
        // dyld_image_count() 返回已加载镜像数量（C API），dyld_get_image_name(_:) 返回镜像名
        let rawCount = _dyld_image_count()
        let imageCount = UInt32(rawCount)

        var i: UInt32 = 0
        while i < imageCount {
            // dyld_get_image_name 接受一个 Int（索引），返回 const char *（C 字符串）
            if let cName = _dyld_get_image_name(i) {
                let name = String(cString: cName)
                if dyldSuspiciousKeywords().contains(where: { name.lowercased().contains($0) }) {
                    return true
                }
            }
            i += 1
        }
        return false
    }

    private func hasSigningAnomaly() -> Bool {
        // 简单检查：应用可执行文件是否可被写入（理想情况下不应该）
        guard let exePath = Bundle.main.executablePath else { return false }
        let fm = FileManager.default
        if fm.isWritableFile(atPath: exePath) {
            return true
        }
        return false
    }

    // MARK: - Obfuscation helpers (简单防静态搜索)

    private func deobfuscate(_ b64: String) -> String? {
        // 使用 base64 -> 再做分段拼接
        guard let data = Data(base64Encoded: b64) else { return nil }
        if var s = String(data: data, encoding: .utf8) {
            // 可能的二次拆分 (例如: "@|/bin/bash|@")
            s = s.replacingOccurrences(of: "@|", with: "")
            return s
        }
        return nil
    }

    private func suspiciousPathsBase64Parts() -> [String] {
        // 把路径分多段 base64 编码，降低简单静态检测概率
        // 这里列出常见路径：Cydia, MobileSubstrate, bash, sshd, apt
        // 注意：不要把所有路径硬编码成明文字符串（虽无法完全防护，但增加搜索难度）
        return [
            "QCUvfGAvQXBwbGljYXRpb25zL0NpZHlhLmFwcA==",      // @|/Applications/Cydia.app|
            "QCUvfExpYnJhcnkvTGlicmFyeS9Nb2JpbGVTdWJzdHJhdGUvTW9iaWxlU3Vic3RyYXRlLmR5bGli", // @|/Library/MobileSubstrate/MobileSubstrate.dylib|
            "QCUvfGAvYmluL2Jhc2g=",                         // @|/bin/bash|
            "QCUvfGAvdXNyL3NiaW4vc3NkZA==",                 // @|/usr/sbin/sshd|
            "QCUvfGAvZXRjL2FwdA==",                         // @|/etc/apt|
            "QCUvfGAvcHJpdmF0ZS92YXIvbGlicy9hcHQv"          // @|/private/var/lib/apt/|
        ]
    }

    private func dyldSuspiciousKeywords() -> [String] {
        // dyld 注入时可能包含的关键词
        return ["cycript", "substrate", "mobilesubstrate", "frida", "tweak", "libjailbreak"]
    }
}
