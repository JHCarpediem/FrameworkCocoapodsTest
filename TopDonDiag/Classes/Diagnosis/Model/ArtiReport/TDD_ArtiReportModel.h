//
//  TDD_ArtiReportModel.h
//  AD200
//
//  Created by 何可人 on 2022/5/6.
//

#import "TDD_ArtiModelBase.h"
#import "TDD_ArtiReportCellModel.h"
#import "TDD_ArtiLiveDataModel.h"

//#import "TopdonDiagnosis/TopdonDiagnosis-Swift.h"
@class TDD_ArtiADASReportResult;
@class TDD_ArtiADASReportTireUnit;
@class TDD_ArtiADASReportFuel;
@class TDD_ArtiADASTirePDFData;

//#import "BGFMDB.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TDD_ArtiReportType) {
    /// 系统诊断报告
    TDD_ArtiReportTypeSystem         = 1,
    /// 故障诊断报告
    TDD_ArtiReportTypeDTC            = 2,
    /// 数据流诊断报告
    TDD_ArtiReportTypeDataStream     = 3,
    
    /// adas系统诊断报告
    TDD_ArtiReportTypeAdasSystem     = 0x11,
    /// adas故障诊断报告
    TDD_ArtiReportTypeAdasDTC        = 0x12,
    ///  adas数据流诊断报告
    TDD_ArtiReportTypeAdasDataStream = 0x13,
    /// ADAS单系统诊断报告（进入系統内的报告）
    TDD_ArtiReportTypeAdasSingleSystem = 0x14,
};

@class TDD_ArtiLiveDataItemModel;

@interface TDD_ArtiReportModel : TDD_ArtiModelBase

// MARK: - 库自带属性

/// 报告标题: 诊断报告
@property (nonatomic, copy) NSString *report_title;
/// 小车探、CarPal. 0 无意义。 参考 eObdEntryType 枚举 。
/// 版本迁移，需要将之前数据库中的 reportType = 4 修改为 2 且 obdEntryType = 32 （OET_CARPAL_OBD_ENGINE_CHECK）
@property (nonatomic, assign) int obdEntryType; // 当前OBD诊断入口类型
/// 报告类型 1系统诊断报告 2故障诊断报告 3数据流诊断报告 4发动机检测报告
@property (nonatomic, assign) TDD_ArtiReportType reportType;
/// 报告类型标题: 系统报告状态(59)
@property (nonatomic, copy) NSString *report_type_title;
/// 描述标题: 2015-09奥迪
@property (nonatomic, copy) NSString *describe_title;
/// 概述标题: 概述:
@property (nonatomic, copy) NSString *system_overview_title;
/// 概述内容: 总共扫描出12个 ... 及时处理排查。
@property (nonatomic, copy) NSString *system_overview_content;
/// 行驶里程: 568KM
@property (nonatomic, copy) NSString *describe_mileage;
/// 车辆品牌: 宝马
@property (nonatomic, copy) NSString *describe_brand;
/// 车型: 320i
@property (nonatomic, copy) NSString *describe_model;
/// 年款: 2021
@property (nonatomic, copy) NSString *describe_year;
/// 发动机: F62-D526
@property (nonatomic, copy) NSString *describe_engine;
/// 子型号: N542
@property (nonatomic, copy) NSString *describe_engine_subType;
/// 诊断路径: 宝马>302>系统>自动扫描
@property (nonatomic, copy) NSString *describe_diagnosis_path;
/// VIN: 代码读出来的VIN
@property (nonatomic, copy) NSString *VIN;

// MARK: - 其它信息

/// 诊断时间: 2022-02-02 12:12:12
@property (nonatomic, copy) NSString *describe_diagnosis_time;
/// 诊断时区 : E+8
@property (nonatomic, copy) NSString *describe_diagnosis_time_zone;
/// 车型软件版本号:  V1.2.3.6.6
@property (nonatomic, copy) NSString *describe_version;
/// 诊断应用软件版本: V1.2.4.8.0
@property (nonatomic, copy) NSString *describe_software_version;
/// 车型模型
@property (nonatomic, strong) TDD_CarModel *carModel;
/// 报告名称 (xxx.pdf)
@property (nonatomic, copy) NSString *reportRecordName;

@property (nonatomic, copy) NSString *report_number;

// MARK: - 动态生成类

/// 显示数据
@property (nonatomic, strong) NSMutableArray<TDD_ArtiReportCellModel *> *cellModels;
/// 诊断数据
@property (nonatomic, strong) NSMutableArray<TDD_ArtiReportCellModel *> *repairCellModels;

// MARK: - 用户输入属性

/// 客户名字: 林先生
@property (nonatomic, copy) NSString *describe_customer_name;
/// VIN: 客户输入的VIN
@property (nonatomic, copy) NSString *inputVIN;
/// 车牌号: 粤DE505E
@property (nonatomic, copy) NSString *describe_license_plate_number;
/// 客户电话 : 15632545220
@property (nonatomic, copy) NSString *describe_customer_call;

/// 维修单号
@property (nonatomic, copy) NSString *repairOrderNum;
/// 维修前后 (1 维修前 2 维修后)
@property (nonatomic, assign) int repairIndex;
/// 是否有维修前后历史数据
@property (nonatomic, assign) BOOL hasRepairHistory;

// MARK: - ADAS

/// 是否是 ADAS 报告
- (BOOL) isAdasReport;
// MARK: - 编辑用数据
/// 留言
@property (nonatomic, copy) NSString *adas_msg;
/// 拍照或者选中的图片，用于保存到本地
@property (nonatomic, strong) NSArray<UIImage*> *adasImageDatas;
@property (nonatomic, strong) NSMutableArray <NSString *> *adas_image_paths;
/// 胎压
@property (nonatomic, strong) TDD_ArtiADASReportTireUnit *tirePressure;
/// 轮眉
@property (nonatomic, strong) TDD_ArtiADASReportTireUnit *wheelEyebrow;
// 燃油表
@property (nonatomic, strong) TDD_ArtiADASReportFuel *fuel;
/// 拍照或者选中的燃油图片，用于保存到本地
@property (nonatomic, strong, nullable) UIImage *fuelImage;
-(BOOL) hasFuel;

// MARK: - 预览用数据
@property (nonatomic, strong) NSMutableArray <TDD_ArtiADASReportResult* > *adas_result;
@property (nonatomic, strong, nullable) TDD_ArtiADASTirePDFData *adas_tirePressureData;
@property (nonatomic, strong, nullable) TDD_ArtiADASTirePDFData *adas_wheelEyebrowData;
@property (nonatomic, strong, nullable) TDD_ArtiADASReportFuel * adasHisotryFuel;

@property (nonatomic, copy) NSString *adasPreScanTime;
@property (nonatomic, copy) NSString *adasPostScanTime;
@property (nonatomic, copy) NSString *adasSingleSysName;

// MARK: - Operation Images
/// 4张图片
+ (void)saveAdasImages: (NSArray<UIImage *> * _Nullable)imageDatas dbType:(TDD_DBType)dbType withCreateTime: (NSTimeInterval)createTime withBlock:(void (^)(void))completionBlock;
+ (void)removeAdasImages:(NSTimeInterval)createTime dbType:(TDD_DBType)dbType;
+ (NSArray <NSString *> * _Nullable )fetchAdasImagePathsWithCreateTime:(NSTimeInterval)createTime dbType:(TDD_DBType)dbType;
// 燃油1张图片
+ (void)saveAdasFuelImage: (UIImage * _Nullable)imageData withCreateTime: (NSTimeInterval)createTime withBlock:(void (^)(void))completionBlock;
+ (void)removeFuelImage:(NSTimeInterval)createTime;
+ (NSString * _Nullable) fetchAdasFuelImagePathWithCreateTime: (NSTimeInterval)createTime;

// MARK: - 其它

/// 更新选择前后数据
-(void)updateRepairHistory;
/// 点击生成报告
@property (nonatomic, copy) void(^generatorTapBlock)(void);
/// 保存的 PDF 路径
@property (nonatomic, copy) NSString *pdfPath;
/// 保存的 A4 PDF 路径
@property (nonatomic, copy) NSString *a4pdfPath;
/// 获取用来可以生成 JSON 的字典
- (NSDictionary *)jsonDictionary;
/// 故障码信息 JSON
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *codesItems;
/// 报告URL
@property (nonatomic, copy) NSString * reportUrl;

@property (nonatomic, assign) NSTimeInterval reportCreateTime;

/// 是否保存了报告
@property (nonatomic, assign) BOOL isSaveReport;

// MARK: - TOPVCI 力洋数据
@property (nonatomic, copy) NSDictionary *carExtraInfo;

/// 更新页面
-(void)reloadView;

//@property (nonatomic, strong) NSString * key;

- (NSString *)generatPdfFileName: (NSInteger)repairIndex;

+ (TDD_ArtiReportCellModel *)reportCellModelWithItem:(TDD_ArtiLiveDataItemModel *)itemModel;

@end

NS_ASSUME_NONNULL_END
