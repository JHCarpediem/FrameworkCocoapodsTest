//
//  TDD_ArtiActiveModel.h
//  AD200
//
//  Created by 何可人 on 2022/4/21.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArtiActiveItemModel : NSObject
@property (nonatomic, assign) uint32_t uIndex;//菜单项编号 从0开始
@property (nonatomic, strong) NSString * strItem;//动作测试项名称
@property (nonatomic, strong) NSString * strValue;//动作测试项值
@property (nonatomic, strong) NSString * strUnit;//动作测试项单位
@property (nonatomic, assign) BOOL bIsLocked;//是否锁定该行
///headModel高度
@property (nonatomic, assign) CGFloat headHeight;
@property (nonatomic, assign) CGFloat headMaxHeight;
@property (nonatomic, assign) CGFloat textMaxHeight;
@property (nonatomic, assign) CGFloat valueHeight;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, strong) UIFont *valueFont;
@property (nonatomic, strong) UIFont *headValueFont;
@property (nonatomic, strong) UIFont *titleFont;

- (void)getMaxHeadHeight;
- (void)getTextMaxHeight;
- (void)getValueHeight;
- (void)getTitleHeight;
@end

@protocol TDD_ArtiActiveModelDelegata <NSObject>

//非阻塞

/**********************************************************
*    功  能：获取当前屏的刷新项（排除锁定行）
*    参  数：无
*    返回值：vector<uint32_t> 当前屏需要刷新的项的下标集合
**********************************************************/
- (NSArray<NSNumber *> *)TDD_ArtiActiveModelGetUpdateItems;

@end

@interface TDD_ArtiActiveModel : TDD_ArtiModelBase
@property (nonatomic, strong) NSMutableArray<ArtiActiveItemModel *> * itemArr;//菜单项数组
@property (nonatomic, strong) NSString * strOperationTopTips;//动作测试操作提示
@property (nonatomic, strong) NSString * strOperationBottomTips;//动作测试操作提示
@property (nonatomic, strong) ArtiActiveItemModel * headModel;//设置列表头(只有3个)
@property (nonatomic, assign) BOOL SetLockFirstRow;//设置第一行是锁定状态

@property (nonatomic, strong) NSString * strTitleTopTips; //头部提示标题
@property (nonatomic, strong) NSString * strTitleBottomTips; //底部提示标题
@property (nonatomic, assign) uint16_t uTitleTopAlignType; //顶部标题title提示位置

@property (nonatomic, assign) uint16_t eTitleTopFontSize; //顶部标题title文字大小

@property (nonatomic, assign) uint16_t eTitleTopBoldType; //顶部标题title文字字重

@property (nonatomic, assign) uint16_t uTitleBottomAlignType; //底部标题title提示位置

@property (nonatomic, assign) uint16_t eTitleBottomFontSize; //底部标题title文字大小

@property (nonatomic, assign) uint16_t eTitleBottomBoldType; //底部标题title文字字重

@property (nonatomic, weak) id<TDD_ArtiActiveModelDelegata> delegate; //代理

@property (nonatomic, strong) UIFont *valueFont;
@property (nonatomic, strong) UIFont *headValueFont;
@property (nonatomic, strong) UIFont *titleFont;
/**********************************************************
*    功  能：添加动作测试项
*
*    参  数：strItem   动作测试项名称，
*
*            bIsLocked=true, 锁定该行，获取刷新项时，排除此行
*            bIsLocked=false,不锁定该行，获取刷新项时，包含此行
*
*            strValue  动作测试项值
*            strUnit   动作测试项单位
*
*    返回值：无
*    注  意：bIsLocked为true时，并不是“冻结此行”的显示效果
*            而是GetUpdateItems不包括此行
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strItem:(NSString *)strItem strValue:(NSString *)strValue bIsLocked:(BOOL)bIsLocked strUnit:(NSString *)strUnit;

/**********************************************************
*    功  能：获取当前屏的刷新项（排除锁定行）
*    参  数：无
*    返回值：vector<uint32_t> 当前屏需要刷新的项的下标集合
**********************************************************/
+ (NSArray *)GetUpdateItemsWithId:(uint32_t)ID;


/**********************************************************
*    功  能：设置动作测试某一项的值
*    参  数：uIndex 动作测试项，strValue 动作测试项值
*    返回值：无
**********************************************************/
+ (void)SetValueWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strValue:(NSString *)strValue;


/**********************************************************
*    功  能：设置动作测试某一项的动作测试项名称
*    参  数：uIndex 动作测试项，strItem 动作测试项名称
*    返回值：无
**********************************************************/
+ (void)SetItemWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strItem:(NSString *)strItem;


/**********************************************************
*    功  能：设置动作测试某一项的单位
*    参  数：uIndex 动作测试项，strUnit 动作测试项单位
*    返回值：无
**********************************************************/
+ (void)SetUnitWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strUnit:(NSString *)strUnit;


/**********************************************************
*    功  能：在界面顶部设置动作测试操作提示
*    参  数：strOperationTips 动作测试操作提示
*    返回值：无
**********************************************************/
+ (void)SetOperationTipsOnTopWithId:(uint32_t)ID strOperationTips:(NSString *)strOperationTips;


/**********************************************************
*    功  能：在界面底部设置动作测试操作提示
*    参  数：strOperationTips 动作测试操作提示
*    返回值：无
**********************************************************/
+ (void)SetOperationTipsOnBottomWithId:(uint32_t)ID strOperationTips:(NSString *)strOperationTips;


/**********************************************************
*    功  能：设置列表头，该行锁定状态
*    参  数：vctHeadNames 列表各列的名称集合
*    返回值：无
**********************************************************/
+ (void)SetHeadsWithId:(uint32_t)ID vctHeadNames:(NSArray<NSString *> *)vctHeadNames;


/**********************************************************
*    功  能：设置第一行是锁定状态，类似Excel表格的“冻结首行”
*
*    参  数：无
*
*    返回值：无
*
*    注  意：首行和列表头(Head)是不一样的
*            如果设置了列表头，SetHeads
*            并且锁定了首行，SetLockFirstRow
*            会有类似冻结了2行的效果
*
*            列表头 和 SetLockFirstRow的首行 底纹 应该有区别的效果
**********************************************************/
+ (void)SetLockFirstRowWithId:(uint32_t)ID;


/**********************************************************
*    功  能：设置指定的动作测试按钮状态
*    参  数：uIndex 指定的动作测试按钮
*            bIsEnable=true 按钮可点击
*            bIsEnable=false 按钮不可点击
*    返回值：无
**********************************************************/
+ (void)SetButtonStatusWithId:(uint32_t)ID uIndex:(uint32_t)uIndex bIsEnable:(BOOL)bIsEnable;

@end

NS_ASSUME_NONNULL_END
