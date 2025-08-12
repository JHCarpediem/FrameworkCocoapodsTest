//
//  TDD_ArtiMsgBoxDsModel.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/27.
//

#import "TDD_ArtiMsgBoxDsModel.h"

@implementation TDD_ArtiMsgBoxDsModel
- (void)setSysName:(NSString *)sysName {
    if ([_sysName isEqualToString:sysName]) {
        return;
    }
    _sysName = sysName;
    
    self.translatedSysName = _sysName;
    _isSysNameTranslated = NO;
}

- (instancetype)init {
    if (self = [super init]) {
        
        NSArray * titleArr = @[TDDLocalized.generate_report,@"完成"];
        
        NSArray * statusArr = @[@(ArtiButtonStatus_ENABLE),@(ArtiButtonStatus_ENABLE)];
        
        NSArray * IDArr = @[@(DF_ID_REPORT),@(DF_ID_OK)];
        self.strTitle = @"动态校准";
        for (int i = 0; i < titleArr.count; i ++) {
            TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
            
            buttonModel.uButtonId = [IDArr[i] intValue];
            
            buttonModel.strButtonText = titleArr[i];
            
            buttonModel.uStatus = (ArtiButtonStatus)[statusArr[i] intValue];
            
            buttonModel.bIsEnable = YES;
            
            [self.buttonArr addObject:buttonModel];
        }
        self.isReloadButton = YES;
    }
    return self;
}

//- (void)machineTranslation
//{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        if (self.sysName.length>0 && !self.isSysNameTranslated) {
//            [self.translatedDic setValue:@"" forKey:self.sysName];
//        }
//        for (TDD_ArtiLiveDataItemModel * model in self.liveDataItems) {
//            if (model.strName.length > 0 && !model.isStrNameTranslated) {
//                [self.translatedDic setValue:@"" forKey:model.strName];
//            }
//        }
//        
//        [super machineTranslation];
//    });
//    
//}
//
//#pragma mark 翻译完成
//- (void)translationCompleted
//{
//    if ([self.translatedDic.allKeys containsObject:self.sysName]) {
//        if ([self.translatedDic[self.sysName] length] > 0) {
//            self.translatedSysName = self.translatedDic[self.sysName];
//            self.isSysNameTranslated = YES;
//        }
//    }
//    for (TDD_ArtiLiveDataItemModel * model in self.liveDataItems) {
//        if ([self.translatedDic.allKeys containsObject:model.strName]) {
//            if ([self.translatedDic[model.strName] length] > 0) {
//                model.strTranslatedName = self.translatedDic[model.strName];
//                model.isStrNameTranslated = YES;
//            }
//        }
//    }
//    
//    [super translationCompleted];
//}
@end
