//
//  TDD_ArtiKeyboardView.m
//  AD200
//
//  Created by AppTD on 2022/10/13.
//

#import "TDD_ArtiKeyboardView.h"
@import TDBasis;

@interface TDD_ArtiKeyboardView ()
@property (nonatomic, weak) UIView<UITextInput> * textInputView;
@property (nonatomic, strong) UIView * lastView;
@property (nonatomic, strong) NSArray *disableKeys;
@property (nonatomic, strong) UIButton *hightlightBtn;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, assign) CGFloat verticalSpace;
@property (nonatomic, assign) CGFloat horizontalSpace;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, assign) CGFloat keyboardWidth;
@end


@implementation TDD_ArtiKeyboardView
- (instancetype)initWithType:(ArtiKeyboardType)type;
{
    if(self = [super init]){
        self.type = type;
        _scale = IS_IPad ? HD_Height : H_Height;
        _leftSpace = (IS_IPad ? 16 : 14) * _scale;
        _topSpace = (IS_IPad ? 19 : 14) * _scale;
        _verticalSpace = (IS_IPad ? 10 : 6) * _scale;
        _horizontalSpace = (IS_IPad ? 10 : 4) * _scale;
        _keyboardHeight = (IS_IPad ? 50 : 39) * _scale;
        _keyboardWidth = ((IphoneWidth - _leftSpace * 2 - _horizontalSpace * 9) / 10.0);
        
        double height = _topSpace + _keyboardHeight * 3 + _verticalSpace * 2 + 73 * _scale + iPhoneX_D;
        self.frame = CGRectMake(0, 0, IphoneWidth, height);
        self.backgroundColor = [UIColor tdd_keyboardViewBackground];
        [self addObserver];
        [self createKeyBoardWithType:type];
    };
    return self;
}
- (instancetype)init{
    self = [super init];
    
    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
        _leftSpace = (IS_IPad ? 16 : 14) * _scale;
        _topSpace = (IS_IPad ? 19 : 14) * _scale;
        _verticalSpace = (IS_IPad ? 10 : 6) * _scale;
        _horizontalSpace = (IS_IPad ? 10 : 4) * _scale;
        _keyboardHeight = (IS_IPad ? 35 : 39) * _scale;
        _keyboardWidth = ((IphoneWidth - _leftSpace * 2 - _horizontalSpace * 9) / 10.0);
        
        double height = _topSpace + _keyboardHeight * 3 + _verticalSpace * 2 + 73 * _scale + iPhoneX_D;
        self.frame = CGRectMake(0, 0, IphoneWidth, height);
        self.backgroundColor = [UIColor tdd_keyboardViewBackground];
        [self addObserver];
        [self creatKeyboardWithType:ArtiInput_F];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
//    self.layer.shadowOffset = CGSizeMake(4,4);
//    self.layer.shadowOpacity = 1 * _scale;
//    self.layer.shadowRadius = 10 * _scale;
}

- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputViewDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputViewDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
}

- (void)textInputViewDidBeginEditing:(NSNotification*)notification{
    _textInputView = notification.object;
    
}

- (void)textInputViewDidEndEditing:(NSNotification*)notification{
    NSString *strValue = [self inputViewString];
    [self setInputViewString:strValue];
    _textInputView = nil;
}

- (void)setInputViewString:(NSString *)string{
    if ([self.textInputView isKindOfClass:[TDD_CustomTextView class]]){
        ((TDD_CustomTextView *)self.textInputView).text = string;
    }else if ([self.textInputView isKindOfClass:[TDD_CustomTextField class]]){
        ((TDD_CustomTextField *)self.textInputView).text = string;
    }
}

- (NSString *)inputViewString{
    NSString *strValue = @"";
    if ([self.textInputView isKindOfClass:[TDD_CustomTextView class]]){
        strValue = ((TDD_CustomTextView *)self.textInputView).text;
    }else if ([self.textInputView isKindOfClass:[TDD_CustomTextField class]]){
        strValue = ((TDD_CustomTextField *)self.textInputView).text;
    }
    return strValue;
}

- (void)createKeyBoardWithType:(ArtiKeyboardType)type {
    if(type == ArtiKeyboardT){
        //#号键盘
        [self TKeyboard];
    }else if(type == ArtiKeyboardA){
        //A键盘
        [self AKeyBoard];
    }else if (type == ArtiKeyboardB){
        //B键盘
        [self BKeyBoard];
    }else if (type == ArtiKeyboardF){
        //f键盘
        [self FKeyboard];
    }else if (type == ArtiKeyboardV){
        //V键盘
        [self VKeyboard];
    }else if (type == ArtiKeyboard0){
        //数字键盘
        [self numberKeyBoard];
    }
    
}
- (void)creatKeyboardWithType:(ArtiInputType)artiInputType
{
    //NSArray * arr = @[@"+",@"-",@"*",@"/",@"Backspace"];
    
    for (int i = 0; i < 3; i ++) {
        if (i == 0) {
            //数字
          
        }else if (i == 1) {
            
        }
    }
}

#pragma mark 数字键盘
- (void)numberKeyBoard {
    CGFloat leftSpace = (IS_IPad ? 67 : 14.5) *_scale;
    CGFloat horizontal = (IS_IPad ? 10 : 8) *_scale;
    [self createNumberButtonsWithTitles:@[] leftSpace:leftSpace horizontal:horizontal];
    
    
}

#pragma mark A键盘
- (void)AKeyBoard{
    
    [self creatButtonsWithTitles:@[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"] leftSpace:_leftSpace];
    [self creatButtonsWithTitles:@[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"] leftSpace:_leftSpace + _keyboardWidth * 0.5];
    [self creatButtonsWithTitles:@[@"Z",@"X",@"C",@"V",@"B",@"N",@"M"] leftSpace:_leftSpace];
    [self createEnterButton];
    
}
#pragma mark B键盘
- (void)BKeyBoard{

    [self creatButtonsWithTitles:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"] leftSpace:_leftSpace];
    [self AKeyBoard];
    [self createEnterButton];
}
#pragma mark f键盘
- (void)FKeyboard{
    
    [self creatButtonsWithTitles:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"] leftSpace:_leftSpace];
    [self creatButtonsWithTitles:@[@"A",@"B",@"C",@"D",@"E",@"F"] leftSpace:_leftSpace];
    [self createEnterButton];
    return;
  
}
#pragma mark V键盘
- (void)VKeyboard{
    self.disableKeys = @[@"Q",@"I",@"O"];
    [self creatButtonsWithTitles:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"] leftSpace:_leftSpace];
    [self creatButtonsWithTitles:@[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"] leftSpace:_leftSpace];
    [self creatButtonsWithTitles:@[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"] leftSpace:_leftSpace + _keyboardWidth * 0.5];
    [self creatButtonsWithTitles:@[@"Z",@"X",@"C",@"V",@"B",@"N",@"M"] leftSpace:_leftSpace];
    [self createEnterButton];
    self.disableKeys = @[];
    return;
}
#pragma mark #键盘
- (void)TKeyboard{
    
    [self creatButtonsWithTitles:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"] leftSpace:_leftSpace];
    if (IS_IPad){
        CGFloat width = ((IphoneWidth - 2 * _leftSpace - 4 * _horizontalSpace - 4 * _keyboardWidth) / 4.0);
        [self creatButtonsWithTitles:@[@"+",@"-",@"*",@"/",@"."] leftSpace:_leftSpace width:width];
    }else {
        [self creatButtonsWithTitles:@[@"+",@"-",@"*",@"/",@"."] leftSpace:_leftSpace width:48 * _scale];
    }
    
    [self createEnterButton];

}
//创建键盘按钮
- (void)creatButtonsWithTitles:(NSArray *)titles leftSpace:(CGFloat)leftSpace{
    [self creatButtonsWithTitles:titles leftSpace:leftSpace width:_keyboardWidth];
}

- (void)creatButtonsWithTitles:(NSArray *)titles leftSpace:(CGFloat)leftSpace width:(CGFloat)width {
    
    for (int i = 0; i < titles.count; i++) {
        UIButton * button = [self creatKeyboardButtonWithTitle:titles[i] tag:i];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                if (self.lastView) {
                    make.top.equalTo(self.lastView.mas_bottom).offset(_verticalSpace * _scale);
                }else {
                    make.top.equalTo(self).offset(_topSpace);
                }
                make.left.equalTo(self).offset(leftSpace * _scale);
            }else {
                make.top.equalTo(self.lastView);
                make.left.equalTo(self.lastView.mas_right).offset(_horizontalSpace * _scale);
            }
            make.size.mas_equalTo(CGSizeMake(width, _keyboardHeight));
        }];
        NSString *title = titles[i];
        if([title isEqualToString:@"*"]){
            button.titleEdgeInsets = UIEdgeInsetsMake(8 * _scale, 0, 0 * _scale, 0);
        }
        self.lastView = button;
    }
    
}

- (void)createNumberButtonsWithTitles:(NSArray *)titles leftSpace:(CGFloat)leftSpace horizontal:(CGFloat)horizontal {
    
    CGFloat width = (IphoneWidth - (leftSpace * 2) - (horizontal * 2)) / 3;
    CGFloat height = 50 * _scale;
    if (titles.count == 0){
        titles = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"image@keyboard_exit",@"0",@"Enter"];
    }
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [self creatNumberKeyboardButtonWithTitle:titles[i] tag:100 + i];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                if (self.lastView) {
                    make.top.equalTo(self.lastView.mas_bottom).offset(horizontal);
                }else {
                    make.top.equalTo(self).offset((IS_IPad ? 20 : 16) * _scale);
                }
                make.left.equalTo(self).offset(leftSpace);
            }else {
                make.top.equalTo(self.lastView).offset((i % 3==0)? (height+horizontal) : 0);
                if (i % 3 == 0){
                    make.left.equalTo(self).offset(leftSpace);
                }else {
                    make.left.equalTo(self.lastView.mas_right).offset(horizontal);
                }
            }
            make.size.mas_equalTo(CGSizeMake(width, height));
        }];
        self.lastView = btn;
    }
    [self layoutIfNeeded];
    CGRect frame = self.lastView.frame;
    self.frame = CGRectMake(0, 0, IphoneWidth, frame.origin.y + frame.size.height + 44 * _scale);
}

- (UIButton *)creatNumberKeyboardButtonWithTitle:(NSString *)title tag:(int)tag {
    if ([title containsString:@"image@"]){
        UIButton *btn = [self creatKeyboardButtonWithImage:[title stringByReplacingOccurrencesOfString:@"image@" withString:@""] tag:0];
        if ([title isEqualToString:@"image@keyboard_exit"]){
            btn.tag = 14;
            btn.backgroundColor = [UIColor tdd_keyboardDeleteBackground];
        }
        return btn;
    }
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.borderColor = UIColor.clearColor.CGColor;
    if(title.length){
        [btn setTitle:title forState:UIControlStateNormal];
    }
    CGFloat fontSize = 20;
    UIColor *backgroundColor = [UIColor tdd_keyboardItemNormalBackground];
    UIColor *titleColor = [UIColor tdd_keyboardItemNormalTitle];
    if ([title isEqualToString:@"Enter"]){
        tag = 15;
        fontSize = 16;
        backgroundColor = [UIColor tdd_keyboardEnterBackground];
        titleColor = [UIColor whiteColor];
    }
    btn.tag = tag;
    btn.titleLabel.font = [[UIFont systemFontOfSize:fontSize] tdd_adaptHD];
    btn.layer.cornerRadius = 4.6 * _scale;
    btn.layer.borderWidth = 1;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
//    [btn td_setborderColor:UIColor.clearColor forState:UIControlStateNormal animated:NO];
//    [btn td_setborderColor:UIColor.tdd_colorDiagTheme forState:UIControlStateHighlighted animated:NO];
//    [btn td_setBackgroundColor:backgroundColor forState:UIControlStateNormal animated:NO];
    btn.backgroundColor = backgroundColor;
    btn.enabled = YES;
    [btn addTarget:self action:@selector(keyboardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(btnClickDown:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(btnClickCancel:) forControlEvents:UIControlEventTouchUpOutside];
    
    return btn ;
}

//回车换行键 删除键
- (void)createEnterButton{
    
    UIButton * deleteBtn = [self creatKeyboardButtonWithImage:@"keyboard_exit" tag:14];
    deleteBtn.backgroundColor = [UIColor tdd_keyboardDeleteBackground];
    [self addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lastView.mas_right).offset(_horizontalSpace);
        make.right.equalTo(self).offset(-_leftSpace);
        make.top.bottom.equalTo(self.lastView);
    }];
    
    UIButton *minusBtn;
    if (self.type == ArtiKeyboardV || self.type == ArtiKeyboardB){
        minusBtn = [self creatKeyboardButtonWithTitle:@"-" tag:16];
        [self addSubview:minusBtn];
        [minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(_leftSpace);
            make.top.equalTo(self.lastView.mas_bottom).offset(_verticalSpace);
            make.size.mas_equalTo(CGSizeMake(_keyboardWidth * 2, _keyboardHeight));
        }];
    }
    
    UIButton  *enterBtn  = [self creatKeyboardButtonWithTitle:nil tag:15];
    enterBtn.layer.borderWidth = 0;
    [self addSubview:enterBtn];
    [enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if(minusBtn){
            make.left.equalTo(minusBtn.mas_right).offset(_horizontalSpace);
        }else {
            make.left.equalTo(self).offset(_leftSpace);
        }
        make.right.equalTo(self).offset(-_leftSpace);
        make.top.equalTo(self.lastView.mas_bottom).offset(_verticalSpace);
        make.height.mas_equalTo(_keyboardHeight);
    }];
    [self layoutIfNeeded];
    
    [enterBtn td_setBackgroundColor:[UIColor tdd_keyboardEnterBackground] forState:UIControlStateNormal animated:NO];
    [enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [enterBtn setTitle:@"Enter" forState:0];
    enterBtn.layer.cornerRadius  = 5;
    enterBtn.layer.masksToBounds = YES;
    
    CGRect frame = enterBtn.frame;
    self.frame = CGRectMake(0, 0, IphoneWidth, frame.origin.y + frame.size.height + 44 * _scale);
}

- (UIButton *)creatKeyboardButtonWithTitle:(NSString *)title tag:(int)tag
{
    UIButton * btn = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = tag;
        if(title.length){
            [btn setTitle:title forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [[UIFont systemFontOfSize:16] tdd_adaptHD];
        btn.layer.cornerRadius = 2.5 * _scale;
        btn.layer.borderWidth = 1;
        
        UIColor *disableBG = [UIColor tdd_keyboardItemDisableBackground];
        UIColor *normalBG = [UIColor tdd_keyboardItemNormalBackground];
        
        UIColor *normalTitle = [UIColor tdd_keyboardItemNormalTitle];
        UIColor *disableTitle = [UIColor tdd_keyboardItemDisableTitle];
        
        [btn setTitleColor:normalTitle forState:UIControlStateNormal];
        [btn setTitleColor:disableTitle forState:UIControlStateDisabled];
//        [btn td_setborderColor:UIColor.clearColor forState:UIControlStateNormal animated:NO];
//        [btn td_setborderColor:[UIColor tdd_keyboardItemHightlightBorderColor] forState:UIControlStateHighlighted animated:NO];
        btn.layer.borderColor = UIColor.clearColor.CGColor;
        if ([self.disableKeys containsObject:title]){
            btn.enabled = NO;
            btn.backgroundColor = disableBG;
        }else{
            btn.backgroundColor = normalBG;
            btn.enabled = YES;
            [btn addTarget:self action:@selector(keyboardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(btnClickDown:) forControlEvents:UIControlEventTouchDown];
            [btn addTarget:self action:@selector(btnClickCancel:) forControlEvents:UIControlEventTouchUpOutside];
        }

        btn;
    });
    
    return btn;
}

- (UIButton *)creatKeyboardButtonWithImage:(NSString *)image tag:(int)tag
{
    UIButton * btn = [self creatKeyboardButtonWithTitle:@"" tag:tag];
    UIImage *img;
    if ([image isEqualToString:@"keyboard_exit"]){
        img = [UIImage tdd_imageDiagKeyboardDelete];
    }else {
        img = kImageNamed(image);
    }
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:img forState:UIControlStateHighlighted];
    return btn;
}

- (void)keyboardButtonClick:(UIButton *)button
{
    [self.hightlightBtn setHidden:YES];
    button.layer.borderColor = UIColor.clearColor.CGColor;
    NSInteger tag    = button.tag;
    NSString * title = button.titleLabel.text;
    if(tag == 14){
        //删除
        if (self.deleteBlock) {
            self.deleteBlock();
        }
//        [_textInputView deleteBackward];
        return;
    }else if (tag == 15){
        //回车收键盘
        if (self.enterBlock) {
            self.enterBlock();
        }
        //[_textInputView resignFirstResponder];
        return;
    }
    if (self.insertBlock) {
        self.insertBlock(title);
    }
    if (button.tag != 15){
        [button setBackgroundColor:[UIColor tdd_keyboardItemNormalBackground]];
    }
    //textView 的 insertText 不会触发shouldChangeTextInRange
    //[_textInputView insertText:title];
}
    

- (void)setGradientView:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor {
    //gradient设置渐变色进度条
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame            = CGRectMake(0, 0, view.tdd_size.width, view.tdd_size.height);
    gl.startPoint       = CGPointMake(0, 0);
    gl.endPoint         = CGPointMake(0, 1);
    gl.colors           = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    gl.locations        = @[@(0), @(1.0f)];
    [view.layer addSublayer:gl];
}

- (void)btnClickDown:(UIButton *)sender{
    NSInteger tag = sender.tag;
    if (tag != 15){
        [sender setBackgroundColor:[UIColor tdd_keyboardItemHightlightBackground]];
    }
    sender.layer.borderColor = [UIColor tdd_keyboardItemHightlightBorderColor].CGColor;
    if (tag != 14 && tag != 15 && tag != 16 && tag < 100){
        [self.hightlightBtn setHidden:NO];
        if (!self.hightlightBtn.superview) {
            [self addSubview:self.hightlightBtn];
        }
        [_hightlightBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        [self.hightlightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(sender.mas_top).offset(IS_IPad ? -5 : 0);
            make.centerX.equalTo(sender);
            make.size.mas_equalTo(CGSizeMake((IS_IPad ? 108 : 40) * _scale, (IS_IPad ? 60 : 56) * _scale));
        }];
    }

}
- (void)btnClickCancel:(UIButton *)sender{
    sender.layer.borderColor = UIColor.clearColor.CGColor;
    [self.hightlightBtn setHidden:YES];
    if (sender.tag != 15){
        [sender setBackgroundColor:[UIColor tdd_keyboardItemNormalBackground]];
    }
}

- (UIButton *)hightlightBtn {
    if (!_hightlightBtn) {
        _hightlightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIColor *normalTitle = [UIColor tdd_colorDiagTheme];
        if (!IS_IPad) {
            [_hightlightBtn setBackgroundImage:[UIImage tdd_imageDiagKeyboardHightlightBG] forState:UIControlStateNormal];
        }else {
            _hightlightBtn.backgroundColor = UIColor.tdd_alertBg;
            _hightlightBtn.layer.cornerRadius = 3.6;
            [_hightlightBtn.layer masksToBounds];
        }
        
        
        [_hightlightBtn setTitleColor:normalTitle forState:UIControlStateNormal];
        _hightlightBtn.titleLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 28 : 19 weight:UIFontWeightSemibold] tdd_adaptHD];

    }
    return _hightlightBtn;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
}

@end
