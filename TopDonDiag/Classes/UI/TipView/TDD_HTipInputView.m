//
//  TDD_HTipInputView.m
//  AD200
//
//  Created by AppTD on 2022/8/30.
//

#import "TDD_HTipInputView.h"

@interface TDD_HTipInputView ()
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * defaultValue;
@property (nonatomic, strong) NSMutableArray * btnArr;
@property (nonatomic,copy) CompleteBlock completeBlock;
@property (nonatomic, assign) BOOL delayDismiss;
@property (nonatomic, assign) CGFloat scale;

@end

@implementation TDD_HTipInputView

- (instancetype)initWithTitle:(NSString *)title delayDismiss:(BOOL )delayDismiss completeBlock:(CompleteBlock)completeBlock{
    self = [super init];
    if (self) {
        self.title = title;
        self.completeBlock = completeBlock;
        self.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.delayDismiss = delayDismiss;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        
        [self creatUI];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title completeBlock:(CompleteBlock)completeBlock{
    self = [super init];
    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
        self.title = title;
        self.completeBlock = completeBlock;
        self.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        
        [self creatUI];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                 delayDismiss:(BOOL )delayDismiss
                 defaultValue:(NSString *)defaultValue
    completeBlock:(CompleteBlock)completeBlock {
    self = [super init];
    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
        self.title = title;
        self.delayDismiss = delayDismiss;
        self.defaultValue = defaultValue;
        self.completeBlock = completeBlock;
        self.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        
        [self creatUI];
    }
    return self;
    
}

- (void)creatUI
{
    float btnTop = isTopVCI ? 28 : 0;
    float btnHeight = (isTopVCI ? 44 : (IS_IPad ? 67 : 48)) * _scale;
    float btnBottom = isTopVCI ? 24 : 0;
    float btnMargin = isTopVCI ? 20 : 0;
    CGFloat leftSpace = (IS_IPad ? 272 : 30) * _scale;
    CGFloat topSpace = (IS_IPad ? 40 : 20) * _scale;
    float whiteWidth = IphoneWidth - leftSpace * 2;
    CGFloat fontSize = IS_IPad ? 22 : 16;
    CGFloat midFontSize = IS_IPad ? 20 : 15;
    UIView * whiteView = [[UIView alloc] init];
    whiteView.layer.backgroundColor = UIColor.tdd_alertBg.CGColor;
    whiteView.layer.cornerRadius = 10;
    [self addSubview:whiteView];
    
    TDD_CustomLabel * titleLabel = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:fontSize weight:UIFontWeightBold] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [TDD_HLanguage getLanguage:self.title];
        label;
    });
    [whiteView addSubview:titleLabel];
    
    UILabel * localL = ({
        UILabel * label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [[UIColor tdd_title] colorWithAlphaComponent:0.5];
        label.numberOfLines = 2;
        label;
    });
    if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
        [whiteView addSubview:localL];
    }

    self.inputTextField = [[TDD_CustomTextField alloc] initWithFrame:CGRectMake(0, 265 * _scale, IphoneWidth, 45 * _scale)];

    self.inputTextField.layer.backgroundColor = UIColor.tdd_textFieldBg.CGColor;
    self.inputTextField.layer.cornerRadius = 6 * _scale;
    self.inputTextField.font = [[UIFont systemFontOfSize:midFontSize] tdd_adaptHD];
    self.inputTextField.textColor= [UIColor tdd_title];
    if ([NSString tdd_isEmpty:self.defaultValue]) {
        self.inputTextField.text = [NSString stringWithFormat:@"%@",[NSDate tdd_getTimeStringWithInterval:[NSDate tdd_getTimestampSince1970] Format:@"yyyy-MM-dd-HH-mm-ss"]];
    }else {
        self.inputTextField.text = _defaultValue;
    }

    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 * _scale, 0)];
    self.inputTextField.leftView = leftView;
    self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
    if (isKindOfTopVCI){
        UIButton *clearButton = [self.inputTextField valueForKey:@"_clearButton"];
        if (clearButton){
            [clearButton setImage:kImageNamed(@"textfiled_clear") forState:UIControlStateNormal];
        }
        if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
            localL.text = TDDLocalized.save_location;
        }
    }


    self.showClearBtn = NO;
    
    [self.inputTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    [whiteView addSubview:self.inputTextField];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor tdd_alertLineColor];
    [whiteView addSubview:lineView];
    
    NSArray * arr = @[@"app_cancel",@"app_confirm"];
    
    
    UIButton * lastButton;
    float btn_w = isTopVCI ? (IphoneWidth - (leftSpace * 2) - 40 - 20) / 2 : whiteWidth / 2;
    
    UIView *horizontalLineView = [[UIView alloc] init];
    horizontalLineView.backgroundColor = [UIColor tdd_alertLineColor];
    [whiteView addSubview:horizontalLineView];
    horizontalLineView.hidden = isTopVCI;
    
    for (int i = 0; i < arr.count; i ++) {
        UIButton * btn = ({
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [[UIFont systemFontOfSize:fontSize] tdd_adaptHD];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[TDD_HLanguage getLanguage:arr[i]] forState:UIControlStateNormal];
            UIColor *txtColor = (i == 0) ? [UIColor tdd_subTitle] : [UIColor tdd_colorDiagTheme];
            if isTopVCI {
                if (i == 0){
                    btn.backgroundColor = UIColor.tdd_line;
                } else {
                    btn.backgroundColor = UIColor.tdd_colorDiagTheme;
                }
                txtColor = UIColor.tdd_title;
                btn.layer.cornerRadius = 5;
                btn.layer.masksToBounds = YES;
            }
            [btn setTitleColor:txtColor forState:UIControlStateNormal];
            btn;
        });
        [whiteView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(btnTop);
            make.height.mas_equalTo(btnHeight * _scale);
            make.width.mas_equalTo(btn_w);
            if (lastButton) {
                make.left.equalTo(lastButton.mas_right).offset(btnMargin);
            }else {
                make.left.equalTo(whiteView).offset(btnMargin);
            }
        }];
        
        [self.btnArr addObject:btn];
        
        lastButton = btn;
    }
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, leftSpace, 0, leftSpace));
        make.center.equalTo(self);
        make.bottom.equalTo(lastButton.mas_bottom).offset(btnBottom);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(whiteView).insets(UIEdgeInsetsMake(topSpace, topSpace, 0, topSpace));
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(whiteView).insets(UIEdgeInsetsMake(0, 23 * _scale, 0, 23 * _scale));
        make.top.equalTo(titleLabel.mas_bottom).offset(topSpace);
        make.height.mas_equalTo(IS_IPad ? 50 * _scale : 40 * _scale);
    }];
    
    if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
        [localL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.inputTextField);
            make.top.equalTo(self.inputTextField.mas_bottom).offset(16 * H_Height);
        }];
    }
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(whiteView).insets(UIEdgeInsetsMake(0, 0 * _scale, 0, 0 * _scale));
        if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
            make.top.equalTo(localL.mas_bottom).offset(25 * _scale);

        }else {
            make.top.equalTo(self.inputTextField.mas_bottom).offset(IS_IPad ? topSpace : 25 * _scale);
        }
        
        make.height.mas_equalTo(1 * _scale);
    }];
    
    [horizontalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(whiteView);
        make.top.equalTo(lineView.mas_bottom).offset(14 * _scale);
        make.width.mas_equalTo(1 * _scale);
        make.bottom.equalTo(whiteView).offset(-14 * _scale);
    }];

    lineView.hidden = isTopVCI;
}

- (void)btnClick:(UIButton *)button
{
    int i = (int)[self.btnArr indexOfObject:button];
    
    if (self.completeBlock) {
        self.completeBlock(self.inputTextField.text, i);
    }
    
    if (!_delayDismiss) {
        [self removeFromSuperview];
    }

}

- (void)textDidChange:(UITextField *)textField
{
    UIButton * btn = self.btnArr[1];
    
    if (self.inputTextField.text.length == 0) {
        btn.enabled = NO;
        [btn setTitleColor:[UIColor tdd_subTitle] forState:UIControlStateNormal];
        if isTopVCI {
            btn.backgroundColor = [UIColor.tdd_colorDiagTheme colorWithAlphaComponent:0.6];
        }
    }else {
        btn.enabled = YES;
        [btn setTitleColor:[UIColor tdd_colorDiagTheme] forState:UIControlStateNormal];
        if isTopVCI {
            [btn setTitleColor:UIColor.tdd_title forState:UIControlStateNormal];
            btn.backgroundColor = UIColor.tdd_colorDiagTheme;
        }
        
    }
}

- (void)setShowClearBtn:(BOOL)showClearBtn
{
    _showClearBtn = showClearBtn;
    
    if (showClearBtn) {
        self.inputTextField.rightView = nil;
        self.inputTextField.clearButtonMode = UITextFieldViewModeAlways;
    } else {
        UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 37 * _scale, 0)];
        self.inputTextField.rightView = rightView;
        self.inputTextField.rightViewMode = UITextFieldViewModeAlways;
    }
}

- (void)tapClick
{
    [self endEditing:YES];
}

- (NSMutableArray *)btnArr
{
    if (!_btnArr) {
        _btnArr = [[NSMutableArray alloc] init];
    }
    
    return _btnArr;
}

@end
