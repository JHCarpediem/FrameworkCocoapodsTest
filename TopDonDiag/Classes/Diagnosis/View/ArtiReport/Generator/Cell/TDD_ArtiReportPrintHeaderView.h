//
//  ArtiReportPrintHeaderView.h
//  AD200
//
//  Created by lk_ios2023001 on 2023/5/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TDD_ArtiReportModel;


// 只用于A4纸打印

@interface TDD_ArtiReportPrintHeaderView : UIView

// 维修店
@property (nonatomic, strong) TDD_CustomLabel * maintainLabel;

// 报告编号
@property (nonatomic, strong) TDD_CustomLabel * serialLabel;

// 电话
@property (nonatomic, strong) TDD_CustomLabel * phoneLabel;

// 创建日期
@property (nonatomic, strong) TDD_CustomLabel * timeLabel;

// 地址
@property (nonatomic, strong) TDD_CustomLabel * addressLabel;

@property (nonatomic, strong) TDD_ArtiReportModel * reportModel;

/// 右上角 App Logo 图片
@property (nonatomic, strong, nullable) UIImage *appLogoImage;

@end

NS_ASSUME_NONNULL_END
