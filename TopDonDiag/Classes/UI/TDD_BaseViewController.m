//
//  TDD_BaseViewController.m
//  BT20
//
//  Created by 何可人 on 2021/9/3.
//

#import "TDD_BaseViewController.h"

@interface TDD_BaseViewController ()<TDD_HTipBtnViewDelegate,TDD_NaviViewDelegate,UIGestureRecognizerDelegate>
//@property (nonatomic, assign) TDD_CustomLabel * titleLab;
@property (nonatomic, assign) float textHigh;
@property (nonatomic, assign) BOOL isTransform;
//@property (nonatomic, strong) UIButton * backBtn;

@end

@implementation TDD_BaseViewController

- (void)injected {
    if ([TDD_DiagnosisManage sharedManage].appScenarios == AS_INTERNAL_USE) {
        NSLog(@"I've been injected: %@", self);
        [self viewDidLoad];
    }
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//
//    if (![self isKindOfClass:[HHomeViewController class]]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//    }
//    
//    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
//}
//
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer
//                                      *)gestureRecognizer{
//    //YES：允许右滑返回  NO：禁止右滑返回
//    if (![self isKindOfClass:[HHomeViewController class]]) {
//        return YES;
//    }else{
//        return NO;
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES; //隐藏导航栏
    
    if (@available(iOS 11.0, *)) {
        
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self viewControllerInit];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChange:) name:HAppLanguageDidChangeNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

// 隐藏键盘
- (void)hideKeyboard {
    [self.view endEditing:YES];
}

- (void)didDisconnectPeripheral{
    
}

- (void)didConnectPeripheral{
    
}

- (void)languageChange:(id)sender {
    
    if (self.isViewLoaded && !self.view.window) {
        //这里置为nil，当视图再次显示的时候会重新走viewDidLoad方法
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        self.view = nil;
    }
}

- (void)viewControllerInit{
    self.view.backgroundColor = [UIColor tdd_colorF5F5F5];

    [self.view addSubview:self.naviView];
    
    //[self.view addSubview:self.topBackImageView];
    
//    [self.naviView.backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self setupNavigation];
}

- (void)setTitleStr:(NSString *)titleStr{
    titleStr = [titleStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    titleStr = [titleStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    if (![_titleStr isEqualToString:titleStr]) {
        _titleStr = titleStr;
        
        self.naviView.title = [TDD_HLanguage getLanguage:titleStr];
    }
}

- (void)setTopBackImageViewHide:(BOOL)hide {
    _topBackImageView.hidden = hide;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return isKindOfTopVCI ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

- (void)setupNavigation {
    self.naviView.naviType = kNaviTypeWhite;
}

- (TDD_NaviView *)naviView
{
    if (!_naviView) {
        _naviView = [[TDD_NaviView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, NavigationHeight)];
        _naviView.delegate = self;
    }
    return _naviView;
}

- (UIImageView *)topBackImageView
{
    if (!_topBackImageView) {
        _topBackImageView = [[UIImageView alloc] init];
        [_topBackImageView setHidden:YES];
    }
    return _topBackImageView;
}

- (void)hiddenBackButton
{
    self.naviView.backBtn.hidden = YES;
}

- (void)showBackButton
{
    self.naviView.backBtn.hidden = NO;
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- 键盘监听
#pragma mark 添加监听
- (void)addkeyBoardObserverWithHigh:(int)high{
    //键盘监听
    self.textHigh = high;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    if (self.isTransform) {
        return;
    }
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGRect begin = [[[note userInfo] objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGFloat ty = rect.size.height;
    double h = IphoneHeight - self.textHigh; //输入框离底的距离
    double y = h - ty;
    //    NSLog(@"\nrect:%@\n---\nbegin:%@", NSStringFromCGRect(rect), NSStringFromCGRect(begin));
    if (y < 0) {
        self.isTransform = YES;
        [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, y);
        }];
    }
    
}

#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    self.isTransform = NO;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        //        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

#pragma 点击触发
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = touches.anyObject;//获取触摸对象
    if (![touch.view isKindOfClass:[TDD_CustomTextField class]]) {
        [self.view endEditing:YES];
    }
}

- (void)hTipBtnViewTag:(int)viewTag didClickWithBtnTag:(int)btnTag{
    
}

- (void)dealloc{
    NSLog(@"%@ -- dealloc", [self class]);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //    [[HHttpRequest shareHHttpRequest] cancelRequest];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"VCdealloc" object:[self class]];
}

@end
