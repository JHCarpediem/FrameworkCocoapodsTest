//
//  TDD_ArtiFreezeModel.h
//  AD200
//
//  Created by 何可人 on 2022/5/6.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiFreezeItemModel : NSObject
@property (nonatomic, strong) NSString * strName; //冻结帧名称
@property (nonatomic, strong) NSString * strValue; //冻结帧值

@property (nonatomic, copy) NSString * strValue2nd; // 冻结帧名称2
@property (nonatomic, strong) NSString * strUnit; //冻结帧单位
@property (nonatomic, strong) NSString * strHelp; //冻结帧帮助
@property (nonatomic, assign) BOOL isShowHelpButton; //是否显示帮助按钮

@property (nonatomic, strong) NSString * strChangeValue; //数据流公英制转换后的值
@property (nonatomic, strong) NSString * strChangeValue2nd; //数据流公英制转换后的值
@property (nonatomic, strong) NSString * strChangeUnit; //数据流公英制转换后的单位
@property (nonatomic, assign) NSInteger eColumnType; // 1 指定冻结帧的值为1列 2 指定冻结帧的值为2列

@property (nonatomic, strong) NSString * strTranslatedName;//冻结帧名称 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, strong) NSString * strTranslatedHelp;//冻结帧帮助 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, assign) BOOL isStrNameTranslated; //冻结帧名称是否已翻译
@property (nonatomic, assign) BOOL isStrHelpTranslated; //冻结帧帮助是否已翻译


@property (nonatomic, strong) NSString * strHead; //冻结帧头文本
@property (nonatomic, strong) NSString * strHead2nd; //冻结帧头文本2

@property (nonatomic, assign) CGFloat nameHeight;//名称高度
@property (nonatomic, assign) CGFloat translatedNameHeight;//翻译名称高度
- (void)changeUnitAndValue;

@end

@interface TDD_ArtiFreezeModel : TDD_ArtiModelBase
@property (nonatomic, strong) NSMutableArray<TDD_ArtiFreezeItemModel *> * groupArr;
@property (nonatomic, assign) NSInteger eColumnType; // 1 指定冻结帧的值为1列 2 指定冻结帧的值为2列
@property (nonatomic, strong) NSString * strHead; //冻结帧头文本
@property (nonatomic, strong) NSString * strHead2nd; //冻结帧头文本2

/**********************************************************
*    功  能：添加冻结帧项
*    参  数：strName 冻结帧名称
*            strValue 冻结帧值
*            strUnit 冻结帧单位
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strName:(NSString *)strName strValue:(NSString *)strValue strUnit:(NSString *)strUnit strHelp:(NSString *)strHelp;
@end

NS_ASSUME_NONNULL_END
