//
//  TDD_ArtiMenuCellView.h
//  AD200
//
//  Created by 何可人 on 2022/4/19.
//

#import <UIKit/UIKit.h>

#import "TDD_ArtiMenuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiMenuCellView : UIView
@property (nonatomic, strong) ArtiMenuItemModel * itemModel;
-(void)setingTitelLabelColor:(UIColor *)color;
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容
@property (nonatomic, assign) CGFloat itemHeight;
@end

NS_ASSUME_NONNULL_END
