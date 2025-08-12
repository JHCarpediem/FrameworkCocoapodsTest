//
//  TDD_ArtiLiveDataSelectModel.m
//  AD200
//
//  Created by 何可人 on 2022/8/8.
//

#import "TDD_ArtiLiveDataSelectModel.h"

@implementation TDD_ArtiLiveDataSelectModel

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        NSArray * titleArr = @[@"live_data_cancel_all",@"app_confirm"];
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

- (void)setLiveDataModel:(TDD_ArtiLiveDataModel *)liveDataModel {
    _liveDataModel = liveDataModel;
//    self.isSelectAll = NO;
    
//    if (liveDataModel.selectItmes.count > 0) {
//
//        if (liveDataModel.selectItmes.count == liveDataModel.itemArr.count) {
//            self.isSelectAll = YES;
//        }else {
//            self.isSelectAll = NO;
//        }
//
//        self.selectItmes = [[NSMutableArray alloc] initWithArray:liveDataModel.selectItmes];
//    }else {
//        self.isSelectAll = NO;
//    }
}

- (void)updateShowLiveData {
    if ([NSString tdd_isEmpty:self.searchKey]) {
        
        self.showItems = [NSMutableArray arrayWithArray:self.liveDataModel.itemArr];
        
    } else {
        NSMutableArray *tempArr = [NSMutableArray array];
        [self.liveDataModel.itemArr  enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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

- (BOOL)ArtiButtonClick:(uint32_t)buttonID
{
    if (buttonID == 0) {
        //取消全选
        BOOL isSelectAll = self.isSelectAll;
        [self.showItems enumerateObjectsUsingBlock:^(TDD_ArtiLiveDataItemModel *obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {

            if (isSelectAll && [self.selectItmes containsObject:obj1]) {
                [self.selectItmes removeObject:obj1];
            } else if (!isSelectAll && ![self.selectItmes containsObject:obj1]) {
                [self.selectItmes addObject:obj1];
            }

        }];

        [self setEditBtnTitle];
        self.isReloadButton = YES;
        [self show];
    } else {
        //确定
        if (self.selectItmes.count == 0) {
            [TDD_HTipManage showBtnTipViewWithTitle:TDDLocalized.liveData_select_error buttonType:HTipBtnOneType block:^(NSInteger btnTag) {
                
            }];
            return NO;
        }
        
        self.liveDataModel.isShowOtherView = NO;
        
        NSArray *sortedArray = [self.selectItmes sortedArrayUsingComparator:^NSComparisonResult(TDD_ArtiLiveDataItemModel *  _Nonnull obj1, TDD_ArtiLiveDataItemModel *  _Nonnull obj2) {
            //升序，key表示比较的关键字
            if (obj1.index < obj2.index )
            {
                return NSOrderedAscending;
            }
            else
            {
                return NSOrderedDescending;
            }
        }];
        
        self.selectItmes = [[NSMutableArray alloc] initWithArray:sortedArray];
        
        self.liveDataModel.selectItmes = [[NSMutableArray alloc] initWithArray:self.selectItmes];
        self.liveDataModel.recordSelectItmes = [[NSMutableArray alloc] initWithArray:self.selectItmes];
                                
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self.liveDataModel userInfo:nil];
    }
    
    return NO;
}

- (BOOL)isSelectAll {
    __block BOOL isContain = NO;
    [self.showItems enumerateObjectsUsingBlock:^(TDD_ArtiLiveDataItemModel *obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
        
        isContain = [self.selectItmes containsObject:obj1];
        if (!isContain) {
            *stop1 = YES;
        }
    }];
    return isContain;
}

- (void)setEditBtnTitle {
    TDD_ArtiButtonModel * buttonModel = self.buttonArr.firstObject;
    if (!self.isSelectAll) {
        buttonModel.strButtonText = TDDLocalized.report_select_all;
    }else {
        buttonModel.strButtonText = TDDLocalized.live_data_cancel_all;
    }
}

- (uint32_t)show
{
    TDD_ArtiButtonModel * buttonModel = self.buttonArr.lastObject;
    
    buttonModel.strButtonText = [NSString stringWithFormat:@"%@(%d)", TDDLocalized.app_confirm, (int)self.selectItmes.count];
    
    self.isReloadButton = YES;
    
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
//        _selectItmes = [[NSMutableArray alloc] initWithArray:self.liveDataModel.selectItmes];
        _selectItmes = [NSMutableArray array];
    }

    return _selectItmes;
}

@end
