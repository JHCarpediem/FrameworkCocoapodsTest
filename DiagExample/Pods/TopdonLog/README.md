# TopdonLog

[![CI Status](https://img.shields.io/travis/app@lenkor.cn/TopdonLog.svg?style=flat)](https://travis-ci.org/app@lenkor.cn/TopdonLog)
[![Version](https://img.shields.io/cocoapods/v/TopdonLog.svg?style=flat)](https://cocoapods.org/pods/TopdonLog)
[![License](https://img.shields.io/cocoapods/l/TopdonLog.svg?style=flat)](https://cocoapods.org/pods/TopdonLog)
[![Platform](https://img.shields.io/cocoapods/p/TopdonLog.svg?style=flat)](https://cocoapods.org/pods/TopdonLog)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Latest Version
v1.50.003

## Installation

TopdonLog is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TopdonLog', '1.50.003
```

## Usage

```swift
// MARK: - AppDelegate

// 1. 启动配置
@objc extension AppDelegate {
    
    func setupLog() {
        TopdonLog.config {
            // 1. 设置收集管理
            LogColletionManager.shared
                .clearLog()
                .setup(delegate: self)
            
            // 2. 设置上传管理
            LogUploadManager.shared.setup(delegate: self)
        }
        
        // 网络可通，用户有登录的情况下
        LogUploadManager.shared.uploadLogsIfNeeded()
    }
    
}

// 2. 实现日志收集代理 LogColletionManagerDelegate，存在获取相关信息
extension AppDelegate: LogColletionManagerDelegate {
    
    public func getVciSN() -> String {
        return ""
    }
    
    public func getTopdonId() -> String {
        return ""
    }
    
    // 附加信息
    public func getAppendexInfos() -> String {
        return ""
    }
    
    // 实现参数获取
    public func getUploadInterface(car: TopdonLog.Car?, uploadType: LogUploadType) -> any TopdonLogLogUploadInterface {
        let model = FileUpload(lfuSn: getVciSN(),
                               lfuCarType: <#String#>,
                               lfuProblem: <#String#>,
                               lfuOtherDescription: getAppendexInfos(),
                               lfuLogGenerationTime: "",
                               lfuSubmitUserName: <#String#>,
                               lfuRemark: <#String#>,
                               lfuCarSoftCode: <#String#>,
                               lfuCarBrandName: <#String#>,
                               lfuCarModelPath: <#String#>,
                               lfuCarLanguageId: <#String#>,
                               lfuCarModelSourceVersion: <#String#>,
                               lfuMainCarVersion: <#String#>,
                               lfuLinkCarVersion: <#String#>,
                               lfuVin: <#String#>,
                               lfuPhoneBrandName: "Apple",
                               lfuPhoneModelName: <#String#>,
                               lfuPhoneSystemVersion: <#String#>,
                               lfuPhoneSystemLanguageId: <#String#>,
                               lfuFirmwareVersion: <#String#>,
                               lfuBootVersion: <#String#>,
                               lfuHardwareVersion: <#String#>,
                               lfuUploadType: <#String#>,
                               lfuLogType: <#String#>,
                               lfuAppVersion: <#String#>,
                               lfuPhoneSystemLanguageName: <#String#>)
        
        return model
    }
    
}

```
```swift
// 3. 实现上传代理 LogUploadManagerDelegate
extension AppDelegate: LogUploadManagerDelegate {
    
    public func upload(_ model: TopdonLog.LogUploadModel, completion: ((Bool) -> Void)?) {
        // 实现上传接口
    }
    
}
```

```swift
// 4. 进车、退车
import TopdonLog

@objc extension TDFileUpdateManagement {
    
    func startDiag(strVehicle: String, strType: String) {
      
      // 进车调用
        LogUploadManager.shared.diagStart(car: Car(brand: strVehicle, strType: strType))
    }
    
    //0 默认
    //1 上传app日志
    //2 上传车型日志
    //3 反馈上传日志
    //4 自动上传车型日志
    //5 autoVin失败静默feedback
    func stopDiag(strVehicle: String, strType: String, uploadType: UInt) {
        let uType: LogUploadType
        switch uploadType {
        case 0, 1:
            uType = .appLog
        case 2:
            uType = .diagCarLog
        case 3:
            uType = .feedbackLog
        case 4:
            uType = .diagCarLogAuto
        case 5:
            uType = .autoVinLog
        default:
            uType = .appLog
        }
        
      	// 退车调用
        LogUploadManager.shared.diagStop(car: Car(brand: strVehicle, strType: strType), uploadType: uType)
    }
    
}
```

```swift
// 5. 固件升级(依赖诊断库 TopdonDiagnosis 接口)
#import "TDD_StdCommModel.h"
// 开始固件升级:
// 1. 进车
LogUploadManager.shared.diagStart(car: Car.firmwareUpdater)
// 2. 调用诊断库往这里写日志 
[TDD_StdCommModel StartLogWithTypeName:@"DIAG" VehName:@"iOSFramework"];

// 结束估计升级:
// 1.退车
LogUploadManager.shared.diagStop(car: Car.firmwareUpdater), uploadType: .appLog)
// 2. App 调用诊断库停止写日志   
[TDD_StdCommModel StopLog];
```



## Author

xinwen.liu@lenkor.cn

## License

TopdonLog is available under the MIT license. See the LICENSE file for more info.
