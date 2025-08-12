//
//  TDD_ArtiLiveDataCellView.h
//  AD200
//
//  Created by 何可人 on 2022/6/2.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiLiveDataModel.h"
#import "TDD_ArtiFreezeModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol TDD_ArtiLiveDataCellViewDelegate <NSObject>

- (void)TDD_ArtiLiveDataCellViewMoreButtonClick:(id)itemModel;

- (void)TDD_ArtiLiveDataCellViewChartButtonClick:(TDD_ArtiLiveDataItemModel *)itemModel;

@end

@interface TDD_ArtiLiveDataCellView : UIView
@property (nonatomic, weak) id<TDD_ArtiLiveDataCellViewDelegate> delegate;
@property (nonatomic, strong) TDD_ArtiLiveDataItemModel * itemModel;
@property (nonatomic, strong) TDD_ArtiFreezeItemModel * freezeItemModel;
@property (nonatomic, strong) TDD_ArtiLiveDataModel * model;
@property (nonatomic,assign) BOOL isPlay; //是否是数据流播放
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容
//- (void)changeSelectButton:(BOOL)isSelect;
@end

NS_ASSUME_NONNULL_END
