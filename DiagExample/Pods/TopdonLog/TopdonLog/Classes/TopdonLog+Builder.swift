//
//  TopdonLog+Builder.swift
//  TopdonLog
//
//  Created by xinwenliu on 2023/11/29.
//

import Foundation

// MARK: - LogConfigurationBuildable

public protocol LogConfigurationBuildable {
    
    func config(_ log: TopdonLog.Type) -> Self
}

// MARK: - LogConfigurationBuilder

@resultBuilder
public struct LogConfigurationBuilder {
    
    public static func buildBlock(_ components: LogConfigurationBuildable...) -> [LogConfigurationBuildable] {
        components
    }
    
    public static func buldBloc() -> [LogConfigurationBuildable] {
        []
    }
    
}

// MARK: - Imp

//extension TopdonLog: LogConfigurationBuildable {
//
//}

extension LogUploadManager: LogConfigurationBuildable { }


extension LogColletionManager: LogConfigurationBuildable { }


