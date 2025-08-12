//
//  TDHistToryDiagModel.m
//  AD200
//
//  Created by yong liu on 2023/9/20.
//

#import "TDD_HistoryDiagModel.h"


@implementation TDD_HistoryDtcNodeExModel



@end

@implementation TDD_HistoryDtcItemModel
+ (NSDictionary *)objectClassInArray{

    return @{@"vctNodeArr" : [TDD_HistoryDtcNodeExModel class]};

}


@end

@implementation TDD_HistoryDiagModel

/// 没有设置报告名称，默认用品牌/型号/年款
- (NSString *)reportName {
    NSString *reportName = _reportName;
    if ([NSString tdd_isEmpty:reportName]) {
        reportName = self.brandName;
        if (![NSString tdd_isEmpty:self.modelName]) {
            reportName = [NSString stringWithFormat:@"%@/%@", reportName, self.modelName];
        }
        if (![NSString tdd_isEmpty:self.carYear]) {
            if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
                NSArray *arr = [self.carYear componentsSeparatedByString:@"/"];
                if (arr.count > 0) {
                    NSString *year = [arr firstObject];
                    reportName = [NSString stringWithFormat:@"%@/%@", reportName, year];
                }
            }else {
                reportName = [NSString stringWithFormat:@"%@/%@", reportName, self.carYear];
            }
            
        }
    }
    return reportName;
}

- (NSString *)exchangeReportName {
    NSString *reportName = self.brandName;
    if (![NSString tdd_isEmpty:self.modelName]) {
        reportName = [NSString stringWithFormat:@"%@/%@", reportName, self.modelName];
    }
    if (![NSString tdd_isEmpty:self.carYear]) {
        NSArray *arr = [self.carYear componentsSeparatedByString:@"/"];
        if (arr.count > 0) {
            NSString *year = [arr firstObject];
            reportName = [NSString stringWithFormat:@"%@/%@", reportName, year];
        }
    }
    
    return  reportName;
}

@end
