//
//  TDD_ArtiModelBase.m
//  AD200
//
//  Created by 何可人 on 2022/4/16.
//

#import "TDD_ArtiModelBase.h"
#import "TDD_TranslationManager.h"
#import "TDD_ArtiLiveDataModel.h"
@interface TDD_ArtiModelBase ()
@property (nonatomic, strong) NSTimer * lockTimer;
@end

@implementation TDD_ArtiModelBase

#pragma mark 注册方法
+ (void)registerMethod
{
    
}

#pragma mark 创建单例
+(TDD_ArtiModelBase *)sharedArtiModel {
    static TDD_ArtiModelBase * artiModel = nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        artiModel = [[self alloc] init];
    });
    return artiModel;
}

#pragma mark 创建对象
///创建对象
+ (void)Construct:(uint32_t)ID{
    @autoreleasepool {
        id oldModel = [self getModelWithID:ID];
        if (oldModel) {
            HLog(@"ID已创建, 请勿重复创建--%d", ID);
            return;
        }
        
        HLog(@"创建%@ - %d", [self class], ID);
        TDD_ArtiModelBase * model = [[self alloc] init];
        model.modID = ID;
        model.returnID = DF_ID_NOKEY;
        model.isLock = YES;
        
        NSString * classStr = NSStringFromClass(self);
        
        if (![[self sharedArtiModel].objectDic.allKeys containsObject:classStr]) {
            NSMutableDictionary * mDic = [[NSMutableDictionary alloc] init];
            
            [[self sharedArtiModel].objectDic setObject:mDic forKey:classStr];
        }
        
        NSMutableDictionary * mDic = [self sharedArtiModel].objectDic[classStr];
        
        [mDic setObject:model forKey:@(ID)];
    }
}

#pragma mark 销毁该对象
///销毁该对象
+ (void)Destruct:(uint32_t)ID{
    @autoreleasepool {
        HLog(@"删除%@ - %d", [self class], ID);
        
        TDD_ArtiModelBase * model = [self getModelWithID:ID];
        
        if (model) {
            NSString * classStr = NSStringFromClass(self);
            NSMutableDictionary * mDic = [self sharedArtiModel].objectDic[classStr];
            [mDic removeObjectForKey:@(ID)];
            model = nil;
            
            HLog(@"删除成功%@ - %d", [self class], ID);
        }else {
            HLog(@"删除失败%@ - %d", [self class], ID);
        }
    }
}

#pragma mark 初始化菜单显示控件，同时设置标题文本
/**********************************************************
 *    功  能：初始化菜单显示控件，同时设置标题文本
 *    参  数：strTitle 标题文本
 *    返回值：true 初始化成功 false 初始化失败
 **********************************************************/
+ (BOOL)InitTitleWithId:(uint32_t)ID strTitle:(NSString *)strTitle{
    HLog(@"%@ - 初始化菜单显示控件，同时设置标题文本 - ID:%d - 标题 ：%@", [self class], ID, strTitle);
    
    [self Destruct:ID];
    
    TDD_ArtiModelBase * model = [self getModelWithID:ID];//
    
    if (!model) {
        [self Construct:ID];
        
        model = [self getModelWithID:ID];
    }
    
    model.strTitle = strTitle;
    
    if ([model.strTitle isEqualToString:strTitle]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark 添加动作测试按钮,添加完按钮默认可点击
/**********************************************************
 *    功  能：添加动作测试按钮,添加完按钮默认可点击
 *
 *    参  数：strButtonText 动作测试按钮文本
 *
 *    返回值：按钮的ID，此ID用于DelButton接口的参数
 *            可能的返回值：
 *                         DF_ID_FREEBTN_0
 *                         DF_ID_FREEBTN_1
 *                         DF_ID_FREEBTN_2
 *                         DF_ID_FREEBTN_3
 *                         DF_ID_FREEBTN_XX
 **********************************************************/
+ (uint32_t)AddButtonExWithId:(uint32_t)ID strButtonText:(NSString *)strButtonText
{
    HLog(@"%@ - 添加动作测试按钮,添加完按钮默认可点击 - ID:%d - strButtonText:%@", [self class], ID, strButtonText);
    
    TDD_ArtiModelBase * model = [self getModelWithID:ID];
    
    TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
    if ([TDD_DiagnosisTools isDebug]) {
        if ([model isKindOfClass:[TDD_ArtiListModel class]]) {
            if ([model.strTitle isEqualToString:@"确认车辆信息"] && [strButtonText isEqualToString:@"确认"]) {
                buttonModel.uiTextIdentify = @"diagConfrimCarInfoButton";
            }
            
        }
    }
    buttonModel.uButtonId = DF_ID_FREEBTN_0 + (uint32_t)model.buttonArr.count;
    
    buttonModel.strButtonText = strButtonText;
    
    buttonModel.bIsEnable = YES;
    
    [model.buttonArr addObject:buttonModel];
    
    model.isReloadButton = YES;
    
    HLog(@"按钮添加完成，当前：%d个按钮", (int)model.buttonArr.count);
    
    return buttonModel.uButtonId;
}

#pragma mark 删除自由按钮
/**********************************************************
 *    功  能：删除自由按钮
 *
 *    参  数：uButtonId  按钮的编号
 *
 *            uButtonId 可能值是 DF_ID_FREEBTN_0
 *                               DF_ID_FREEBTN_1
 *                               DF_ID_FREEBTN_2
 *                               DF_ID_FREEBTN_3
 *                               DF_ID_FREEBTN_XX
 *
 *    返回值：true  自用添加的按钮删除成功
 *            false 自用添加的按钮删除失败
 **********************************************************/
+ (BOOL)DelButtonWithId:(uint32_t)ID uButtonId:(uint32_t)uButtonId
{
    HLog(@"%@ - 删除自由按钮 - ID:%d - uButtonId:%d", [self class], ID, uButtonId);
    
    if (uButtonId >= DF_ID_FREEBTN_0) {
        uButtonId -= DF_ID_FREEBTN_0;
    }
    
    TDD_ArtiModelBase * model = [self getModelWithID:ID];
    
    if (model.buttonArr.count <= uButtonId) {
        HLog(@"没有uButtonId：%d",uButtonId);
        return NO;
    }
    
    [model.buttonArr removeObjectAtIndex:uButtonId];
    
    model.isReloadButton = YES;
    
    //    ArtiButtonModel * buttonModel = model.buttonArr[uButtonId];
    //
    //    buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
    
    return YES;
}

#pragma mark 设置自定义按钮的状态
/******************************************************************
 *    功  能：设置自定义按钮的状态
 *
 *    参  数：uIndex      自定义按钮下标
 *            bStatus     自定义按钮的状态
 *
 *                  DF_ST_BTN_ENABLE    按钮状态为可见并且可点击
 *                  DF_ST_BTN_DISABLE   按钮状态为可见但不可点击
 *                  DF_ST_BTN_UNVISIBLE 按钮状态为不可见，隐藏
 *
 *    返回值：无
 *            如果没有调用此接口，默认为按钮状态为可见并且可点击
 ********************************************************************/
+ (void)SetButtonStatusWithId:(uint32_t)ID uIndex:(uint32_t)uIndex uStatus:(uint32_t)uStatus
{
    HLog(@"%@ - 设置指定的动作测试按钮状态 - ID:%d - uIndex:%d - uStatus:%d", [self class], ID, uIndex, uStatus);
    
    if (uIndex >= DF_ID_FREEBTN_0) {
        uIndex -= DF_ID_FREEBTN_0;
    }
    
    TDD_ArtiModelBase * model = [self getModelWithID:ID];
    
    if (model.buttonArr.count <= uIndex) {
        HLog(@"没有uIndex：%d",uIndex);
        return;
    }
    
    TDD_ArtiButtonModel * buttonModel = model.buttonArr[uIndex];
    
    if (buttonModel.uStatus != uStatus){
        buttonModel.uStatus = uStatus;
        
        model.isReloadButton = YES;
    }

}

#pragma mark 设置指定的动作测试按钮文本
/**********************************************************
 *    功  能：设置指定的动作测试按钮文本
 *    参  数：uIndex 指定的按钮
 *            strButtonText 需要设置的动作测试按钮文本
 *    返回值：无
 **********************************************************/
+ (void)SetButtonTextWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strButtonText:(NSString *)strButtonText
{
    HLog(@"%@ - 设置指定的动作测试按钮文本 - ID:%d - uIndex:%d - strButtonText:%@", [self class], ID, uIndex, strButtonText);
    
    if (uIndex >= DF_ID_FREEBTN_0) {
        uIndex -= DF_ID_FREEBTN_0;
    }
    
    TDD_ArtiModelBase * model = [self getModelWithID:ID];
    
    if (model.buttonArr.count <= uIndex) {
        HLog(@"没有uIndex：%d",uIndex);
        return;
    }
    
    TDD_ArtiButtonModel * buttonModel = model.buttonArr[uIndex];
    //如果文本没有更新，不需要刷新
    if (![buttonModel.strButtonText isEqualToString:strButtonText]){
        buttonModel.strButtonText = strButtonText;
        
        model.isReloadButton = YES;
    }

}

#pragma mark 显示菜单
/**********************************************************
 *    功  能：显示菜单
 *    参  数：无
 *    返回值：uint32_t 组件界面按键返回值
 *            选中菜单树区域，菜单项，返回
 *            阻塞接口
 **********************************************************/
+ (uint32_t)ShowWithId:(uint32_t)ID{
    HLog(@"%@ - 显示页面 - ID:%d", [self class], ID);
    
    if ([NSThread isMainThread]) {
        HLog(@"当前在主线程");
        //        return 0;
    }
    
    TDD_ArtiModelBase * model = (TDD_ArtiModelBase *)[self getModelWithID:ID];
    
    if (!model) {
        return DF_ID_BACK;
    }
    
    return [model show];
}

#pragma mark 根据ID获取model
+ (TDD_ArtiModelBase *)getModelWithID:(uint32_t)ID{
    NSString * classStr = @"";
    @autoreleasepool {
        classStr = NSStringFromClass(self);
    }
    
    if (![[self sharedArtiModel].objectDic objectForKey:classStr]) {
        HLog(@"%@ - %d 字典不存在", classStr, ID);
        return nil;
    }
    
    NSMutableDictionary * mDic = [self sharedArtiModel].objectDic[classStr];
    
    if (![mDic objectForKey:@(ID)]) {
        HLog(@"%@ - %d ID不存在", classStr, ID);
        return nil;
    }
    
    return mDic[@(ID)];
}

#pragma mark 更新字典缓存model
+ (void)updateModel:(TDD_ArtiModelBase *)model {
    NSString * classStr = @"";
    @autoreleasepool {
        classStr = NSStringFromClass([model class]);
    }
    
    if (![[self sharedArtiModel].objectDic objectForKey:classStr]) {
        HLog(@"%@ - %d 字典不存在", classStr, model.modID);
        return;
    }
    
    NSMutableDictionary * mDic = [self sharedArtiModel].objectDic[classStr];
    if (![mDic objectForKey:@(model.modID)]) {
        HLog(@"%@ - %d ID不存在", classStr, model.modID);
        return;
    }
    [mDic setObject:model forKey:@(model.modID)];
}

#pragma mark 移除所有model
+ (void)removeAllObjects{
    [[self sharedArtiModel].objectDic removeAllObjects];
}

#pragma mark 显示
- (uint32_t)show
{
    HLog(@"first-UI返回值");
//    if (TDD_ArtiGlobalModel.sharedArtiGlobalModel.isShowTranslated) {
//        //打开翻译则自动翻译
//        [self machineTranslation];
//    }
    
    //如果最后一次点击的按钮且 returnID 等于 按钮的 buttonID
    if ((self.lastClickButtonModel) && (self.returnID == self.lastClickButtonModel.uButtonId)) {
        if ([self.buttonArr containsObject:self.lastClickButtonModel]) {
            //当按钮是无效的，则 returnID 重置,报告会临时设为不可点击(需要排除掉bIsTemporaryNoEnable)
            if (self.lastClickButtonModel.uStatus != ArtiButtonStatus_ENABLE && !self.lastClickButtonModel.bIsTemporaryNoEnable) {
                self.returnID = DF_ID_NOKEY;
            }
        }else {
            //按钮被删除时，returnID 重置
            self.returnID = DF_ID_NOKEY;
        }
    }
    
    [self reloadButtonState];
    
    if (self.isLock) {

        [self.condition lock];

        if (!self.isShowOtherView) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self userInfo:nil];
            });
        }else {
            [self conditionSignalWithTime:0.1];
        }
        
        [self.condition wait];
        
        [self.condition unlock];

    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self userInfo:nil];
        });
    }
    
    uint32_t returnID = self.returnID;
    
    self.returnID = DF_ID_NOKEY;
    
    HLog(@"UI返回值为：%u", returnID);
    
    return returnID;
}

- (void)reloadButtonState
{
    for (TDD_ArtiButtonModel * buttonModel in self.buttonArr) {
        if (buttonModel.uButtonId == DF_ID_REPORT){
            //报告按钮
            if (buttonModel.bIsTemporaryNoEnable) {
                buttonModel.uStatus = ArtiButtonStatus_ENABLE;
                buttonModel.bIsTemporaryNoEnable = NO;
                self.isReloadButton = YES;
            }
            break;
        }
    }
}

#pragma mark 底部按钮点击
- (BOOL)ArtiButtonClick:(uint32_t)buttonID
{
    return YES;
}

#pragma mark 等待时间后解锁
- (void)conditionSignalWithTime:(float)time
{
    if ([[NSThread currentThread] isMainThread]) {
        [self startLockTime:time];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self startLockTime:time];
        });
    }
}

- (void)startLockTime:(float)time
{
    [self stopLockTime];
    
    self.lockTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(conditionSignal) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.lockTimer forMode:NSRunLoopCommonModes];
}

- (void)stopLockTime
{
    if (self.lockTimer) {
        [self.lockTimer invalidate];
        self.lockTimer = nil;
    }
}

#pragma mark 解锁
- (void)conditionSignal{
    //    self.runLoopThreadDidFinishFlag = YES;
    
    [self stopLockTime];
    
    [self.condition lock];
    [self.condition signal];
    //    [self.condition broadcast];
    [self.condition unlock];

}

#pragma mark 点击退出按钮
- (void)backClick{
    self.returnID = DF_ID_BACK;
    
    if (self.isLock) {
        [self conditionSignal];
    }
}

#pragma mark 机器翻译
- (void)machineTranslation
{
    //判断KEY是否翻译过，如果翻译过则不进行翻译 -- 减少翻译量
    //如果对应的KEY已在翻译中，则不需要进行翻译，仅需把其他KEY进行翻译
    //如果一部分已翻译，则先展示已翻译的一部分，再进行翻译剩下的一部分，再展示
    
    HLog(@"触发翻译");
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (TDD_ArtiButtonModel * model in self.buttonArr) {
            //添加按钮文本
            
            if (model.strTranslatedButtonText.length > 0 && !model.isTranslated) {
                //仅添加未翻译文本
                
                model.strButtonText = [TDD_HLanguage getLanguage:model.strButtonText];
                
                [self.translatedDic setValue:@"" forKey:model.strTranslatedButtonText];
            }
        }
        
        //添加标题文本
        if (self.strTranslatedTitle.length > 0 && !self.isTitleTranslated) {
            //仅添加未翻译文本
            [self.translatedDic setValue:@"" forKey:self.strTranslatedTitle];
        }
        
        if (self.translatedDic.count > 0) {
            //有需要翻译的内容
            HLog(@"有需要翻译的内容");
            self.isTranslating = YES;
            
            [self translation];
        } else {
            //无翻译内容
            HLog(@"无翻译内容");
            [self translationCompleted];
        }
    });
}

- (void)translation
{
    HLog(@"开始翻译");
    
    //记录正在翻译的数据 -- 单例处理
    //如果有重复数据则需要清除
    //翻译完成后删除已翻译数据
    
    NSMutableDictionary * dic = [self.translatedDic mutableCopy];
    
    NSArray *toTranslateArray = [dic allKeys];
    
    NSString * languageStr = [TDD_DiagnosisManage getCurrentLanguage];
    
    if ([languageStr isEqualToString:@"zh-Hans"]) {
        languageStr = @"zh-cn";
    }else if ([languageStr isEqualToString:@"zh-HK"]) {
        languageStr = @"zh-TW";
    }else {
        languageStr = [languageStr componentsSeparatedByString:@"-"][0];
    }
    
    [[TDD_TranslationManager sharedManager] queryWords:toTranslateArray target:languageStr completionHandler:^(NSArray * _Nullable strTranslatedValues, NSError * _Nullable error, NSString * errorStr) {
        //翻译完成
        HLog(@"翻译完成");
        if (toTranslateArray.count == strTranslatedValues.count) {
            for (int i = 0; i < toTranslateArray.count; i++) {
                NSDictionary *translatedValue = strTranslatedValues[i];
                NSString *translation = translatedValue[@"translatedText"];
                [self.translatedDic setValue:translation forKey:toTranslateArray[i]];
            }
        }else {
            HLog(@"翻译内容数量错误：/n原文：%@\n译文：%@", toTranslateArray, strTranslatedValues);
        }
        if (error) {
            self.translateSucc = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.translate_error];
            });
        }else {
            self.translateSucc = YES;
        }
        self.isTranslating = NO;
        [self translationCompleted];
        [self.translatedDic removeObjectsForKeys:dic.allKeys]; //清空已翻译缓存
    }];
}

#pragma mark 翻译完成
- (void)translationCompleted
{
    //翻译切换需要更新按钮文本
    self.isReloadButton = YES;
    
    for (TDD_ArtiButtonModel * model in self.buttonArr) {
        if ([self.translatedDic.allKeys containsObject:model.strButtonText]) {
            if ([self.translatedDic[model.strButtonText] length] > 0) {
                model.strTranslatedButtonText = self.translatedDic[model.strButtonText];
                model.isTranslated = YES;
            }
        }
    }
    
    if ([self.translatedDic.allKeys containsObject:self.strTranslatedTitle]) {
        if ([self.translatedDic[self.strTranslatedTitle] length] > 0) {
            self.strTranslatedTitle = self.translatedDic[self.strTranslatedTitle];
            self.isTitleTranslated = YES;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiTranslatedShow object:self userInfo:nil];
    });
}

#pragma mark - 懒加载
- (void)setStrTitle:(NSString *)strTitle
{
    if ([_strTitle isEqualToString:strTitle]) {
        return;
    }
    
    _strTitle = strTitle;
    
    self.strTranslatedTitle = strTitle;
    
    self.isTitleTranslated = NO;
}

- (NSMutableDictionary *)objectDic{
    if (!_objectDic) {
        _objectDic = [[NSMutableDictionary alloc] init];
    }
    
    return _objectDic;
}

- (NSCondition *)condition{
    if (!_condition) {
        _condition = [[NSCondition alloc] init];
    }
    
    return _condition;
}

- (NSMutableArray<TDD_ArtiButtonModel *> *)buttonArr{
    if (!_buttonArr) {
        _buttonArr = [[NSMutableArray alloc] init];
    }
    
    return _buttonArr;
}

- (NSMutableArray<TDD_ArtiButtonModel *> *)customButtonArr{
    if (!_customButtonArr) {
        _customButtonArr = [[NSMutableArray alloc] init];
    }
    
    return _customButtonArr;
}

- (NSMutableDictionary *)translatedDic{
    if (!_translatedDic) {
        _translatedDic = [[NSMutableDictionary alloc] init];
    }
    
    return _translatedDic;
}

- (NSString *)description{
    unsigned int count;
    const char *clasName    = object_getClassName(self);
    NSMutableString *string = [NSMutableString stringWithFormat:@"<%s: %p>:[ \n",clasName, self];
    Class clas              = NSClassFromString([NSString stringWithCString:clasName encoding:NSUTF8StringEncoding]);
    Ivar *ivars             = class_copyIvarList(clas, &count);

    for (int i = 0; i < count; i++) {

        @autoreleasepool {

            Ivar       ivar  = ivars[i];
            const char *name = ivar_getName(ivar);

            //得到类型
            NSString *type   = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
            NSString *key    = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id       value   = [self valueForKey:key];

            //确保BOOL值输出的是YES 或 NO
            if ([type isEqualToString:@"B"]) {
                value = (value == 0 ? @"NO" : @"YES");
            }

            [string appendFormat:@"\t%@: %@\n",[self deleteUnderLine:key], value];
        }
    }

    [string appendFormat:@"]"];

    return string;
}

/// 去掉下划线
- (NSString *)deleteUnderLine:(NSString *)string{
    
    if ([string hasPrefix:@"_"]) {
        return [string substringFromIndex:1];
    }
    return string;
}

- (NSString *)searchKey {
    if (!_searchKey) {
        _searchKey = @"";
    }
    return _searchKey;
}

- (NSMutableArray *)filterArray {
    if (!_filterArray) {
        _filterArray = [NSMutableArray array];
    }
    return _filterArray;
}


- (void)dealloc
{
    HLog(@"%@ - dealloc", self.class);
}


@end

@implementation TDD_ArtiButtonModel

- (void)setStrButtonText:(NSString *)strButtonText
{
    if ([_strButtonText isEqualToString:strButtonText]) {
        return;
    }
    
    _strButtonText = strButtonText;
    
    _strTranslatedButtonText = strButtonText;
    
    self.isTranslated = NO;
}

@end
