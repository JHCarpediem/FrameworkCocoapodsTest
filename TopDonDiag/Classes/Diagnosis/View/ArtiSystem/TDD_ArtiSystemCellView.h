//
//  TDD_ArtiSystemCellView.h
//  AD200
//
//  Created by 何可人 on 2022/7/29.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiSystemModel.h"
NS_ASSUME_NONNULL_BEGIN

@class TDD_ArtiSystemCellView;

@protocol TDD_ArtiSystemCellViewDelegate <NSObject>

- (void)ArtiSystemCellViewBottomButtonClick:(TDD_ArtiSystemCellView *)cellView;

- (void)ArtiSystemCellViewAdasButtonClick:(TDD_ArtiSystemCellView *)cellView;
@end


@interface TDD_ArtiSystemCellView : UIView
@property (nonatomic, weak) id<TDD_ArtiSystemCellViewDelegate> delegate;
@property (nonatomic, strong) ArtiSystemItemModel * systemItemModel;
@property (nonatomic,assign) int index;
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容

- (void)highlightBackView;
- (void)cancelHighlightBackView;

- (void)setTitleLabelTextColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
