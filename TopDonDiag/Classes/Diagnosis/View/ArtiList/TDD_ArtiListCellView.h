//
//  TDD_ArtiListCellView.h
//  AD200
//
//  Created by 何可人 on 2022/5/13.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiListModel.h"
NS_ASSUME_NONNULL_BEGIN

@class TDD_ArtiListCellView;

@protocol TDD_ArtiListCellViewDelegate <NSObject>

- (void)TDD_ArtiListCellViewUnderButtonClick:(TDD_ArtiListCellView *)cellView;

- (void)TDD_ArtiListCellViewSelectButtonClick:(TDD_ArtiListCellView *)cellView;

@end

@interface TDD_ArtiListCellView : UIView
@property (nonatomic, weak) id<TDD_ArtiListCellViewDelegate> delegate;
@property (nonatomic, strong) TDD_ArtiListModel * model;
@property (nonatomic, strong) ArtiListItemModel * itemModel;
@property (nonatomic, strong) NSArray * vctColWidth;
@property (nonatomic, assign) eListViewType listViewType; //列表类型
@property (nonatomic, assign) BOOL isHeader; //是否是头部
@property (nonatomic, assign) BOOL isShowImage; //是否显示图片
@property (nonatomic, assign) uint32_t uColImageIndex; //显示图片列
@property (nonatomic, strong) NSString * imageUrlStr; //图片路径

- (void)changeSelectButtonWithIsSelect:(BOOL)isSelect;

@end

NS_ASSUME_NONNULL_END
