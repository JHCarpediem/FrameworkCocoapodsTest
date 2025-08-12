//
//  TDD_ArtiLiveDataModel.h
//  AD200
//
//  Created by 何可人 on 2022/5/30.
//

#import "TDD_ArtiModelBase.h"
#import "TDD_ArtiLiveDataRecordeModel.h"
#import "TDD_UnitConversion.h"
@class TDD_HChartModel;

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveDataItemModel : NSObject
@property (nonatomic, assign) uint32_t index; //下标
@property (nonatomic, strong) NSString * strName; //数据流名称
@property (nonatomic, strong) NSString * strValue; //数据流值
@property (nonatomic, strong) NSString * strUnit; //数据流单位
@property (nonatomic, strong) NSString * strChangeValue; //数据流公英制转换后的值
@property (nonatomic, strong) NSString * strChangeUnit; //数据流公英制转换后的单位
@property (nonatomic, strong) NSString * strChangeMin; //数据流公英制转换后的最小参考值
@property (nonatomic, strong) NSString * strChangeMax; //数据流公英制转换后的最大参考值
@property (nonatomic, strong) NSString * strMin; //数据流最小参考值  - 在下
@property (nonatomic, strong) NSString * strMax; //数据流最大参考值 - 在下
@property (nonatomic, strong) NSString * strReference; //数据流枚举型的参考值 - 在上
@property (nonatomic, strong) NSString * strHelpText; //帮助文本
@property (nonatomic, assign) int UIType; //0、文本 1、折线图 2、饼状图
@property (nonatomic, strong) NSString * setStrMin; //用户设置的数据流最小参考值  - 在下
@property (nonatomic, strong) NSString * setStrMax; //用户设置的数据流最大参考值 - 在下
@property (nonatomic, strong) NSMutableArray<TDD_HChartModel *> * valueArr; //图表数据数组
@property (nonatomic, strong) NSMutableArray<NSString *> * valueStrArr; //非数字数据，使用数组存储
@property (nonatomic, assign) NSTimeInterval startTime; // 开始日期
@property (nonatomic, assign) double chartTime;
@property (nonatomic, assign) BOOL setHasChange; // 设置是否发生变化
@property (nonatomic, assign) BOOL isPlay; // 是否播放数据流
//公英制单位
@property (nonatomic, assign) TDD_UnitConversionType originalUnitConversionType;//item修改前的单位
@property (nonatomic, assign) TDD_UnitConversionType unitConversionType;//item 单独修改的单位
@property (nonatomic, strong) NSString * strMetricUnit; //数据流单位
@property (nonatomic, strong) NSString * strImperialUnit; //数据流单位
@property (nonatomic, strong) NSString * strMetricMin; //公里制最小参考值
@property (nonatomic, strong) NSString * strMetricMax; //公里制最大参考值
@property (nonatomic, strong) NSString * strImperialMin; //英里制最小参考值
@property (nonatomic, strong) NSString * strImperialMax; //英里制最大参考值

/// 是否录制临时数据
@property (nonatomic, assign) BOOL isTempe;
@property (nonatomic, strong) NSMutableDictionary *recordChangeDict;
@end

@protocol TDD_ArtiLiveDataModelDelegata <NSObject>

/**********************************************************
*    功  能：获取当前显示屏的更新项的下标集合
*    参  数：无
*    返回值：更新项的下标集合
**********************************************************/
- (NSArray *)GetUpdateItems;

/**********************************************************
*    功  能：获取当前搜索项的下标集合
*    参  数：无
*    返回值：搜索的下标集合
**********************************************************/
- (NSArray *)GetSearchItems;

/**********************************************************
*    功  能：获取选中的数据流行号下标集合
*
*    参  数：无
*
*    返回值：选中的数据流行号下标集合
*            如果大小为0，表示没有选中任何一项
**********************************************************/
- (NSArray *)GetSelectedItems;

/***********************************************************************************
*    功  能：获取被用户修改参考值后的数据流下标集合
*
*            如果用户没有修改过，返回数组为空
*
*    参  数：无
*
*    返回值：被用户修改参考值后的数据流下标集合
*            如果用户没有修改过，返回数组为空
*************************************************************************************/
- (NSArray *)GetModifyLimitItems;

/***********************************************************************************
*    功  能：获取在数据流报告上需要展示的数据流下标集合
*
*            注意GetReportItems和GetSelectedItems、GetSearchItems是有区别的
*            实际返回的集合场景，根据不同产品APP可能存在差异
*
*    参  数：无
*
*    返回值：需要在报告中展示的数据流下标集合
*************************************************************************************/
- (NSArray *)GetReportItems;

/**********************************************************
*    功  能：获取某条数据流是否需要更新
*    参  数：无
*    返回值：true 需要更新，false 不需要更新
**********************************************************/
- (BOOL)GetItemIsUpdateWithUIndex:(uint32_t)uIndex;

@end

@interface TDD_ArtiLiveDataModel : TDD_ArtiModelBase

@property (nonatomic, strong) NSMutableArray<TDD_ArtiLiveDataItemModel *> * itemArr;
@property (nonatomic, assign) BOOL isShowNextButton; //是否显示Next按钮
@property (nonatomic, strong) NSString * NextButtonText; //Next按钮文本
@property (nonatomic, assign) BOOL isShowPrevButton; //是否显示Prev按钮
@property (nonatomic, strong) NSString * PrevButtonText; //Prev按钮文本
@property (nonatomic, assign) __nullable id<TDD_ArtiLiveDataModelDelegata> delegate;
@property (nonatomic, strong) NSMutableArray<TDD_ArtiLiveDataItemModel *> * selectItmes; //选中的item
@property (nonatomic, strong) NSMutableArray<TDD_ArtiLiveDataItemModel *> * recordSelectItmes; // 编辑记录选中的item
@property (nonatomic, strong) NSMutableArray<TDD_ArtiLiveDataItemModel *> * chartItmes; //图表的item
@property (nonatomic, assign) int32_t widthName; //"名称"   列宽占比
@property (nonatomic, assign) int32_t widthValue; //"值"     列宽占比
@property (nonatomic, assign) int32_t widthUnit; //"单位"   列宽占比
@property (nonatomic, assign) int32_t widthRef; //"参考值" 列宽占比
@property (nonatomic, assign) NSTimeInterval startTime; // 开始日期
/// 是否处于录制状态
@property (nonatomic, assign) BOOL isRecording;

//TODO: 数据流搜索 新增用户搜索的数据items
// 搜索items
@property (nonatomic, strong) NSMutableArray<TDD_ArtiLiveDataItemModel *> * _Nullable  searchItems;

/// 页面展示的items 如果是在搜索页面 使用searchItems 如果不在搜索页面 展示selectItems
@property (nonatomic, strong, readonly) NSMutableArray<TDD_ArtiLiveDataItemModel *> * showItems;

// 搜索后更新数据流显示数据，底部按钮显示
- (void)updateLiveDataModel;

/// TopVCI
/// 部件测试类型
@property (nonatomic, assign) uint32_t uType;
/// 部件测试结果值
@property (nonatomic, assign) uint32_t uResult;

/// record 过程中修改过的 model 的属性的 keyValue
@property (nonatomic, strong) NSMutableDictionary *recordChangeDict;
/// record 过程中修改过的 model  的 itemModel 数据
@property (nonatomic, strong) NSMutableDictionary *recordChangeItemDict;
//非阻塞

#pragma mark 设置部件测试类型
/*******************************************************************
*    功  能：设置部件测试类型，此接口只针对小车探（国内版TOPVCI）
*
*    参  数：uType 部件测试类型
*
*            DF_TYPE_THROTTLE_CARBON      节气门积碳检测
*            DF_TYPE_FULE_CORRECTION      燃油修正控制系统检测
*            DF_TYPE_MAF_TEST             空气流量传感器检测
*            DF_TYPE_INTAKE_PRESSURE      进气压力传感器检测
*            DF_TYPE_OXYGEN_SENSOR        氧传感器检测
*
*    返回值：无
*******************************************************************/
+ (void) SetComponentType:(uint32_t)ID uType:(uint32_t)uType;

/*******************************************************************
*    功  能：设置部件测试结果值，此接口只针对小车探（国内版TOPVCI）
*
*    参  数：uResult 结果类型
*
*    当部件测试类型为 DF_TYPE_THROTTLE_CARBON 节气门积碳检测
*    uResult的值可为：
*        DF_RESULT_THROTTLE_NORMAL        1  发动机节气门运作正常
*        DF_RESULT_THROTTLE_LIGHT_CARBON  2  节气门疑似有轻微积碳
*        DF_RESULT_THROTTLE_SERIOUSLY     3  节气门积碳严重
*
*    当部件测试类型为 DF_TYPE_FULE_CORRECTION 燃油修正控制系统检测
*    uResult的值可为：
*        DF_RESULT_FULE_NORMAL      1 燃油修正正常
*        DF_RESULT_FULE_HIGH        2 燃油修正偏浓
*        DF_RESULT_FULE_LOW         3 燃油修正偏稀
*        DF_RESULT_FULE_ABNORMAL    4 燃油修正异常
*
*    当部件测试类型为 DF_TYPE_MAF_TEST 空气流量传感器检测
*    uResult的值可为：
*        DF_RESULT_MAF_NORMAL   1  进气量正常
*        DF_RESULT_MAF_HIGH     2  进气量偏大
*        DF_RESULT_MAF_LOW      3  进气量偏小
*
*    当部件测试类型为 DF_TYPE_INTAKE_PRESSURE 进气压力传感器检测
*    uResult的值可为：
*        DF_RESULT_INTAKE_PRESSURE_NORMAL  1  进气压力正常
*        DF_RESULT_INTAKE_PRESSURE_HIGH    2  进气压力偏高
*
*    当部件测试类型为 DF_TYPE_OXYGEN_SENSOR 氧传感器检测
*    uResult的值可为：
*         DF_RESULT_OXYGEN_NORMAL  1  氧传感器正常
*         DF_RESULT_OXYGEN_ERROR   2  氧传感器出现故障
*
*
*    返回值：无
**********************************************************/
+ (void)SetComponentResult:(uint32_t)ID uResult:(uint32_t)uResult;


/**********************************************************
*    功  能：添加数据流项
*    参  数：strName 数据流名称
*            strValue 数据流值
*            strUnit 数据流单位
*            strMin 数据流最小参考值  - 在下
*            strMax 数据流最大参考值 - 在下
*            strReference 数据流枚举型的参考值 - 在上
*    返回值：无
*     说明：  如果某一列全是空，就隐藏该列
*     通常情况下，4列，名称-值-单位-参考值
*    范围由最小参考值和最大参考值构成
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strName:(NSString *)strName strValue:(NSString *)strValue strUnit:(NSString *)strUnit strMin:(NSString *)strMin strMax:(NSString *)strMax strReference:(NSString *)strReference;

/**********************************************************
*    功  能：设置Next按钮是否显示，控件默认不显示（Benz车系需求，默认文本Next）
*    参  数：bIsVisible = true  显示Next按钮
*            bIsVisible = false 隐藏Next按钮
*    返回值：无
*
*     说明： 此按钮返回值 DF_ID_LIVEDATA_NEXT 在Show中返回
**********************************************************/
+ (void)SetNextButtonVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible;

/**********************************************************
*    功  能：修改Next按钮的文本
*    参  数：strButtonText  修改按钮显示的文本
*    返回值：无
**********************************************************/
+ (void)SetNextButtonTextWithId:(uint32_t)ID strButtonText:(NSString *)strButtonText;

/**********************************************************
*    功  能：设置Prev按钮是否显示，控件默认不显示
*           （大众通道数据流需求，默认文本Next）
*
*    参  数：bIsVisible = true  显示Prev按钮
*            bIsVisible = false 隐藏Prev按钮
*
*    返回值：无
*
*     说明： 此按钮返回值 DF_ID_LIVEDATA_PREV 在Show中返回
**********************************************************/
+ (void)SetPrevButtonVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible;

/**********************************************************
*    功  能：修改Prev按钮的文本
*
*    参  数：strButtonText  修改按钮显示的文本
*
*    返回值：无
**********************************************************/
+ (void)SetPrevButtonTextWithId:(uint32_t)ID strButtonText:(NSString *)strButtonText;

/**********************************************************
*    功  能：设置某条数据流的单位
*    参  数：uIndex 指定的数据流
*            strUnit 需要设置的单位文本
*    返回值：无
**********************************************************/
+ (void)SetUnitWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strUnit:(NSString *)strUnit;

/**********************************************************
*    功  能：设置某条数据流的范围
*    参  数：uIndex 指定的数据流
*            strMin 需要设置的最小值参考值
*            strMax 需要设置的最大值参考值
*    返回值：无
**********************************************************/
+ (void)SetLimitsWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strMin:(NSString *)strMin strMax:(NSString *)strMax;

/**********************************************************
*    功  能：设置某条数据流的枚举型参考值
*    参  数：uIndex 指定的数据流
*           strReference 需要设置的枚举型参考值
*    返回值：无
**********************************************************/
+ (void)SetReferenceWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strReference:(NSString *)strReference;

/**********************************************************
*    功  能：设置某条数据流的帮助信息
*    参  数：uIndex 指定的数据流
*            strHelp 需要设置的帮助文本
*    返回值：无
**********************************************************/
+ (void)SetHelpTextWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strHelpText:(NSString *)strHelpText;

/**********************************************************
*    功  能：设置各列表列宽比，如果列宽百分比为0，则隐藏该列
*            4列列宽比加起来为100
*
*    参  数： widthName        "名称"   列宽占比
*             widthValue    "值"     列宽占比
*             widthUnit        "单位"   列宽占比
*             widthRef      "参考值" 列宽占比
*
*    返回值：无
*
*     说  明：4列列宽比加起来为100
**********************************************************/
+ (void)SetColWidthWithId:(uint32_t)ID widthName:(int32_t)widthName widthValue:(int32_t)widthValue widthUnit:(int32_t)widthUnit widthRef:(int32_t)widthRef;

/**********************************************************
*    功  能：刷新某条数据流的值
*    参  数：uIndex 指定的数据流
*            strValue 需要设置的数据流值
*    返回值：无
**********************************************************/
+ (void)FlushValueWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strValue:(NSString *)strValue;

/**********************************************************
*    功  能：获取当前显示屏的更新项的下标集合
*    参  数：无
*    返回值：更新项的下标集合
**********************************************************/
+ (NSArray *)GetUpdateItemsWithId:(uint32_t)ID;

/**********************************************************
*    功  能：获取某条数据流是否需要更新
*    参  数：无
*    返回值：true 需要更新，false 不需要更新
**********************************************************/
+ (BOOL)GetItemIsUpdateWithId:(uint32_t)ID uIndex:(uint32_t)uIndex;

/**********************************************************
*    功  能：显示数据流控件
*    参  数：无
*    返回值：uint32_t 组件界面按键返回值
*
*           DF_ID_LIVEDATA_BACK        点击了返回
*            DF_ID_LIVEDATA_NEXT     点击了NEXT按钮
**********************************************************/

#pragma mark - 更新按钮状态
- (void)reloadButtonData;

@end


NS_ASSUME_NONNULL_END
