//
//  TDD_ArtiMsgBoxGroupModel.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/16.
//

#import "TDD_ArtiMsgBoxGroupModel.h"
@implementation TDD_ArtiMsgBoxGroupItemModel
- (void)setTitle:(NSString *)title
{
    if ([_title isEqualToString:title]) {
        return;
    }
    
    _title = title;
    
    self.translatedTitle = _title;
    
    self.isTitleTranslated = NO;
}

- (void)setContent:(NSString *)content
{
    if ([_content isEqualToString:content]) {
        return;
    }
    
    _content = content;
    
    self.translatedContent = _content;
    
    self.isContentTranslated = NO;
}
@end
@implementation TDD_ArtiMsgBoxGroupModel
- (instancetype)init {
    if (self = [super init]) {
        
        NSArray * titleArr = @[TDDLocalized.app_cancel,TDDLocalized.app_confirm];
        
        NSArray * statusArr = @[@(ArtiButtonStatus_ENABLE),@(ArtiButtonStatus_ENABLE)];
        
        NSArray * IDArr = @[@(DF_ID_CANCEL),@(DF_ID_OK)];
        
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

- (BOOL)ArtiButtonClick:(uint32_t)buttonID {

    return YES;
}

#pragma mark 机器翻译 -- 后期有卡顿的话需要优化
- (void)machineTranslation
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (TDD_ArtiMsgBoxGroupItemModel * model in self.itemArr) {
            if (model.title.length > 0 && !model.isTitleTranslated) {
                [self.translatedDic setValue:@"" forKey:model.title];
            }
            if (model.content.length > 0 && !model.isContentTranslated) {
                [self.translatedDic setValue:@"" forKey:model.content];
            }
        }
        
        [super machineTranslation];
    });
    
}

#pragma mark 翻译完成
- (void)translationCompleted
{
    for (TDD_ArtiMsgBoxGroupItemModel * model in self.itemArr) {
        if ([self.translatedDic.allKeys containsObject:model.title]) {
            if ([self.translatedDic[model.title] length] > 0) {
                model.translatedTitle = self.translatedDic[model.title];
                model.isTitleTranslated = YES;
            }
        }
        if ([self.translatedDic.allKeys containsObject:model.content]) {
            if ([self.translatedDic[model.content] length] > 0) {
                model.translatedContent = self.translatedDic[model.content];
                model.isContentTranslated = YES;
            }
        }
    }
    
    [super translationCompleted];
}
@end
