//
//  Car.swift
//  TopdonLog
//
//  Created by xinwenliu on 2023/11/21.
//

import Foundation

extension TopdonLog {
    
    public class Car {
        /// DD_CarModel => strVehicle，车型缩写，Benz、Ford等
        public var brand: String
        /// TDD_CarModel => strType，类型，可能的实参为，"DIAG"或者"IMMO","RFID"，即是诊断车型还是锁匠车型
        public var strType: String = ""
        
        /* 4.60 TopScan 需求, 区分诊断具体反馈类型
        类型     中文                 英文               备注
        汽车    汽车诊断              CarDiagnostics
         
               ADAS                 ADAS
               汽车防盗              CarIMMO
               汽车机油归零           CarOil
               汽车……(具体的保养名称)  Car……
               全车健康检测           HealthCheck       仅针对carpal/小车探
               发动机检测             EngineInspection
               数据流                LiveData
         
        摩托车  摩托车诊断             MotoDiagnostics
         
               摩托车防盗             MotoIMMO
               摩托车机油归零          MotoOil
              摩托车……(具体的保养名称)  Moto……
         
         注：T-Darts 日志名称不修改
         */
        /// 必传：“T-Darts”传 T-Darts App端根据 "T-Darts" 和 "AppLog" 剔除, 固件升级等可以传“AppLog”
        public var logType: String
        /// 默认空，外部传入值
        public var fileUpload: FileUpload = .empty
        
        /// 默认 -1 代表无定义, App端调用 diagStart(car: Car) 进车时候，car 参数带入
        public var autoVinEntryType: Int = -1

        public init(brand: String, strType: String, logType: String) {
            self.brand = brand
            self.strType = strType
            self.logType = logType
        }
        
        var zipType: String {
            strType.uppercased()
        }
       
        var isAutoVin: Bool {
            brand.uppercased() == "AUTOVIN"
        }
        
        var isFirmwareUpdater: Bool {
            let fCar = Car.firmwareUpdater
            return brand.uppercased() == fCar.brand && strType == fCar.strType
        }
        
    }

}

public typealias Car = TopdonLog.Car

public extension Car {
    
    /// 固件升级采用进车逻辑，定义一种 car
    static var firmwareUpdater: Car {
        Car(brand: "iOSFramework", strType: "DIAG", logType: "AppLog")
    }
    
}
