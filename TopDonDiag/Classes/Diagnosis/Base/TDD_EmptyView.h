//
//  EmptyView.h
//  AD200
//
//  Created by yong liu on 2022/7/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_EmptyView : UIView<UITextViewDelegate>

@property (nonatomic, strong) UIImageView *emptyImageView;

@property (nonatomic, strong) TDD_CustomLabel *tipLabel;

- (void)setEmptyImage:(NSString *)imageStr width:(CGFloat)width height:(CGFloat)height;

- (void)setEmptyImageWidth:(CGFloat)width height:(CGFloat)height;

//image距离顶部间距,不传为-1
- (void)setEmptyImage:(NSString *)imageStr width:(CGFloat)width height:(CGFloat)height topSpacing:(CGFloat)topSpacing;


@end

NS_ASSUME_NONNULL_END
