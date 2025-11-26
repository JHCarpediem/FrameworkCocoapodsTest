//
//  TDD_ArtiButtonCollectionCellView.h
//  AD200
//
//  Created by AI Assistant on 2024/12/19.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiModelBase.h"
NS_ASSUME_NONNULL_BEGIN

@class TDD_ArtiButtonCollectionCellView;

@protocol TDD_ArtiButtonCollectionCellViewDelegate <NSObject>

- (void)ArtiButtonCollectionCellButtonClick:(UIButton *)Button cell:(TDD_ArtiButtonCollectionCellView *)cell;

@end

@interface TDD_ArtiButtonCollectionCellView : UICollectionViewCell
@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, weak) id<TDD_ArtiButtonCollectionCellViewDelegate> delegate;
@property (nonatomic, strong) TDD_ArtiButtonModel * model;
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容

@end

NS_ASSUME_NONNULL_END 
