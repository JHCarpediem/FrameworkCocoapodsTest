//
//  TDD_ArtiContentBaseView.h
//  AD200
//
//  Created by 何可人 on 2022/6/2.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ArtiContentViewDelegate <NSObject>

- (void)ArtiContentViewDelegateReloadData:(TDD_ArtiModelBase *)model;

@end

@interface TDD_ArtiContentBaseView : UIView
@property (nonatomic, weak) id<ArtiContentViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
