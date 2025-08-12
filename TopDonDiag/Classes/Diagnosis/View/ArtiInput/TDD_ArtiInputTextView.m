//
//  TDD_ArtiInputTextView.m
//  AD200
//
//  Created by 何可人 on 2022/5/10.
//

#import "TDD_ArtiInputTextView.h"
#import "TDD_ArtiKeyboardView.h"

@interface TDD_ArtiInputTextView ()<UITextViewDelegate>
@property (nonatomic, strong) UIView * whiteView;
@property (nonatomic, strong) TDD_CustomLabel * titleLab;
@property (nonatomic, strong) TDD_CustomTextView * textView;
@property (nonatomic, assign) float textHigh;
@property (nonatomic, assign) BOOL isTransform;
@property (nonatomic, strong) id keyboardUserInfo;
@end

@implementation TDD_ArtiInputTextView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self creatUI];
        [self addkeyBoardObserver];
    }
    
    return self;
}

- (void)creatUI
{
    float btnTop = isKindOfTopVCI ? 28 : 5;
    float btnHeight = isKindOfTopVCI ? 44 : 41;
    float btnBottom = isKindOfTopVCI ? 24 : 0;
    float btnMargin = isKindOfTopVCI ? 20 : 0;
    UIView * whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = UIColor.tdd_viewControllerBackground;
    whiteView.layer.cornerRadius = 10;
    //whiteView.bounces = NO;
    [self addSubview:whiteView];
    self.whiteView = whiteView;
    
    
    TDD_CustomLabel * titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 0;
        label;
    });
    [whiteView addSubview:titleLab];
    self.titleLab = titleLab;
    
    TDD_CustomTextView * textView = ({
        TDD_CustomTextView * textView = [[TDD_CustomTextView alloc] init];
        textView.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        textView.textColor = [UIColor tdd_title];
        textView.delegate = self;
        textView.layer.cornerRadius = 5;
        if (!isKindOfTopVCI) {
            textView.layer.borderWidth = 1;
            textView.layer.borderColor = [UIColor tdd_listBackground].CGColor;
        }
        textView.backgroundColor = [UIColor tdd_inputTextViewBackground];
//         textView.inputView = [[TDD_ArtiKeyboardView alloc] init];
        textView;
    });
    [whiteView addSubview:textView];
    self.textView = textView;
    
    NSArray * btnTitleArr = @[@"app_cancel",@"app_confirm"];
    
    NSMutableArray * btnArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 2; i ++) {
        UIButton * btn = ({
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 100 + i;
            btn.titleLabel.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            UIColor *txtColor = i == 0 ? UIColor.tdd_subTitle : UIColor.tdd_colorDiagTheme;
            if isKindOfTopVCI {
                if (i == 0){
                    btn.backgroundColor = UIColor.tdd_line;
                } else {
                    btn.backgroundColor = UIColor.tdd_colorDiagTheme;
                }
                txtColor = UIColor.tdd_title;
                btn.layer.cornerRadius = 5;
                btn.layer.masksToBounds = YES;
            }
            [btn setTitle:[TDD_HLanguage getLanguage:btnTitleArr[i]] forState:UIControlStateNormal];
            [btn setTitleColor:txtColor forState:UIControlStateNormal];
            btn;
        });
        [whiteView addSubview:btn];
        [btnArr addObject:btn];
    }
    
    CGFloat width = IphoneWidth - 30 * H_Height;
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(width + 20 * H_Height);
        make.height.mas_lessThanOrEqualTo(IphoneHeight - 200);
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(whiteView).insets(UIEdgeInsetsMake(20 * H_Height, 10 * H_Height, 0, 10 * H_Height));
        make.width.mas_equalTo(width);
    }];

    __block UIView *textContainerView = nil;

    [textView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"_UITextContainerView")]) {
            textContainerView = obj;
            *stop = YES;
        }
    }];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(btnTop * H_Height);
        make.height.mas_equalTo(textContainerView).priorityLow();
        make.left.right.equalTo(whiteView).insets(UIEdgeInsetsMake(0, 10 * H_Height, 0, 10 * H_Height));
    }];
    
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:btnMargin leadSpacing:btnMargin tailSpacing:btnMargin];
    
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).offset(btnTop * H_Height);
        make.height.mas_equalTo(btnHeight);
        make.bottom.equalTo(whiteView).inset(btnBottom);
    }];
}

- (void)btnClick:(UIButton *)btn
{
    [self removeFromSuperview];
    
    NSInteger tag = btn.tag - 100;
    
    if (tag == 1) {
        if ([self.delegate respondsToSelector:@selector(TDD_ArtiInputTextViewButtonClick:)]) {
            [self.delegate TDD_ArtiInputTextViewButtonClick:self.textView.text];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:NO];
}

- (void)setItemModel:(ArtiInputItemModel *)itemModel
{
    _itemModel = itemModel;
    
    if (self.isShowTranslated) {
        self.titleLab.text = itemModel.strTranslatedTips?:(itemModel.strTips?:@"");
    }else {
        self.titleLab.text = itemModel.strTips?:@"";
    }
    
    self.textView.text = itemModel.strDefault;
    
    [self layoutIfNeeded];

    self.textHigh = IphoneHeight / 2.0 + self.whiteView.frame.size.height / 2.0 + 10;
    
    NSString *type = [self getKeyboardType];
    self.textView.keyboardType = UIKeyboardTypeDefault;
    if([type isEqualToString:@"0"]){
        self.textView.keyboardType = UIKeyboardTypeNumberPad;
//       self.textView.inputView = [[TDD_ArtiKeyboardView alloc] initWithType:ArtiKeyboard0];
    }else if ([type isEqualToString:@"A"]){
       self.textView.inputView = [[TDD_ArtiKeyboardView alloc] initWithType:ArtiKeyboardA];
    }else if([type isEqualToString:@"B"]){
       self.textView.inputView = [[TDD_ArtiKeyboardView alloc] initWithType:ArtiKeyboardB];
    }else if ([type isEqualToString:@"F"]){
       self.textView.inputView = [[TDD_ArtiKeyboardView alloc] initWithType:ArtiKeyboardF];
    }else if ([type isEqualToString:@"V"]){
       self.textView.inputView = [[TDD_ArtiKeyboardView alloc] initWithType:ArtiKeyboardV];
    }else if ([type isEqualToString:@"#"]){
       self.textView.inputView = [[TDD_ArtiKeyboardView alloc] initWithType:ArtiKeyboardT];
    }
}

- (void)textViewDidChange:(TDD_CustomTextView *)textView
{
    //长度校验
    if (self.itemModel.strMask.length > 0 && textView.text.length >= self.itemModel.strMask.length) {
        textView.text = [textView.text substringToIndex:self.itemModel.strMask.length];
    }
    
    [self layoutIfNeeded];

    self.textHigh = IphoneHeight / 2.0 + self.whiteView.frame.size.height / 2.0 + 10;

    [self changeWhiteViewFrame];
    
    // 输入校验
//    if (textView.text.length > 0) {
//       
//        NSString *regex = @"";
//
//        if ([self isFullOfStr:@"0" withText:self.itemModel.strMask]) {
//            regex = @"^[0-9]*$";
//        }else if ([self isFullOfStr:@"A" withText:self.itemModel.strMask]) {
//            regex = @"^[A-Z]*$";
//        }else if ([self isFullOfStr:@"F" withText:self.itemModel.strMask]) {
//            regex = @"^[0-9A-F]*$";
//        }else if ([self isFullOfStr:@"V" withText:self.itemModel.strMask]) {
//            regex = @"^[0-9A-Z && [^I] && [^O] && [^Q] ]*$";
//        }else if ([self isFullOfStr:@"#" withText:self.itemModel.strMask]) {
//            regex = @"^[0-9+*/\\-]*$";
//        }else if ([self isFullOfStr:@"B" withText:self.itemModel.strMask]) {
//            regex = @"^[0-9A-Z]*$";
//        }
//        
//
//        
//        if (regex.length > 0) {
////            BOOL isInput = [self textFieldOfRegex:regex andText:textView.text];
//            
////            if (!isInput) {
////                return NO;
////            }
//        }
//    }
}

- (BOOL)textView:(TDD_CustomTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // 输入校验
    if (text.length > 0) {
       
        NSString *regex = @"";
        
        if ([self isFullOfStr:@"0" withText:self.itemModel.strMask]) {
            regex = @"^[0-9]*$";
        }else if ([self isFullOfStr:@"A" withText:self.itemModel.strMask]) {
            regex = @"^[A-Z]*$";
        }else if ([self isFullOfStr:@"F" withText:self.itemModel.strMask]) {
            regex = @"^[0-9A-F]*$";
        }else if ([self isFullOfStr:@"V" withText:self.itemModel.strMask]) {
            regex = @"^[0-9A-Z && [^I] && [^O] && [^Q] ]*$";
        }else if ([self isFullOfStr:@"#" withText:self.itemModel.strMask]) {
            regex = @"^[0-9+*/\\-]*$";
        }else if ([self isFullOfStr:@"B" withText:self.itemModel.strMask]) {
            regex = @"^[0-9A-Z]*$";
        }
        
        if (regex.length > 0) {
            BOOL isInput = [self textFieldOfRegex:regex andText:text];
            
            if (!isInput) {
                return NO;
            }
        }
    }
    
    return YES;
}
 
//正则表达式
- (BOOL)textFieldOfRegex:(NSString*)regex andText:(NSString*)text {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:text];
}

//是否全是该字符
- (BOOL)isFullOfStr:(NSString *)str withText:(NSString *)text
{
    int nub = (int)text.length;
    //空为全键盘
    if (nub==0) {
        return NO;
    }
    for (int i = 0; i < nub; i ++) {
        NSString * subStr = [text substringWithRange:NSMakeRange(i, 1)];
        
        if (![subStr localizedCaseInsensitiveContainsString:str]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark- 键盘监听
#pragma mark 添加监听
- (void)addkeyBoardObserver{
    //键盘监听
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    if (self.isTransform) {
        return;
    }
    
    self.keyboardUserInfo = note.userInfo;
    
    [self changeWhiteViewFrame];
}

- (void)changeWhiteViewFrame
{
    CGRect rect = [self.keyboardUserInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat ty = rect.size.height;
    double h = IphoneHeight - self.textHigh; //输入框离底的距离
    double y = h - ty;
//    NSLog(@"\nrect:%@\n---\nbegin:%@", NSStringFromCGRect(rect), NSStringFromCGRect(begin));
    if (y < 0) {
        self.isTransform = YES;
        
        [UIView animateWithDuration:[self.keyboardUserInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
            self.whiteView.transform = CGAffineTransformMakeTranslation(0, y);
        }];
    }
}

#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    self.isTransform = NO;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.whiteView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}
-(NSString *)getKeyboardType{
    
    NSString *type = @"*";

    if ([self isFullOfStr:@"0" withText:self.itemModel.strMask]) {
        type = @"0";
    }else if ([self isFullOfStr:@"A" withText:self.itemModel.strMask]) {
        type = @"A";
    }else if ([self isFullOfStr:@"F" withText:self.itemModel.strMask]) {
        type = @"F";
    }else if ([self isFullOfStr:@"V" withText:self.itemModel.strMask]) {
        type = @"V";
    }else if ([self isFullOfStr:@"#" withText:self.itemModel.strMask]) {
        type = @"#";
    }else if ([self isFullOfStr:@"B" withText:self.itemModel.strMask]) {
        type = @"B";
    }
    

    return type;
}
@end
