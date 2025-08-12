//
//  UIButton+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

///* tableView collectionView 复用协议
public protocol ReusableProtocol {
    static var reusableIdentify : String { get }
    static var nib : UINib? { get }
}

public extension ReusableProtocol {
    ///* 复用id 默认为 类名字符串
    static var reusableIdentify : String  {
        return "\(self)"
    }
    
    ///* 如果是从xib中注册cell 请在cell类中 重写这个属性 并在xib中将reuserIdentify属性 设置成类名
    /*
     static var nib : UINib? {
         return UINib.init(nibName: "\(self)", bundle: nil)
     }
     */
    static var nib : UINib? {
        return nil
    }
}


