//
//  TDD_HLoadingView.h
//  BT20
//
//  Created by 何可人 on 2021/10/28.
//

#import "TDD_TipBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_HLoadingView : TDD_TipBaseView
- (instancetype)initWithTitle:(NSString *)title;
- (void)updateTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
