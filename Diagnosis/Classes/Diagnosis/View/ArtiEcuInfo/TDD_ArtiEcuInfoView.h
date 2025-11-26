//
//  TDD_ArtiEcuInfoView.h
//  AD200
//
//  Created by Diag on 2022/5/5.
//

#import "TDD_ArtiContentBaseView.h"
#import "TDD_ArtiEcuInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiEcuInfoView : TDD_ArtiContentBaseView
@property (nonatomic, strong) TDD_ArtiEcuInfoModel * ecuInfoModel;
@end

NS_ASSUME_NONNULL_END
