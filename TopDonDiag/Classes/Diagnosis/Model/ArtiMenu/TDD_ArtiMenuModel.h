//
//  TDD_ArtiMenuModel.h
//  AD200
//
//  Created by 何可人 on 2022/4/16.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArtiMenuItemModel : NSObject
@property (nonatomic, assign) uint32_t uIndex;//菜单项编号 从0开始
@property (nonatomic, strong) NSString * strItem;//菜单项名称
@property (nonatomic, strong) NSString * strIconPath;//菜单项图片路径
@property (nonatomic, strong) NSString * strShortName;//菜单项的名称缩写
@property (nonatomic, assign) uint32_t uStatus;//菜单项的状态
@property (nonatomic, strong) NSString * strTranslatedItem;//菜单项名称 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, strong) NSString * strTranslatedShortName;//菜单项的名称缩写 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, assign) BOOL isStrItemTranslated; //菜单项名称是否已翻译
@property (nonatomic, assign) BOOL isStrShortNameTranslated; //菜单项的名称缩写是否已翻译
@end

@interface TDD_ArtiMenuModel : TDD_ArtiModelBase
@property (nonatomic, strong) NSMutableArray<ArtiMenuItemModel *> * itemArr;//菜单项数组
@property (nonatomic, assign) BOOL helpButtonVisible;//帮助按钮是否显示，控件默认不显示
@property (nonatomic, assign) BOOL menuTreeVisiblel;//左侧菜单树要不要显示，默认不显示
@property (nonatomic, strong) NSString * strMenuId;//设置菜单ID给显示层，由显示层存储，必要时去取
@property (nonatomic, assign) int32_t selectIndex;//选中的编号
@property (nonatomic, strong) NSMutableArray *selectArray;  // 记录选中多个编号

/**********************************************************
*    功  能：添加菜单项
*    参  数：strItem 菜单项名称
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strItem:(NSString *)strItem uStatus:(uint32_t )uStatus;

/**********************************************************
*    功  能：获取指定菜单项的文本串
*    参  数：uIndex 指定的菜单项
*    返回值：string 指定菜单项的文本串
**********************************************************/
+ (NSString *)GetItemWithId:(uint32_t)ID uIndex:(uint32_t)uIndex;

/**********************************************************
*    功  能：设置指定菜单项需要附加的图片
*
*    参  数：uIndex 指定的菜单项
*            strIconPath   需要设置的图片路径
*            strShortName  菜单项的名称缩写
*                          如果strShortName为空串，则不改变菜
*                          单项的名称
*
*    返回值：无
*
*    注 意： 菜单图标的大小暂设定为150*150，输入图标长宽如果
*            不等于150，等比例缩放到长宽最大值为150显示
**********************************************************/
+ (void)SetIconWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strIconPath:(NSString *)strIconPath strShortName:(NSString *)strShortName;

/**********************************************************
*    功  能：设置帮助按钮是否显示，控件默认不显示
*    参  数：bIsVisible = true  显示帮助按钮
*            bIsVisible = false 隐藏帮助按钮
*    返回值：无
**********************************************************/
+ (void)SetHelpButtonVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible;

/**********************************************************
*    功  能：设置左侧菜单树要不要显示，默认不显示
*    参  数：bIsVisible = true  显示左侧菜单树
*            bIsVisible = false 隐藏左侧菜单树
*    返回值：无
**********************************************************/
+ (void)SetMenuTreeVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible;

/**********************************************************
*    功  能：设置菜单ID给显示层，由显示层存储，必要时去取
*    参  数：strMenuId 菜单ID
*    返回值：无
**********************************************************/
+ (void)SetMenuIdWithId:(uint32_t)ID strMenuId:(NSString *)strMenuId;

/**********************************************************
*    功  能：获取菜单树选择项的菜单ID
*    参  数：无
*    返回值：string 设置过的菜单ID
**********************************************************/
+ (NSString *)GetMenuIdWithId:(uint32_t)ID;

@end

NS_ASSUME_NONNULL_END
