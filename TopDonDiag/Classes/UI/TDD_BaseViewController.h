//
//  TDD_BaseViewController.h
//  BT20
//
//  Created by 何可人 on 2021/9/3.
//

#import <UIKit/UIKit.h>
#import "TDD_NaviView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_BaseViewController : UIViewController

@property (nonatomic, strong) TDD_NaviView *naviView;
@property (nonatomic, strong) UIImageView *topBackImageView;

- (void)setupNavigation;

@property (nonatomic, strong) NSString * titleStr;

- (void)didDisconnectPeripheral;

- (void)didConnectPeripheral;

///添加键盘高度
- (void)addkeyBoardObserverWithHigh:(int)high;

- (void)setTopBackImageViewHide:(BOOL)hide;

///退出
- (void)backClick;

- (void)hiddenBackButton;

- (void)showBackButton;




@end

NS_ASSUME_NONNULL_END
