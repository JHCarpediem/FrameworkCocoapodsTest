//
//  TDD_ArtiFACLoginView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/11/30.
//

#import "TDD_ArtiFACAuthView.h"
#import "TDD_ArtiUnlockTypeSelectView.h"
#import "YYText/YYText.h"
@import IQKeyboardManager;
@import TDUIProvider;

@interface TDD_ArtiFACAuthView()<UITextFieldDelegate>
/// data
@property (nonatomic,strong)NSArray *createUrlArr;
@property (nonatomic,strong)NSArray *forgetUrlArr;
@property (nonatomic,strong)NSArray *phoneArr;
@property (nonatomic,strong)NSArray *emailArr;
@property (nonatomic,strong)NSArray *webArr;
@property (nonatomic,strong)NSArray *webAttStrArr;
@property (nonatomic,strong)NSArray *unlockTypeTitleArr;
/// UI
@property (nonatomic,strong)UIScrollView *contentView;
@property (nonatomic,strong)UIView *switchTypeView;
@property (nonatomic,strong)UIButton *naAreaBtn;
@property (nonatomic,strong)UIButton *otherAreaBtn;
@property (nonatomic,strong)UIButton *otherUnlockBtn;
@property (nonatomic,strong)UIImageView *logoImageView;
@property (nonatomic,strong)UIView * containerView;
@property (nonatomic,strong)TDD_CustomLabel *snLabel;
@property (nonatomic,strong)TDD_CustomLabel *unlockTypeTitleLabel;
@property (nonatomic,strong)UIControl *unlockTypeControl;
@property (nonatomic,strong)TDD_CustomLabel *unlockTypeLabel;
@property (nonatomic,strong)UIImageView *unlockTypeArrowIcon;
@property (nonatomic,strong)UIView *unlockTypeLineView;
@property (nonatomic,strong)TDD_CustomLabel *vinTitleLabel;
@property (nonatomic,strong)UIView * accountItemView;
@property (nonatomic,strong)UIView * passwordItemView;
@property (nonatomic,strong)TDD_VXXScrollLabel *accountTipsLabel;
@property (nonatomic,strong)TDD_CustomTextField * accountTextField;
@property (nonatomic,strong)TDD_CustomTextField * passwordTextField;
@property (nonatomic,strong)UIButton *forgottenBtn;
@property (nonatomic,strong)UIButton *createAccountBtn;
@property (nonatomic,assign)NSInteger unlockSubTypeSelIndex;
@property (nonatomic,strong)TDD_ArtiUnlockTypeSelectView *selectView;
@property (nonatomic,strong)UIButton *tipsBtn;
@property (nonatomic,strong)UIImageView *tipArrowImageView;
@property (nonatomic,strong)TDD_CustomLabel *countTipLabel;
@property (nonatomic,strong)YYLabel * webSpecLabel;
@property (nonatomic,strong)TDD_CustomLabel * emailSpecLabel;
@property (nonatomic,strong)TDD_CustomLabel * techSpecLabel;
@property (nonatomic,assign)NSInteger selectTapBtnTag;
@property (nonatomic,assign)CGFloat scale;
@property (nonatomic,assign)CGSize fcaLogoSize;
@property (nonatomic,assign)CGSize renaultLogoSize;
@end


@implementation TDD_ArtiFACAuthView

- (instancetype)init {
    if (self = [super init]) {

        [self createData];
        [self createUI];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(vciStatusDidChange) name:KTDDNotificationVciStatusDidChange object:nil];
    }
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow: newWindow];
    
    if (newWindow) {
        IQKeyboardManager.sharedManager.enable = YES;
    } else {
        IQKeyboardManager.sharedManager.enable = NO;
    }
}

- (void)createData {
    
    self.createUrlArr = @[@"https://webapp.autoauth.com/signup",@"https://www.technicalinformation.fiat.com/regAuth/en/registration/0"];
    self.forgetUrlArr = @[@"https://webapp.autoauth.com/resetPassword",@"https://www.technicalinformation.fiat.com/regAuth/en/login"];
    self.phoneArr = @[@"(+1) 833-629-4832",@"+34 930 038 094"];
    self.emailArr = @[@"support@topdon.us",@"support.eu@topdon.com"];
    self.webArr = @[@"https://www.topdon.us/",@"https://eu.topdon.com/"];
    self.unlockTypeTitleArr = @[TDDLocalized.topdon_account, TDDLocalized.europe_fca_official_site];
    self.webAttStrArr = @[[self webAttStr:0],[self webAttStr:1]];
}

- (void)vciStatusDidChange {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([TDD_EADSessionController sharedController].VciStatus) {
            self.snLabel.text = [TDD_EADSessionController sharedController].SN?:@"--";
        }else {
            self.snLabel.text = @"--";
        }
    });
    
}

- (void)createUI {
    _scale = IS_IPad ? HD_Height : H_Height;
    CGFloat space = IS_IPad ? 214 * _scale : 40 * _scale;
    CGFloat iconWH = (56 - 2 * 10) * _scale; // 图标大小
    CGFloat itemSpace = 10 * _scale;    // 间距
    _renaultLogoSize = IS_IPad ? CGSizeMake(203 * _scale, 72 * _scale) : CGSizeMake(186 * _scale, 36 * _scale);
    _fcaLogoSize = IS_IPad ? CGSizeMake(400 * _scale, 64 * _scale) : CGSizeMake(245 * _scale, 36 * _scale);
    
    //字体
    CGFloat bigFontSize = IS_IPad ? 18 : 16;
    CGFloat midFontSize = IS_IPad ? 16 : 14;
    CGFloat smallFontSize = IS_IPad ? 14 : 12;
    self.backgroundColor = [UIColor tdd_viewControllerBackground];
    
    [self addSubview:self.contentView];
    
    [self.contentView addSubview:self.otherUnlockBtn];
    
    [self.contentView addSubview:self.switchTypeView];
    [self.switchTypeView addSubview:self.naAreaBtn];
    [self.switchTypeView addSubview:self.otherAreaBtn];
    [_switchTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20 * _scale);
        make.left.equalTo(self.contentView).offset(40 * _scale);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(38 * _scale);
    }];
    [_naAreaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.switchTypeView).insets(UIEdgeInsetsMake(1, 1, 1, 0));
        make.width.mas_equalTo((IphoneWidth - 82 * _scale)/2);
    }];
    [_otherAreaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.switchTypeView).insets(UIEdgeInsetsMake(1, 0, 1, 1));
        make.width.equalTo(self.naAreaBtn);
    }];
    
    _logoImageView = [[UIImageView alloc] initWithImage:kImageNamed(@"FCA_Logo")];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_logoImageView];
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(55 * _scale);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(_fcaLogoSize);
    }];
    
    // 中间容器View
    UIView * containerView = [UIView new];
    [self.contentView addSubview:containerView];
    self.containerView = containerView;
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(space);
        make.width.mas_equalTo(IphoneWidth - space * 2);
        make.top.equalTo(self.logoImageView.mas_bottom).offset((IS_IPad ? 40 : 20) * _scale);
    }];
    
    [_otherUnlockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10 * _scale);
        make.right.equalTo(containerView).offset(20 * _scale);
        make.height.mas_equalTo(22 * _scale);
    }];
    
    //解锁方式
    _unlockTypeTitleLabel = [[TDD_CustomLabel alloc] init];
    _unlockTypeTitleLabel.text = TDDLocalized.unlock_method;
    _unlockTypeTitleLabel.textColor = [UIColor tdd_color666666];
    _unlockTypeTitleLabel.font = [[UIFont systemFontOfSize:bigFontSize weight:UIFontWeightRegular] tdd_adaptHD];
    [containerView addSubview:_unlockTypeTitleLabel];
    [_unlockTypeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView);
        make.left.offset(0);
        make.height.offset(50 * _scale);
    }];
    
    _unlockTypeControl = [UIControl new];
    [_unlockTypeControl addTarget:self action:@selector(unlockTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:_unlockTypeControl];
    [_unlockTypeControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.centerY.equalTo(_unlockTypeTitleLabel);
        make.height.offset(50 * _scale);
    }];
    
    TDD_CustomLabel *unlockTypeLabel = [[TDD_CustomLabel alloc] init];
    unlockTypeLabel.textColor = [UIColor tdd_title];
    unlockTypeLabel.font = [[UIFont systemFontOfSize:bigFontSize weight:UIFontWeightRegular] tdd_adaptHD];
    self.unlockTypeLabel = unlockTypeLabel;
    
    [_unlockTypeControl addSubview:unlockTypeLabel];
    [unlockTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_unlockTypeControl);
        make.left.offset(0);
    }];
    _unlockTypeArrowIcon = [[UIImageView alloc] initWithImage:kImageNamed(@"auth_input_drop")];
    
    [_unlockTypeControl addSubview:_unlockTypeArrowIcon];
    [_unlockTypeArrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_unlockTypeControl);
        make.right.offset(0);
        make.left.equalTo(unlockTypeLabel.mas_right).offset(6 * _scale);
    }];
    
    _unlockTypeLineView = [UIView new];
    _unlockTypeLineView.backgroundColor = [UIColor tdd_line];
    [containerView addSubview:_unlockTypeLineView];
    [_unlockTypeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_unlockTypeTitleLabel.mas_bottom);
        make.left.offset(0);
        make.centerX.equalTo(containerView);
        make.height.offset(0.5);
    }];
    
    //VIN
    _vinTitleLabel = [[TDD_CustomLabel alloc] init];
    _vinTitleLabel.text = @"VIN";
    _vinTitleLabel.textColor = [UIColor tdd_color999999];
    _vinTitleLabel.font = [[UIFont systemFontOfSize:bigFontSize weight:UIFontWeightRegular] tdd_adaptHD];
    [containerView addSubview:_vinTitleLabel];
    [_vinTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_unlockTypeLineView.mas_bottom).offset(12 * _scale);
        make.left.offset(0);
        make.height.offset(50 * _scale);
    }];
    
    TDD_CustomLabel * vinLabel = [[TDD_CustomLabel alloc] init];
    vinLabel.textColor = [UIColor tdd_color999999];
    vinLabel.font = [[UIFont systemFontOfSize:bigFontSize weight:UIFontWeightRegular] tdd_adaptHD];
    vinLabel.text = [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVIN;
    [containerView addSubview:vinLabel];
    [vinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_vinTitleLabel);
        make.right.offset(0);
        make.height.offset(50 * _scale);
    }];
    
    UIView *vinLineView = [UIView new];
    vinLineView.backgroundColor = [UIColor tdd_line];
    [containerView addSubview:vinLineView];
    [vinLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_vinTitleLabel.mas_bottom);
        make.left.offset(0);
        make.centerX.equalTo(containerView);
        make.height.offset(0.5);
    }];
    
    //sn
    TDD_CustomLabel *snTitleLabel = [[TDD_CustomLabel alloc] init];
    snTitleLabel.text = @"SN";
    snTitleLabel.textColor = [UIColor tdd_color999999];
    snTitleLabel.font = [[UIFont systemFontOfSize:bigFontSize weight:UIFontWeightRegular] tdd_adaptHD];
    [containerView addSubview:snTitleLabel];
    [snTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vinLineView.mas_bottom).offset(12 * _scale);
        make.left.offset(0);
        make.height.offset(50 * _scale);
    }];
    
    _snLabel = [[TDD_CustomLabel alloc] init];
    _snLabel.textColor = [UIColor tdd_color999999];
    _snLabel.font = [[UIFont systemFontOfSize:bigFontSize weight:UIFontWeightRegular] tdd_adaptHD];
    [containerView addSubview:_snLabel];
    [_snLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(snTitleLabel);
        make.right.offset(0);
        make.height.offset(50 * _scale);
    }];
    
    UIView *snLineView = [UIView new];
    snLineView.backgroundColor = [UIColor tdd_line];
    [containerView addSubview:snLineView];
    [snLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(snTitleLabel.mas_bottom);
        make.left.offset(0);
        make.centerX.equalTo(containerView);
        make.height.offset(0.5);
    }];
    
    //输入框
    NSArray * titleArr = @[TDDLocalized.please_enter_email,TDDLocalized.hint_login_password];
    UIView * lastView;
    
    for (int i = 0; i < titleArr.count; i++) {
        
        UIView * itemView = [UIView new];
        itemView.tag = 200 + i;
        [containerView addSubview:itemView];
        
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView ? lastView.mas_bottom : snLineView.mas_bottom).offset(12 * _scale);
            make.left.right.offset(0);
            make.height.offset(50 * _scale);
        }];
        
        TDD_CustomTextField * textField = [[TDD_CustomTextField alloc] init];
        textField.tag = 100 + i;
        NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:titleArr[i]];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor placeholderTextColor],NSFontAttributeName: [[UIFont systemFontOfSize:bigFontSize] tdd_adaptHD]} range:NSMakeRange(0, attStr.length)];
        textField.attributedPlaceholder = attStr;
        textField.font = [[UIFont systemFontOfSize:bigFontSize] tdd_adaptHD];
        textField.textColor = [UIColor tdd_title];
        textField.delegate = self;

        [itemView addSubview:textField];
        
        UIView * lineView = [UIView new];
        lineView.backgroundColor = [UIColor tdd_line];
        [itemView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.offset(0.5);
        }];
        
        if (i == 0) {
            _accountTipsLabel = [[TDD_VXXScrollLabel alloc] init];
            _accountTipsLabel.hidden = YES;
            _accountTipsLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 18 : 16] tdd_adaptHD];
            _accountTipsLabel.textColor = [UIColor placeholderTextColor];
            _accountTipsLabel.backgroundColor = UIColor.tdd_viewControllerBackground;
            [textField addSubview:_accountTipsLabel];
            
            textField.keyboardType = UIKeyboardTypeEmailAddress;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.placeholder = nil;
            [textField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
            UIButton *clean = [textField valueForKey:@"_clearButton"]; //key是固定的
            [clean setImage:kImageNamed(@"LMS_login_delete") forState:UIControlStateNormal];
            [clean setImage:kImageNamed(@"LMS_login_delete") forState:UIControlStateHighlighted];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(itemView);
                make.left.offset(0);
                make.centerY.offset(0);
                make.height.offset(iconWH);
            }];
            _accountTextField = textField;
            _accountItemView = itemView;
            [_accountTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(textField);
            }];
        } else {
        
            textField.secureTextEntry = YES;
            
            // 显示密码按钮
            UIButton * eyesBtn = [[UIButton alloc] init];
            [eyesBtn setImage:[kImageNamed(@"LMS_login_hidden_password") tdd_imageByTintColor:[UIColor tdd_title]] forState:UIControlStateNormal];
            [eyesBtn addTarget:self action:@selector(showPasswordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [itemView addSubview:eyesBtn];
            
            [eyesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(itemView);
                make.centerY.equalTo(itemView);
                make.size.mas_equalTo(CGSizeMake(iconWH, iconWH));
            }];
            
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(eyesBtn.mas_left).offset(-itemSpace);
                make.left.offset(0);
                make.centerY.offset(0);
                make.height.offset(iconWH);
            }];
            _passwordTextField = textField;
            _passwordItemView = itemView;
        }
        
        lastView = itemView;
    }
    
    // 忘记密码
    UIButton * forgottenBtn = [UIButton new];
    NSString * password_str = [NSString stringWithFormat:@"%@",TDDLocalized.user_login_forgotten];
    forgottenBtn.titleLabel.font = [[UIFont systemFontOfSize:midFontSize] tdd_adaptHD];
    [forgottenBtn setTitle:password_str forState:UIControlStateNormal];
    [forgottenBtn setTitleColor:[UIColor tdd_colorDiagTheme] forState:UIControlStateNormal];
    [forgottenBtn addTarget:self action:@selector(forgottenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.forgottenBtn = forgottenBtn;
    [containerView addSubview:forgottenBtn];
    
    [forgottenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(containerView);
        make.top.equalTo(lastView.mas_bottom).offset(20 * _scale);
    }];
    
    _tipsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tipsBtn addTarget:self action:@selector(tipClick) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:_tipsBtn];
    
    _tipArrowImageView = [[UIImageView alloc] initWithImage:kImageNamed(@"diag_arrow_right")];
    [_tipsBtn addSubview:_tipArrowImageView];
    
    _countTipLabel = [TDD_CustomLabel new];
    _countTipLabel.textColor = [UIColor tdd_color666666];
    _countTipLabel.text = TDDLocalized.operation_guide;
    _countTipLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD];
    _countTipLabel.numberOfLines = 0;
    [_tipsBtn addSubview:_countTipLabel];
    
    [_countTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipsBtn).offset(20 * _scale);
        make.left.equalTo(_tipsBtn);
        make.centerY.equalTo(_tipsBtn);
    }];
    
    [_tipArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_countTipLabel.mas_right).offset(4);
        make.centerY.equalTo(_countTipLabel);
        make.size.mas_equalTo(CGSizeMake(12 * _scale, 12 * _scale));
        make.right.equalTo(_tipsBtn);
    }];
    
    [_tipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordTextField.mas_bottom);
        make.centerX.equalTo(self);
    }];
    
    TDD_ArtiUnlockTypeSelectView *selectView = [[TDD_ArtiUnlockTypeSelectView alloc] init];
    self.selectView = selectView;
    @kWeakObj(self)
    selectView.selectBlock = ^(NSInteger i) {
        @kStrongObj(self)
        [self changeSubUnlockType:i];
    };
    selectView.tag = 400;
    selectView.hidden = YES;
    [containerView addSubview:selectView];
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_unlockTypeControl.mas_bottom).offset(-10 * _scale);
        make.left.right.equalTo(containerView);
    }];
    
    // 注册
    UIButton * createAccountBtn = [UIButton new];
    NSString *accountStr = TDDLocalized.no_account;
    NSString *registerStr = TDDLocalized.click_register;
    
    NSString * createAccountStr = [NSString stringWithFormat:@"%@ %@",accountStr,registerStr];
    createAccountBtn.titleLabel.font = [[UIFont systemFontOfSize:midFontSize] tdd_adaptHD];
    [createAccountBtn setTitleColor:[UIColor tdd_colorDiagTheme] forState:UIControlStateNormal];
    NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:createAccountStr];
    attStr.yy_color = [UIColor tdd_colorDiagTheme];
    [attStr yy_setColor:[UIColor tdd_title] range:NSMakeRange(0, accountStr.length)];
    [createAccountBtn setAttributedTitle:attStr forState:0];
    [createAccountBtn addTarget:self action:@selector(createAccountBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.createAccountBtn = createAccountBtn;
    [self.contentView addSubview:createAccountBtn];
    
    [createAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(forgottenBtn.mas_bottom);
    }];
    
    [containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(createAccountBtn);
    }];
    
    // 技术支持
    YYLabel * webSpecLabel = [YYLabel new];
    webSpecLabel.font = [[UIFont systemFontOfSize:smallFontSize] tdd_adaptHD];
    webSpecLabel.textColor = [UIColor tdd_color666666];
    webSpecLabel.textAlignment = NSTextAlignmentLeft;
    
    self.webSpecLabel = webSpecLabel;
    [self.contentView addSubview:webSpecLabel];
    [webSpecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        //make.bottom.equalTo(self.contentView.mas_bottom).offset(IS_iPhoneX ? -30 * H_Height : -10 * H_Height);
    }];
    
    TDD_CustomLabel * emailSpecLabel = [TDD_CustomLabel new];
    emailSpecLabel.font = [[UIFont systemFontOfSize:smallFontSize] tdd_adaptHD];
    emailSpecLabel.textColor = [UIColor tdd_color666666];
    emailSpecLabel.text = [NSString stringWithFormat:@"%@: support@topdon.us", TDDLocalized.tech_support];
    self.emailSpecLabel = emailSpecLabel;
    [self.contentView addSubview:emailSpecLabel];
    [emailSpecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(webSpecLabel.mas_top).offset(-4 * _scale);
    }];
    
    TDD_CustomLabel * techSpecLabel = [TDD_CustomLabel new];
    techSpecLabel.font = [[UIFont systemFontOfSize:smallFontSize] tdd_adaptHD];
    techSpecLabel.textColor = [UIColor tdd_color666666];
    techSpecLabel.text = [NSString stringWithFormat:@"%@: (+1) 833-629-4832", TDDLocalized.contact_number];
    self.techSpecLabel = techSpecLabel;
    [self.contentView addSubview:techSpecLabel];
    [techSpecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.passwordItemView.mas_bottom).offset((IS_IPad ? 56 : 94) * _scale);
        make.bottom.equalTo(emailSpecLabel.mas_top).offset(-4 * _scale);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
        make.bottom.equalTo(webSpecLabel.mas_bottom).offset(IS_iPhoneX ? 30 * H_Height : 10 * H_Height);
        make.width.mas_equalTo(IphoneWidth);
    }];
}

- (NSAttributedString *)webAttStr:(NSInteger)i {
    //添加点击事件
    NSString * webValue = _webArr[MIN(i, _webArr.count-1)];
    NSString * webText = [NSString stringWithFormat:@"%@: %@", TDDLocalized.web,webValue];
    NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString: webText];
    attStr.yy_font = [[UIFont systemFontOfSize:12] tdd_adaptHD];
    attStr.yy_color = [UIColor tdd_color666666];
    NSRange range = [webText rangeOfString:webValue];
    [attStr yy_setUnderlineStyle:NSUnderlineStyleSingle range:range];
    [attStr yy_setUnderlineColor:[UIColor tdd_mainColor] range:range];
    [attStr yy_setColor:[UIColor tdd_mainColor] range:range];
    
    //添加点击事件
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setFont:[[UIFont systemFontOfSize:12] tdd_adaptHD]];
    [attStr yy_setTextHighlight:highlight range:range];
    
    highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //点击跳转浏览器
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webValue] options:@{} completionHandler:nil];
    };
    
    return attStr;
}

- (void)setFcaModel:(TDD_FCAAuthModel *)fcaModel {
    _fcaModel = fcaModel;

    if (_fcaModel.uType == SST_FUNC_FCA_AUTH || _fcaModel.uType == SST_FUNC_NISSAN_AUTH) {
        if (_fcaModel.unlockType == 0) {
            [self switchArea:self.naAreaBtn];
        }else {
            [self switchArea:self.otherAreaBtn];
        }
        
    }else {
        [self updateUType];
    }

    if (isDeepScan) {
        _tipsBtn.hidden = true;
        _webSpecLabel.hidden = true;
        _techSpecLabel.hidden = true;
        _emailSpecLabel.hidden = true;
        [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
            make.bottom.equalTo(_fcaModel.uType == 0?self.createAccountBtn.mas_bottom :self.passwordTextField.mas_bottom).offset(IS_iPhoneX ? 30 * H_Height : 10 * H_Height);
        }];
    }

    [self changeSubUnlockType:_unlockSubTypeSelIndex];
    
    //这个地方使用连接的SN
    _snLabel.text = [TDD_EADSessionController sharedController].SN;
    
}

- (void)updateAccountAndPassword {
    NSString *accountStr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthAccount];
    NSString *passwordStr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthPassword];
    if ([NSString tdd_isEmpty:passwordStr]) {
        passwordStr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getSaveAuthPassword];
    }
    _accountTextField.text = accountStr;
    if ([NSString tdd_isEmpty:_accountTextField.text]) {
        _accountTipsLabel.hidden = NO;
    }else {
        _accountTipsLabel.hidden = YES;
    }
    _passwordTextField.text = passwordStr;
    
    if (_fcaModel.unlockType == 0) {
        NSString *str = TDDLocalized.ple_input_autoauth_email_hint;
        _accountTipsLabel.text = str;
    }else {
        NSString *str = TDDLocalized.please_enter_email;
        _accountTipsLabel.text = str;
    }
    
    if (![NSString tdd_isEmpty:_accountTextField.text] && ![NSString tdd_isEmpty:_passwordTextField.text]) {

        [_fcaModel setLoginBtnEnable:YES];
    }else {
        [_fcaModel setLoginBtnEnable:NO];
    }
    if ([self.delegate respondsToSelector:@selector(ArtiContentViewDelegateReloadData:)]) {
        [self.delegate ArtiContentViewDelegateReloadData:self.fcaModel];
    }
}

- (void)updateUType {

    [self updateAccountAndPassword];

    //注册忘记密码隐藏
    if (_fcaModel.unlockType == 1) {
        //FCA TopDon 解锁时 隐藏注册登录按钮
        [self hideRegisterAndForget:YES];
    }else {
        [self hideRegisterAndForget:NO];
    }
    //设置联系方式
    if ([TDD_DiagnosisTools isAutoAuthNa] == -1) {
        [self setConnect:(_fcaModel.unlockType == 0) ? 0 : 1];
    }else {
        [self setConnect:[TDD_DiagnosisTools isAutoAuthNa]? 0 : 1];
    }
    CGFloat techTopSpace;
    switch (_fcaModel.uType) {
        case SST_FUNC_FCA_AUTH:
        case SST_FUNC_NISSAN_AUTH:
        {
            _otherUnlockBtn.hidden = true;
            _switchTypeView.hidden = false;
            if (_fcaModel.unlockType == 0) {
                [_logoImageView setImage: kImageNamed(@"FCA_Logo")];
                techTopSpace = 142;
            }else {
                [_logoImageView setImage:(_fcaModel.uType == SST_FUNC_FCA_AUTH) ? [UIImage tdd_imageDiagGateWayFCATopDonLogo] : [UIImage tdd_imageDiagGateWayNissanLogo]];
                techTopSpace = 92;
            }
            
            if (_fcaModel.uType == SST_FUNC_NISSAN_AUTH) {
                [self setSubUnlockTypeDefault:0];
            }
            //autoAuth 隐藏解锁类型
            if (_fcaModel.unlockType == 0) {
                [self setSelectUnlockTypeViewHide:true];
            }else {
                [self setSelectUnlockTypeViewHide:false];
            }
            
            _tipsBtn.hidden = true;
            [_logoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo((_fcaModel.unlockType == 0) ? _fcaLogoSize :_renaultLogoSize);
                make.top.equalTo(self.contentView).offset(98 * _scale);
            }];
        }
            break;
        case SST_FUNC_RENAULT_AUTH:
        {
            _otherUnlockBtn.hidden = true;
            _switchTypeView.hidden = true;
            UIImage *renualtImage = IS_IPad ? kImageNamed(@"FCA_Logo_renualt_hd") : [UIImage tdd_imageDiagGateWayRenualtLogo];
            [_logoImageView setImage:renualtImage];
            techTopSpace = 128;
            [self setSubUnlockTypeDefault:0];
            
            [_logoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(_renaultLogoSize);
                make.top.equalTo(self.contentView).offset(_switchTypeView.hidden? 55 * _scale : 98 * _scale);
            }];
            
            //操作指引视频按钮只有雷诺
            if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
                _tipsBtn.hidden = YES;
            }else {
                _tipsBtn.hidden = false;
            }
            
        }
            break;
        case SST_FUNC_VW_SFD_AUTH:
        {
            _otherUnlockBtn.hidden = false;
            _switchTypeView.hidden = true;
            [_logoImageView setImage:[UIImage tdd_imageDiagGateWayVWSFDLogo]];
            techTopSpace = 128;
            [self setSubUnlockTypeDefault:0];
            
            [_otherUnlockBtn setTitle:TDDLocalized.third_party_processing forState:UIControlStateNormal];
            
            _tipsBtn.hidden = true;
            [_logoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(_fcaLogoSize);
                make.top.equalTo(self.contentView).offset(58 * _scale);
            }];
            
        }
            break;
        case SST_FUNC_DEMO_AUTH:
        {
            _otherUnlockBtn.hidden = true;
            _switchTypeView.hidden = true;
            [_logoImageView setImage:[UIImage tdd_imageDiagGateWayDEMOLogo]];
            techTopSpace = 128;
            [self setSubUnlockTypeDefault:0];
            
            _tipsBtn.hidden = true;
            [_logoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(_fcaLogoSize);
                make.top.equalTo(self.contentView).offset(55 * _scale);
            }];
            break;
    }
        default:
            break;
    }
    techTopSpace = (IS_iPhoneX ? techTopSpace : 22) * _scale;
    [_techSpecLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        if (IS_IPad) {
            make.top.equalTo(self.tipsBtn.hidden ? self.tipsBtn.mas_bottom : self.createAccountBtn.mas_bottom).offset(20 * _scale);
        }else {
            if (IS_iPhoneX) {
                make.top.equalTo(self.passwordItemView.mas_bottom).offset(techTopSpace);
            }else {
                make.top.equalTo(self.tipsBtn.hidden ? (self.createAccountBtn.hidden ? self.passwordItemView.mas_bottom : self.createAccountBtn.mas_bottom) : self.tipsBtn.mas_bottom).offset(techTopSpace);
            }
            
        }
        
        make.bottom.equalTo(_emailSpecLabel.mas_top).offset(-4 * _scale);
    }];
}

- (void)setSelectUnlockTypeViewHide:(BOOL)isHide {
    _unlockTypeTitleLabel.hidden = isHide;
    _unlockTypeControl.hidden = isHide;
    _unlockTypeLabel.hidden = isHide;
    _unlockTypeArrowIcon.hidden = isHide;
    _unlockTypeLineView.hidden = isHide;
    [_vinTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(isHide? _containerView: _unlockTypeLineView.mas_bottom).offset(isHide? 0 : 12 * _scale);
        make.left.offset(0);
        make.height.offset(50 * _scale);
    }];
}

/// 隐藏注册忘记密码按钮
- (void)hideRegisterAndForget:(BOOL )hide {
    self.forgottenBtn.hidden = self.createAccountBtn.hidden = hide;
    
}

#pragma mark - 解锁方式
/// 设置默认解锁方式并不可点击
- (void)setSubUnlockTypeDefault:(NSInteger)i {
    _unlockSubTypeSelIndex = i;
    _unlockTypeLabel.text = _unlockTypeTitleArr[i];
    _unlockTypeLabel.textColor = [UIColor tdd_color999999];
    _unlockTypeControl.enabled = NO;
    _unlockTypeArrowIcon.image = kImageNamed(@"artiInput_down_disable");
    
}
/// 点击解锁方式
- (void)unlockTypeClick:(UIButton *)btn {
    TDD_ArtiUnlockTypeSelectView *view = [self viewWithTag:400];
    view.hidden = !view.hidden;
    _unlockTypeArrowIcon.image = view.hidden?kImageNamed(@"auth_input_drop"):kImageNamed(@"auth_input_up");
}
/// 选择解锁方式
- (void)changeSubUnlockType:(NSInteger)i {
    self.selectView.hidden = YES;
    self.unlockSubTypeSelIndex = i;
    _selectView.unlockType = _unlockSubTypeSelIndex;
    _unlockTypeLabel.text = _unlockTypeTitleArr[i];
    if (_fcaModel.unlockType > 0) {
        _fcaModel.unlockType = i + 1;
    }
    
    [self updateAccountAndPassword];
    if (_fcaModel.uType == SST_FUNC_FCA_AUTH) {
        _unlockTypeArrowIcon.image = kImageNamed(@"auth_input_drop");
    }

    [self hideRegisterAndForget:_fcaModel.unlockType == 1];
}

/// 设置联系方式的地区
- (void)setConnect:(NSInteger )area {
    
    _emailSpecLabel.text = [NSString stringWithFormat:@"%@: %@", TDDLocalized.tech_support,_emailArr[MIN(area, _emailArr.count-1)]];
    _techSpecLabel.text = [NSString stringWithFormat:@"%@: %@", TDDLocalized.contact_number,_phoneArr[MIN(area, _phoneArr.count-1)]];
    
    _webSpecLabel.attributedText = _webAttStrArr[MIN(area, _webAttStrArr.count-1)];
    
}


#pragma mark - 显示密码按钮点击
- (void)showPasswordBtnClick:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
    
    if (btn.isSelected) {
        [btn setImage:[kImageNamed(@"LMS_login_show_password") tdd_imageByTintColor:[UIColor tdd_title]] forState:UIControlStateNormal];
    } else {
        [btn setImage:[kImageNamed(@"LMS_login_hidden_password") tdd_imageByTintColor:[UIColor tdd_title]] forState:UIControlStateNormal];
    }
    
    TDD_CustomTextField * textField = [self viewWithTag:101];
    
    textField.secureTextEntry = !btn.isSelected;
}

#pragma mark 注册按钮点击
- (void)createAccountBtnClick {
    if (_unlockSubTypeSelIndex >= self.createUrlArr.count){
        return;
    }
    NSURL *url = [NSURL URLWithString:[self.createUrlArr[_unlockSubTypeSelIndex] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

#pragma mark 忘记密码点击
- (void)forgottenBtnClick {
    if (_unlockSubTypeSelIndex >= self.forgetUrlArr.count){
        return;
    }
    NSURL *url = [NSURL URLWithString:[self.forgetUrlArr[_unlockSubTypeSelIndex] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

#pragma mark 观看视频
- (void)tipClick {
    if ([_fcaModel.delegate respondsToSelector:@selector(ArtiFatewayGotoWebView:param:)]) {
        [_fcaModel.delegate ArtiFatewayGotoWebView:_fcaModel param:@{@"web":@"https://youtu.be/BxH9FtlFFlk"}];
    }
}

#pragma mark 切换地区
- (void)switchArea:(UIButton *)sender {
    if (sender.tag == _selectTapBtnTag) {
        return;
    }
    TDD_ArtiUnlockTypeSelectView *view = [self viewWithTag:400];
    view.hidden = true;
    _unlockTypeArrowIcon.image = kImageNamed(@"auth_input_drop");
    _selectTapBtnTag = sender.tag;
    UIButton *btn;
    if (sender.tag == 500) {
        btn = [_switchTypeView viewWithTag:501];
        _fcaModel.unlockType = 0;
    }else {
        btn = [_switchTypeView viewWithTag:500];
        _fcaModel.unlockType = _unlockSubTypeSelIndex + 1;
    }

    [sender setBackgroundColor:[UIColor tdd_colorDiagTheme]];
    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    [btn setBackgroundColor:[UIColor cardBg]];
    [btn setTitleColor:[UIColor tdd_subTitle] forState:UIControlStateNormal];

    [self updateUType];
    
}

- (void)toOtherUnlockType {
    self.fcaModel.returnID = DF_ID_SFD_THIRD;
    [self.fcaModel conditionSignal];
    
}
#pragma mark UITextFieldDelegate

- (void)valueChange {
    if ([NSString tdd_isEmpty:_accountTextField.text]) {
        _accountTipsLabel.hidden = NO;
    }else {
        _accountTipsLabel.hidden = YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField.tag == 100 && toBeString.length > 255){
        
        textField.text = [toBeString substringToIndex:40];
        if ([NSString tdd_isEmpty:_accountTextField.text]) {
            _accountTipsLabel.hidden = NO;
        }else {
            _accountTipsLabel.hidden = YES;
        }
        return NO;
        
    } else if (textField.tag == 101 && toBeString.length > 30){
        
        textField.text = [toBeString substringToIndex:30];
            
        return NO;
    }


    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *typeStr = @"";
    if (_fcaModel.unlockType > 0) {
        typeStr = [NSString stringWithFormat:@"%u_%ld",_fcaModel.uType,_fcaModel.unlockType];
    }else {
        typeStr = [NSString tdd_strFromInterger:_fcaModel.uType];
    }
    if (textField == _accountTextField) {
        [[TDD_ArtiGlobalModel sharedArtiGlobalModel].authAccountDict setValue:_accountTextField.text?:@"" forKey:typeStr];
        if ([NSString tdd_isEmpty:_accountTextField.text]) {
            _accountTipsLabel.hidden = NO;
        }else {
            _accountTipsLabel.hidden = YES;
        }
    }else if (textField == _passwordTextField){
        [[TDD_ArtiGlobalModel sharedArtiGlobalModel].authPasswordDict setValue:_passwordTextField.text?:@"" forKey:typeStr];
        
    }
    
    if (![NSString tdd_isEmpty:_accountTextField.text] && ![NSString tdd_isEmpty:_passwordTextField.text]) {

        [_fcaModel setLoginBtnEnable:YES];
    }else {
        [_fcaModel setLoginBtnEnable:NO];
    }
    if ([self.delegate respondsToSelector:@selector(ArtiContentViewDelegateReloadData:)]) {
        [self.delegate ArtiContentViewDelegateReloadData:self.fcaModel];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSString *typeStr = @"";
    if (_fcaModel.unlockType > 0) {
        typeStr = [NSString stringWithFormat:@"%u_%ld",_fcaModel.uType,_fcaModel.unlockType];
    }else {
        typeStr = [NSString tdd_strFromInterger:_fcaModel.uType];
    }
    if (textField == _accountTextField) {
        [[TDD_ArtiGlobalModel sharedArtiGlobalModel].authAccountDict setValue:@"" forKey:typeStr];
    }
    if (textField == _passwordTextField) {
        [[TDD_ArtiGlobalModel sharedArtiGlobalModel].authPasswordDict setValue:@"" forKey:typeStr];
    }
    if ([NSString tdd_isEmpty:_accountTextField.text]) {
        _accountTipsLabel.hidden = NO;
    }else {
        _accountTipsLabel.hidden = YES;
    }
    return YES;
}

#pragma mark lazy
- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.scrollEnabled = YES;
        _contentView.bounces = false;
    }
    return _contentView;
}

- (UIView *)switchTypeView {
    if (!_switchTypeView) {
        _switchTypeView = [UIView new];
        _switchTypeView.backgroundColor = [UIColor cardBg];
        _switchTypeView.hidden = YES;
        [_switchTypeView tdd_addCornerRadius:5];
    }
    return _switchTypeView;
}

- (UIButton *)naAreaBtn {
    if (!_naAreaBtn) {
        _naAreaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _naAreaBtn.tag = 500;
        _naAreaBtn.backgroundColor = [UIColor tdd_colorDiagTheme];
        [_naAreaBtn setTitle:TDDLocalized.region_north_american forState:UIControlStateNormal];
        [_naAreaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _naAreaBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [_naAreaBtn addTarget:self action:@selector(switchArea:) forControlEvents:UIControlEventTouchUpInside];
        [_naAreaBtn tdd_addCornerRadius:5];
    }
    return _naAreaBtn;
}

- (UIButton *)otherAreaBtn {
    if (!_otherAreaBtn) {
        _otherAreaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _otherAreaBtn.tag = 501;
        _otherAreaBtn.backgroundColor = [UIColor cardBg];
        [_otherAreaBtn setTitle:TDDLocalized.other_regions forState:UIControlStateNormal];
        [_otherAreaBtn setTitleColor:[UIColor tdd_subTitle] forState:UIControlStateNormal];
        _otherAreaBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [_otherAreaBtn addTarget:self action:@selector(switchArea:) forControlEvents:UIControlEventTouchUpInside];
        [_otherAreaBtn tdd_addCornerRadius:5];
    }
    return _otherAreaBtn;
}

- (UIButton *)otherUnlockBtn {
    if (!_otherUnlockBtn) {
        UIImage *backgroundImage = [UIImage tdd_imageDiagGateWaySwitchBG];
        UIEdgeInsets capInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        UIImage *resizableImage = [backgroundImage resizableImageWithCapInsets:capInsets];
        _otherUnlockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_otherUnlockBtn setBackgroundImage:resizableImage forState:UIControlStateNormal];
        [_otherUnlockBtn setTitle:TDDLocalized.third_party_processing forState:UIControlStateNormal];
        [_otherUnlockBtn setTitleColor:[UIColor tdd_colorFFFFFF] forState:UIControlStateNormal];
        _otherUnlockBtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        [_otherUnlockBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 8)];
        [_otherUnlockBtn addTarget:self action:@selector(toOtherUnlockType) forControlEvents:UIControlEventTouchUpInside];
    }
    return _otherUnlockBtn;
}
@end
