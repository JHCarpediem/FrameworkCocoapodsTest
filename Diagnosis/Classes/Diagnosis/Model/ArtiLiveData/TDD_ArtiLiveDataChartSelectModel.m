//
//  TDD_ArtiLiveDataChartSelectModel.m
//  AD200
//
//  Created by AppTD on 2022/9/15.
//

#import "TDD_ArtiLiveDataChartSelectModel.h"

@implementation TDD_ArtiLiveDataChartSelectModel
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        NSArray * titleArr = @[@"app_confirm"];
        for (int i = 0; i < titleArr.count; i ++) {
            TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
            
            buttonModel.uButtonId = i;
            
            buttonModel.strButtonText = [NSString stringWithFormat:@"%@", [TDD_HLanguage getLanguage:titleArr[i]]];
            
            buttonModel.bIsEnable = YES;
            
            [self.buttonArr addObject:buttonModel];
        }
    }
    
    return self;
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID
{
    if (self.selectItmes.count == 0) {
        [TDD_HTipManage showBtnTipViewWithTitle:TDDLocalized.liveData_select_error buttonType:HTipBtnOneType block:^(NSInteger btnTag) {
            
        }];
        return NO;
    }
    
    self.liveDataMoreChartModel.selectItmes = self.selectItmes;
    
    self.liveDataMoreChartModel.liveDataModel.chartItmes = self.selectItmes;
    
    [self backClick];
    
    return NO;
}

- (void)updateShowLiveData {
    if ([NSString tdd_isEmpty:self.searchKey]) {
        
        self.showItems  = [NSMutableArray arrayWithArray:self.liveDataMoreChartModel.liveDataModel.itemArr];
        
    } else {
        NSMutableArray *tempArr = [NSMutableArray array];
        [self.liveDataMoreChartModel.liveDataModel.itemArr  enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TDD_ArtiLiveDataItemModel *objModel;
            if ([obj isKindOfClass:[TDD_ArtiLiveDataItemModel class]]){
                objModel = obj;
            }else {
                objModel = [TDD_ArtiLiveDataItemModel yy_modelWithJSON:obj];
            }
            if ([objModel.strName.lowercaseString containsString:self.searchKey.lowercaseString]) {
                [tempArr addObject:objModel];
            }
        }];
        self.showItems = tempArr;
    }
    self.isReloadButton = YES;
}

- (uint32_t)show
{
    TDD_ArtiButtonModel * buttonModel = self.buttonArr.lastObject;
    
    buttonModel.strButtonText = [NSString stringWithFormat:@"%@(%d)", TDDLocalized.app_confirm, (int)self.selectItmes.count];
    
    if (self.selectItmes.count > 4) {
        buttonModel.uStatus = ArtiButtonStatus_DISABLE;
    }else {
        buttonModel.uStatus = ArtiButtonStatus_ENABLE;
    }
    
    self.isReloadButton = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self userInfo:nil];
    
    return 0;
}

- (void)backClick
{
    self.liveDataMoreChartModel.isShowOtherView = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self.liveDataMoreChartModel userInfo:nil];
}

- (NSMutableArray *)selectItmes
{
    if (!_selectItmes) {
        _selectItmes = [[NSMutableArray alloc] initWithArray:self.liveDataMoreChartModel.selectItmes];
    }

    return _selectItmes;
}

- (BOOL)isSearch {
    return ![NSString tdd_isEmpty:self.searchKey];
}

- (NSMutableArray *)showItems
{
    if (!_showItems) {
        _showItems = [[NSMutableArray alloc] initWithArray:self.liveDataMoreChartModel.liveDataModel.showItems];
    }
    return _showItems;
}
@end
