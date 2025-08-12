//
//  TDD_ArtiButtonCellView.h
//  AD200
//
//  Created by 何可人 on 2022/4/28.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiModelBase.h"
NS_ASSUME_NONNULL_BEGIN

@class TDD_ArtiButtonCellView;

@protocol TDD_ArtiButtonCellViewDelegate <NSObject>

- (void)ArtiButtonCellButtonClick:(UIButton *)Button cell:(TDD_ArtiButtonCellView *)cell;

@end

@interface TDD_ArtiButtonCellView : UITableViewCell
@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, weak) id<TDD_ArtiButtonCellViewDelegate> delegate;
@property (nonatomic, strong) TDD_ArtiButtonModel * model;
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容
@end

NS_ASSUME_NONNULL_END
