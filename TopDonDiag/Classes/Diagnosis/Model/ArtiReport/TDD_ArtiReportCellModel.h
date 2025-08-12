//
//  TDD_ArtiReportCellModel.h
//  AD200
//
//  Created by lecason on 2022/8/3.
//

#import <Foundation/Foundation.h>
//#import "TopdonDiagnosis/TopdonDiagnosis-Swift.h"
@class TDD_ArtiADASReportResult;
@class TDD_ArtiADASTirePDFData;
@class TDD_ArtiADASReportFuel;
@class TDD_ArtiReportInfo;

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportCellModel : NSObject

// MARK: 通用

/// 标识
@property (nonatomic, copy) NSString *identifier;
/// 标题
@property (nonatomic, copy) NSString *headerTitle;
/// 子标题
@property (nonatomic, copy) NSString *subTitle;
/// 行高
@property (nonatomic, assign) CGFloat cellHeight;
/// 打印A4纸行高
@property (nonatomic, assign) CGFloat cellA4Height;
/// 左边宽度
@property (nonatomic, assign) CGFloat leftWidth;
/// 右边宽度
@property (nonatomic, assign) CGFloat rightWidth;
/// 子标题
@property (nonatomic, copy) NSString *leftTitle;
/// 子标题
@property (nonatomic, copy) NSString *rightTitle;

@property (nonatomic, assign) NSTextAlignment textAlignment;

// MARK: 诊断报告

/// 系统ID
@property (nonatomic, copy) NSString *system_id;
/// 左错误码个数
@property (nonatomic, assign) uint32_t leftUDtsNums;
/// 左错误码标题
@property (nonatomic, copy) NSString *leftUDtsName;
/// 右错误码个数
@property (nonatomic, assign) uint32_t rightUDtsNums;
/// 右错误码标题
@property (nonatomic, copy) NSString *rightUDtsName;

// MARK: 故障码

/// 当前故障码Current  历史故障码History 待定故障码Pending  临时故障码Temporary 未知故障码 N/A
@property (nonatomic, assign) uint32_t dtcNodeStatus;

@property (nonatomic, copy) NSString * dtcNodeStatusStr;

// MARK: 数据流

@property (nonatomic, strong) NSArray *liveDatas;

// MARK: 一些特定信息
/// 报告标题: 诊断报告
@property (nonatomic, copy) NSString *report_title;

/// 设置报告类型时候，设置 obdEntryType 类型
/// 报告类型 1系统诊断报告 2故障诊断报告 3数据流诊断报告
@property (nonatomic, assign) int reportType;
/// 小车探、CarPal. 0 无意义。 参考 eObdEntryType 枚举 。
/// 版本迁移，需要将之前数据库中的 reportType = 4 修改为 2 且 obdEntryType = 32 （OET_CARPAL_OBD_ENGINE_CHECK）
@property (nonatomic, assign) int obdEntryType; // 当前OBD诊断入口类型

/// 启动数据库迁移字段
@property (nonatomic, assign) int reportTypeUpdateFlag;

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

/// 诊断编号
@property (nonatomic, assign) uint32_t report_number;

/// A4 显示用 Info
- (NSMutableArray <TDD_ArtiReportInfo *> *)infos;

/// 历史诊断报告信息
- (NSArray<TDD_ArtiReportInfo *> *)historyDiagReportInfos;

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
/// 维修单号
@property (nonatomic, copy) NSString *repairOrderNum;

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
/// 维修前后 (0 维修前 1 维修后)
@property (nonatomic, assign) int repairIndex;
/// 是否有维修前后历史数据
@property (nonatomic, assign) BOOL hasRepairHistory;

// MARK: - 自定义的数据
@property (nonatomic, copy) NSString *cell_header_title; // 混合了strSysId和strSysName的显示文字

@property (nonatomic, copy) NSString * cellName;

@property (nonatomic, assign) UIKeyboardType keyboardType;

/// 附件数组（字符串分割用英文逗号分割）
@property (nonatomic, copy) NSString *fileArrayStr;

// MARK: - ADAS

@property (nonatomic, copy) NSString *adasMessage;
@property (nonatomic, copy) NSArray <UIImage *> *adasImages;
@property (nonatomic, strong) TDD_ArtiADASReportResult *adasResult;
@property (nonatomic, strong) TDD_ArtiADASTirePDFData *adasTireData;
@property (nonatomic, strong) TDD_ArtiADASReportFuel *adasFuel;

@property (nonatomic, copy) NSString *adasPreScanTime;
@property (nonatomic, copy) NSString *adasPostScanTime;

@end

NS_ASSUME_NONNULL_END
