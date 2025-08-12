//
//  TDD_ArtiShareView.m
//  TopdonDiagnosis
//
//  Created by zhouxiong on 2024/8/16.
//

#import "TDD_ArtiShareView.h"
#import "TDD_QRTool.h"
#import "TDD_DiagnosisTools.h"

@interface TDD_ArtiShareView ()<UITextViewDelegate,UITextFieldDelegate>
//HD
@property (nonatomic,strong) UIView * popBGView;
@property (nonatomic,strong) UIImageView * arrowImageView;

@property (nonatomic,strong) UIImageView * popImageView;
@property (nonatomic,strong) TDD_CustomTextField * emailTextField;
@property (nonatomic,strong) TDD_CustomTextField * titleTextField;
@property (nonatomic,strong) TDD_CustomTextView * contentTextView;
@property (nonatomic,strong) UIButton * sendBtn;
@property (nonatomic,strong) UIView * shareBackView;
@property (nonatomic,strong) TDD_ArtiListModel * model;
@property (nonatomic,assign) CGFloat scale;
@end

@implementation TDD_ArtiShareView

- (instancetype)initWithFrame:(CGRect)frame model:(TDD_ArtiListModel *)model {
    self = [super init];
    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
        
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        self.model = model;
        if (IS_IPad) {
            [self configIpadUI];
        }else {
            [self configUI];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackView)];
        [self addGestureRecognizer:tap];
        
        // 添加观察者
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 分享和二维码按钮弹窗
- (void)configUI {
    
    self.popImageView = [[UIImageView alloc] initWithImage:[UIImage tdd_imageSFDSharePopBG]];
    self.popImageView.userInteractionEnabled = YES;
    
    UIButton *qrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qrBtn setImage:[UIImage tdd_imageSFDQrIcon] forState:UIControlStateNormal];
    [qrBtn setTitleColor:[UIColor tdd_title] forState:UIControlStateNormal];
    qrBtn.titleLabel.font = [[UIFont systemFontOfSize:14] tdd_adaptHD];
    [qrBtn setTitle:[NSString stringWithFormat:@" %@", TDDLocalized.qr_code] forState:UIControlStateNormal];
    qrBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [qrBtn addTarget:self action:@selector(tapQR) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *emailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [emailBtn setImage:[UIImage tdd_imageSFDEmailIcon] forState:UIControlStateNormal];
    [emailBtn setTitleColor:[UIColor tdd_title] forState:UIControlStateNormal];
    emailBtn.titleLabel.font = [[UIFont systemFontOfSize:14] tdd_adaptHD];
    [emailBtn setTitle:[NSString stringWithFormat:@" %@", TDDLocalized.sign_email] forState:UIControlStateNormal];
    emailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [emailBtn addTarget:self action:@selector(tapEmail) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor tdd_line];
    
    [self addSubview:self.popImageView];
    [self.popImageView addSubview:qrBtn];
    [self.popImageView addSubview:line];
    [self.popImageView addSubview:emailBtn];
    
    CGFloat pointCenter = 0;
    for (int i = 0; i < self.model.customButtonArr.count; i++) {
        TDD_ArtiButtonModel *model = self.model.customButtonArr[i];
        if (model.uButtonId == [@(DF_ID_SHARE) intValue]) {
            CGFloat centerX = model.clickPoint.x;
            pointCenter = centerX;
            if (centerX > IphoneWidth - 70) {
                pointCenter = IphoneWidth - 70;
            }
            if (centerX < 70) {
                pointCenter = 70;
            }
            break;
        }
    }
    
    [self.popImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@140);
        make.height.equalTo(@106);
        make.bottom.equalTo(@(-kSafeBottomHeight - 55));
        make.centerX.equalTo(self.mas_left).offset(pointCenter);
    }];
    [qrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@-25);
        make.top.equalTo(@10);
        make.height.equalTo(@40);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.top.equalTo(@49);
        make.height.equalTo(@0.5);
    }];
    [emailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@-25);
        make.top.equalTo(line.mas_bottom).offset(0);
        make.height.equalTo(@40);
    }];
}

// 分享和二维码按钮弹窗
- (void)configIpadUI {
    CGFloat bottomSpace =  IS_IPad ? 100 * _scale : 58 * _scale;
    CGFloat btnFontSize = IS_IPad ? 20 : 14;
    self.popBGView = [UIView new];
    _popBGView.backgroundColor = [UIColor redColor];
    _popBGView.layer.cornerRadius = 8;
    _popBGView.layer.shadowColor = [UIColor tdd_colorWithHex:0x000000 alpha:0.25].CGColor;
    _popBGView.layer.shadowRadius = 8;
    _popBGView.layer.shadowOpacity = 0.8;
    _popBGView.layer.shadowOffset = CGSizeMake(0, 2);
    
    _arrowImageView = [[UIImageView alloc] initWithImage:kImageNamed(@"arti_share_pop_arrow")];
    
    UIButton *qrCol = [UIButton new];
    [qrCol addTarget:self action:@selector(tapQR) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *qrIcon = [[UIImageView alloc] initWithImage:[UIImage tdd_imageSFDQrIcon]];
    TDD_CustomLabel *qrLabel = [[TDD_CustomLabel alloc] init];
    qrLabel.font = kSystemFont(20);
    qrLabel.text = TDDLocalized.qr_code;
    qrLabel.textColor = [UIColor tdd_title];
    qrLabel.font = [[UIFont systemFontOfSize:btnFontSize] tdd_adaptHD];

    
    UIButton *emailCol = [UIButton new];
    [emailCol addTarget:self action:@selector(tapEmail) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *emailIcon = [[UIImageView alloc] initWithImage:[UIImage tdd_imageSFDEmailIcon]];
    TDD_CustomLabel *emailLabel = [[TDD_CustomLabel alloc] init];
    emailLabel.font = kSystemFont(20);
    emailLabel.text = TDDLocalized.sign_email;
    emailLabel.textColor = [UIColor tdd_title];
    emailLabel.font = [[UIFont systemFontOfSize:btnFontSize] tdd_adaptHD];

    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor tdd_line];
    
    [self addSubview:self.popBGView];
    [self addSubview:_arrowImageView];
    [self.popBGView addSubview:qrIcon];
    [self.popBGView addSubview:qrLabel];
    [self.popBGView addSubview:emailIcon];
    [self.popBGView addSubview:emailLabel];
    [self.popBGView addSubview:qrCol];
    [self.popBGView addSubview:line];
    [self.popBGView addSubview:emailCol];
    
    CGFloat pointCenter = 0;
    for (int i = 0; i < self.model.customButtonArr.count; i++) {
        TDD_ArtiButtonModel *model = self.model.customButtonArr[i];
        if (model.uButtonId == [@(DF_ID_SHARE) intValue]) {
            CGFloat centerX = model.clickPoint.x;
            pointCenter = centerX;
            if (centerX > IphoneWidth - 130 * _scale) {
                pointCenter = IphoneWidth - 130 * _scale;
            }
            if (centerX < 130 * _scale) {
                pointCenter = 130 * _scale;
            }
            break;
        }
    }
    
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-bottomSpace - iPhoneX_D);
        make.centerX.equalTo(self.mas_left).offset(pointCenter);
        
    }];
    [self.popBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_arrowImageView.mas_top);
        make.centerX.equalTo(_arrowImageView);
        make.width.mas_equalTo(260 * _scale);
        make.height.mas_equalTo(120 * _scale);
    }];
    [qrCol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.popBGView);
        make.height.mas_equalTo(60 * _scale);
    }];
    [qrIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(24 * _scale, 24 * _scale));
        make.left.equalTo(qrCol).offset(20 * _scale);
        make.centerY.equalTo(qrCol);
    }];
    [qrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(qrIcon.mas_right).offset(10 * _scale);
        make.centerY.equalTo(qrCol);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.popBGView);
        make.top.equalTo(qrCol.mas_bottom);
        make.height.equalTo(@1);
    }];
    [emailCol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.popBGView);
        make.height.mas_equalTo(60 * _scale);
        make.top.equalTo(line.mas_bottom);
    }];
    [emailIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(24 * _scale, 24 * _scale));
        make.left.equalTo(emailCol).offset(20 * _scale);
        make.centerY.equalTo(emailCol);
    }];
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(emailIcon.mas_right).offset(10 * _scale);
        make.centerY.equalTo(emailCol);
    }];
}

// 二维码弹窗
- (void)tapQR {
    if (IS_IPad) {
        [self.popBGView removeFromSuperview];
        [self.arrowImageView removeFromSuperview];
    }else {
        [self.popImageView removeFromSuperview];
    }
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    UIView * whiteView = [[UIView alloc] init];
    whiteView.backgroundColor =  UIColor.tdd_alertBg;
    whiteView.layer.cornerRadius = 2.5;
        
    TDD_VXXScrollLabel *titleLabel = [[TDD_VXXScrollLabel alloc] init];
    titleLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 24 : 16 weight:UIFontWeightBold] tdd_adaptHD];
    titleLabel.textColor = [UIColor tdd_title];
    titleLabel.text = TDDLocalized.scan_qr_code_to_share;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *imageView  = [[UIImageView alloc] init];
    UIImage *qrImage = [TDD_QRTool generateQRCodeFromString:self.model.strShareContent withSize:IS_IPad ? 200 : 140];
    imageView.image = qrImage;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor tdd_line];

    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setTitleColor:[UIColor tdd_colorDiagTheme] forState:UIControlStateNormal];
    okBtn.titleLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 22 : 16] tdd_adaptHD];
    [okBtn setTitle:TDDLocalized.app_confirm forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(tapQROK) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:whiteView];
    [whiteView addSubview:titleLabel];
    [whiteView addSubview:imageView];
    [whiteView addSubview:line];
    [whiteView addSubview:okBtn];

    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.equalTo(IS_IPad ? @(400 * _scale) : @(283 * _scale));
        make.height.equalTo(IS_IPad ? @(412 * _scale) : @(269 * _scale));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(IS_IPad ? @(30 * _scale) : @(22.5 * _scale));
        make.centerX.equalTo(whiteView);
        make.left.equalTo(IS_IPad ? @(68 * _scale) : @(16 * _scale));
        make.right.equalTo(IS_IPad ? @(-68 * _scale) : @(-16 * _scale));
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(IS_IPad ? (40 * _scale) : (14.5 * _scale));
        make.centerX.equalTo(whiteView);
        make.width.height.equalTo(IS_IPad ? @(200 * _scale) : @(140 * _scale));
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(IS_IPad ? @(-66 * _scale) : @(-49 * _scale));
        make.height.equalTo(@0.5);
    }];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(line.mas_bottom).offset(0);
        make.bottom.equalTo(@0);
    }];
}

// 分享输入弹窗
- (void)tapEmail {
    CGFloat leftSpace = IS_IPad ? 40 : 20;
    CGFloat textH = IS_IPad ? 50 : 40;
    CGFloat btnH = IS_IPad ? 67 : 49;
    if (IS_IPad) {
        [self.popBGView removeFromSuperview];
        [self.arrowImageView removeFromSuperview];
    }else {
        [self.popImageView removeFromSuperview];
    }
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    UIView * whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = UIColor.tdd_alertBg;
    whiteView.layer.cornerRadius = 2.5;
    self.shareBackView = whiteView;

    TDD_CustomLabel *titleLabel = [[TDD_CustomLabel alloc] init];
    titleLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 24 : 16 weight:UIFontWeightSemibold] tdd_adaptHD];
    titleLabel.textColor = [UIColor tdd_title];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = TDDLocalized.sign_email;
    
    TDD_CustomTextField *emailText = [self creatTextField];
    self.emailTextField = emailText;
    self.emailTextField.font = [[UIFont systemFontOfSize:IS_IPad ? 20 : 12] tdd_adaptHD];
    self.emailTextField.placeholder = TDDLocalized.to;
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailTextField.delegate = self;

    if ([self td_isValidateEmail:[TDD_ArtiGlobalModel sharedArtiGlobalModel].strShareAccount]) {
        self.emailTextField.text = [TDD_ArtiGlobalModel sharedArtiGlobalModel].strShareAccount;
    } else {
        NSString *userAccount = [TDD_DiagnosisTools userAccount];
        if ([self td_isValidateEmail: userAccount]) {
            self.emailTextField.text = userAccount;
        }
    }

    TDD_CustomTextField *titleText = [self creatTextField];
    self.titleTextField = titleText;
    self.titleTextField.font = [[UIFont systemFontOfSize:IS_IPad ? 20 : 12] tdd_adaptHD];
    self.titleTextField.text = self.model.strShareTitle;
    self.titleTextField.delegate = self;
    
    self.contentTextView = [[TDD_CustomTextView alloc] init];
    self.contentTextView.layer.backgroundColor = UIColor.tdd_textFieldBg.CGColor;
    self.contentTextView.layer.cornerRadius = 2.5;
    self.contentTextView.font = [[UIFont systemFontOfSize:IS_IPad ? 20 : 12] tdd_adaptHD];
    self.contentTextView.textColor = [UIColor tdd_title];
    // 设置上下左右内边距
    self.contentTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16);
    // 移除额外的左右内边距（默认为 5）
    self.contentTextView.textContainer.lineFragmentPadding = 0;
    self.contentTextView.text = self.model.strShareContent;
    self.contentTextView.delegate = self;

    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor tdd_line];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor tdd_line];

    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitleColor:[UIColor tdd_color999999] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 22 : 16] tdd_adaptHD];
    [cancelBtn setTitle:TDDLocalized.app_cancel forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(tapShareCancel) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setTitleColor:[UIColor tdd_colorDiagTheme] forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor tdd_btnDisableBackground] forState:UIControlStateDisabled];
    okBtn.titleLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 22 : 16] tdd_adaptHD];
    [okBtn setTitle:TDDLocalized.send forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(tapShareOK) forControlEvents:UIControlEventTouchUpInside];
    self.sendBtn = okBtn;
    
    [self addSubview:whiteView];
    [whiteView addSubview:titleLabel];
    [whiteView addSubview:self.emailTextField];
    [whiteView addSubview:self.titleTextField];
    [whiteView addSubview:self.contentTextView];
    [whiteView addSubview:line];
    [whiteView addSubview:line2];
    [whiteView addSubview:cancelBtn];
    [whiteView addSubview:okBtn];

    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.left.equalTo(self).offset(IS_IPad ? 212 : 46);
        make.height.equalTo(IS_IPad ? @566 : @394);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(IS_IPad ? @30 : @22.5);
        make.centerX.equalTo(whiteView);
        make.left.equalTo(IS_IPad ? @40 : @10);
        make.right.equalTo(IS_IPad ? @-40 : @-10);
    }];
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(IS_IPad ? 24 : 14.5);
        make.centerX.equalTo(whiteView);
        make.left.equalTo(whiteView).offset(leftSpace);
        make.height.mas_equalTo(textH);
    }];
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTextField.mas_bottom).offset(12);
        make.centerX.equalTo(whiteView);
        make.left.equalTo(whiteView).offset(leftSpace);
        make.height.mas_equalTo(textH);
    }];
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleTextField.mas_bottom).offset(12);
        make.centerX.equalTo(whiteView);
        make.left.equalTo(whiteView).offset(leftSpace);
        make.height.equalTo(IS_IPad ? @230 : @160);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(whiteView).offset(-btnH);
        make.height.equalTo(@0.5);
    }];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(@0);
        make.height.mas_equalTo(btnH);
        make.left.equalTo(whiteView.mas_centerX).offset(0);
    }];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(whiteView);
        make.centerY.equalTo(okBtn);
        make.width.equalTo(@1);
        make.height.equalTo(IS_IPad ? @28 : @20);
    }];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(@0);
        make.height.mas_equalTo(btnH);
        make.right.equalTo(whiteView.mas_centerX).offset(0);
    }];
    
}

- (void)tapQROK {
    [self removeFromSuperview];
}

- (void)tapShareCancel {
    [self endEditing:YES];
    [self removeFromSuperview];
}

- (void)tapShareOK {
    [self endEditing:YES];
    if (![self td_isValidateEmail:self.emailTextField.text]) {
        [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.lms_enter_email_error_tips];
        return;
    }
    if ([NSString tdd_isEmpty:self.contentTextView.text]) {
        [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.email_content_error_tip];
        return;
    }
    [self requestShare];
}

- (void)tapBackView {
    if ([self.subviews containsObject:self.popImageView] || [self.subviews containsObject:self.popBGView]) {
        [self removeFromSuperview];
    }
    [self endEditing:YES];
}

- (void)requestShare {
    if (![[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
        return;
    }
    
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setValue:self.emailTextField.text forKey:@"toEmail"];
    [param setValue:self.titleTextField.text forKey:@"emailSubject"];
    [param setValue:self.contentTextView.text forKey:@"emailContent"];

    @kWeakObj(self)
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_UploadShareReport param:param completeHandle:^(id  _Nonnull result) {
        @kStrongObj(self)
        
        NSDictionary *responsDic = result;
        NSInteger code = [responsDic tdd_getIntValueForKey:@"code" defaultValue:-1];
//        NSString *codeStr = [NSString stringWithFormat:@"%ld",(long)code];
//        NSString *msg = responsDic[@"msg"];
        if (code == 2000) {
            [self removeFromSuperview];
            [TDD_ArtiGlobalModel sharedArtiGlobalModel].strShareAccount = self.emailTextField.text;
        }
    }];
}


// 键盘显示时调用的方法
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    // 调整窗口上的 view 位置
    if ([self.contentTextView isFirstResponder]) {
        [self.shareBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(@(-kbSize.height + (IS_IPad ? 67 : 49)));
            make.left.equalTo(self).offset(IS_IPad ? 212 : 46);
            make.height.equalTo(IS_IPad ? @566 : @394);
        }];
    }
}

- (void)textViewDidEndEditing:(TDD_CustomTextView *)textView {
    [self.shareBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.left.equalTo(self).offset(IS_IPad ? 212 : 46);
        make.height.equalTo(IS_IPad ? @566 : @394);
    }];
    _sendBtn.enabled = (![NSString tdd_isEmpty:_emailTextField.text] && ![NSString tdd_isEmpty:_titleTextField.text] && ![NSString tdd_isEmpty:_contentTextView.text]);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _sendBtn.enabled = (![NSString tdd_isEmpty:_emailTextField.text] && ![NSString tdd_isEmpty:_titleTextField.text] && ![NSString tdd_isEmpty:_contentTextView.text]);
}

- (TDD_CustomTextField *)creatTextField {
    TDD_CustomTextField *textField = [[TDD_CustomTextField alloc] init];
    textField.layer.backgroundColor = UIColor.tdd_textFieldBg.CGColor;
    textField.layer.cornerRadius = 2.5;
    textField.font = [[UIFont systemFontOfSize:12] tdd_adaptHD];
    textField.textColor = [UIColor tdd_title];

    // 左侧偏移量
    UIView *leftPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 40)];
    textField.leftView = leftPaddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;

    // 右侧偏移量
    UIView *rightPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 40)];
    textField.rightView = rightPaddingView;
    textField.rightViewMode = UITextFieldViewModeAlways;

    return textField;
}

- (BOOL)td_isValidateEmail:(NSString *)str {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
}

@end
