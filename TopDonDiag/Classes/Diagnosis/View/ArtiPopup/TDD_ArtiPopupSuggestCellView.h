//
//  TDD_ArtiPopupSuggestCellView.h
//  TopdonDiagnosis
//
//  Created by lk_ios2023002 on 2024/3/11.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiPopupModel.h"
#import "TDD_ArtiTroubleModel.h"
NS_ASSUME_NONNULL_BEGIN
@class TDD_ArtiPopupSuggestCellView;
@protocol TDD_ArtiPopupSuggestCellViewDelegate <NSObject>

- (void)ArtiPopupSuggestCellMoreButtonClick:(TDD_ArtiPopupSuggestCellView *)cellView;
- (void)ArtiPopupToSuggestDetailClick:(TDD_ArtiPopupSuggestCellView *)cellView;//维修建议
- (void)ArtiPopupToTroubleXMLDetailClick:(TDD_ArtiPopupSuggestCellView *)cellView;//获取维修指引
- (void)ArtiPopupFuctionButtonClick:(UIButton *)button;
@end
@interface TDD_ArtiPopupSuggestCellView : UIView
@property (nonatomic, weak) id<TDD_ArtiPopupSuggestCellViewDelegate> delegate;
@property (nonatomic, strong) TDD_ArtiPopupItemModel * itemModel;
@property (nonatomic, strong) TDD_ArtiTroubleItemModel * troubleItemModel;
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容
- (void)showGuildView;
@end

NS_ASSUME_NONNULL_END
