//
//  CarLog.swift
//  CocoaLumberjack
//
//  Created by xinwenliu on 2023/11/21.
//

import Foundation

/// Documents/log/(Car.brand)
final class CarLog: BaseLog {

    override func collectionLogs(limitCount: Int = 5) -> [String] {
        guard let car = self.car else { return [] }
        collectionLogDir = logDir + "/\(car.brand)"
        
        return super.autoCollectionLogs(limitCount: limitCount)
    }
    
}
