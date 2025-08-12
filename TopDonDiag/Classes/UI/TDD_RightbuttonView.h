//
//  TDD_RightbuttonView.h
//  AD200
//
//  Created by tangjilin on 2022/7/20.
//

#import <UIKit/UIKit.h>
#import "TDD_BtnLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DiagNaviShowRightBtn) {
    kVCIStatusBtn = 0,              // 蓝牙状态
    kFeedBackBtn = 1,               // 反馈
    kTranslateBtn = 2,              // 翻译
    kSearchBtn = 3,                 // 搜索
    kServiceBtn = 4,                // 客服
    kIMMOTDartsStatusBtn = 5,       // 诊断类型为IMMO时，T-Darts蓝牙连接状态
    kHelpBtn = 6,                   // 帮助
    kNavMoreBtn = 10,               // 更多
    kNavSaveBtn = 11,               // 保存
};

typedef void (^returnblock)(NSInteger indexbtn);

typedef void (^moreBtnBlock)(NSArray <NSNumber *> *showBtnArray);

@interface TDD_RightbuttonView : UIView

@property (nonatomic, strong) UIButton *vciStatusBtn;   // 蓝牙连接状态按钮

@property (nonatomic, strong) UIButton *saveBtn;   // 保存按钮

@property (nonatomic, copy) returnblock buttonblock;

@property (nonatomic, copy) moreBtnBlock moreBtnBlock;

@property (nonatomic, readonly, strong) NSArray *showBtnArray;

+ (UIImage *)navBtnImage:(DiagNaviShowRightBtn )showRightBtnType;

- (instancetype)initWithType:(TDD_DiagNavType)diagNavType;


/// 更新显示的按钮 （蓝牙状态按钮和反馈按钮固定显示，翻译和搜索按钮根据页面显示）
/// - Parameter showBtnArray: 显示的按钮
- (void)updateShowBtn:(NSArray *)showBtnArray isSearch:(BOOL)isSearch;

/// 翻译是否完成
- (void)showTranslateFinish:(BOOL )finish;
/// 翻译按钮loading动画
- (void)showTranslateAnimate:(BOOL )show;


/// 按钮点击事件
- (void)navBtnClick:(UIButton *)col;
/// 调起蓝牙未连接弹框
- (void)vciStatusBtnClick;
@end

NS_ASSUME_NONNULL_END
