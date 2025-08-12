//
//  TDD_ArtiButtonView.h
//  AD200
//
//  Created by 何可人 on 2022/4/27.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TDD_ArtiButtonViewDelegate <NSObject>

- (void)ArtiButtonClick:(TDD_ArtiButtonModel *)model;

@end

@interface TDD_ArtiButtonView : UIView
@property (nonatomic, weak) id<TDD_ArtiButtonViewDelegate> delegate;
@property (nonatomic, strong) TDD_ArtiModelBase * model;
@end

NS_ASSUME_NONNULL_END
