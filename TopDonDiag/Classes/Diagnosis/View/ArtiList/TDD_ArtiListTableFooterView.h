//
//  TDD_ArtiListFooterView.h
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/12/15.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiListTableFooterView : UIView
@property (nonatomic, strong) TDD_ArtiListModel * listModel;
@property (nonatomic, copy)void(^hideBlock)(void);
- (CGFloat )footViewHeight;
@end

NS_ASSUME_NONNULL_END
