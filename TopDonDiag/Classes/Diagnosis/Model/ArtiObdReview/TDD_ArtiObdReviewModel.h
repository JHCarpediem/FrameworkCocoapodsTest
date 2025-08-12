//
//  TDD_ArtiObdReviewModel.h
//  TopDonDiag
//
//  Created by fench on 2023/9/5.
//

#import <Foundation/Foundation.h>
#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@class TDD_ArtiTroubleItemModel, TDD_ArtiLiveDataItemModel;

typedef enum {
    RESULT_TYPE_PASS   = 1,         /* 检测合格 */
    RESULT_TYPE_FAILED = 2,         /* 检测不合格 */
    
    RESULT_TYPE_INVALID = 0xFF
} TDD_OBDResultType;

typedef enum {
    READINESS_TYPE_OK       = 1,         /* 就绪 */
    READINESS_TYPE_FAILED   = 2,         /* 未就绪 */
    READINESS_TYPE_NOT_SUPOORT  = 3,         /* 不支持 */
    READINESS_TYPE_FAILED_EX    = 4,         /* 需要判断的，未就绪 */
    READINESS_TYPE_INVALID = 0xFF
} TDD_OBDReadinessType;

@interface TDD_ArtiObdReviewItemModel: NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *strStatus;
@property (nonatomic, assign) uint32_t status;
@end

@interface TDD_ArtiObdReviewEcuItemModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray<NSString *> *calidItems;
@property (nonatomic, strong) NSMutableArray<NSString *> *cvnItems;

@end

@interface TDD_ArtiObdReviewMainTypeDataModel : NSObject
/// 发动机名字
@property (nonatomic, copy) NSString *name;
/// 数据流列表项
@property (nonatomic, strong) NSMutableArray<TDD_ArtiLiveDataItemModel *> *liveDataItems;
/// 车载排放诊断系统实际监测频率 (IUPR状态)
@property (nonatomic, strong) NSMutableArray<TDD_ArtiObdReviewItemModel *> *iuprItems;

/// 诊断就绪状态未完成项目
@property (nonatomic, strong) NSMutableArray<TDD_ArtiObdReviewItemModel *> *readinessItems;

@end



@interface TDD_ArtiObdReviewModel : TDD_ArtiModelBase

/// 年检预审报告显示控件，同时设置标题文本
@property (nonatomic, copy) NSString *title;
/// 发动机机信息，例如，"F62-D52"
@property (nonatomic, copy) NSString *engineInfo;
/// 发动机子型号或者其它信息，例如，"N542"
@property (nonatomic, copy) NSString *engineSubType;
/// 年检预审的检测结果类型
@property (nonatomic, assign) TDD_OBDResultType checkResult;
/// 年检预审的复检结果类型
@property (nonatomic, assign) TDD_OBDResultType reCheckResult;

@property (nonatomic, assign) TDD_OBDReadinessType readinessType;
/// OBD的通信协议类型
@property (nonatomic, copy) NSString *strProtocol;
/// 与OBD诊断仪通讯情况 YES:  通信成功
@property (nonatomic, assign) BOOL bCommOk;
/// 是否需要复检
@property (nonatomic, assign) BOOL isNeedRecheck;
/// 如果需要复检，复检内容
@property (nonatomic, copy) NSString *strRecheck;
/// OBD系统故障指示器状态 YES: OBD系统故障指示器点亮
@property (nonatomic, assign) BOOL bMILStatus;
/// “OBD故障指示器”结果类型
@property (nonatomic, assign) TDD_OBDResultType obdStatus;
/// 故障灯亮后的行驶里程，单位为KM
@property (nonatomic, copy) NSString *strMilOnMileage;

/// 车辆控制单元的CALID（如果适用）和CVN信息（如果适用）
@property (nonatomic, strong) NSMutableArray<TDD_ArtiObdReviewEcuItemModel *> *ecuItems;
/// 故障码列表项
@property (nonatomic, strong) NSMutableArray<TDD_ArtiTroubleItemModel *> *dtcItems;

@property (nonatomic, strong) NSMutableArray<TDD_ArtiObdReviewMainTypeDataModel *> *mainTypeItems;
@end

NS_ASSUME_NONNULL_END
