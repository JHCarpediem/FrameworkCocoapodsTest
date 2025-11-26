//
//  ViewController.m
//  DiagExample
//
//  Created by diag on 2023/12/19.
//

#import "ViewController.h"
#import <Diagnosis/TDD_DiagnosisManage.h>
#import <Diagnosis/TDD_EADSessionController.h>
#import <Diagnosis/TDD_HMBLECenterHandle.h>
#import <Diagnosis/UIColor+TDD_ADCategory.h>
@import Diagnosis;
@interface ViewController ()<TDD_DiagnosisManageDelegate,DiagnosisVCDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [TDD_DiagnosisManage setLanguage: TDDHLanguageTypeChinese];
    [self initDiagnosis];
    [TDD_DiagnosisManage enterLocalChooseCarViewController:DET_ALLFUN delegate:self];
    [TDD_DiagnosisManage sharedManage].currentSoftware = TDDSoftwareDiagScan;
//    self.view.backgroundColor = [UIColor tdd_colorDiagNormalGradient:TDD_GradientStyleUpleftToLowright withFrame:self.view.bounds.size];

}

- (void)initDiagnosis {
    //[[TDD_DiagnosisManage sharedManage] setViewColorType: TDD_DiagViewColorType_GradientBlack];//配色
#ifdef DEBUG
    [[TDD_DiagnosisManage sharedManage] setAppScenarios:AS_INTERNAL_USE];//debug/release
#endif
    [TDD_EADSessionController sharedController]; //蓝牙连接初始化
    [TDD_DiagnosisManage DiagnosisInit]; //诊断初始化
    //诊断内部manage委托外部manage代理
    [TDD_DiagnosisManage sharedManage].manageDelegate = self;
    [TDD_DiagnosisManage logStaticLibraryVersion];
    [HBLEManager scan];//开启蓝牙
}

- (NSString *)serverURL
{
    return @"https://www.baidu.com";
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [TDD_DiagnosisManage enterLocalChooseCarViewController:DEF_BASE_EIGHT_FUNCTION delegate:self];
}


@end
