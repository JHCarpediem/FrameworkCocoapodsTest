//
//  TDD_DiagTopVCIProNaviBtnGuildVIew.h
//  TopDonDiag
//
//  Created by liuyong on 2024/5/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kUserDefaultDiagNaviGuild @"kUserDefaultDiagNaviGuild"

typedef void(^ShowMoreBtnBlock)(BOOL isShow);

@interface TDD_DiagTopVCIProNaviBtnGuildVIew : UIView

- (instancetype)initWithDiagType:(TDD_DiagNavType)diagNavType;

@property (nonatomic, copy) ShowMoreBtnBlock block;

- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
