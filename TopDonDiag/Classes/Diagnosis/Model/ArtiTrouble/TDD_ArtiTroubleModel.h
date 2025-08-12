//
//  TDD_ArtiTroubleModel.h
//  AD200
//
//  Created by 何可人 on 2022/5/9.
//

#import "TDD_ArtiModelBase.h"
#import "TDD_ArtiTroubleRepairInfoModle.h"
NS_ASSUME_NONNULL_BEGIN
@class TDD_ArtiTroubleModel;
@interface TDD_ArtiTroubleItemModel : NSObject
@property (nonatomic, strong) NSString * strTroubleCode;//故障码号
@property (nonatomic, strong) NSString * strTroubleDesc;//故障码描述(定义)
@property (nonatomic, strong) NSString * strTroubleStatus;//故障码状态
@property (nonatomic, assign) uint32_t uStatus; 
@property (nonatomic, strong) NSString * strTroubleHelp;//故障码帮助信息
@property (nonatomic, assign) BOOL isShowMILStatus;//是否显示故障灯
@property (nonatomic, assign) BOOL isShowFreezeStatus;//是否显示冻结帧标志
@property (nonatomic, assign) BOOL isShowHelpButton;//是否显示帮助按钮
@property (nonatomic, assign) BOOL isShowMore;//是否完全显示描述文本

@property (nonatomic, strong) NSString * strTranslatedTroubleDesc;//故障码描述 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, strong) NSString * strTranslatedTroubleStatus;//故障码状态 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, strong) NSString * strTranslatedTroubleHelp;//故障码帮助信息 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, assign) BOOL isStrTroubleDescTranslated; //故障码描述是否已翻译
@property (nonatomic, assign) BOOL isStrTroubleStatusTranslated; //故障码状态是否已翻译
@property (nonatomic, assign) BOOL isStrTroubleHelpTranslated; //故障码帮助信息是否已翻译
@end

@protocol TDD_ArtiTroubleModelDelegata <NSObject>

/**********************************************************
*    功  能：设置维修指南所需要的信息
**********************************************************/
- (void)ArtiTroubleSetRepairManualInfo:(TDD_ArtiTroubleRepairInfoModle *)model;

- (void)ArtiTroubleToTroubleDetail:(NSArray<NSDictionary *> *)results;

/**********************************************************
*    功  能：跳转 AI
**********************************************************/
- (void)ArtiTroubleGotoAI:(TDD_ArtiTroubleModel *)model itemIndex:(NSInteger )itemIndex;
@end

@interface TDD_ArtiTroubleModel : TDD_ArtiModelBase

@property (nonatomic, strong) NSMutableArray<TDD_ArtiTroubleItemModel *> * itemArr;

@property (nonatomic, weak) __nullable id<TDD_ArtiTroubleModelDelegata> delegate;

@property (nonatomic, assign) BOOL iSCdtcButtonVisible; //清码按钮是否显示

@property (nonatomic, strong) TDD_ArtiTroubleRepairInfoModle * repairInfoModle; //故障码维修指引数据Model
@property (nonatomic, assign) NSInteger  repairInfoIndex; //需要获取维修指引的 itemIndex

/**********************************************************
*    功  能：添加故障码
*    参  数：strTroubleCode 故障码号
*            strTroubleDesc 故障码描述
*            strTroubleState 故障码状态
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strTroubleCode:(NSString *)strTroubleCode strTroubleDesc:(NSString *)strTroubleDesc strTroubleStatus:(NSString *)strTroubleStatus strTroubleHelp:(NSString *)strTroubleHelp;

/**********************************************************
*    功  能：设置指定故障码的帮助信息
*    参  数：uIndex 指定的故障码
*            strToubleHelp 故障码帮助信息
*    返回值：无
**********************************************************/
+ (void)SetItemHelpWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strToubleHelp:(NSString *)strToubleHelp;

/**********************************************************
*    功  能：设置指定故障码后边故障灯的状态
*    参  数：uIndex 指定的故障码
*            bIsShow=true 显示一个点亮的故障灯
*            bIsShow=false 不显示故障灯
*    返回值：无
**********************************************************/
+ (void)SetMILStatusWithId:(uint32_t)ID uIndex:(uint32_t)uIndex bIsShow:(BOOL)bIsShow;

/**********************************************************
*    功  能：设置指定故障码后边冻结帧标志的状态
*    参  数：uIndex 指定的故障码
*            bIsShow=true 显示冻结帧标志
*            bIsShow=false 不显示冻结帧标志
*    返回值：无
**********************************************************/
+ (void)SetFreezeStatusWithId:(uint32_t)ID uIndex:(uint32_t)uIndex bIsShow:(BOOL)bIsShow;

/**********************************************************
*    功  能：设置清码按钮是否显示
*    参  数：bIsVisible=true  显示清码按钮
*            bIsVisible=false 隐藏清码按钮
*    返回值：无
**********************************************************/
+ (void)SetCdtcButtonVisibleWithId:(uint32_t)ID bIsShow:(BOOL)bIsShow;

/*********************************************************************************
*    功  能：设置维修指南所需要的信息
*
*    参  数：vctDtcInfo    维修资料所需信息数组
*
*             stRepairInfoItem类型的元素
*             eRepairInfoType eType            维修资料所需信息的类型
*                                            例如 RIT_DTC_CODE，表示是 "故障码编码"
*            std::string     strValue        实际的字符串值
*                                           例如当 eType = RIT_VIN时
*                                           strValue为 "KMHSH81DX9U478798"
*
*    返回值：设置失败
*            例如当数组元素为空时，返回false
*            例如当数组中不包含"故障码编码"，返回false
*********************************************************************************/
//+ (BOOL)SetRepairManualInfoWithId:(uint32_t)ID vctDtcInfo:(const std::vector<stRepairInfoItem>)vctDtcInfo;
@end
NS_ASSUME_NONNULL_END
