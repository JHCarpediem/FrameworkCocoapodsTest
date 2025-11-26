//
//  TDD_NaviView.h
//  TOPKEY_iPad
//
//  Created by yong liu on 2022/1/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NaviType) {
    kNaviTypeHide = 0,                  // 隐藏导航栏
    kNaviTypeWhite = 1,                 // 白色背景
    kNaviTypeBlue = 2,                  // 蓝色背景
    kNaviTypeGradientBlue = 3,          // 蓝色渐变背景
    kNaviTypeClear = 4                  // 背景透明
};

@protocol TDD_NaviViewDelegate <NSObject>

- (void)backClick;

- (void)searchKeyChanged:(NSString *)searchKey;

@end

@interface TDD_NaviView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *backBtn;        // 返回按钮
@property (nonatomic, strong) TDD_VXXScrollLabel *titleLabel;      // 标题

@property (nonatomic, assign) NaviType naviType;        // 导航栏样式

@property (nonatomic, copy) NSString *title;

@property (nonatomic, weak) id<TDD_NaviViewDelegate> delegate;

@property(nonatomic, assign) BOOL isTitleCenter;        // 标题是否居中  默认居左


@property (nonatomic, strong) TDD_CustomTextField *searchField;         // 搜索
@property (nonatomic, copy) NSString *searchKey;

- (void)updateSearckKey:(NSString *)searchKey;

- (void)layouForLandscape: (BOOL)isLandscape;

@end

NS_ASSUME_NONNULL_END
