//
//  TDD_ArtiPopupModel.m
//  TopDonDiag
//
//  Created by fench on 2023/8/29.
//

#import "TDD_ArtiPopupModel.h"

#if useCarsFramework
#import <CarsFramework/RegPopup.hpp>
#else
#import "RegPopup.hpp"
#endif

#import "TDD_CTools.h"
#import "TDD_DiagnosisViewController.h"

@implementation TDD_ArtiPopupModel

+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegPopup::Construct(ArtiPopupConstruct);
    CRegPopup::Destruct(ArtiPopupDestruct);
    CRegPopup::InitTitle(ArtiPopupInitTitle);
    CRegPopup::AddItemVec(ArtiPopupAddItem);
    CRegPopup::SetTitle(ArtiPopupSetTitle);
    CRegPopup::SetContent(ArtiPopupSetContent);
    CRegPopup::SetPopDirection(ArtiPopupSetPopDirection);
    CRegPopup::AddButton(ArtiPopupAddButton);
    CRegPopup::SetButtonText(ArtiPopupSetButtonText);
    CRegPopup::SetColWidth(ArtiPopupSetColWidth);
    CRegPopup::Show(ArtiPopupShow);
}

void ArtiPopupConstruct(uint32_t ID)
{
    [TDD_ArtiPopupModel Construct:ID];
}

void ArtiPopupDestruct(uint32_t ID)
{
    [TDD_ArtiPopupModel Destruct:ID];
}

bool ArtiPopupInitTitle(uint32_t ID, const std::string& strTitle, uint32_t uPopupType)
{
    return [TDD_ArtiPopupModel initTitle:ID withTitle:[TDD_CTools CStrToNSString:strTitle] uPopupType:uPopupType];
}

void ArtiPopupAddItem(uint32_t ID, const std::vector<std::string>& fnAddItem)
{
    [TDD_ArtiPopupModel addItems:ID withContent:[TDD_CTools CVectorToStringNSArray:fnAddItem]];
}

void ArtiPopupSetContent(uint32_t ID, const std::string& strContent)
{
    [TDD_ArtiPopupModel setContent:ID withContent:[TDD_CTools CStrToNSString:strContent]];
}

void ArtiPopupSetTitle(uint32_t ID, const std::string& strSetTitle)
{
    [TDD_ArtiPopupModel setTitle:ID withTitle:[TDD_CTools CStrToNSString:strSetTitle]];
}

void ArtiPopupSetPopDirection(uint32_t ID, uint32_t uDirection)
{
    [TDD_ArtiPopupModel setPopupType:ID forType:(int)uDirection];
}

uint32_t ArtiPopupAddButton(uint32_t ID, const std::string& strButtonText)
{
    return (uint32_t)[TDD_ArtiPopupModel addButton:ID withTitle:[TDD_CTools CStrToNSString:strButtonText]];
}

void ArtiPopupSetButtonText(uint32_t ID, uint16_t uIndex, const std::string& strButtonText)
{
    [TDD_ArtiPopupModel setButtonTitle:ID forIndex:(int)uIndex withTitle:[TDD_CTools CStrToNSString:strButtonText]];
}

void ArtiPopupSetColWidth(uint32_t ID, const std::vector<uint32_t>& vctColWidth)
{
    
}

uint32_t ArtiPopupShow(uint32_t ID)
{
    return [TDD_ArtiPopupModel ShowWithId:ID];
}

+ (void)Construct:(uint32_t)ID
{
    [super Construct:ID];
    
//    TDD_ArtiPopupModel * model = (TDD_ArtiPopupModel *)[self getModelWithID:ID];
//
//    NSArray * titleArr = @[@"app_report",@"diagnosis_remove_code"];
//
//    NSArray * statusArr = @[@(ArtiButtonStatus_ENABLE),@(ArtiButtonStatus_UNVISIBLE)];
//
//    NSArray * IDArr = @[@(DF_ID_TROUBLE_REPORT),@(DF_ID_CLEAR_DTC)];
//
//    for (int i = 0; i < titleArr.count; i ++) {
//        TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
//
//        buttonModel.uButtonId = [IDArr[i] intValue];
//
//        buttonModel.strButtonText = titleArr[i];
//
//        buttonModel.uStatus = (ArtiButtonStatus)[statusArr[i] intValue];
//
//        buttonModel.bIsEnable = YES;
//
//        [model.buttonArr addObject:buttonModel];
//    }
}

+ (bool)initTitle:(uint32_t)ID withTitle:(NSString *)strTitle uPopupType:(int)uPopupType
{
    HLog(@"%@ - 初始化菜单显示控件，同时设置标题文本 - ID:%d - 标题 ：%@", [self class], ID, strTitle);
    
    [self Destruct:ID];
    
    TDD_ArtiPopupModel * model = (TDD_ArtiPopupModel *)[self getModelWithID:ID];
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiPopupModel *)[self getModelWithID:ID];
    }
    
    model.strTitle = strTitle;
    model.popupType = uPopupType;
    
    if ([model.strTitle isEqualToString:strTitle]) {
        return YES;
    }else{
        return NO;
    }
}

+ (void)setTitle:(uint32_t)ID withTitle:(NSString *)title
{
    HLog(@"%@ 设置标题: - ID:%d - title:%@", [self class], ID, title);
    TDD_ArtiPopupModel * model = (TDD_ArtiPopupModel *)[self getModelWithID:ID];
    model.title = title;
}

+ (void)setContent:(uint32_t)ID withContent:(NSString *)content
{
    HLog(@"%@ 设置内容: - ID:%d - content:%@", [self class], ID, content);
    TDD_ArtiPopupModel * model = (TDD_ArtiPopupModel *)[self getModelWithID:ID];
    model.content = content;
}

+ (void)addItems:(uint32_t)ID withContent:(NSArray *)items
{
    
    // 小车探 专属写法。 其他项目需要注意
    TDD_ArtiPopupModel * model = (TDD_ArtiPopupModel *)[self getModelWithID:ID];
    TDD_ArtiPopupItemModel *itemModel = [TDD_ArtiPopupItemModel new];
    
    itemModel.status = @"";
    itemModel.code = @"";
    itemModel.content = @"";
    
    if (items.count > 2) {
        itemModel.status = items[2];
    }
    if (items.count > 1) {
        itemModel.content = items[1];
    }
    if (items.count > 0) {
        itemModel.code = items[0];
    }
    if (!model.items) {
        model.items = [NSMutableArray array];
    }
    
    HLog(@"%@ 添加Items: - ID:%d - items:[code:%@, 描述：%@, 状态: %@, array: %@]", [self class], ID, itemModel.code, itemModel.content, itemModel.status, items);
    [model.items addObject:itemModel];
}

+ (NSInteger)addButton:(uint32_t)ID withTitle:(NSString *)title
{
    HLog(@"%@ 添加按钮: - ID:%d - title:%@", [self class], ID, title);
    TDD_ArtiPopupModel * model = (TDD_ArtiPopupModel *)[self getModelWithID:ID];
    if (!model.btnTitleArray) {
        model.btnTitleArray = [NSMutableArray array];
    }
    
    [model.btnTitleArray addObject:title];
    return model.btnTitleArray.count - 1;
}

+ (void)setButtonTitle:(uint32_t)ID forIndex:(int)index withTitle:(NSString *)title
{
    HLog(@"%@ 添加按钮: - ID:%d - title:%@", [self class], ID, title);
    TDD_ArtiPopupModel * model = (TDD_ArtiPopupModel *)[self getModelWithID:ID];
    
    if (!model.btnTitleArray) {
        model.btnTitleArray = [NSMutableArray array];
    }
    
    if (model.btnTitleArray.count > index) {
        [model.btnTitleArray replaceObjectAtIndex:index withObject:title];
    } else {
        [model.btnTitleArray addObject:title];
    }
}

+ (void)setPopupType:(uint32_t)ID forType:(int)type
{
    HLog(@"%@ setPopupType: - ID:%d - title:%d", [self class], ID, type);
    TDD_ArtiPopupModel * model = (TDD_ArtiPopupModel *)[self getModelWithID:ID];
    
    model.popupType = type;
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID {
    if (buttonID == DF_ID_REPORT){
        //报告
        NSString *referrer = @"EngineInspection";
        if ([[UIViewController tdd_topViewController] isKindOfClass:[TDD_DiagnosisViewController class]]) {
            referrer = @"AutoScan";
        }
        [TDD_Statistics event:Event_ClickReport attributes:@{@"Reportreferrer":referrer}];
    }
    return YES;
}

#pragma mark 机器翻译 -- 后期有卡顿的话需要优化
- (void)machineTranslation
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (TDD_ArtiPopupItemModel * model in self.items) {
            if (model.content.length > 0 && !model.isStrContentTranslated) {
                [self.translatedDic setValue:@"" forKey:model.content];
            }
            if (model.status.length > 0 && !model.isStrStatusTranslated) {
                [self.translatedDic setValue:@"" forKey:model.status];
            }
        }
        
        [super machineTranslation];
    });
    
}

#pragma mark 翻译完成
- (void)translationCompleted
{
    for (TDD_ArtiPopupItemModel * model in self.items) {
        if ([self.translatedDic.allKeys containsObject:model.content]) {
            if ([self.translatedDic[model.content] length] > 0) {
                model.strTranslatedContent = self.translatedDic[model.content];
                model.isStrContentTranslated = YES;
            }
        }
        
        if ([self.translatedDic.allKeys containsObject:model.status]) {
            if ([self.translatedDic[model.status] length] > 0) {
                model.strTranslatedStatus = self.translatedDic[model.status];
                model.isStrStatusTranslated = YES;
            }
        }
    }
    
    [super translationCompleted];
}

@end


@implementation TDD_ArtiPopupItemModel
- (void)setContent:(NSString *)content {
    if ([_content isEqualToString:content]) {
        return;
    }
    _content = content;
    self.strTranslatedContent = _content;
    self.isStrContentTranslated = NO;
}

- (void)setStatus:(NSString *)status {
    if ([_status isEqualToString:status]) {
        return;
    }
    _status = status;
    self.strTranslatedStatus = _status;
    self.isStrStatusTranslated = NO;
}

@end
