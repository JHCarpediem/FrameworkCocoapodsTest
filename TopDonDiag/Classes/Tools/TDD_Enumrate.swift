//
//  TDD_Enumrate.swift
//  TopDonDiag
//
//  Created by fench on 2024/1/30.
//

import Foundation

@objc enum Software: Int {
    case topscan = 0
    case topvci
    case topvci_pro
    case carpal
    case carpal_guru
    case keynow
    case topscan_hd
    case topscan_vag
    case deepscan
    case topscan_bmw
    case topscan_ford
}

extension Software {
    static var current: Software {

        let dSoftware = TDD_DiagnosisManage.shared().currentSoftware
        if dSoftware.contains(.topVciPro) {
            return .topvci_pro
        }
        if dSoftware.contains(.topScan) {
            return .topscan
        }
        if dSoftware.contains(.topVci) {
            return .topvci
        }
        if dSoftware.contains(.carPal) || dSoftware.contains(.carPalGuru) {
            return .carpal
        }
        
        if dSoftware.contains(.keyNow) {
            return .keynow
        }
        
        if dSoftware.contains(.topScanHD) {
            return .topscan_hd
        }
        
        if dSoftware.contains(.topScanVAG) {
            return .topscan_vag
        }
        
        if dSoftware.contains(.topScanBMW) {
            return .topscan_bmw
        }
        
        if dSoftware.contains(.topScanFORD) {
            return .topscan_ford
        }
        
        return .topscan
    }
    
    static var isTopVCI: Bool {
        return current == .topvci
    }
    
    static var isTopVCIPro: Bool {
        return current == .topvci_pro
    }
    
    static var isTopScan: Bool {
        return current == .topscan
    }
    
    static var isTopScanHD: Bool {
        return current == .topscan_hd
    }
    
    static var isKeyNow: Bool {
        return current == .keynow
    }
    
    static var isCarpal: Bool {
        return current == .carpal
    }
    
    static var isKindOfTopVCI: Bool {
        return current == .carpal || current == .topvci
    }
    
    static var isDeepScan: Bool {
        return current == .deepscan
    }
}
