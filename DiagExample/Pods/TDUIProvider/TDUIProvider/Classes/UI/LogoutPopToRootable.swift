//
//  LogoutPopToRootable.swift
//  TDUIProvider
//
//  Created by Fench on 2025/1/8.
//

import Foundation
import TDBasis
import TDTheme

/// 这是一个占位协议，用来标记需要在登录退出之后 控制需要返回到根页面
/// 如果控制器需要在 token 失效后退出到 根页面 需要实现 `logOutNeedPopToRoot` 返回 `true`
/// 默认返回 `false`
public protocol LogoutPopToRootable {
    var logOutNeedPopToRoot: Bool { get }
}

extension LogoutPopToRootable {
    public var logOutNeedPopToRoot: Bool { false }
}
