//
//  TDD_ArtiReportGeneratorCellModel.h
//  AD200
//
//  Created by lecason on 2022/8/9.
//

#import <Foundation/Foundation.h>
#import "TDD_ArtiReportCellModel.h"
#import "TopdonDiagnosis/TopdonDiagnosis-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportGeneratorCellModel : TDD_ArtiReportCellModel

/// 输入框标题
@property (nonatomic, copy) NSString *inputTitleName;
/// 输入框值
@property (nonatomic, copy) NSString *inputValue;
/// 头部标题
@property (nonatomic, copy) NSString *sectionTitleName;
/// 内容文字
@property (nonatomic, copy) NSString *text;

// MARK: - ADAS
@property (nonatomic, strong) TDD_ArtiADASReportTireUnit *tirePressure;
@property (nonatomic, strong) TDD_ArtiADASReportTireUnit *wheelEyebrow;

@end

NS_ASSUME_NONNULL_END
