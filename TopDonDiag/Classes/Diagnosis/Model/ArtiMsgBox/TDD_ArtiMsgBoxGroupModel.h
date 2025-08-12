//
//  TDD_ArtiMsgBoxGroupModel.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/16.
//

#import "TDD_ArtiModelBase.h"
#if useCarsFramework
#include <CarsFramework/HStdOtherMaco.h>
#else
#include "HStdOtherMaco.h"
#endif

NS_ASSUME_NONNULL_BEGIN
@interface TDD_ArtiMsgBoxGroupItemModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *translatedTitle;//标题 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, copy) NSString *translatedContent;//内容 - 翻译后的数据 - 未翻译前与原数据一致

@property (nonatomic, assign) BOOL isTitleTranslated; //标题是否已翻译
@property (nonatomic, assign) BOOL isContentTranslated; //内容是否已翻译
@end

@interface TDD_ArtiMsgBoxGroupModel : TDD_ArtiModelBase
@property (nonatomic, assign) uint32_t  msgGroupType; //类型
@property (nonatomic, strong) NSMutableArray *itemArr;

@end

NS_ASSUME_NONNULL_END
