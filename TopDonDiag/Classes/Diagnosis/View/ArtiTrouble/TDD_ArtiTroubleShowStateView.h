//
//  TDD_ArtiTroubleShowStateView.h
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/9/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef CGFloat (^ArrowDownBottomOffsetBlock)(CGFloat arrowDownBottom);

@interface TDD_ArtiTroubleShowStateView : UIView

@property (nonatomic, copy) NSMutableAttributedString *stateStr;

// 箭头向下偏移 arrowBottom 位置
@property (nonatomic, copy) ArrowDownBottomOffsetBlock arrowDownBottomOffsetBlock;
// 6
@property (nonatomic, assign) CGFloat arrowHeight;
// 20
@property (nonatomic, assign) CGFloat arrowTopOffset;

- (void)showWithPopPoint:(CGPoint)point content:(NSAttributedString *)content;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
