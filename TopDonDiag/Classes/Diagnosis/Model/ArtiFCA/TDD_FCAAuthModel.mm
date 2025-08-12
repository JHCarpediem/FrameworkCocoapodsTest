//
//  TDD_FCAAuthModel.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/12/1.
//

#import "TDD_FCAAuthModel.h"
#import "TDD_LoadingView.h"
#import "TDD_AlertTools.h"

@implementation TDD_GatewayProductEquityModel

@end

@implementation TDD_FCAAuthModel

- (instancetype)init {
    if (self == [super init]) {
    
    }
    return self;
}

- (void)setViewType:(NSInteger)viewType {
    _viewType = viewType;
    self.strTitle = viewType == 1 ? TDDLocalized.detail_info : TDDLocalized.app_sign_in;
    
    if (viewType == 1) {
        if (self.uType == SST_FUNC_FCA_AUTH || self.uType == SST_FUNC_NISSAN_AUTH) {
            if ([TDD_DiagnosisTools isAutoAuthNa] == 1) {
                self.unlockType = 0;
            }else {
                self.unlockType = 1;
            }
        }else {
            self.unlockType = 1;
        }
    }
    
    NSString *uTypeStr = @"";
    if (_unlockType > 0) {
        uTypeStr = [NSString stringWithFormat:@"%u_%ld",_uType,_unlockType];
    }else {
        uTypeStr = [NSString tdd_strFromInterger:_uType];
    }
    
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel] clearAuthMessage:NO];
    //TopDon解锁有切换账号的缓存
    NSString *accountStr = @"";
    if (_unlockType == 1) {
        accountStr = [TDD_ArtiGlobalModel sharedArtiGlobalModel].authChangeAccount;
    }

    if ([NSString tdd_isEmpty:accountStr]) {
        accountStr = [TDD_UserdefaultManager getAuthAccount:_uType unlockType:_unlockType];
    }
    //重置输入框的缓存
    NSString *passwordStr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getSaveAuthPassword];
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].authAccountDict setValue:accountStr?:@"" forKey:uTypeStr];
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].authPasswordDict setValue:passwordStr?:@"" forKey:uTypeStr];
    BOOL canLogin = (![NSString tdd_isEmpty:accountStr] && ![NSString tdd_isEmpty:passwordStr]);
    
    //重置按钮
    [self.buttonArr removeAllObjects];
    NSArray * titleArr = @[TDDLocalized.app_cancel,TDDLocalized.diag_unlock];
    NSArray * statusArr = @[@(ArtiButtonStatus_ENABLE),canLogin?@(ArtiButtonStatus_ENABLE):@(ArtiButtonStatus_DISABLE)];
    
    NSArray * IDArr = @[@(DF_ID_BACK),@(DF_ID_YES)];
    if (viewType == 1) {
        titleArr = @[TDDLocalized.app_cancel,TDDLocalized.app_next];
        IDArr = @[@(DF_ID_BACK),@(DF_ID_YES)];
        statusArr = @[@(ArtiButtonStatus_ENABLE),@(ArtiButtonStatus_DISABLE)];
    }
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

- (BOOL)ArtiButtonClick:(uint32_t)buttonID {
    //        [TDD_ArtiGlobalModel sharedArtiGlobalModel].fcaAccount = @"topdonusa111";
    //        [TDD_ArtiGlobalModel sharedArtiGlobalModel].fcaPassword = @"Volvoxc90xc30.";
    if (buttonID == DF_ID_YES) {
        if (_viewType == 2) {
            //登录页面
            if ([NSString tdd_isEmpty:[[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthAccount]] || [NSString tdd_isEmpty:[[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthPassword]]){
                [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.tip_input_email_or_psd_empty];
                return NO;
            }
            @kWeakObj(self)
            [TDD_HTipManage showNewLoadingViewWithTitle:TDDLocalized.tip_loading];
            if (self.uType == SST_FUNC_DEMO_AUTH) {
                @kWeakObj(self)
                if (self.isLock) {
                    self.returnID = buttonID;
                    [self conditionSignal];
                }

                return NO;
            }
            [TDD_FCAAuthModel requestFcaLoginWithType:self.uType complete:^(BOOL isSuccess,NSInteger code) {
                @kStrongObj(self)
                if (code == 102060) {
                    @kWeakObj(self)
                    [TDD_AlertTools showNeedBuyAlert:^{
                        @kStrongObj(self);
                        [self ArtiButtonClick:DF_ID_BACK];
                    }];
                }
                if (self.uType == SST_FUNC_FCA_AUTH && self.unlockType == 0) {
                    //FCA  autoAuth
                    [TDD_HTipManage deallocView];
                    if (isSuccess) {

                        if (self.isLock) {
                            self.returnID = buttonID;
                            [self conditionSignal];
                        }
                    }
                }else {
                    if (isSuccess) {
                        if (self.uType == SST_FUNC_RENAULT_AUTH || self.uType == SST_FUNC_NISSAN_AUTH || self.uType == SST_FUNC_VW_SFD_AUTH || (self.uType == SST_FUNC_FCA_AUTH && self.unlockType == 1)) {
                            if (self.uType == SST_FUNC_VW_SFD_AUTH) {
                                if ([TDD_DiagnosisManage sharedManage].manageDelegate) {
                                    NSString *accountStr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthAccount];
                                    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_ShowSFDUserInfo param:@{@"email":accountStr?:@""} completeHandle:^(id  _Nonnull result) {
                                        NSNumber *successNum = result;
                                        if (successNum.boolValue) {
                                            //登录成功请求权限
                                            [self loginSuccessToCheckRight:buttonID];
                                        }
                                    }];
                                }
                            }else {
                                //登录成功请求权限
                                [self loginSuccessToCheckRight:buttonID];
                            }

                        }else {
                            if (self.isLock) {
                                self.returnID = buttonID;
                                [self conditionSignal];
                            }
                        }
                        
                    }else {
                        [TDD_HTipManage deallocView];
                    }
                    
                }
            }];

            return NO;
        }else {
            //权益页面跳转登录页面
            [TDD_LoadingView resetStatic];
            self.viewType = 2;
            self.strTitle = TDDLocalized.app_sign_in;
            NSString *accountStr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthAccount];
            if ([NSString tdd_isEmpty:accountStr]) {
                accountStr = [TDD_UserdefaultManager getAuthAccount:self.uType];
                if (![NSString tdd_isEmpty:accountStr]) {
                    accountStr = [TDD_DiagnosisTools userAccount]?:@"";
                }
                NSString *uTypeStr = @"";
                if (_unlockType > 0) {
                    uTypeStr = [NSString stringWithFormat:@"%u_%ld",_uType,_unlockType];
                }else {
                    uTypeStr = [NSString tdd_strFromInterger:_uType];
                }
                [[TDD_ArtiGlobalModel sharedArtiGlobalModel].authAccountDict setValue:accountStr forKey:uTypeStr];

            }
            [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self userInfo:nil];
            return NO;
        }

    }else if (buttonID == DF_ID_BACK) {
        if (self.viewType == 2) {
            self.viewType = 1;
            [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self userInfo:nil];
            return NO;
        }

    }    
    return YES;
}

- (void)backClick {
    if (self.viewType == 2) {
        self.viewType = 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self userInfo:nil];

    }else {
        [super backClick];
    }
    
}

//显示前往购买按钮
- (void)showNeedBuyAlert {
    
    @kWeakObj(self)
    [TDD_AlertTools showNeedBuyAlert:^{
        @kStrongObj(self)
        [self ArtiButtonClick:DF_ID_BACK];
    }];
    
}

//登录按钮可点击
- (void)setLoginBtnEnable:(BOOL)enable {
    
    if (self.buttonArr.count > 1 && self.viewType == 2) {
        TDD_ArtiButtonModel * buttonModel = self.buttonArr[1];
        ArtiButtonStatus oldStatus = buttonModel.uStatus;
        buttonModel.uStatus = enable?ArtiButtonStatus_ENABLE:ArtiButtonStatus_DISABLE;
        if (oldStatus != buttonModel.uStatus) {
            self.isReloadButton = YES;
        }
    }
    
}

//下一步按钮可点击
- (void)setNextBtnEnable:(BOOL)enable {
    if (self.buttonArr.count > 1 && self.viewType == 1) {
        TDD_ArtiButtonModel * buttonModel = self.buttonArr[1];
        ArtiButtonStatus oldStatus = buttonModel.uStatus;
        buttonModel.uStatus = enable?ArtiButtonStatus_ENABLE:ArtiButtonStatus_DISABLE;
        if (oldStatus != buttonModel.uStatus) {
            self.isReloadButton = YES;
        }
    }
    
}

- (BOOL)checkHadRight {
    if (self.equityModel.chargeType == 1) {
        return self.equityModel.remainTimes > 0;

    }else {
        return (self.equityModel.available == 1);
        
    }
    return YES;
}

//雷诺登录成功请求次数
- (void)loginSuccessToCheckRight:(uint32_t )buttonID {
    @kWeakObj(self)
    [self requestSGWRight:nil complete:^(id  _Nonnull result) {
        [TDD_HTipManage deallocView];
        @kStrongObj(self)
        NSArray *dataArr = result[@"data"];
        NSNumber *success = result[@"success"];
        NSString *msg = result[@"msg"];
        if (dataArr.count > 0) {
            self.equityModel = dataArr.firstObject;
        }
        
        if (success.boolValue) {
            if ([self checkHadRight]) {
                if (self.isLock) {
                    self.returnID = buttonID;
                    [self conditionSignal];
                }
            }else {
                [self showNeedBuyAlert];
            }
        }else {
            if (![NSString tdd_isEmpty:msg]) {
                [TDD_HTipManage showBottomTipViewWithTitle:msg];
            }
        }

    }];
    
}

/// 登陆认证
/// 测试： sn = @"11034213F10085"; accountStr = @"tchenautoauth"; passwordStr = @"Tchen@autoauth123";
/// 欧洲：RyanZhang1/1z2h1ang#K1
+ (void)requestFcaLoginWithType:(eSpecialShowType)type complete:(void(^)(BOOL isSuccess,NSInteger code))complete {
    //账户
    NSString *accountStr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthAccount];
    //密码
    NSString *passwordStr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthPassword];

    if ([NSString tdd_isEmpty:accountStr] || [NSString tdd_isEmpty:passwordStr]){
        [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.tip_input_email_or_psd_empty];
        complete(NO,-1);
        return;
    }
    
    if ([TDD_DiagnosisManage sharedManage].netState <= 0) {
        [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.network_is_abnormal_check_the_network];
        complete(NO,-1);
        return;
    }
    
    if (![TDD_DiagnosisTools userIsLogin]) {
        if ([[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalEvent:param:)]) {
            [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalEvent:TDD_DiagOtherEventType_GotoLoginView param:@{}];
        }
        complete(NO,-1);
        return;
    }
    
    if (![[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
        complete(NO,-1);
        return;
    }
    
    NSMutableDictionary *param = @{}.mutableCopy;
    if (type == SST_FUNC_FCA_AUTH) {
        
        if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].authUnlockType == 0) {
            //北美 autoAuth
            [param setValue:@(1) forKey:@"source"];
            [param setValue:@(1) forKey:@"brand"];
            [param setValue:@(1) forKey:@"authType"];
        }else if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].authUnlockType == 1) {
            //TopDon
            [param setValue:@(2) forKey:@"source"];
            [param setValue:@(5) forKey:@"brand"];
            [param setValue:@(2) forKey:@"authType"];
        }
        else {
            // 欧洲 FCA
            [param setValue:@(1) forKey:@"brand"];
            [param setValue:@(1) forKey:@"authType"];
            [param setValue:@(2) forKey:@"source"];
        }
        
    }else if (type == SST_FUNC_RENAULT_AUTH) {
        [param setValue:@(2) forKey:@"source"];
        [param setValue:@(2) forKey:@"brand"];
        [param setValue:@(2) forKey:@"authType"];
    }else if (type == SST_FUNC_NISSAN_AUTH) {
        if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].authUnlockType == 0) {
            //北美 autoAuth
            [param setValue:@(1) forKey:@"source"];
            [param setValue:@(6) forKey:@"brand"];
            [param setValue:@(1) forKey:@"authType"];
        }else if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].authUnlockType == 1) {
            //TopDon
            [param setValue:@(2) forKey:@"source"];
            [param setValue:@(3) forKey:@"brand"];
            [param setValue:@(2) forKey:@"authType"];
        }
    }else if (type == SST_FUNC_VW_SFD_AUTH) {
        [param setValue:@(2) forKey:@"source"];
        [param setValue:@(4) forKey:@"brand"];
        [param setValue:@(2) forKey:@"authType"];
    }
    else {
        HLog(@"requestFcaLoginWithType 当前类型不支持");
        complete(NO,-1);
        return;
    }

    //二次验证 token
    [param setValue:[TDD_DiagnosisTools userTwoFATokenToken:accountStr]?:@"" forKey:@"twoFactorAuthToken"];
    NSString *originalAccountStr = accountStr;
    if (![NSString tdd_isEmpty:accountStr]){
        if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(AESEncrypt:)]){
            accountStr = [[TDD_DiagnosisManage sharedManage].manageDelegate AESEncrypt:accountStr];
        }
    }
    [param setValue:accountStr?:@"" forKey:@"username"];
    HLog(@"requestFcaLogin username: - %@",accountStr);

    if (![NSString tdd_isEmpty:passwordStr]){
        if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(AESEncrypt:)]){
            passwordStr = [[TDD_DiagnosisManage sharedManage].manageDelegate AESEncrypt:passwordStr];
        }
    }
    [param setValue:passwordStr?:@"" forKey:@"password"];
    HLog(@"requestFcaLogin password: - %@",passwordStr);
    
    //(如果二次验证，LMS会自己传一个，以防在页面停留太久)
    [param setValue:@((NSInteger)[NSDate tdd_getTimestampSince1970] * 1000) forKey:@"localTimeStamp"];

    NSString *snStr = [TDD_EADSessionController sharedController].SN;
    NSString *softCodeStr = [TDD_ArtiGlobalModel sharedArtiGlobalModel].softCode;
    if (![NSString tdd_isEmpty:snStr]) {
        [param setValue:snStr forKey:@"sn"];
    }
    if (![NSString tdd_isEmpty:softCodeStr]) {
        [param setValue:softCodeStr forKey:@"softCode"];
    }
          
    __block BOOL success = NO;
    
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_AuthLogin param:param completeHandle:^(id  _Nonnull result) {

        NSDictionary *responsDic = result;
        NSInteger code = [responsDic tdd_getIntValueForKey:@"code" defaultValue:-1];
        NSString *codeStr = [NSString stringWithFormat:@"%ld",(long)code];
        NSString *msg = responsDic[@"msg"];
        NSString *oem = @"";
        NSString *sessionID = @"";
        NSString *token = responsDic[@"token"];
        if ([NSString tdd_isEmpty:token]) {
            token = @"";
        }
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].authToken = token;

        if ([NSString tdd_isEmpty:msg]) {
            msg = [NSString stringWithFormat:@"%@",codeStr];
        }
        
        if (code == 2000) {
            //成功
            //本地化区域和账号
            //[[TDD_ArtiGlobalModel sharedArtiGlobalModel] saveGatewayArea];
            [[TDD_ArtiGlobalModel sharedArtiGlobalModel] saveGatewayAccount];
            //缓存密码
            [[TDD_ArtiGlobalModel sharedArtiGlobalModel] saveAuthPassword];
            //登录成功更新切换账号的缓存位登录成功账号
            if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].authUnlockType == 1) {
                [TDD_ArtiGlobalModel sharedArtiGlobalModel].authChangeAccount = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthAccount];
            }

            success = YES;
            
            complete(success,1);
        } else {
            if (code == 13135) {
                //判断账号是否一致
                if ([originalAccountStr isEqualToString:[TDD_DiagnosisTools userAccount]]) {
                    
                    [TDD_AlertTools openTwoFaAlert:param];
                }else {
                    [TDD_AlertTools openTwoFaChangeAccountAlert:originalAccountStr];
                }
                
                complete(success,code);
            }else if (code == 13136 || code == 13137) {
                //直接跳转二次验证
                //LMS记录 token
                [param setValue:originalAccountStr?:@"" forKey:@"email"];
                [param removeObjectForKey:@"twoFactorAuthToken"];
                [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_GetTwoFactorAuthToken param:param completeHandle:^(id  _Nonnull result) {
                    NSString *token = result;
                    if ([NSString tdd_isEmpty:token]) {
                        token = @"";
                        success = NO;
                    }else {
                        //本地化区域和账号
                        //[[TDD_ArtiGlobalModel sharedArtiGlobalModel] saveGatewayArea];
                        [[TDD_ArtiGlobalModel sharedArtiGlobalModel] saveGatewayAccount];
                        //缓存密码
                        [[TDD_ArtiGlobalModel sharedArtiGlobalModel] saveAuthPassword];
                        //登录成功更新切换账号的缓存位登录成功账号
                        if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].authUnlockType == 1) {
                            [TDD_ArtiGlobalModel sharedArtiGlobalModel].authChangeAccount = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthAccount];
                        }

                        success = YES;
                    }
                    [TDD_ArtiGlobalModel sharedArtiGlobalModel].authToken = token;
                
                    complete(success,code);
                }];
            }else if (code == 401) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [TDD_HTipManage showBottomTipViewWithTitle:msg];
                });
                
                complete(success,code);
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *title = [NSString stringWithFormat:@"%@\n\n%@",TDDLocalized.app_tip,msg];
                    [TDD_HTipManage showBtnTipViewWithTitle:TDDLocalized.app_tip content:msg buttonType:HTipBtnOneType block:^(NSInteger btnTag) {
                        
                    }];
                });
                
                complete(success,code);
            }

        }

    }];
}

//软件是否过期
- (void)requestSoftExpire:(nullable void(^)(id result))complete {
    
    if (![[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
        HLog(@"requestSoftExpire代理未实现");
        if (complete) {
            complete(@{@"data":@{},@"success":@(NO),@"msg":@""});
        }
        return;
    }
    NSMutableDictionary *param = @{}.mutableCopy;

    NSString *snStr =  [TDD_EADSessionController sharedController].SN;
    NSString *softCodeStr = [TDD_ArtiGlobalModel sharedArtiGlobalModel].softCode;
    if ([NSString tdd_isEmpty:snStr]) {
        HLog(@"requestSoftExpire VCI 未连接");
        if (complete) {
            complete(@{@"data":@{},@"success":@(NO),@"msg":@""});
        }
        return;
    }else {
        [param setObject:snStr forKey:@"sn"];
    }
    if ([NSString tdd_isEmpty:softCodeStr]) {
        HLog(@"没有 softCode");
        if (complete) {
            complete(@{@"data":@{},@"success":@(NO),@"msg":@""});
        }
        return;
    }else {
        [param setObject:softCodeStr forKey:@"softCode"];
    }
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_QueryExpire param:param completeHandle:complete];
}

//获取用户解锁剩余次数
- (void)requestSGWRight:(nullable NSString *)accountStr complete:(nullable void(^)(id result))complete {
    if (![[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
        HLog(@"权益 ArtiGlobalNetwork代理未实现");
        if (complete) {
            complete(@{@"data":@[],@"success":@(NO),@"msg":@""});
        }
        return;
    }
    NSMutableDictionary *param = @{}.mutableCopy;
    NSMutableArray *equityTypeList = @[].mutableCopy;
    //FCA 直接进登录页面，这是预留代码(如果 FCA 也需要展示此页面，需要现有选区域提前)
    if (self.uType == SST_FUNC_FCA_AUTH) {
        [equityTypeList addObject:@(1)];
    }else if (self.uType == SST_FUNC_RENAULT_AUTH){
        [equityTypeList addObject:@(2)];
    }else if (self.uType == SST_FUNC_NISSAN_AUTH){
        [equityTypeList addObject:@(3)];
    }else if (self.uType == SST_FUNC_VW_SFD_AUTH){
        [equityTypeList addObject:@(9)];
    }
    [param setValue:equityTypeList forKey:@"equityTypeList"];
    
    
//    if (isatty(STDOUT_FILENO) != 0) {
//        [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVIN = @"1C3J8B3R26Y109514";
//    }

    //账户
    if ([NSString tdd_isEmpty:accountStr]) {
        accountStr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthAccount];
        if ([NSString tdd_isEmpty:accountStr]) {
            if (_viewType==1) {
                accountStr = [TDD_DiagnosisTools userAccount];
            }
        }

    }
    [param setValue:[TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVIN?:@"" forKey:@"vin"];
    [param setValue:[TDD_EADSessionController sharedController].SN?:@"" forKey:@"sn"];
    if (![NSString tdd_isEmpty:accountStr]) {
        [param setValue:accountStr forKey:@"email"];
    }
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_QuerySGW param:param completeHandle:complete];
    
}

- (void)setUnlockType:(NSInteger)unlockType {
    _unlockType = unlockType;
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].authUnlockType = unlockType;
}
@end
