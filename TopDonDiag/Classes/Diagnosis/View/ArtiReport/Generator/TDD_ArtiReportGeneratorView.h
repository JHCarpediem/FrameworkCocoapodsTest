//
//  TDD_ArtiReportGeneratorView.h
//  AD200
//
//  Created by lecason on 2022/8/8.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiContentBaseView.h"
#import "TDD_ArtiReportModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportGeneratorView : TDD_ArtiContentBaseView

@property (nonatomic, strong) TDD_ArtiReportModel * reportModel;

@end

NS_ASSUME_NONNULL_END
