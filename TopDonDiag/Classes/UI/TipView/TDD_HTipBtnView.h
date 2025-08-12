//
//  TDD_HTipBtnView.h
//  BT20
//
//  Created by 何可人 on 2021/10/28.
//

#import "TDD_TipBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum _HTipBtnType
{
    HTipBtnOneType, //一个按钮
    HTipBtnTwoType, //两个按钮 好的、取消
    HTipBtnTwoYNType //两个按钮 yes、no
}HTipBtnType;

@protocol TDD_HTipBtnViewDelegate <NSObject>

@optional

/// 按钮点击事件
/// @param viewTag 标签
/// @param btnTag 0：取消， 1：确定
- (void)hTipBtnViewTag:(int)viewTag didClickWithBtnTag:(int)btnTag;

@end

@interface TDD_HTipBtnView : TDD_TipBaseView

@property (nonatomic, weak) id <TDD_HTipBtnViewDelegate> delegata;
@property (nonatomic, copy) void(^clickBlock)(NSInteger btnTag);
- (instancetype)initWithTitle:(NSString *)title buttonType:(HTipBtnType)tipBtnType;

/// 设置按钮文字
- (void)setupButtonTitles:(NSArray *)btnTitles;

@end

NS_ASSUME_NONNULL_END
