//
//  TDD_ArtiADASReportGeneratorView.h
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/11.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiContentBaseView.h"

@class TDD_ArtiReportModel;

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiADASReportGeneratorView : TDD_ArtiContentBaseView

@property (nonatomic, strong) TDD_ArtiReportModel * reportModel;
@property (nonatomic, weak) UIViewController * owningViewController;

@end

NS_ASSUME_NONNULL_END
