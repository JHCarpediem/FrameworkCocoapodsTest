//
//  TDD_ArtiVehAutoAuthModel.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/8/12.
//

#import <TopdonDiagnosis/TopdonDiagnosis.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum
{   // 表示是哪个车品牌
    BT_VEHICLE_TOPDON     = 0,     // 表示当前是公司算法服务器调用

    BT_VEHICLE_FCA        = 1,     // 表示当前的品牌是FCA
    BT_VEHICLE_RENAULT    = 2,     // 表示当前的品牌是雷诺
    BT_VEHICLE_NISSAN     = 3,     // 表示当前的品牌是日产
    BT_VEHICLE_MITSUBISHI = 4,     // 表示当前的品牌是三菱
    BT_VEHICLE_VW_SFD     = 5,            // 表示当前的品牌是大众

    BT_VEHICLE_DEMO       = 0xFFFFFFF0,   // 表示当前的品牌是DEMO的（演示使用）

    BT_VEHICLE_INVALID   = 0xFFFFFFFF,
}eBrandType;

// 指定哪个服务接口类型，适用于 SendRecv 接口
typedef enum
{   // 服务请求接口的类型
    SRT_FCA_DIAG_INIT  = 1,     // 表示当前请求的是FCA的Init接口，即 FcaAuthDiagInit
                                // FCA服务器认证请求（Authentication初始化）

    SRT_FCA_DIAG_REQ   = 2,     // 表示当前请求的是FCA的Request接口，即 FcaAuthDiagRequest
                                // 向FCA服务器转发SGW的 Challenge 随机码

    SRT_FCA_DIAG_TRACK = 3,     // 表示当前请求的是FCA的TrackResp接口，结果追踪，即 FcaAuthDiagTrackResp
                                // 向FCA服务器转发 SGW解锁的 TrackResponse 结果追踪（可理解为欧洲FCA的SGW解锁埋点）

    SRT_RENAULT_DIAG_REQ = 4,   // 表示当前请求的是雷诺的网关算法请求接口
                                // 向雷诺网关算法服务器转发 网关算法请求数据
    
    SRT_NISSAN_DIAG_REQ  = 5,   // 表示当前请求的是日产的网关算法请求接口
                                // 向日产网关算法服务器转发 网关算法请求数据
    
    SRT_VW_DIAG_REQ      = 6,   // 表示当前请求的是大众的网关算法请求接口
    
    SRT_VW_SFD_REPORT    = 0x80,    // 表示当前请求的是公司产品数据中心的网关解锁数据上报接口
                                    // /api/v1/baseinfo/carData/unlockReport

    // 向雷诺网关算法服务器转发 网关算法请求数据

    SRT_INVALID_TYPE = 0xFFFFFFFF,
}eSendRecvType;


@interface TDD_ArtiVehAutoAuthModel : TDD_ArtiModelBase
@property (nonatomic, assign)eBrandType brandType;
@property (nonatomic, copy)NSString *strBrand;
@property (nonatomic, copy)NSString *strModel;
@property (nonatomic, copy)NSString *strSysName;
@property (nonatomic, copy)NSString *strChallenge;//EcuTocken
@property (nonatomic, copy)NSString *vin;
@property (nonatomic, copy)NSString *strType;//ecuUnlockType
@property (nonatomic, copy)NSString *strData;//ecuPublicServiceData
@property (nonatomic, copy)NSString *strSeed;//ecuChallenge
@property (nonatomic, copy)NSString *strCanID;//ecuCANID
@property (nonatomic, copy)NSString *strPolicy;//routingPolicy
@property (nonatomic, copy)NSString *respondCode;
@property (nonatomic, copy)NSString *respondMsg;
@property (nonatomic, copy)NSString *sgwChallengeResponse;
@end

NS_ASSUME_NONNULL_END
