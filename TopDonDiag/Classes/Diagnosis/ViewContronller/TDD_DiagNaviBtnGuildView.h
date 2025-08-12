//
//  TDD_DiagNaviBtnGuildView.h
//  TopDonDiag
//
//  Created by yong liu on 2023/9/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kUserDefaultDiagNaviGuild @"kUserDefaultDiagNaviGuild"

typedef void(^ShowMoreBtnBlock)(BOOL isShow);

@interface TDD_DiagNaviBtnGuildView : UIView

- (instancetype)initWithDiagType:(TDD_DiagNavType)diagNavType;

@property (nonatomic, copy) ShowMoreBtnBlock block;

- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
