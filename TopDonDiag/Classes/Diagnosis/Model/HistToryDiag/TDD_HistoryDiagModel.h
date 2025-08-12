//
//  TDHistToryDiagModel.h
//  AD200
//
//  Created by yong liu on 2023/9/20.
//

#import "TDD_JKDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_HistoryDtcNodeExModel : NSObject
@property (nonatomic, copy)NSString *nodeCode;// 故障代码，不能为空，例如："P0316:00-28"
@property (nonatomic, copy)NSString *nodeDescription;// 故障码描述
@property (nonatomic, copy)NSString *nodeStatus;// 故障码状态，字符串形式
@property (nonatomic, assign)long long status;// 故障码状态

@end

@interface TDD_HistoryDtcItemModel : NSObject
@property (nonatomic, copy)NSString *itemID;//系统ID
@property (nonatomic, copy)NSString *itemName;//系统Name
@property (nonatomic, strong)NSArray<TDD_HistoryDtcNodeExModel *> *vctNodeArr;// 故障码数组，包含了此系统下的所有故障码

@end

@interface TDD_HistoryDiagModel : TDD_JKDBModel

/// 用户topdonId
@property (nonatomic, copy) NSString *topdonId;

/// 语言
@property (nonatomic, copy) NSString *language;

///
@property (nonatomic, copy) NSString *historyRecordID;

/// 品牌
@property (nonatomic, copy) NSString *brandName;

/// 编辑后的品牌
@property (nonatomic, copy) NSString *editBrandName;

/// 车型
@property (nonatomic, copy) NSString *modelName;

/// 编辑后的车型
@property (nonatomic, copy) NSString *editModelName;

/// 年份
@property (nonatomic, copy) NSString *carYear;

/// 编辑后的年份
@property (nonatomic, copy) NSString *editCarYear;

/// 报告名称
@property (nonatomic, copy) NSString *reportName;

/// 车牌号
@property (nonatomic, copy) NSString *licensePlateNum;

/// 行驶里程
@property (nonatomic, copy) NSString *mileage;

/// 里程单位
@property (nonatomic, copy) NSString *mileageUnit;

/// 发动机
@property (nonatomic, copy) NSString *engine;

/// 发动机子型号
@property (nonatomic, copy) NSString *subEngine;

/// 诊断日期
@property (nonatomic, copy) NSString *time;

/// 诊断时间
@property (nonatomic, assign) NSTimeInterval timeStamp;

/// 车型软件版本号
@property (nonatomic, copy) NSString *softwareVersion;

/// 诊断应用软件版本
@property (nonatomic, copy) NSString *diagSoftwareVersion;

/// vin码
@property (nonatomic, copy) NSString *vin;

/// 诊断路径
@property (nonatomic, copy) NSString *diagPath;

/// 客户
@property (nonatomic, copy) NSString *customerName;

/// 客户电话
@property (nonatomic, copy) NSString *customerPhoneNum;

/// 系统数组（故障码）
@property (nonatomic, copy) NSString *systemArrayStr;

/// 备注
@property (nonatomic, copy) NSString *note;

/// 附件
@property (nonatomic, copy) NSString *fileArrayStr;


@property (nonatomic, copy) NSString *a4pdfPath;


/// TOPVCI 相关数据
/// 进车的SN
@property (nonatomic, copy) NSString *sn;


/// 车型名称
@property (nonatomic, copy) NSString *vehicleName;

/// 功能掩码
@property (nonatomic, assign) long entryType;

/// 入口类型
@property (nonatomic, assign) long diagShowType;

/// 二级入口类型
@property (nonatomic, assign) long diagShowSecondaryType;

/// 车型软件编码
@property (nonatomic, copy) NSString * softCode;

/// app 语言 Id
@property (nonatomic, assign) NSInteger appLanguageId;

/// 数据库位置（本地/群组）
@property (nonatomic, assign) NSInteger dbType;

- (NSString *)exchangeReportName;
@end

NS_ASSUME_NONNULL_END
