//
//  TDD_ArtiWheelBrowView.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/17.
//

#import "TDD_ArtiWheelBrowView.h"
@import IQKeyboardManager;
@interface TDD_ArtiWheelBrowView()<UITextFieldDelegate>
@property (nonatomic, strong)UIScrollView *bgScrollView;
@property (nonatomic, strong)UIImageView *topImgView;
@property (nonatomic, strong)TDD_CustomLabel *topLabel;
@property (nonatomic, strong)TDD_CustomLabel *topTipsLabel;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)TDD_CustomLabel *warnTipsLabel;
@property (nonatomic, strong)TDD_CustomTextField *lastTextFiled;
@property (nonatomic, strong)TDD_CustomTextField *selectTextFiled;
@property (nonatomic, assign) CGFloat scale;
@end
@implementation TDD_ArtiWheelBrowView

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
        [self addNotification];
        IQKeyboardManager.sharedManager.enableAutoToolbar = NO;
        IQKeyboardManager.sharedManager.enable = NO;
    }
    return self;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)createUI {
    _scale = IS_IPad ? HD_Height : H_Height;
    CGFloat height  = IS_IPad ? 100 * _scale : 58 * _scale;
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight - NavigationHeight - (height + iPhoneX_D))];
    _bgScrollView.backgroundColor = [UIColor tdd_collectionViewBG];
    _bgScrollView.bounces = NO;
    _bgScrollView.scrollEnabled = YES;

    [self addSubview:_bgScrollView];
    [_bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_bgScrollView addSubview:self.topImgView];
    
    [self.topImgView addSubview:self.topLabel];
    [self.topImgView addSubview:self.topTipsLabel];
    
    
    [_topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgScrollView).offset(16 * _scale);
        make.centerX.equalTo(_bgScrollView);
        make.size.mas_equalTo(CGSizeMake(335 * _scale, 260 * _scale));
    }];
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topImgView).offset(18 * _scale);
        make.left.equalTo(_topImgView).offset(20 * _scale);
    }];
    [_topTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topLabel);
        make.top.equalTo(_topLabel.mas_bottom).offset(8 * _scale);
    }];
    
    UIView *shadowBottomView = [UIView new];
    shadowBottomView.backgroundColor = [UIColor whiteColor];
    shadowBottomView.layer.cornerRadius = 2.5;
    shadowBottomView.layer.shadowColor = [UIColor tdd_colorWithHex:0x120505 alpha:0.08].CGColor;
    shadowBottomView.layer.shadowRadius = 5;
    shadowBottomView.layer.shadowOpacity = 1;
    shadowBottomView.layer.shadowOffset = CGSizeMake(0, 1);
    [_bgScrollView addSubview:shadowBottomView];

    [_bgScrollView addSubview:self.bottomView];
    [shadowBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bottomView);
    }];

    NSArray *browArr = @[TDDLocalized.left_front_wheel, TDDLocalized.right_front_wheel, TDDLocalized.left_rear_wheel, TDDLocalized.right_rear_wheel];

    NSString *placeholder;
    if ([TDD_UnitConversion sharedUnit].unitConversionType == TDD_UnitConversionType_Metric) {
        placeholder = [TDDLocalized.input_num_range stringByReplacingOccurrencesOfString:@"%@" withString:@"500-1000"]; //@"请输入500-1000内的数字";
    }else {
        placeholder = [TDDLocalized.input_num_range stringByReplacingOccurrencesOfString:@"%@" withString:@"19.7-39.4"];//@"请输入19.7-39.4内的数字";
    }
    for (int i=0; i<browArr.count; i++) {
        TDD_CustomLabel *label = [TDD_CustomLabel new];
        label.textColor = [UIColor tdd_color666666];
        label.font = [[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] tdd_adaptHD];
        label.text = browArr[i];
        [self.bottomView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).offset(16 * _scale);
            make.top.equalTo(_lastTextFiled?_lastTextFiled.mas_bottom:self.bottomView).offset(12 * _scale);
        }];
        
        TDD_CustomTextField *textField = [[TDD_CustomTextField alloc] init];
        textField.tag = 100 + i;
        textField.placeholder = placeholder;
        NSAttributedString *attrString = [NSAttributedString attributedStringWithLTRString:placeholder attributes:
            @{NSForegroundColorAttributeName:[UIColor tdd_color999999],
                         NSFontAttributeName:textField.font
                 }];
        textField.attributedPlaceholder = attrString;
        textField.textColor = [UIColor tdd_color333333];

        textField.font = [[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] tdd_adaptHD];
        textField.keyboardType = [TDD_UnitConversion sharedUnit].unitConversionType == TDD_UnitConversionType_Metric ? UIKeyboardTypeNumberPad :UIKeyboardTypeDecimalPad;
        textField.layer.borderColor = [[UIColor tdd_colorWithHex:0xdddddd] CGColor];
        textField.layer.borderWidth = 0.5;
        [textField addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
        
        //leftView
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12 * H_Height, 36 * H_Height)];
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        
        //rightView
        UIView *rightView = [UIView new];
        TDD_CustomLabel *rightLabel = [[TDD_CustomLabel alloc] initWithFrame:CGRectMake(0, 0, 50 * H_Height, 0)];
        rightLabel.textColor = [UIColor tdd_color666666];
        rightLabel.font = [[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] tdd_adaptHD];
        rightLabel.text = [TDD_UnitConversion sharedUnit].unitConversionType == TDD_UnitConversionType_Metric ? @"mm" : @"inch";
        [rightView addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightView);
            make.right.equalTo(rightView).offset(-12 * _scale);
            make.centerY.equalTo(rightView);
        }];
        textField.rightView = rightView;
        textField.rightViewMode = UITextFieldViewModeAlways;
        
        textField.delegate = self;
        [self.bottomView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).offset(4 * _scale);
            make.left.equalTo(label);
            make.centerX.equalTo(self.bottomView);
            make.height.mas_equalTo(36 * _scale);
        }];
        _lastTextFiled = textField;
        
    }
    [self.bottomView addSubview:self.warnTipsLabel];
    [_warnTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView).inset(16 * _scale);
        make.top.equalTo(_lastTextFiled.mas_bottom).offset(8 * _scale);
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgScrollView);
        make.left.equalTo(_bgScrollView).offset(20 * _scale);
        make.top.equalTo(_topImgView.mas_bottom).offset(16 * _scale);
        make.bottom.equalTo(_lastTextFiled).offset(16 * _scale);
        make.bottom.equalTo(_bgScrollView).offset(-16 * _scale);
    }];
    
    
}

- (void)setWheelBrowModel:(TDD_ArtiWheelBrowModel *)wheelBrowModel {
    _wheelBrowModel = wheelBrowModel;
    if (_wheelBrowModel.lfBrowModel.value > 0) {
        NSArray *valueArr = @[@(_wheelBrowModel.lfBrowModel.value),@(_wheelBrowModel.rfBrowModel.value),@(_wheelBrowModel.lrBrowModel.value),@(_wheelBrowModel.rrBrowModel.value)];
        for (int i = 0; i<4; i++) {
            TDD_CustomTextField *textField = [self.bottomView viewWithTag:100 + i];
            textField.text = [NSString stringWithFormat:@"%@",valueArr[i]];
        }
    }
    [self reloadWarning];

}

- (void)reloadWarning {
    for (int i = 0; i<4; i++) {
        TDD_CustomTextField *textField = [self.bottomView viewWithTag:100 + i];
        BOOL showError = false;
        if (_wheelBrowModel.warningType == 1) {
            showError = (i < 2);
        }else if (_wheelBrowModel.warningType == 2) {
            showError = (i >= 2);
        }else if (_wheelBrowModel.warningType == 3) {
            showError = YES;
        }
        textField.layer.borderColor = showError ? [[UIColor tdd_errorRed] CGColor] : [[UIColor tdd_colorWithHex:0xdddddd] CGColor];
        textField.textColor = showError ? [UIColor tdd_errorRed] : [UIColor tdd_color333333];
    }

    _warnTipsLabel.hidden = _wheelBrowModel.warningType == 0;
    _warnTipsLabel.text = _wheelBrowModel.warningTips;
    if (_wheelBrowModel.warningType > 0) {
        [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_bgScrollView);
            make.left.equalTo(_bgScrollView).offset(20 * _scale);
            make.top.equalTo(_topImgView.mas_bottom).offset(16 * _scale);
            make.bottom.equalTo(_warnTipsLabel).offset(16 * _scale);
        }];
    }else {
        [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_bgScrollView);
            make.left.equalTo(_bgScrollView).offset(20 * _scale);
            make.top.equalTo(_topImgView.mas_bottom).offset(16 * _scale);
            make.bottom.equalTo(_lastTextFiled).offset(16 * _scale);
        }];
    }
    [self layoutIfNeeded];
    _bgScrollView.contentSize = CGSizeMake(IphoneWidth ,_bottomView.tdd_bottom + 16 * _scale);
}

#pragma mark UITextFiled
- (void)textValueChange:(UITextField *)textField {

    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _selectTextFiled = textField;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *text = textField.text;
    NSString *newStr = [self handleInputStr:text];
    if (![NSString tdd_isEmpty:newStr]) {
        textField.text = newStr;
    }
    switch (textField.tag - 100) {
        case 0:
        {
            _wheelBrowModel.lfBrowModel.value = textField.text.floatValue;
        }

            break;
        case 1:
        {
            _wheelBrowModel.rfBrowModel.value = textField.text.floatValue;
        }

            break;
        case 2:
        {
            _wheelBrowModel.lrBrowModel.value = textField.text.floatValue;
        }

            break;
        case 3:
        {
            _wheelBrowModel.rrBrowModel.value = textField.text.floatValue;
        }
            break;
            
        default:
            break;
    }
    
    //底部按钮
    TDD_ArtiButtonModel *buttonModel;
    BOOL isChange = NO;
    if (_wheelBrowModel.buttonArr.count == 1) {
        buttonModel = _wheelBrowModel.buttonArr.firstObject;
    }
    if (_wheelBrowModel.lfBrowModel.value > 0 && _wheelBrowModel.rfBrowModel.value > 0 && _wheelBrowModel.lrBrowModel.value > 0 && _wheelBrowModel.rrBrowModel.value > 0) {
        if (buttonModel) {
            isChange = (buttonModel.uStatus == ArtiButtonStatus_DISABLE);
            buttonModel.uStatus = ArtiButtonStatus_ENABLE;
        }
    }else {
        if (buttonModel) {
            isChange = (buttonModel.uStatus == ArtiButtonStatus_ENABLE);
            buttonModel.uStatus = ArtiButtonStatus_DISABLE;
        }
    }
    [_wheelBrowModel handleDifference];
    [self reloadWarning];
    if (isChange) {
        [_wheelBrowModel reloadButtonView];
    }

    
}


- (NSString *)handleInputStr:(NSString *)text {
    if ([NSString tdd_isEmpty:text]) {
        text = @"0";
    }
    text = [text stringByReplacingOccurrencesOfString:@"," withString:@"."];
    if ([NSString tdd_isNum:text]) {
        CGFloat num = text.floatValue;
        if ([TDD_UnitConversion sharedUnit].unitConversionType == TDD_UnitConversionType_Metric) {
            num = MIN(1000, num);
            num = MAX(500, num);
        }else {
            num = MIN(39.4, num);
            num = MAX(19.7, num);
        }
        NSNumber *number = @(num);
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setMinimumFractionDigits:0];
        if ([TDD_UnitConversion sharedUnit].unitConversionType == TDD_UnitConversionType_Metric) {
            [formatter setMaximumFractionDigits:0];
        }else {
            [formatter setMaximumFractionDigits:1];
        }
        
        NSString *formattedString = [formatter stringFromNumber:number];
        formattedString = [formattedString stringByReplacingOccurrencesOfString:@"," withString:@"."];

        return formattedString;

    }
    return @"";
}

#pragma mark -- 键盘监听事件

- (void)keyboardShow:(NSNotification *)noti
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:noti.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat offsetH = -keyBoardHeight;
    if (_selectTextFiled) {
        offsetH = self.tdd_height - keyBoardHeight - _selectTextFiled.tdd_bottom - _bottomView.tdd_top + (58 * _scale + iPhoneX_D);
        if (offsetH > 0) {
            return;
        }
    }
    [UIView animateWithDuration:animationTime animations:^{
        [self.topImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgScrollView).offset(offsetH + (16 * self.scale));
            make.centerX.equalTo(self.bgScrollView);
            make.size.mas_equalTo(CGSizeMake(335 * self.scale, 260 * self.scale));
        }];

        [self layoutIfNeeded];
    }];

}

- (void)keyboardHide:(NSNotification *)noti
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:noti.userInfo];
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationTime animations:^{
        [self.topImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgScrollView).offset(16 * self.scale);
            make.centerX.equalTo(self.bgScrollView);
            make.size.mas_equalTo(CGSizeMake(335 * self.scale, 260 * self.scale));
        }];
        [self layoutIfNeeded];
    }];
}


- (UIImageView *)topImgView {
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithImage:kImageNamed(@"arti_wheel_brow_top_bg")];

    }
    return _topImgView;;
}

- (TDD_CustomLabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [TDD_CustomLabel new];
        _topLabel.textColor = [UIColor tdd_color333333];
        _topLabel.font = [[UIFont systemFontOfSize:16 weight:UIFontWeightMedium] tdd_adaptHD];
        _topLabel.text = TDDLocalized.wheel_eyebrow_height;
    }
    return _topLabel;
}

- (TDD_CustomLabel *)topTipsLabel {
    if (!_topTipsLabel) {
        _topTipsLabel = [TDD_CustomLabel new];
        _topTipsLabel.textColor = [UIColor tdd_color666666];
        _topTipsLabel.font = [[UIFont systemFontOfSize:11 weight:UIFontWeightRegular] tdd_adaptHD];
        _topTipsLabel.numberOfLines = 0;
        _topTipsLabel.text = [NSString stringWithFormat:@"* %@", TDDLocalized.input_wheel_brow];
    }
    return _topTipsLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.cornerRadius = 2.5 * _scale;
        _bottomView.layer.borderColor = [[UIColor tdd_colorWithHex:0xe2e2e2] CGColor];
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.masksToBounds = YES;
        _bottomView.userInteractionEnabled = YES;

    }
    return _bottomView;
}

- (TDD_CustomLabel *)warnTipsLabel {
    if (!_warnTipsLabel) {
        _warnTipsLabel = [TDD_CustomLabel new];
        _warnTipsLabel.textColor = [UIColor tdd_errorRed];
        _warnTipsLabel.font = [[UIFont systemFontOfSize:11 weight:UIFontWeightRegular] tdd_adaptHD];
        _warnTipsLabel.hidden = YES;
        _warnTipsLabel.numberOfLines = 0;
    }
    return _warnTipsLabel;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
