//
//  TDD_ArtiInputCellView.m
//  AD200
//
//  Created by 何可人 on 2022/5/10.
//

#import "TDD_ArtiInputCellView.h"
#import "TDD_ArtiInputTextView.h"
#import "TDD_ArtiInputSaveView.h"

#import "TDD_ArtiKeyboardView.h"//
@interface TDD_ArtiInputCellView ()<TDD_ArtiInputTextViewDelegate,TDD_ArtiInputSaveViewDelegate,UITextViewDelegate,UITextFieldDelegate,TDD_HTipBtnViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) TDD_ArtiInputSaveView * saveView;
@property (nonatomic, strong) TDD_CustomLabel * titleLab;

@property (nonatomic, strong) UIView    *enterbgView;   //  输入框背景
@property (nonatomic, strong) UIButton  *downbtn;
//@property (nonatomic, strong) UITextField   *enterText;
@property (nonatomic, strong) TDD_CustomTextView *textView;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, copy) NSString    *value;

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat viewTopSpace;
@property (nonatomic, assign) CGFloat textViewWidth;
@end

@implementation TDD_ArtiInputCellView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        [self setupUI];
        [self updateTextViewHeightWithOneLine:NO];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoChanged:) name:KTDDNotificationArtiInputModelChange object:nil];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUI {
    _scale = IS_IPad ? HD_Height : H_Height;
    _leftSpace = (IS_IPad ? 40 : 20) * _scale;
    _viewTopSpace = 12 * _scale;
    CGFloat hScale = IS_IPad ? (50.0 / 32.0) : 1;
    CGFloat viewLeftSpace = (IS_IPad ? 16 : 10) * _scale;
    CGFloat downBtnSize = 20 *_scale;
    TDD_CustomLabel * titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = IS_IPad ? [[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold] tdd_adaptHD] : [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label;
    });
    [self addSubview:titleLab];
    self.titleLab = titleLab;

    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(_viewTopSpace * _scale);
        make.centerX.equalTo(self);
        make.left.equalTo(self).offset(_leftSpace);
    }];
    
    self.enterbgView = [[UIView alloc]init];
//    self.enterbgView.backgroundColor = [UIColor tdd_alertBg];
    self.enterbgView.layer.borderWidth = 1;
    self.enterbgView.layer.borderColor = [UIColor tdd_borderColor].CGColor;
    self.enterbgView.layer.cornerRadius = 2.5;
    [self addSubview:self.enterbgView];
    self.enterbgView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.enterbgView.bounds]CGPath];
    
    [self.enterbgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(_viewTopSpace);
        make.left.equalTo(self).offset(_leftSpace);
        make.right.equalTo(self).offset(-_leftSpace);
    }];
    
   
    self.downbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.downbtn setImage:kImageNamed(@"input_down_arrow") forState:UIControlStateNormal];
    [self.downbtn setImage:kImageNamed(@"input_up_arrow") forState:UIControlStateSelected];
    [self.enterbgView addSubview:self.downbtn];
    [self.downbtn addTarget:self action:@selector(downList) forControlEvents:UIControlEventTouchUpInside];
    [self.downbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.enterbgView.mas_right).offset(-viewLeftSpace);
        make.top.equalTo(@(13 * hScale));
        make.size.mas_equalTo(CGSizeMake(downBtnSize, downBtnSize));
    }];
    self.downbtn.tdd_hitEdgeInsets = UIEdgeInsetsMake(-15, -15, -15, -15);
    
//    self.enterText = [[TDD_CustomTextField alloc]init];
//    self.enterText.delegate = self;
//    self.enterText.keyboardType = UIKeyboardTypeDefault;
//    self.enterText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    self.enterText.textColor = [UIColor tdd_title];
//    self.enterText.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
//    if (isKindOfTopVCI){
//        UIButton *clearButton = [self.enterText valueForKey:@"_clearButton"];
//        if (clearButton){
//            [clearButton setImage:kImageNamed(@"textfiled_clear") forState:UIControlStateNormal];
//        }
//    }
    

    // 初始化UITextView
    self.textView = [[TDD_CustomTextView alloc] init];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, IS_IPad ? 60 : 30); // 添加右侧留空以放置按钮
    self.textView.textColor = [UIColor tdd_title];
    self.textView.font = [[UIFont systemFontOfSize:IS_IPad ? 20 : 14 weight:UIFontWeightMedium] tdd_adaptHD];
    
    // 初始化清空按钮
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (isKindOfTopVCI){
        [self.clearButton setImage:kImageNamed(@"textfiled_clear") forState:UIControlStateNormal];
    } else {
        [self.clearButton setBackgroundImage:kImageNamed(@"topscan_text_clear") forState:UIControlStateNormal];
    }
    [self.clearButton addTarget:self action:@selector(clearText) forControlEvents:UIControlEventTouchUpInside];
    self.clearButton.hidden = YES;
    
    [self.enterbgView addSubview:self.textView];
    [self.enterbgView addSubview:self.clearButton];
    
    _textViewWidth = IphoneWidth - ( _leftSpace + 16 * _scale + downBtnSize + viewLeftSpace);
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.enterbgView).offset(16 * _scale);
        make.right.equalTo(self.downbtn.mas_left).offset(0);
        make.height.mas_equalTo((IS_IPad ? 50 : 32));
        make.top.equalTo(self.enterbgView).offset(6 * hScale);
        make.bottom.equalTo(self.enterbgView).offset(-6);
    }];
    
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.downbtn);
        make.width.height.equalTo(IS_IPad ? @22 : @16);
        make.right.equalTo(self.downbtn.mas_left).offset(IS_IPad ? -12 : -8);
    }];

    
//    [self.enterbgView addSubview:self.enterText];
//    [self.enterText mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.enterbgView);
//        make.left.equalTo(self.enterbgView).offset(12 * _scale);
//        make.right.equalTo(self.downbtn.mas_left).offset(-viewLeftSpace);
//    }];
//
//    [self.enterText addTarget:self action:@selector(inputText:) forControlEvents:UIControlEventEditingChanged];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.enterbgView.mas_bottom).offset(_viewTopSpace);
    }];
    
}

#pragma mark UI展示
- (void)infoChanged:(NSNotification *)info{
        
    TDD_ArtiModelBase * model = info.object;
    
    if ([model isKindOfClass:[ArtiInputItemModel class]]) {
        ArtiInputItemModel *currentModel = (ArtiInputItemModel *)model;
        if ([currentModel.strTips isEqualToString:self.itemModel.strTips]) {
            //[self.textView insertText:currentModel.strText];
            self.textView.text = currentModel.strText;
            self.itemModel.strText = currentModel.strText;
            [self updateTextViewHeightWithOneLine:NO];
        }
    }
}


- (void)setItemModel:(ArtiInputItemModel *)itemModel
{
    _itemModel = itemModel;
    
    self.textView.editable = !self.itemModel.isDropDownBox;
    self.clearButton.hidden = itemModel.isDropDownBox;
    
    if (self.isShowTranslated) {
        self.titleLab.text = itemModel.strTranslatedTips;
    }else {
        self.titleLab.text = itemModel.strTips;
    }
    
    NSString * buttonTitle = itemModel.strText;
    
    if ( (buttonTitle.length == 0 || ![itemModel.vctValue containsObject:buttonTitle]) && itemModel.vctValue.count > 0) {
        buttonTitle = itemModel.vctValue.firstObject;
    }
    
    buttonTitle = [buttonTitle stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    if (self.itemModel.strMask.length > 0) {
        buttonTitle = [buttonTitle substringWithRange:NSMakeRange(0, MIN(self.itemModel.strMask.length, buttonTitle.length))];
    }
    [self.textView setText:buttonTitle];
    [self updateTextViewHeightWithOneLine:NO];

    NSString *type = [self getKeyboardType];
    self.textView.inputView = nil;
    if([type isEqualToString:@"0"]){
        self.textView.inputView = [[TDD_ArtiKeyboardView alloc] initWithType:ArtiKeyboard0];//UIKeyboardTypeNumberPad;
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
    }else {
        self.textView.keyboardType = UIKeyboardTypeDefault;
    }
    if ([self.textView.inputView isKindOfClass:[TDD_ArtiKeyboardView class]]) {
        TDD_ArtiKeyboardView * inputView = self.textView.inputView;
        @kWeakObj(self);
        inputView.enterBlock = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                @kStrongObj(self)
                [self.textView resignFirstResponder];
            });
        };
        inputView.deleteBlock = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                @kStrongObj(self)
                [self.textView deleteBackward];
            });
        };
        inputView.insertBlock = ^(NSString * _Nonnull text) {
            dispatch_async(dispatch_get_main_queue(), ^{
                @kStrongObj(self)
                // textView insertText 不会走shouldChangeTextInRange
                if ([self checkTextMatch:text]) {
                    [self.textView insertText:text];
                }
            });
        };
    }
    self.downbtn.hidden = ![self hadHistoryRecord];
    CGFloat space = self.downbtn.hidden ? (IS_IPad ? -16 : -12) : (IS_IPad ? -12 : -8);
    [self.clearButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.downbtn);
        make.width.height.equalTo(IS_IPad ? @22 : @16);
        make.right.equalTo(self.downbtn.hidden ? self.enterbgView.mas_right :self.downbtn.mas_left).offset(space);
    }];
}

- (BOOL )hadHistoryRecord {
    NSInteger historyCount = [TDD_ArtiInputSaveView historyRecordCount:_itemModel];
    if (historyCount>0 || _itemModel.vctValue.count>0){
        return YES;
    }
    return NO;
}

- (void)downList {
    self.downbtn.selected = !self.downbtn.selected;
    if (self.downbtn.selected) {
        CGPoint point = [self.downbtn convertPoint:CGPointMake(0,0) toView:[UIApplication sharedApplication].windows.lastObject];
        self.saveView.clickPoint = point;
    }
    self.saveView.itemModel = self.itemModel;
//    [self updateTextViewHeightWithOneLine:self.downbtn.selected];

    if (self.heightDidChange) {
        self.heightDidChange();
    }
}


#pragma mark - UITextView输入响应事件
- (void)clearText {
    self.textView.text = self.itemModel.strText = @"";
    [self updateTextViewHeightWithOneLine:NO];
}

- (void)textViewDidChange:(TDD_CustomTextView *)textView {
    if ([_itemModel shouldTurnToUppercase]) {
        textView.text = [textView.text uppercaseString];
    }
    //极端情况下，系统的键盘输入已经进到系统的substringToIndex后，值被改了导致系统方法崩溃
    if (self.itemModel.strMask.length > 0 && textView.text.length >= self.itemModel.strMask.length && [textView.inputView isKindOfClass:[TDD_ArtiKeyboardView class]]) {
        textView.text = [textView.text substringToIndex:MIN(textView.text.length, self.itemModel.strMask.length)];
    }
    [self updateTextViewHeightWithOneLine:NO];
}

- (void)textViewDidEndEditing:(TDD_CustomTextView *)textView {
    self.itemModel.strText = textView.text;
}
          
- (BOOL)textView:(TDD_CustomTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // 处理删除操作
    if (range.length > 0 && text.length == 0) {
        return YES;
    }

    //AFVB 转大写
    if ([_itemModel shouldTurnToUppercase]) {
        text = [text uppercaseString];
    }
    // 1. 处理普通输入（非粘贴）
    if (text.length <= 1) {
        // 常规字符处理逻辑
        NSString *currentText = textView.text;
        NSString *newText = [currentText stringByReplacingCharactersInRange:range withString:text];
        NSUInteger newTextLength = newText.length;
        
        if (newTextLength > self.itemModel.strMask.length && self.itemModel.strMask.length > 0) {
            return NO;
        }
        return YES;
    }
    
    // 2. 处理粘贴操作（text.length > 1 时为粘贴内容）
    if ([text containsString:@"\n"] || text.length > 1) { // 简单判断是否为粘贴
        
        // 3. 计算粘贴后的新文本
        NSString *currentText = textView.text;
        NSString *newText = [currentText stringByReplacingCharactersInRange:range withString:text];
        NSUInteger newTextLength = newText.length;
        
        // 4. 超限则截断
        if (newTextLength > self.itemModel.strMask.length && self.itemModel.strMask.length > 0) {
            newText = [newText substringToIndex:self.itemModel.strMask.length];
            // 保持光标在粘贴后的末尾
            NSRange newRange = NSMakeRange(range.location + (self.itemModel.strMask.length - range.location), 0);
            if ([self checkTextMatch:newText]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    textView.text = newText;
                    textView.selectedRange = newRange;
                });
            }
            return NO; // 阻止默认粘贴行为
        }
    }
    return [self checkTextMatch:text];
}

- (void)textViewDidBeginEditing:(TDD_CustomTextView *)textView {
    [self updateTextViewHeightWithOneLine:NO];
}

- (BOOL)checkTextMatch:(NSString *)text {
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
            regex = @"^[0-9A-Z-&& [^I] && [^O] && [^Q]]*$";
        }else if ([self isFullOfStr:@"#" withText:self.itemModel.strMask]) {
            regex = @"^[0-9+*/\\-.]*$";
        }else if ([self isFullOfStr:@"B" withText:self.itemModel.strMask]) {
            regex = @"^[0-9A-Z +-]*$";
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

- (void)updateTextViewHeightWithOneLine:(BOOL)oneLine {
    CGFloat oneLightHeight = (IS_IPad ? 50 : 32) * _scale;
    if (oneLine) {
        // 设置 TextView 的内容显示属性
        self.textView.textContainer.maximumNumberOfLines = 1;
        self.textView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail; // 超出一行时省略
        self.textView.scrollEnabled = NO;
    } else {
        self.textView.textContainer.maximumNumberOfLines = 0;
        self.textView.textContainer.lineBreakMode = NSLineBreakByWordWrapping;
        self.textView.scrollEnabled = YES;
    }
    CGSize sizeThatFits = [self.textView sizeThatFits:CGSizeMake(_textViewWidth, CGFLOAT_MAX)];
    CGFloat height = sizeThatFits.height > oneLightHeight+1 ? sizeThatFits.height : oneLightHeight;
    height = height > 219 ? 219 : height;
    if (oneLine) {
        height =  oneLightHeight;
    }
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    
    if (self.textView.text.length > 0 && !self.itemModel.isDropDownBox) {
        self.clearButton.hidden = NO;
    } else {
        self.clearButton.hidden = YES;
    }
    
    [self layoutIfNeeded];
    
    // 如果高度变化，则触发回调以更新表格行的高度
     if (self.heightDidChange) {
         self.heightDidChange();
     }
}

#pragma mark - UITextField输入响应事件
//- (void)inputText:(UITextField *)textfield
//{
//    //长度校验
//    if (self.itemModel.strMask.length > 0 && textfield.text.length >= self.itemModel.strMask.length) {
//        textfield.text = [textfield.text substringToIndex:self.itemModel.strMask.length];
//    }
//
//}

#pragma mark UITextFieldDelegate
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    self.itemModel.strText = textField.text;
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    self.itemModel.strText = textField.text;
//    return YES;
//}
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    // 输入校验
//    if (string.length > 0) {
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
//        if (regex.length > 0) {
//            BOOL isInput = [self textFieldOfRegex:regex andText:string];
//
//            if (!isInput) {
//                return NO;
//            }
//        }
//    }
//
//    return YES;
//}

- (NSString *)getKeyboardType{
    
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

#pragma mark - 代理
- (void)TDD_ArtiInputTextViewButtonClick:(NSString *)textStr
{
    self.itemModel.strText = textStr;
    
    NSString * buttonTitle = textStr;
    
    buttonTitle = [buttonTitle stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    if (self.itemModel.strMask.length > 0) {
        buttonTitle = [buttonTitle substringWithRange:NSMakeRange(0, MIN(self.itemModel.strMask.length, buttonTitle.length))];
    }

    [self.textView setText:buttonTitle];
    [self updateTextViewHeightWithOneLine:NO];
}

- (void)TDD_ArtiInputSaveViewDidSelect:(NSString *)textStr
{
    self.itemModel.strText = textStr;
    
    NSString * buttonTitle = textStr;
    
    buttonTitle = [buttonTitle stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    if (self.itemModel.strMask.length > 0) {
        buttonTitle = [buttonTitle substringWithRange:NSMakeRange(0, MIN(self.itemModel.strMask.length, buttonTitle.length))];
    }
    
    [self.textView setText:buttonTitle];
    [self updateTextViewHeightWithOneLine:NO];
}

- (void)tdd_artiInputRemoveView:(BOOL )isEmpty {
    self.downbtn.selected = NO;
    [self updateTextViewHeightWithOneLine:NO];
    self.downbtn.hidden = isEmpty;
    CGFloat space = self.downbtn.hidden ? (IS_IPad ? -16 : -12) : (IS_IPad ? -12 : -8);
    [self.clearButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.downbtn);
        make.width.height.equalTo(IS_IPad ? @22 : @16);
        make.right.equalTo(self.downbtn.hidden ? self.enterbgView.mas_right :self.downbtn.mas_left).offset(space);
    }];
    
}

#pragma mark - 懒加载

- (TDD_ArtiInputSaveView *)saveView
{
    if (!_saveView) {
        _saveView = [[TDD_ArtiInputSaveView alloc] init];
        _saveView.delegate = self;
    }
    
    
    return _saveView;
}

@end
