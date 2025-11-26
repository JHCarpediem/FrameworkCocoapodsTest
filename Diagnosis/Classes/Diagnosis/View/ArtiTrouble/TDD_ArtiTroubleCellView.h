//
//  TDD_ArtiTroubleCellView.h
//  AD200
//
//  Created by Diag on 2022/5/9.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiTroubleModel.h"
#import "TDD_ArtiPopupModel.h"
NS_ASSUME_NONNULL_BEGIN

@class TDD_ArtiTroubleCellView;

@protocol TDD_ArtiTroubleCellViewDelegate <NSObject>

- (void)ArtiTroubleCellButtonClick:(UIButton *)button;

- (void)ArtiTroubleCellMoreButtonClick:(TDD_ArtiTroubleCellView *)cellView;

- (void)ArtiTroubleCellLockClick:(TDD_ArtiTroubleCellView *)cellView;
@end

@interface TDD_ArtiTroubleCellView : UIView
@property (nonatomic, weak) id<TDD_ArtiTroubleCellViewDelegate> delegate;
@property (nonatomic, strong) TDD_ArtiTroubleItemModel * itemModel;
@property (nonatomic, strong) TDD_ArtiPopupItemModel * popupItemModel;
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容

- (void)addLayer;
- (void)showGuildView;
@end

NS_ASSUME_NONNULL_END
