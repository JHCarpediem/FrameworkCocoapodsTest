//
//  TDD_ArtiPopupModel.h
//  TopDonDiag
//
//  Created by fench on 2023/8/29.
//

#import "TDD_ArtiModelBase.h"
#import "TDD_ArtiTroubleRepairInfoModle.h"

NS_ASSUME_NONNULL_BEGIN
@class TDD_ArtiPopupModel;
@interface TDD_ArtiPopupItemModel : NSObject

@property (nonatomic, copy) NSString *code;//故障码

@property (nonatomic, copy) NSString *content;//描述内容

@property (nonatomic, copy) NSString *status;//故障码状态

@property (nonatomic, assign) BOOL isShowMore;//是否完全显示描述文本

@property (nonatomic, assign) BOOL hadSuggest;//有维修建议

@property (nonatomic, strong) NSString * strTranslatedContent;//描述内容 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, strong) NSString * strTranslatedStatus;//故障码状态 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, assign) BOOL isStrContentTranslated; //故障码描述是否已翻译
@property (nonatomic, assign) BOOL isStrStatusTranslated; //故障码状态是否已翻译

@end

@protocol TDD_ArtiPopupModelDelegata <NSObject>

/**********************************************************
*    功  能：跳转故障码详情
**********************************************************/
- (void)ArtiPopupToTroubleDetail:(NSString *)troubleCode;

/**********************************************************
*    功  能：跳转 AI
**********************************************************/
- (void)ArtiPopupGotoAI:(TDD_ArtiPopupModel *)model itemIndex:(NSInteger )itemIndex;
@end

@interface TDD_ArtiPopupModel : TDD_ArtiModelBase

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) int popupType;

@property (nonatomic, strong) NSMutableArray<NSString *> *btnTitleArray;

@property (nonatomic, strong) TDD_ArtiTroubleRepairInfoModle * repairInfoModle; //故障码维修指引数据Model

@property (nonatomic, strong) NSMutableArray<TDD_ArtiPopupItemModel *> *items;

@property (nonatomic, weak) __nullable id<TDD_ArtiPopupModelDelegata> delegate;

@end

NS_ASSUME_NONNULL_END
