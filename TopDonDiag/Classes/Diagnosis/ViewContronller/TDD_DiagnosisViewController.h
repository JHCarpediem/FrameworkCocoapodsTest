//
//  TDD_DiagnosisViewController.h
//  AD200
//
//  Created by 何可人 on 2022/4/16.
//

#import "TDD_BaseViewController.h"
#import "TDD_CarModel.h"
#import "TDD_DiagnosisManage.h"

NS_ASSUME_NONNULL_BEGIN
@interface TDD_DiagnosisViewController : TDD_BaseViewController
@property (nonatomic, assign) TDD_DiagNavType diagNavType; //当前诊断的显示类型
@property (nonatomic, strong) TDD_CarModel * carModel;
@property (nonatomic, assign) eDiagEntryType diagEntryType; //当前诊断的入口类型
@property (nonatomic, assign) eDiagMenuMask diagMenuMask; //当前诊断的系统掩码值
@property (nonatomic, strong) NSString * carLanguage; //CN、EN
@property (nonatomic, weak)   id<DiagnosisVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
