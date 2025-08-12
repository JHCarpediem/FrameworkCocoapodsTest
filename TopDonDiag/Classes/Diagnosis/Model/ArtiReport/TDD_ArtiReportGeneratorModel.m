//
//  TDD_ArtiReportGeneratorModel.m
//  AD200
//
//  Created by lecason on 2022/8/8.
//

#import "TDD_ArtiReportGeneratorModel.h"
#import "TDD_ArtiReportFlowSectionTableViewCell.h"
@interface TDD_ArtiReportGeneratorModel()<TDD_HTipBtnViewDelegate>
@end
@implementation TDD_ArtiReportGeneratorModel 

- (instancetype)init
{
    if (self == [super init]) {
        NSArray * titleArr = @[@"app_confirm"];
        for (int i = 0; i < titleArr.count; i ++) {
            TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
            
            buttonModel.uButtonId = i;
            
            buttonModel.strButtonText = [TDD_HLanguage getLanguage:titleArr[i]];
            
            buttonModel.bIsEnable = YES;
            if ([TDD_DiagnosisTools isDebug]) {
                buttonModel.uiTextIdentify = @"diagReportConfirmButton";
                
            }
            [self.buttonArr addObject:buttonModel];
        }
    }
    
    return self;
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID
{
    if (buttonID == 0) {
        
//        if (self.reportModel.inputVIN == nil || [self.reportModel.inputVIN isEqualToString:@""] || self.reportModel.describe_mileage == nil || [self.reportModel.describe_mileage isEqualToString:@""]) {
//            [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.request_vin_and_mileage];
//            return NO;
//        }
        
        [self.reportModel updateRepairHistory];
        
        // 需要先更新完历史数据后再获取 JSON 才是正确的。

        [TDD_HTipManage showLoadingView];
        
        NSDictionary *json = [self.reportModel jsonDictionary];
 
        NSLog(@"JSON -> %@", json);
        if ([self.delegate respondsToSelector:@selector(ArtiUploadDiagReport:param:completeHandle:)]){
            [self.delegate ArtiUploadDiagReport:self.reportModel param:json completeHandle:^(id  _Nonnull result) {
                if ([result isKindOfClass:[NSString class]]) {
                    self.reportModel.reportUrl = result;
                }
            }];
        }
        [self.reportModel conditionSignal];
    }
    
    return NO;
}

- (uint32_t)show
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self userInfo:nil];
    });
    return 0;
}

@end
