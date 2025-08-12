//
//  TDD_ArtiInputModel.m
//  AD200
//
//  Created by 何可人 on 2022/5/10.
//

#import "TDD_ArtiInputModel.h"
#import "TDD_ArtiInputSaveModel.h"

#if useCarsFramework
#import <CarsFramework/RegInput.hpp>
#else
#import "RegInput.hpp"
#endif

#import "TDD_CTools.h"

@implementation TDD_ArtiInputModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegInput::Construct(ArtiInputConstruct);
    CRegInput::Destruct(ArtiInputDestruct);
    CRegInput::InitOneInputBox(ArtiInputInitOneInputBox);
    CRegInput::GetOneInputBox(ArtiInputGetOneInputBox);
    CRegInput::AddButton(ArtiInputAddButton);
    CRegInput::InitManyInputBox(ArtiInputInitManyInputBox);
    CRegInput::GetManyInputBox(ArtiInputGetManyInputBox);
    CRegInput::InitOneComboBox(ArtiInputInitOneComboBox);
    CRegInput::GetOneComboBox(ArtiInputGetOneComboBox);
    CRegInput::InitManyComboBox(ArtiInputInitManyComboBox);
    CRegInput::GetManyComboBox(ArtiInputGetManyComboBox);
    CRegInput::GetManyComboBoxNum(ArtiInputGetManyComboBoxNum);
    CRegInput::InitMixedInputComboBox(ArtiInputInitMixedInputComboBox);
    CRegInput::GetMixedInputComboBox(ArtiInputGetMixedInputComboBox);
    CRegInput::GetMixedComboBoxNum(ArtiInputGetMixedComboBoxNum);
    CRegInput::Show(ArtiInputShow);
    
    // 大众 SFD 解锁
    CRegInput::SetVisibleButtonQR(ArtiInputSetVisibleButtonQR);
    CRegInput::SetVisibleButtonQREx(ArtiInputSetVisibleButtonQREx);
}

// 是否显示二维码
uint32_t ArtiInputSetVisibleButtonQR(uint32_t id, bool bVisible)
{
    return [TDD_ArtiInputModel SetVisibleButtonQRWithId:id bVisible:bVisible];
}

// 是否显示二维码和粘贴
uint32_t ArtiInputSetVisibleButtonQREx(uint32_t id, bool bScanVisible, bool bPasteVisible)
{
    return [TDD_ArtiInputModel SetVisibleButtonQRExWithId:id bScanVisible:bScanVisible bPasteVisible:bPasteVisible];
}

void ArtiInputConstruct(uint32_t id)
{
    [TDD_ArtiInputModel Construct:id];
}

void ArtiInputDestruct(uint32_t id)
{
    [TDD_ArtiInputModel Destruct:id];
}

bool ArtiInputInitOneInputBox(uint32_t id, const std::string& strTitle, const std::string& strContent, const std::string& strMask, const std::string& strDefault = "")
{
    return [TDD_ArtiInputModel InitOneInputBoxWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle] strTips:[TDD_CTools CStrToNSString:strContent] strMask:[TDD_CTools CStrToNSString:strMask] strDefault:[TDD_CTools CStrToNSString:strDefault]];
}

std::string const ArtiInputGetOneInputBox(uint32_t id)
{
    NSString * resultStr = [TDD_ArtiInputModel GetOneInputBoxWithId:id];
    
    return [TDD_CTools NSStringToCStr:resultStr];
}

void ArtiInputAddButton(uint32_t id, const std::string& strButtonText)
{
    [TDD_ArtiInputModel AddButtonWithId:id strButtonText:[TDD_CTools CStrToNSString:strButtonText]];
}

bool ArtiInputInitManyInputBox(uint32_t id, const std::string& strTitle, const std::vector<std::string>& vctContents, const std::vector<std::string>& vctMasks, const std::vector<std::string>& vctDefaults)
{
    return [TDD_ArtiInputModel InitManyInputBoxWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle] vctTips:[TDD_CTools CVectorToStringNSArray:vctContents] vctMasks:[TDD_CTools CVectorToStringNSArray:vctMasks] vctDefaults:[TDD_CTools CVectorToStringNSArray:vctDefaults]];
}

std::vector<std::string> ArtiInputGetManyInputBox(uint32_t id)
{
    NSArray * arr = [TDD_ArtiInputModel GetManyInputBoxWithId:id];
    
    return [TDD_CTools NSArrayToStringCVector:arr];
}

bool ArtiInputInitOneComboBox(uint32_t id, const std::string& strTitle, const std::string& strTips, const std::vector<std::string>& vctValue, const std::string& strDefault)
{
    return [TDD_ArtiInputModel InitOneComboBoxWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle] strTips:[TDD_CTools CStrToNSString:strTips] vctValue:[TDD_CTools CVectorToStringNSArray:vctValue] strDefault:[TDD_CTools CStrToNSString:strDefault]];
}

std::string const ArtiInputGetOneComboBox(uint32_t id)
{
    NSString * resultStr = [TDD_ArtiInputModel GetOneComboBoxWithId:id];
    
    return [TDD_CTools NSStringToCStr:resultStr];
}

bool ArtiInputInitManyComboBox(uint32_t id, const std::string& strTitle, const std::vector<std::string>& vctTips, const std::vector<std::vector<std::string>>& vctValue, const std::vector<std::string>& vctDefault)
{
    NSMutableArray *nsArray = [NSMutableArray array];
    
    for (int j = 0; j < vctValue.size(); j++) {
        
        [nsArray addObject:[TDD_CTools CVectorToStringNSArray:vctValue[j]]];
    }
    
    return [TDD_ArtiInputModel InitManyComboBoxWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle] vctTips:[TDD_CTools CVectorToStringNSArray:vctTips] vctValue:nsArray vctDefaults:[TDD_CTools CVectorToStringNSArray:vctDefault]];
}

std::vector<std::string> ArtiInputGetManyComboBox(uint32_t id)
{
    NSArray * arr = [TDD_ArtiInputModel GetManyInputBoxWithId:id];
    
    return [TDD_CTools NSArrayToStringCVector:arr];
}

std::vector<uint16_t> ArtiInputGetManyComboBoxNum(uint32_t id)
{
    NSArray * arr = [TDD_ArtiInputModel GetManyComboBoxNumWithId:id];
    
    return [TDD_CTools NSArrayToInt16CVector:arr];
}

bool ArtiInputInitMixedInputComboBox(uint32_t id, const std::string& strTitle,
                                                                    const std::vector<std::string>& vctTips,
                                                                    const std::vector<std::string>& vctMasks,
                                                                    const std::vector<std::string>& vctDefaults,
                                                                    const std::vector<std::vector<std::string>>& vctComboValues,
                                                                    const std::vector<std::string>& vctComboDefaults,
                                                                    const std::vector<uint32_t>& vctOrder)
{
    NSMutableArray *nsArray = [NSMutableArray array];
    
    for (int j = 0; j < vctComboValues.size(); j++) {
        
        [nsArray addObject:[TDD_CTools CVectorToStringNSArray:vctComboValues[j]]];
    }
    NSMutableArray *typeArray = [NSMutableArray array];
    
    for (int j = 0; j < vctOrder.size(); j++) {
        
        [typeArray addObject:@(vctOrder[j])];
    }

    return [TDD_ArtiInputModel InitMixedInputComboBoxWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle] vctTips:[TDD_CTools CVectorToStringNSArray:vctTips] vctMasks:[TDD_CTools CVectorToStringNSArray:vctMasks] vctDefaults:[TDD_CTools CVectorToStringNSArray:vctDefaults] vctComboValues:nsArray vctComboDefaults:[TDD_CTools CVectorToStringNSArray:vctComboDefaults] vctOrders:typeArray];
}

std::vector<std::string> ArtiInputGetMixedInputComboBox(uint32_t id)
{
    NSArray * arr = [TDD_ArtiInputModel GetMixedInputComboBoxWithId:id];
    
    return [TDD_CTools NSArrayToStringCVector:arr];
}

std::vector<uint16_t> ArtiInputGetMixedComboBoxNum(uint32_t id)
{
    NSArray * arr = [TDD_ArtiInputModel GetMixedComboBoxNumWithId:id];
    
    return [TDD_CTools NSArrayToInt16CVector:arr];
}

uint32_t ArtiInputShow(uint32_t id)
{
    return [TDD_ArtiInputModel ShowWithId:id];
}


#pragma mark 创建对象
///创建对象
+ (void)Construct:(uint32_t)ID{
    [super Construct:ID];
    
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    NSArray * titleArr = @[@"app_confirm",@"app_cancel"];
    NSArray * IDArr = @[@(DF_ID_YES),@(DF_ID_CANCEL)];
    
    for (int i = 0; i < 2; i ++) {
        TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
        buttonModel.uButtonId = [IDArr[i] intValue];
        buttonModel.strButtonText = [TDD_HLanguage getLanguage:titleArr[i]];
        buttonModel.bIsEnable = YES;
        [model.buttonArr addObject:buttonModel];
    }
    
    /// 自定义按钮
    TDD_ArtiButtonModel * pasteButtonModel = [[TDD_ArtiButtonModel alloc] init];
    pasteButtonModel.uButtonId = [@(DF_ID_PASTE) intValue];
    pasteButtonModel.strButtonText = TDDLocalized.paste_text;
    pasteButtonModel.bIsEnable = YES;
    pasteButtonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
    [model.customButtonArr addObject:pasteButtonModel];
    
    TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
    buttonModel.uButtonId = [@(DF_ID_QR) intValue];
    buttonModel.strButtonText = TDDLocalized.diagnostic_button_scan;
    buttonModel.bIsEnable = YES;
    buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
    [model.customButtonArr addObject:buttonModel];

    model.isReloadButton = YES;
    
}

/**********************************************************
*    功  能：初始化单输入框控件
*    参  数：strTitle 标题文本
*            strTips 提示文本
*            strMask 输入掩码
*            strDefault 默认值
*    返回值：true 初始化成功 false 初始化失败
**********************************************************/
+ (BOOL)InitOneInputBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle strTips:(NSString *)strTips strMask:(NSString *)strMask strDefault:(NSString *)strDefault
{
    HLog(@"%@ - 初始化单输入框控件 - ID:%d - strTitle ：%@, strTips:%@, strMask:%@, strDefault:%@", [self class], ID, strTitle, strTips, strMask, strDefault);
    
    [self Destruct:ID];
    
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    }
    
    model.strTitle = strTitle;
    
    ArtiInputItemModel * itemModel = [[ArtiInputItemModel alloc] init];
    
    itemModel.strTips = strTips;
    
    itemModel.strMask = strMask;
    
    itemModel.strDefault = strDefault;
    
    if (model.strTitle.length > 0) {
        if (![model.strTitle isEqualToString:strTitle]) {
            return NO;
        }
    }
    
    if (itemModel.strTips.length > 0) {
        if (![itemModel.strTips isEqualToString:strTips]) {
            return NO;
        }
    }
    
    if (itemModel.strMask.length > 0) {
        if (![itemModel.strMask isEqualToString:strMask]) {
            return NO;
        }
    }
    
    if (itemModel.strDefault.length > 0) {
        if (![itemModel.strDefault isEqualToString:strDefault]) {
            return NO;
        }
    }

    [model.itemArr addObject:itemModel];
    
    return YES;
    
}


/**********************************************************
*    功  能：获取单输入框的内容
*    参  数：无
*    返回值：string 输入框输入的值
**********************************************************/
+ (NSString *)GetOneInputBoxWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取单输入框的内容 - ID:%d", [self class], ID);
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    if (model.itemArr.count == 0) {
        HLog(@"没有item");
        return @"";
    }
    
    ArtiInputItemModel * itemModel = model.itemArr.firstObject;
    
    NSString * str = itemModel.strText;
    if (!str) {
        str = @"";
    }
    return str;
}

/**********************************************************
*    功  能：添加按钮
*    参  数：strButtonText 按钮文本
*    返回值：无
**********************************************************/
+ (void)AddButtonWithId:(uint32_t)ID strButtonText:(NSString *)strButtonText
{
    HLog(@"%@ - 添加按钮 - ID:%d - strButtonText:%@", [self class], ID, strButtonText);
    
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
    
    buttonModel.uButtonId = DF_ID_FREEBTN_0 + (uint32_t)model.buttonArr.count - 2;
    
    buttonModel.strButtonText = strButtonText;
    
    buttonModel.bIsEnable = YES;
    
    [model.buttonArr addObject:buttonModel];
    
    model.isReloadButton = YES;
}

/**********************************************************
*    功  能：初始化多输入框控件
*    参  数：strTitle 标题文本
*            vctTips 输入框对应的提示文本集合，一一对应
*            vctMasks 输入框对应的输入掩码，一一对应
*            vctDefaults 输入框对应的默认值，一一对应
*    返回值：无
**********************************************************/
+ (BOOL)InitManyInputBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle vctTips:(NSArray<NSString *> *)vctTips vctMasks:(NSArray<NSString *> *)vctMasks vctDefaults:(NSArray<NSString *> *)vctDefaults
{
    HLog(@"%@ - 初始化多输入框控件 - ID:%d - strTitle ：%@, vctTips:%@, vctMasks:%@, vctDefaults:%@", [self class], ID, strTitle, vctTips, vctMasks, vctDefaults);
 
    [self Destruct:ID];
    
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    }
    
    model.strTitle = strTitle;
    
    for (int i = 0; i < vctTips.count; i ++) {
        ArtiInputItemModel * itemModel = [[ArtiInputItemModel alloc] init];
        
        if (i < vctTips.count) {
            itemModel.strTips = vctTips[i];
        }
        
        if (i < vctMasks.count) {
            itemModel.strMask = vctMasks[i];
        }
        
        if (i < vctDefaults.count) {
            itemModel.strDefault = vctDefaults[i];
        }
        
        [model.itemArr addObject:itemModel];
    }
    
    return YES;
}

/**********************************************************
*    功  能：获取多输入框的返回值
*    参  数：无
*    返回值：vector<string> 多输入框输入值的集合
**********************************************************/
+ (NSArray<NSString *> *)GetManyInputBoxWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取多输入框的返回值 - ID:%d", [self class], ID);
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    if (model.itemArr.count == 0) {
        HLog(@"没有item");
        return @[];
    }
    
    NSMutableArray * returnArr = [[NSMutableArray alloc] init];
    
    for (ArtiInputItemModel * itemModel in model.itemArr) {
        NSString * str = itemModel.strText;
        if (!str) {
            str = @"";
        }
        [returnArr addObject:str];
    }
    
    return returnArr;
}

//=======2022年08月22日10:47:22=======
/**********************************************************************************
*    功  能：初始化单个ComboBox下拉框控件
*
*    参  数：strTitle        标题文本
*            strTips        下拉框对应的提示文本
*            vctValue        下拉框所有能被选择的值的集合
*            strDefault        默认下拉框被选中的初始值，如果不存在于vctValue中，则认为
*                           vctValue的第一个，如果strDefault为空，下拉框被选中的初始
*                           值也是vctValue的第一个
*
*    返回值：true 初始化成功 false 初始化失败
*
*    说  明：如果vctValue的大小为1，则没有下拉框选择，只是一个不可输入的输入框显示
*            strDefault为下拉框被选中的初始值，如果strDefault为空，下拉框被选中的初始
*            值也是vctValue的第一个
************************************************************************************/
+ (BOOL)InitOneComboBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle strTips:(NSString *)strTips vctValue:(NSArray<NSString *> *)vctValue strDefault:(NSString *)strDefault
{
    HLog(@"%@ - 初始化单个ComboBox下拉框控件 - ID:%d - strTitle ：%@, strTips:%@, vctValue:%@, strDefault:%@", [self class], ID, strTitle, strTips, vctValue, strDefault);
    
    [self Destruct:ID];
    
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    }
    
    model.strTitle = strTitle;
    
    ArtiInputItemModel * itemModel = [[ArtiInputItemModel alloc] init];
    
    itemModel.isDropDownBox = YES;
    
    itemModel.strTips = strTips;
    
    itemModel.vctValue = vctValue;
    
    itemModel.strDefault = strDefault;
    
    if ([model.strTitle isEqualToString:strTitle] && [itemModel.strTips isEqualToString:strTips] && [itemModel.strDefault isEqualToString:strDefault]) {
        
        [model.itemArr addObject:itemModel];
        
        return YES;
    }
    
    return NO;
}

/**********************************************************************************
*    功  能：获取单下拉框ComboBox的内容
*
*    参  数：无
*
*    返回值：string 下拉框ComboBox选择的值
************************************************************************************/
+ (NSString *)GetOneComboBoxWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取单下拉框ComboBox的内容 - ID:%d", [self class], ID);
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    if (model.itemArr.count == 0) {
        HLog(@"没有item");
        return @"";
    }
    
    ArtiInputItemModel * itemModel = model.itemArr.firstObject;
    
    NSString * str = itemModel.strText;
    if (!str) {
        str = @"";
    }
    return str;
}


/**********************************************************************************
*    功  能：初始化多个ComboBox下拉框控件
*
*    参  数：strTitle        标题文本
*            vctTips        所有下拉框对应的提示文本的集合，一一对应
*            vctValue        所有下拉框对应的所有能被选择的值，一一对应
*            vctDefault        所有下拉框对应的初始值，默认下拉框被选中的初始值，一一对
*                           应,如果不存在于vctValue中，则认为vctValue的第一个，如果
*                           vctDefault为空，下拉框被选中的初始值也是vctValue的第一个
*
*    返回值：true 初始化成功 false 初始化失败
*
*    说  明：如果vctValue的某个元素的大小为1，则其对应的那个下拉框控件没有下拉框选择，
*            只是一个不可输入的输入框显示，vctDefault为下拉框被选中的初始值，如果
*            vctDefault的某个元素为空，则其对应的那个下拉框被选中的初始值也是
*            vctValue对应的第一个值
************************************************************************************/
+ (BOOL)InitManyComboBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle vctTips:(NSArray<NSString *> *)vctTips vctValue:(NSArray<NSArray<NSString *> *> *)vctValue vctDefaults:(NSArray<NSString *> *)vctDefaults
{
    HLog(@"%@ - 初始化多输入框控件 - ID:%d - strTitle ：%@, vctTips:%@, vctValue:%@, vctDefaults:%@", [self class], ID, strTitle, vctTips, vctValue, vctDefaults);
 
    [self Destruct:ID];
    
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    }
    
    model.strTitle = strTitle;
    
    for (int i = 0; i < vctTips.count; i ++) {
        ArtiInputItemModel * itemModel = [[ArtiInputItemModel alloc] init];
        
        itemModel.isDropDownBox = YES;
        
        if (i < vctTips.count) {
            itemModel.strTips = vctTips[i];
        }
        
        if (i < vctValue.count) {
            itemModel.vctValue = vctValue[i];
        }
        
        if (i < vctDefaults.count) {
            itemModel.strDefault = vctDefaults[i];
        }
        
        [model.itemArr addObject:itemModel];
    }
    
    return YES;
}


/**********************************************************************************
*    功  能：获取多个下拉框ComboBox的内容
*
*    参  数：无
*
*    返回值：vector<string> 多下拉框ComboBox选择的值集合
************************************************************************************/
+ (NSArray<NSString *> *)GetManyComboBoxWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取多输入框的返回值 - ID:%d", [self class], ID);
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    if (model.itemArr.count == 0) {
        HLog(@"没有item");
        return @[];
    }
    
    NSMutableArray * returnArr = [[NSMutableArray alloc] init];
    
    for (ArtiInputItemModel * itemModel in model.itemArr) {
        
        NSString * str = itemModel.strText;
        if (!str) {
            str = @"";
        }
        
        [returnArr addObject:str];
    }
    
    return returnArr;
}

/****************************************************************************
    *    功  能：  添加固定的“二维码扫描获取”按钮，并显示
    *              默认没有显示这个QR按钮，即bVisible为false
    *
    *              固定的“二维码扫描获取”按钮点击不做任何返回值
    *              即App在Show中不会将用户点击此按钮返回给诊断应用
    *
    *              扫描二维码后的结果字串应在输入框中显示，诊断应用通过接口
    *              GetOneInputBox获取二维码上的字串
    *
    *    参  数：  bVisible 是否显示按钮并可用
    *                       true   显示并可用
    *                       false  隐藏
    *
    *    返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *              其他值，暂无意义
    *
    *    注  意：  如果没有调用过此接口，此按钮不显示
    ****************************************************************************/
+ (uint32_t)SetVisibleButtonQRWithId:(uint32_t)ID bVisible:(BOOL)bVisible
{
    HLog(@"%@ - 二维码扫描获取 - ID:%d - bVisible:%d", [self class], ID, bVisible);
    
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    for (TDD_ArtiButtonModel * buttonModel in model.customButtonArr) {
        if (buttonModel.uButtonId == [@(DF_ID_QR) intValue]) {
            if (bVisible) {
                buttonModel.uStatus = ArtiButtonStatus_ENABLE;
            } else {
                buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
            }
        }
    }
        
    model.isReloadButton = YES;

    return 0;
}

+ (uint32_t)SetVisibleButtonQRExWithId:(uint32_t)ID bScanVisible:(BOOL)bScanVisible bPasteVisible:(BOOL)bPasteVisible
{
    HLog(@"%@ - 扫描以及粘贴获取 - ID:%d - bScanVisible:%d bPasteVisible:%d", [self class], ID, bScanVisible, bPasteVisible);
    
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    for (TDD_ArtiButtonModel * buttonModel in model.customButtonArr) {
        if (buttonModel.uButtonId == [@(DF_ID_QR) intValue]) {
            if (bScanVisible) {
                buttonModel.uStatus = ArtiButtonStatus_ENABLE;
            } else {
                buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
            }
        }
        if (buttonModel.uButtonId == [@(DF_ID_PASTE) intValue]) {
            if (bPasteVisible) {
                buttonModel.uStatus = ArtiButtonStatus_ENABLE;
            } else {
                buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
            }
        }
    }
        
    model.isReloadButton = YES;

    return 0;
}

/**********************************************************************************
*    功  能：初始化混合输入框和下拉框控件
*
*    参  数：strTitle       标题文本
*            vctTips        所有控件对应的提示文本的集合
*            vctMasks       输入框对应的输入掩码集合
*            vctDefaults    输入框对应的默认值集合
*            vctComboValues 下拉框对应的所有能被选择的值集合
*            vctComboDefaults 下拉框对应的初始值集合
*            vctOrder       控件显示顺序，ControlType::InputBox 表示输入框，ControlType::ComboBox 表示下拉框
*
*           例子：
*                   vector<string> tips = {"输入框1提示", "下拉框1提示", "输入框2提示", "下拉框2提示"};
*                   vector<string> masks = {"*", "*"};
*                   vector<string> defaults = {"默认值1", "默认值2"};
*
*                   vector<vector<string>> comboValues = {
*                   {"选项1", "选项2", "选项3"}, // 第一个下拉框的选项
*                   {"选项A", "选项B", "选项C"} // 第二个下拉框的选项
*                   };
*
*                   vector<string> comboDefaults = {
*                       "选项2", // 第一个下拉框的默认值
*                       "选项B" // 第二个下拉框的默认值
*                   };
*
*                   vector<ControlType> order = {ControlType::InputBox, ControlType::ComboBox, ControlType::InputBox, ControlType::ComboBox}; // 控件显示顺序
*
*    返回值：true 初始化成功 false 初始化失败
**********************************************************************************/
+ (BOOL)InitMixedInputComboBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle vctTips:(NSArray<NSString *> *)vctTips
                            vctMasks:(NSArray<NSString *> *)vctMasks
                         vctDefaults:(NSArray<NSString *> *)vctDefaults
                      vctComboValues:(NSArray<NSArray<NSString *> *> *)vctComboValues 
                    vctComboDefaults:(NSArray<NSString *> *)vctComboDefaults
                    vctOrders:(NSArray<NSNumber *> *)vctOrders
{
    HLog(@"%@ - 初始化多个混合框控件 - ID:%d - strTitle ：%@, vctTips:%@, vctMasks:%@, vctDefaults:%@, vctComboValues:%@, vctComboDefaults:%@, vctOrder:%@", [self class], ID, strTitle, vctTips, vctMasks, vctDefaults,vctComboValues,vctComboDefaults,vctOrders);
 
    [self Destruct:ID];
    
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    }
    
    if ((vctTips.count != vctOrders.count) || (vctMasks.count != vctDefaults.count) || (vctComboValues.count != vctComboDefaults.count) || (vctMasks.count + vctComboValues.count != vctOrders.count)) {
        HLog(@"%@ - 初始化多个混合框控件 - ID:%d 车型返回数组数量有误", [self class], ID);
        return false;
    }
    
    model.strTitle = strTitle;
    
    uint32_t inputCount = 0;
    uint32_t comboxCount = 0;
    
    for (int i = 0; i < vctOrders.count; i ++) {
        ArtiInputItemModel * itemModel = [[ArtiInputItemModel alloc] init];
        if (i < vctTips.count) {
            itemModel.strTips = vctTips[i];
        }

        NSNumber *orderNum = vctOrders[i];
        if (orderNum.intValue == 0) {
            itemModel.isDropDownBox = false;
            if (inputCount < vctMasks.count) {
                itemModel.strMask = vctMasks[inputCount];
            }
            if (inputCount < vctDefaults.count) {
                itemModel.strDefault = vctDefaults[inputCount];
            }
            inputCount ++;
        }else {
            itemModel.isDropDownBox = true;
            if (comboxCount < vctComboValues.count) {
                itemModel.vctValue = vctComboValues[comboxCount];
            }
            if (comboxCount < vctComboDefaults.count) {
                itemModel.strDefault = vctComboDefaults[comboxCount];
            }
            comboxCount++;
        }
        
        [model.itemArr addObject:itemModel];
    }
    
    return YES;
}

/**********************************************************
*    功  能：获取多输入框的返回值
*    参  数：无
*    返回值：vector<string> 多输入框输入值的集合
**********************************************************/
+ (NSArray<NSString *> *)GetMixedInputComboBoxWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取混合多输入框的返回值 - ID:%d", [self class], ID);
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    if (model.itemArr.count == 0) {
        HLog(@"%@ - 获取混合多输入框的返回值 - ID: 没有item", [self class], ID);
        return @[];
    }
    
    NSMutableArray * returnArr = [[NSMutableArray alloc] init];
    
    for (ArtiInputItemModel * itemModel in model.itemArr) {
        NSString * str = itemModel.strText;
        if (!str) {
            str = @"";
        }
        [returnArr addObject:str];
        
    }
    HLog(@"%@ - 获取混合多输入框的返回值 - ID:%d - 返回值:%@", [self class], ID, returnArr);
    return returnArr;
}

+ (NSArray<NSNumber *> *)GetMixedComboBoxNumWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取多输入框的返回值Num - ID:%d", [self class], ID);
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    if (model.itemArr.count == 0) {
        HLog(@"%@ - 获取多输入框的返回值Num - ID:%d - 没有item", [self class], ID);
        return @[];
    }
    
    NSMutableArray * returnArr = [[NSMutableArray alloc] init];
    for (ArtiInputItemModel * itemModel in model.itemArr) {
        if (itemModel.isDropDownBox) {
            NSString * str = itemModel.strText;
            if ([itemModel.vctValue containsObject:str]) {
                NSInteger index = [itemModel.vctValue indexOfObject:str];
                [returnArr addObject:[NSNumber numberWithInteger:index]];
            }else {
                [returnArr addObject:@(-1)];
            }
        }

    }
    HLog(@"%@ - 获取多输入框的返回值Num - ID:%d - 返回值:%@", [self class], ID, returnArr);
    return returnArr;
}
#pragma mark 机器翻译 -- 后期有卡顿的话需要优化
- (void)machineTranslation
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (ArtiInputItemModel * model in self.itemArr) {
            if (model.strTips.length > 0 && !model.isStrTipsTranslated) {
                [self.translatedDic setValue:@"" forKey:model.strTips];
            }
        }
        
        [super machineTranslation];
    });
    
}

#pragma mark 翻译完成
- (void)translationCompleted
{
    for (ArtiInputItemModel * model in self.itemArr) {
        if ([self.translatedDic.allKeys containsObject:model.strTips]) {
            if ([self.translatedDic[model.strTips] length] > 0) {
                model.strTranslatedTips = self.translatedDic[model.strTips];
                model.isStrTipsTranslated = YES;
            }
        }
    }
    
    [super translationCompleted];
}

+ (NSArray<NSNumber *> *)GetManyComboBoxNumWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取多输入框的返回值Num - ID:%d", [self class], ID);
    TDD_ArtiInputModel * model = (TDD_ArtiInputModel *)[self getModelWithID:ID];
    
    if (model.itemArr.count == 0) {
        HLog(@"没有item");
        return @[];
    }
    
    NSMutableArray * returnArr = [[NSMutableArray alloc] init];
    for (ArtiInputItemModel * itemModel in model.itemArr) {
        
        NSString * str = itemModel.strText;
        if ([itemModel.vctValue containsObject:str]) {
            NSInteger index = [itemModel.vctValue indexOfObject:str];
            [returnArr addObject:[NSNumber numberWithInteger:index]];
        }else {
            [returnArr addObject:@(-1)];
        }

    }
    return returnArr;
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID
{
    if (buttonID == 0) {
        //保存
        for (int i = 0; i < self.itemArr.count; i ++) {
            ArtiInputItemModel * itemModel = self.itemArr[i];
            
            if (itemModel.strText.length == 0) {
                continue;
            }
            
            TDD_ArtiInputSaveModel * oldModel = [TDD_ArtiInputSaveModel findFirstByCriteria:[NSString stringWithFormat:@"WHERE path = '%@' and mask = '%@' and value = '%@'", TDD_ArtiGlobalModel.sharedArtiGlobalModel.CarName, itemModel.strMask,itemModel.strText]];
            
            if (!oldModel) {
                TDD_ArtiInputSaveModel * saveModel = [[TDD_ArtiInputSaveModel alloc] init];
                saveModel.value = itemModel.strText;
                saveModel.path = TDD_ArtiGlobalModel.sharedArtiGlobalModel.CarName;
                saveModel.mask = itemModel.strMask;
                [saveModel save];
            }
        }
    }else if (buttonID == DF_ID_PASTE) {
        //粘贴
        for (int i = 0; i < self.itemArr.count; i ++) {
            ArtiInputItemModel * itemModel = self.itemArr[i];
            if (i == 0 && itemModel.isDropDownBox == false) {
                NSString *pasteboardString = [UIPasteboard generalPasteboard].string;
                pasteboardString = [itemModel.strText?:@"" stringByAppendingString:pasteboardString?:@""];
                pasteboardString = [itemModel filterTextMatch:pasteboardString?:@""];
                itemModel.strText = pasteboardString;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiInputModelChange object:itemModel userInfo:nil];
                });
                break;
            }
        }
        return false;
    }
    return YES;
}

- (NSMutableArray<ArtiInputItemModel *> *)itemArr
{
    if (!_itemArr) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    
    return _itemArr;
}

@end

@implementation ArtiInputItemModel

- (void)setStrDefault:(NSString *)strDefault
{
    _strDefault = strDefault;
    
    _strText = strDefault;
}

- (void)setStrTips:(NSString *)strTips
{
    if ([_strTips isEqualToString:strTips]) {
        return;
    }
    
    _strTips = strTips;
    
    self.strTranslatedTips = _strTips;
    
    self.isStrTipsTranslated = NO;
}

- (NSString *)filterTextMatch:(NSString *)text {
    // 输入校验
    if (text.length > 0) {
        BOOL shouldToUppercase = false;
        NSString *regex = @"";
        
        if ([self isFullOfStr:@"0" withText:self.strMask]) {
            regex = @"^[0-9]*$";
        }else if ([self isFullOfStr:@"A" withText:self.strMask]) {
            regex = @"^[A-Z]*$";
            shouldToUppercase = true;
        }else if ([self isFullOfStr:@"F" withText:self.strMask]) {
            regex = @"^[0-9A-F]*$";
            shouldToUppercase = true;
        }else if ([self isFullOfStr:@"V" withText:self.strMask]) {
            regex = @"^[0-9A-Z && [^I] && [^O] && [^Q] ]*$";
            shouldToUppercase = true;
        }else if ([self isFullOfStr:@"#" withText:self.strMask]) {
            regex = @"^[0-9+*/\\-]*$";
        }else if ([self isFullOfStr:@"B" withText:self.strMask]) {
            regex = @"^[0-9A-Z]*$";
            shouldToUppercase = true;
        }
        if (shouldToUppercase) {
            text = [text uppercaseString];
        }
        if (self.strMask.length > 0 && text.length >= self.strMask.length) {
            text = [text substringToIndex:MIN(text.length, self.strMask.length)];
        }
        if (regex.length > 0) {
            
            // 创建正则表达式对象
            NSError *error = nil;
            NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:&error];
            
            if (error) {
                NSLog(@"正则表达式创建失败: %@", error.localizedDescription);
            } else {
                NSMutableString *newString = [NSMutableString string];  // 用于组装的新字符串

                // 遍历字符串的每个字符
                for (NSUInteger i = 0; i < text.length; i++) {
                    unichar character = [text characterAtIndex:i];  // 获取每个字符
                    // 获取所有匹配项
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                    if ([pred evaluateWithObject:[NSString stringWithFormat:@"%C", character]]) {
                        // 将符合条件的字符添加到新字符串
                        [newString appendFormat:@"%C", character];
                    }
                }
                return newString;
            }
        }
    }
    
    return text;
}

- (BOOL)shouldTurnToUppercase {
    BOOL shouldToUppercase = false;
    
    if ([self isFullOfStr:@"A" withText:self.strMask]) {
        shouldToUppercase = true;
    }else if ([self isFullOfStr:@"F" withText:self.strMask]) {
        shouldToUppercase = true;
    }else if ([self isFullOfStr:@"V" withText:self.strMask]) {
        shouldToUppercase = true;
    }else if ([self isFullOfStr:@"B" withText:self.strMask]) {
        shouldToUppercase = true;
    }
    return shouldToUppercase;
}

//是否全是该字符
- (BOOL)isFullOfStr:(NSString *)str withText:(NSString *)text
{
    int nub = (int)text.length;
    //空为全键盘
    if (nub==0) {
        return NO;
    }
    for (int i = 0; i < nub; i ++) {
        NSString * subStr = [text substringWithRange:NSMakeRange(i, 1)];
        
        if (![subStr localizedCaseInsensitiveContainsString:str]) {
            return NO;
        }
    }
    
    return YES;
}



@end
