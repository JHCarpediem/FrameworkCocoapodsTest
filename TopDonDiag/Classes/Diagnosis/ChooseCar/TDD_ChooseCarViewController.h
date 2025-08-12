//
//  TDD_ChooseCarViewController.h
//  AD200
//
//  Created by 何可人 on 2022/4/16.
//

#import "TDD_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ChooseCarViewController : TDD_BaseViewController
@property (nonatomic, assign) eDiagEntryType diagEntryType; //当前诊断的入口类型
@property (nonatomic, weak)   id<DiagnosisVCDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
