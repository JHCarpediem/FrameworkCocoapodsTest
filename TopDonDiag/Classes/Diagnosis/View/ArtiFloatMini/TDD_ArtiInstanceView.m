//
//  TDD_ArtiInstanceView.m
//  TopdonDiagnosis
//
//  Created by zhouxiong on 2024/8/16.
//

#import "TDD_ArtiInstanceView.h"
#import "TDD_ArtiInstanceTipView.h"

@interface TDD_ArtiInstanceView()
@property (assign, nonatomic) CGRect bottonRect;
@property (assign, nonatomic) CGRect middleRect;
@property (assign, nonatomic) CGRect topRect;

@end

@implementation TDD_ArtiInstanceView

- (void)checkShowInstanceView:(TDD_ArtiFloatMiniModel *)model {
    CGFloat leftSpace = IS_IPad ? 72 : 24;
    CGFloat bottomSpace = IS_IPad ? 42 : 32;
    UIView *subview = [self viewWithTag:model.ID];
    if (subview) {
        if (model.hidden) {
            [subview removeFromSuperview];
        }
    } else {
        // 最多三个 tip，超过三个替换掉第一个，否则新增一个，位置在上一个 tip 至上
        if (!model.hidden) {
            if (self.subviews.count >= 3) {
                TDD_ArtiInstanceTipView *firstView = [self.subviews firstObject];
                [firstView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self).offset(-leftSpace);
                    make.bottom.equalTo(@(-bottomSpace));
                    make.left.greaterThanOrEqualTo(self).offset(leftSpace);
                }];
                [firstView refreshContentWith:model];
                firstView.tag = model.ID;
                
                [self layoutIfNeeded];
                self.bottonRect = firstView.frame;
            } else {
                TDD_ArtiInstanceTipView *lastView = [[TDD_ArtiInstanceTipView alloc] init];
                lastView.tag = model.ID;
                [self addSubview:lastView];
                UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(lastViewDrag:)];
                [lastView addGestureRecognizer:panGesture];
                
                // 确定底部位置布局
                CGFloat Y = 0;
                if (self.subviews.count == 1) {
                    Y = 0;
                } else if (self.subviews.count == 2) {
                    Y = self.bottonRect.origin.y;
                } else {
                    Y = self.middleRect.origin.y;
                }
                
                [lastView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self).offset(-leftSpace);
                    make.bottom.equalTo(@(-bottomSpace - Y));
                    make.left.greaterThanOrEqualTo(self).offset(leftSpace);
                }];
                [lastView refreshContentWith:model];
                
                [self layoutIfNeeded];
                
                // 确定当前三个 tip 位置
                if (self.subviews.count == 1) {
                    self.bottonRect = lastView.frame;
                } else if (self.subviews.count == 2) {
                    self.middleRect = lastView.frame;
                } else {
                    self.topRect = lastView.frame;
                }
            }
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 查找子视图
    UIView *hitView = [super hitTest:point withEvent:event];
    
    // 如果点击位置在子视图上，则返回该子视图
    if (hitView != self) {
        return hitView;
    }
    
    // 如果点击位置在空白区域，返回 nil，让事件传递给下一层视图
    return nil;
}


- (void)lastViewDrag:(UIPanGestureRecognizer *)gesture {
    UIView *view = gesture.view;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [gesture translationInView:self];
        view.center = CGPointMake(view.center.x + point.x, view.center.y + point.y);
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [gesture translationInView:self];
        CGPoint newPoint = CGPointMake(view.center.x + point.x, view.center.y + point.y);
        
        CGFloat width = view.frame.size.width;
        CGFloat height = view.frame.size.height;
        
        CGFloat maxX = IphoneWidth - width / 2;
        CGFloat maxY = self.frame.size.height - height / 2;

        if (newPoint.x < width / 2) {
            newPoint.x = width / 2;
        } else if (newPoint.x > maxX) {
            newPoint.x = maxX;
        }
        
        if (newPoint.y <= height / 2) {
            newPoint.y = height / 2;
        } else if (newPoint.y >= maxY) {
            newPoint.y = maxY;
        }
        
        view.center = newPoint;
        
    }
    [gesture setTranslation:CGPointZero inView:self];
}

@end
