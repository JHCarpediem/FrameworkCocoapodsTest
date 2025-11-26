//
//  TDD_ArtiSystemScoreView.h
//  Diag
//
//  Created by diag on 2023/10/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiSystemScoreView : UIView
@property (nonatomic, assign)NSInteger score;
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, assign) BOOL isLoading;

- (void)startLoading;

- (void)stopLoading;
@end

NS_ASSUME_NONNULL_END
