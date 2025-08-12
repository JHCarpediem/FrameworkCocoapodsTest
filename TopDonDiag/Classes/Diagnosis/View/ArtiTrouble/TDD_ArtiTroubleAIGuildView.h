//
//  TDD_ArtiTroubleAIGuildView.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/3/7.
//

#import <UIKit/UIKit.h>
#define TDDDidShowTroubleGuild  @"TDDDidShowTroubleGuild"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiTroubleAIGuildView : UIView
- (void)showWithPopPoint:(CGPoint)point;

- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
