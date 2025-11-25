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
        NSArray * titleArr = @[TDDLocalized.app_cancel, TDDLocalized.app_confirm];
        for (int i = 0; i < titleArr.count; i ++) {
            TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
            buttonModel.uButtonId = i;
            buttonModel.strButtonText = titleArr[i];
            buttonModel.bIsEnable = YES;
            if ([TDD_DiagnosisTools isDebug] && [titleArr[i] isEqualToString:TDDLocalized.app_confirm]) {
                buttonModel.uiTextIdentify = @"diagReportConfirmButton";
            }
            [self.buttonArr addObject:buttonModel];
        }
    }
    
    return self;
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID {
    if (buttonID == 0) {
        [self backClick];
    } else if (buttonID == 1) {
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
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            uint32_t returnId = [self.reportModel reportShow];
            if (returnId == DF_ID_BACK) {
                [self backClick];
            } else if (returnId == 0) {
                NSLog(@"cancel");
                [self cancelClick];
            }
        });
        
    }
    return NO;
}

#pragma mark 点击取消按钮
- (void)cancelClick {
    self.returnID = 0;
    
    if (self.isLock) {
        [self conditionSignal];
    }
}

@end
