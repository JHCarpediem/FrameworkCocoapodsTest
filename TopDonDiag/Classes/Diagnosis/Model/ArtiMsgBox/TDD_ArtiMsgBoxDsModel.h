//
//  TDD_ArtiMsgBoxDsModel.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/27.
//

#import <TopdonDiagnosis/TopdonDiagnosis.h>
#import "TDD_ArtiLiveDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiMsgBoxDsModel : TDD_ArtiModelBase
@property (nonatomic, strong) NSString * sysName; //系统名称
@property (nonatomic, strong) NSString * translatedSysName;//系统名称 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, assign) BOOL isSysNameTranslated; //系统名称是否已翻译
@property (nonatomic, strong) NSMutableArray<TDD_ArtiLiveDataItemModel *> *liveDataItems;
@end

NS_ASSUME_NONNULL_END
