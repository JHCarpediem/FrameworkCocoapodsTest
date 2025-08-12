//
//  BridgeTool.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/13.
//

import Foundation
import UIKit

public class BridgeTool {
    
    @objc
    public static func tdd_imageNamed(_ imageName: String) -> UIImage? {
        let bundle = Bundle(for: Self.self)
        let image = UIImage(named: "TopdonDiagnosis.bundle/image/\(imageName)", in: bundle, compatibleWith: nil)
        return image
    }
}

// MARK: - Info.plist

public extension BridgeTool {
    
    public static func tdd_getInfoDictionary() -> [String: Any] {
        var infoDict = Bundle.main.localizedInfoDictionary
        if infoDict == nil || infoDict?.isEmpty == true {
            infoDict = Bundle.main.infoDictionary
        }
        if infoDict == nil || infoDict?.isEmpty == true {
            if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
               let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                infoDict = dict
            }
        }
        return infoDict ?? [:]
    }
    
    public static func tdd_getAppName() -> String {
        var infoDict = tdd_getInfoDictionary()
        var appName = infoDict["CFBundleDisplayName"] as? String
        if appName == nil { appName = infoDict["CFBundleName"] as? String }
        if appName == nil { appName = infoDict["CFBundleExecutable"] as? String }
        
        if appName == nil {
            infoDict = Bundle.main.infoDictionary ?? [:]
            appName = infoDict["CFBundleDisplayName"] as? String
            if appName == nil { appName = infoDict["CFBundleName"] as? String }
            if appName == nil { appName = infoDict["CFBundleExecutable"] as? String }
        }
        
        return appName ?? "App"
    }
    
}
