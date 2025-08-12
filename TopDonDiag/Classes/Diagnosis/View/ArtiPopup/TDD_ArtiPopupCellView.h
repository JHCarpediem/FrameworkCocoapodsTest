//
//  TDD_ArtiPopupCellView.h
//  TopDonDiag
//
//  Created by fench on 2023/8/29.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiPopupModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TDD_ArtiPopupCellView;

@protocol TDD_ArtiPopupCellViewDelegate <NSObject>

- (void)ArtiPopupCellMoreButtonClick:(TDD_ArtiPopupCellView *)cellView;
- (void)ArtiPopupToTroubleDetailClick:(TDD_ArtiPopupCellView *)cellView;
@end

@interface TDD_ArtiPopupCellView : UIView
@property (nonatomic, weak) id<TDD_ArtiPopupCellViewDelegate> delegate;
@property (nonatomic, strong) TDD_ArtiPopupItemModel * itemModel;
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容

- (void)addLayer;
- (void)showGuildView;
@end

NS_ASSUME_NONNULL_END
