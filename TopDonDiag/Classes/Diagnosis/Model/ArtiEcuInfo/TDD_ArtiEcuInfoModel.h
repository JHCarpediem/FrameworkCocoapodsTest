//
//  TDD_ArtiEcuInfoModel.h
//  AD200
//
//  Created by 何可人 on 2022/5/5.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArtiEcuInfoItemModel : NSObject

@property (nonatomic, strong) NSString * strItem; //版本信息项名称

@property (nonatomic, strong) NSString * strValue; //版本信息项的值

@property (nonatomic, strong) NSString * strGroupName; //分组名称文本

@property (nonatomic, assign) BOOL isAddGroup; //是否添加分组

@property (nonatomic, strong) NSString * strTranslatedItem;//版本信息项名称 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, strong) NSString * strTranslatedGroupName;//分组名称文本 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, assign) BOOL isStrItemTranslated; //版本信息项名称是否已翻译
@property (nonatomic, assign) BOOL isStrGroupNameTranslated; //分组名称文本是否已翻译

@end

@interface TDD_ArtiEcuInfoModel : TDD_ArtiModelBase

@property (nonatomic, assign) uint32_t iFirstPercent; //版本信息项宽

@property (nonatomic, assign) uint32_t iSecondPercent; //版本信息项值宽

@property (nonatomic, strong) NSMutableArray<ArtiEcuInfoItemModel *> * itemArr;

/**********************************************************
*    功  能：设置版本信息项名和值所在列的比例
*    参  数：iFirstPercent 版本信息项宽，
*            strValue 版本信息项值宽
*    返回值：无
**********************************************************/
+ (void)SetColWidthWithId:(uint32_t)ID iFirstPercent:(uint32_t)iFirstPercent iSecondPercent:(uint32_t)iSecondPercent;


/**********************************************************
*    功  能：添加版本信息的分组
*    参  数：strGroupName 分组名称文本
*    返回值：无
**********************************************************/
+ (void)AddGroupWithId:(uint32_t)ID strGroupName:(NSString *)strGroupName;


/**********************************************************
*    功  能：添加版本信息项
*    参  数：strItem 版本信息项名称，
*            strValue 版本信息项的值
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strItem:(NSString *)strItem strValue:(NSString *)strValue;

@end

NS_ASSUME_NONNULL_END
