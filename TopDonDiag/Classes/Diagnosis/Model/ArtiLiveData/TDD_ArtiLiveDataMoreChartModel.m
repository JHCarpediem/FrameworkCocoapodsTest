//
//  TDD_ArtiLiveDataMoreChartModel.m
//  AD200
//
//  Created by AppTD on 2022/9/8.
//

#import "TDD_ArtiLiveDataMoreChartModel.h"
#import "TDD_ArtiLiveDataChartSelectModel.h"

@implementation TDD_ArtiLiveDataMoreChartModel

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        NSArray * titleArr = @[@"liveData_chart_more"];
        for (int i = 0; i < titleArr.count; i ++) {
            TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
            
            buttonModel.uButtonId = i;
            
            buttonModel.strButtonText = [TDD_HLanguage getLanguage:titleArr[i]];
            
            buttonModel.bIsEnable = YES;
            
            [self.buttonArr addObject:buttonModel];
        }
    }
    
    return self;
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID
{
    self.isShowOtherView = YES;
    
    TDD_ArtiLiveDataChartSelectModel * selectModel = [[TDD_ArtiLiveDataChartSelectModel alloc] init];
    selectModel.strTitle = TDDLocalized.live_data_add;
    selectModel.liveDataMoreChartModel = self;
    [selectModel show];
    return NO;
}

- (uint32_t)show
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self userInfo:nil];
    
    return 0;
}

- (void)backClick
{
    self.liveDataModel.isShowOtherView = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self.liveDataModel userInfo:nil];
}

- (NSMutableArray *)selectItmes
{
    if (!_selectItmes) {
        _selectItmes = [[NSMutableArray alloc] initWithArray:self.liveDataModel.selectItmes];
    }

    return _selectItmes;
}
@end
