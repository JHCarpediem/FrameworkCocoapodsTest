//
//  TDBasis+Theme.swift
//  Pods
//
//  Created by fench on 2023/7/17.
//

import UIKit


public struct TDThemeBasis<Base> {
    public var base : Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol TDThemeCompatible: AnyObject { }

extension TDThemeCompatible {
    public static var theme: TDThemeBasis<Self>.Type {
        get { TDThemeBasis<Self>.self }
        set { }
    }
    
    public var theme: TDThemeBasis<Self> {
        get { TDThemeBasis(self) }
        set { }
    }
    
}

public protocol TDThemeCompatibleValue { }

extension TDThemeCompatibleValue {
    public static var theme: TDThemeBasis<Self>.Type {
        get { TDThemeBasis<Self>.self }
        set { }
    }
    
    public var theme: TDThemeBasis<Self> {
        get { TDThemeBasis(self) }
        set { }
    }
    
}

import Foundation

extension UIImage : TDThemeCompatible { }

extension UIColor : TDThemeCompatible { }

extension UIBarItem: TDThemeCompatible { }

extension UIView : TDThemeCompatible { }

extension CALayer : TDThemeCompatible {}

extension UIApplication : TDThemeCompatible { }

@available(iOS 13.0, *)
extension UINavigationBarAppearance : TDThemeCompatible {}

@available(iOS 13.0, *)
extension UIBarAppearance: TDThemeCompatible {}
