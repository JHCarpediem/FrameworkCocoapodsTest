//
//  TDD_VCIInitializeModel.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/7/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///VCI初始化状态
typedef enum
{
    VCI_INIT_DEFAULT    = 1,        //未初始化
    VCI_INIT_ING        = 2,        //初始化中
    VCI_INIT_SUCCESS    = 3,        //初始成功
    VCI_INIT_FAIL                   //初始化失败

}eVCIInitializeStatus;

///Wi-Fi初始化状态
typedef enum
{
    WIFI_INIT_DEFAULT    = 1,        //未初始化
    WIFI_INIT_ING        = 2,        //初始化中
    WIFI_INIT_SUCCESS    = 3,        //初始成功
    WIFI_INIT_FAIL                   //初始化失败

}eWIFIInitializeStatus;

///VCI初始化Error 类型(可包含多个)
typedef enum
{
    ///vciSN获取失败
    VCI_VALUE_ERROR_VCI_SN          = 1,
    ///VCI型号获取失败
    VCI_VALUE_ERROR_DEVCIE_TYPE     = 2,
    ///VCI版本获取失败
    VCI_VALUE_ERROR_FW_VERSION      = 4,
    ///蓝牙版本获取失败
    VCI_VALUE_ERROR_BT_VERSION      = 8,
}eVCIValueErrorType;

///WIFI初始化Error 类型(可包含多个)
typedef enum
{
    ///WIFI 未启动
    WIFI_VALUE_UN_READY          = 1,
    ///WIFI MT7628系统版本号获取失败
    WIFI_VALUE_ERROR_OS_VERSION     = 2,
    ///WIFI MT7628APP 版本号获取失败
    WIFI_VALUE_ERROR_APP_VERSION      = 4,
    ///获取MT7628的设备类型
    WIFI_VALUE_ERROR_DEVICE_TYPE      = 8,
    
}eWIFIValueErrorType;

@interface TDD_VCIInitializeModel : NSObject
///VCISN
@property (nonatomic, readonly) NSString *vciSN;
///VCI型号
@property (nonatomic, readonly) NSInteger deviceType;
///VCI版本
@property (nonatomic, readonly) NSString *fwVersion;
///蓝牙版本
@property (nonatomic, readonly) NSString *btVersion;
///引脚电压数组(除开 4-5)
@property (nonatomic, readonly) NSMutableDictionary *voltaDict;
///是否支持MT7628
@property (nonatomic, readonly) BOOL isSupportMT7628;
///初始化状态
@property (nonatomic, readonly) eVCIInitializeStatus initStatus;
@property (nonatomic, readonly) NSInteger failIndex;
///Wi-Fi 相关
///MT7628是否已启动
@property (nonatomic, readonly) BOOL mt7628IsReady;
///MT7628系统版本号
@property (nonatomic, readonly) NSString *mt7628OsVersion;
///MT7628App/库版本号
@property (nonatomic, readonly) NSString *mt7628AppVersion;
///获取MT7628的设备类型
@property (nonatomic, readonly) NSInteger mt7628DeviceType;
///初始化状态
@property (nonatomic, readonly) eWIFIInitializeStatus wifiInitStatus;
@property (nonatomic, readonly) NSInteger wifiFailIndex;
#pragma mark - 上层 app不要使用下面的方法
//重置
- (void)reset;

// sdtCommModel 部分方法会阻塞线程
- (void)getMessage;
@end

NS_ASSUME_NONNULL_END
