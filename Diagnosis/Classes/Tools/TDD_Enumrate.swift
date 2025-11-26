//
//  TDD_Enumrate.swift
//  Diag
//
//  Created by Diag on 2024/1/30.
//

import Foundation

@objc enum Software: Int {
    case topdiag = 0

}

extension Software {
    static var current: Software {

        return .topdiag
    }
    
}
