//
//  TDD_ArtiInstanceTipView.h
//  TopdonDiagnosis
//
//  Created by zhouxiong on 2024/8/19.
//

#import <TopdonDiagnosis/TopdonDiagnosis.h>
#import "TDD_ArtiFloatMiniModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiInstanceTipView : TDD_TipBaseView
- (void)refreshContentWith:(TDD_ArtiFloatMiniModel *)model;
@end

NS_ASSUME_NONNULL_END
