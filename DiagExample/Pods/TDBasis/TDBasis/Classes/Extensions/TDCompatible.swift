//
//  TDCompatible.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

public struct TDBasisWrap<Base> {
    public var base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol TDCompatible: AnyObject { }

public protocol TDCompatibleValue { }

extension TDCompatible {
    public static var td: TDBasisWrap<Self>.Type {
        get { TDBasisWrap<Self>.self }
        set { }
    }
    
    public var td: TDBasisWrap<Self> {
        get { TDBasisWrap(self) }
        set { }
    }
    
}

extension TDCompatibleValue {
    public static var td: TDBasisWrap<Self>.Type {
        get { TDBasisWrap<Self>.self }
        set { }
    }
    
    public var td: TDBasisWrap<Self> {
        get { TDBasisWrap(self) }
        set { }
    }
    
}

import Foundation

extension NSObject: TDCompatible { }

extension String: TDCompatibleValue { }

extension Array: TDCompatibleValue { }

extension Dictionary: TDCompatibleValue { }

extension Set: TDCompatibleValue { }

extension Date: TDCompatibleValue { }

extension Data: TDCompatibleValue { }

extension Optional: TDCompatibleValue { }

extension URL: TDCompatibleValue { }
