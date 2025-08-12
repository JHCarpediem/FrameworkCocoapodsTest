//
//  TDD_AlertTools.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/3/6.
//

#import "TDD_AlertTools.h"
@import TDUIProvider;
@import TDBasis;
@implementation TDD_AlertTools
+ (void)resetAlert {
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].isShowBatteryVoltTip = NO;
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].isShowBleBreakTip = NO;
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].isShowBackgroundTip = NO;
}

+ (void)showBatteryVoltLowAlert {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (![TDD_ArtiGlobalModel sharedArtiGlobalModel].isShowBatteryVoltTip && ![TDD_EADSessionController sharedController].noMoreShowBatteryVoltLowTip) {
            [TDD_ArtiGlobalModel sharedArtiGlobalModel].isShowBatteryVoltTip = YES;

            //选中不再提示后当次 app 运行不再弹
            //一次进车只弹一次

            LMSAlertAction *action = [[LMSAlertAction alloc] initWithTitle:TDDLocalized.app_confirm titleColor:[LMSAlertAction confirmAction].titleColor backgroundColor:nil image:nil :^(LMSAlertAction * _Nonnull action) {
                [TDD_EADSessionController sharedController].noMoreShowBatteryVoltLowTip = action.isNomoreAlert;
            }] ;

            [LMSAlertController showWithTitle:TDDLocalized.voltage_low content:TDDLocalized.dialog_vci_vol_content image:nil shouldNoMoreAlert:YES priorityValue:1003 actions:@[action]];
        }

    });

}

+ (void)showBleBreakAlert {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (![TDD_ArtiGlobalModel sharedArtiGlobalModel].isShowBleBreakTip) {
            [TDD_ArtiGlobalModel sharedArtiGlobalModel].isShowBleBreakTip = YES;
            //一次进车只弹一次
            [LMSAlertController showWithTitle:TDDLocalized.bluetooth_disconnect_tips content:TDDLocalized.dialog_blue_content image:nil priority:1002 actions:@[[LMSAlertAction confirmAction]]];
        }

    });
    
}

+ (void)showBackgroundAlert {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (![TDD_ArtiGlobalModel sharedArtiGlobalModel].isShowBackgroundTip) {
            [TDD_ArtiGlobalModel sharedArtiGlobalModel].isShowBackgroundTip = YES;
            //一次进车可弹多次
            LMSAlertAction *action = [[LMSAlertAction alloc] initWithTitle:TDDLocalized.app_confirm titleColor:[LMSAlertAction confirmAction].titleColor backgroundColor:nil image:nil :^(LMSAlertAction * _Nonnull ac) {
                [TDD_ArtiGlobalModel sharedArtiGlobalModel].isShowBackgroundTip = NO;
            }] ;
            [LMSAlertController showWithTitle: TDDLocalized.bluetooth_disconnect_tips content:TDDLocalized.dialog_blue_process_content image:nil priority:1002 actions:@[action]];
        }

    });
    
}

+ (void)showSoftExpiredToBuyAlert:(nullable void (^)(void))completionHandler {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany) {
            [LMSAlertController showWithTitle:TDDLocalized.software_expired content:TDDLocalized.software_is_out_of_date_custom image:nil priority:1002 actions:@[[LMSAlertAction confirmAction]]];
            
        }else if ([TDD_DiagnosisTools isDEMO]){
            LMSAlertAction *action = [[LMSAlertAction alloc] initWithTitle:TDDLocalized.app_confirm titleColor:[LMSAlertAction confirmAction].titleColor backgroundColor:nil image:nil :^(LMSAlertAction * _Nonnull ac) {
                if (completionHandler) {
                    completionHandler();
                }
            }] ;
            [LMSAlertController showWithTitle:TDDLocalized.buy_tips content:TDDLocalized.demo_buy_tips image:nil priority:1002 actions:@[action]];
        }
        else {
            LMSAlertAction *action = [[LMSAlertAction alloc] initWithTitle:TDDLocalized.go_to_renewal titleColor:[LMSAlertAction confirmAction].titleColor backgroundColor:nil image:nil :^(LMSAlertAction * _Nonnull ac) {
                if ([[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalEvent:param:)]) {
                    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalEvent:TDD_DiagOtherEventType_GotoShop param:@{@"mallType":@(30)}];
                }
            }] ;
            [LMSAlertController showWithTitle:TDDLocalized.software_expired content:TDDLocalized.software_fuction_expire_tip image:nil priority:1002 actions:@[[LMSAlertAction cancelAction],action]];
        }
        
    });
    
}

+ (void)openTwoFaAlert:(NSDictionary *)param {
    LMSAlertAction *action = [[LMSAlertAction alloc] initWithTitle:TDDLocalized.user_immediate_open titleColor:[LMSAlertAction confirmAction].titleColor backgroundColor:nil image:nil :^(LMSAlertAction * _Nonnull action) {
        [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_OpenTwoFactorAuthToken param:param completeHandle:^(id  _Nonnull result) {
            NSLog(@"");
        }];
    }] ;

    [LMSAlertController showWithTitle:TDDLocalized.explanation content:TDDLocalized.tips_authentication image:nil shouldNoMoreAlert:NO priorityValue:1003 actions:@[LMSAlertAction.cancelAction,action]];
}

+ (void)openTwoFaChangeAccountAlert:(NSString *)account {
    NSString *contentStr = [NSString stringWithFormat:TDDLocalized.tips_authentication_account_error,account];
    LMSAlertController *alert = [LMSAlertController showWithTitle:TDDLocalized.explanation content:contentStr image:nil shouldNoMoreAlert:NO priorityValue:1003 actions:@[LMSAlertAction.confirmAction]];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    [attStr yy_setColor:[UIColor tdd_colorDiagTheme] range:[contentStr rangeOfString:account]];
    [alert setAttributeMessage:attStr];
    
}

+ (void)showNeedBuyAlert:(void(^)(void))complict {
    LMSAlertAction *action = LMSAlertAction.confirmAction;
    action.action = ^(LMSAlertAction * _Nonnull action) {
        if (complict) {
            complict();
        }
    };

    LMSAlertController *alertController =     [LMSAlertController showWithTitle:TDDLocalized.app_tip content:TDDLocalized.unlock_rights_need_buy image:nil priority:1002 actions:@[action]];

    NSString *carName = [NSString tdd_isEmpty:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carServiceName]?[TDD_ArtiGlobalModel sharedArtiGlobalModel].CarName:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carServiceName;
    NSString *accountStr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthAccount];
    NSString *str = [NSString stringWithFormat:TDDLocalized.unlock_rights_need_buy,accountStr,carName];
    NSMutableAttributedString *attributedString = [NSMutableAttributedString mutableAttributedStringWithLTRString:str];
    [attributedString addAttributes:@{ NSForegroundColorAttributeName: [UIColor tdd_colorDiagTheme], NSFontAttributeName: [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD] } range:[str rangeOfString:accountStr]];
    [attributedString addAttributes:@{ NSForegroundColorAttributeName: [UIColor tdd_colorDiagTheme], NSFontAttributeName: [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD] } range:[str rangeOfString:carName]];
    [alertController setAttributeMessage:attributedString];
    
}
@end
