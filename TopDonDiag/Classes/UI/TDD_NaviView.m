//
//  TDD_NaviView.m
//  TOPKEY_iPad
//
//  Created by yong liu on 2022/1/18.
//

#import "TDD_NaviView.h"

@interface TDD_NaviView ()<UITextFieldDelegate>
@property (nonatomic, assign)CGFloat scale;
@property (nonatomic, strong) MASConstraint * backBtnCenterYConstraints;

@end

@implementation TDD_NaviView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    
    [self addSubview:self.backBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.searchField];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        self.backBtnCenterYConstraints = make.centerY.equalTo(self).offset(StatusBarHeight / 2);
        make.left.equalTo(self).offset(15 * _scale);
        make.width.mas_equalTo(30 * _scale);
        make.height.mas_equalTo(30 * _scale);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn);
        make.right.equalTo(self).offset(-150 * _scale);
        make.left.equalTo(self.backBtn.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn);
        make.right.equalTo(self).offset(-128 * _scale);
        make.left.equalTo(self.backBtn.mas_right);
        make.height.mas_equalTo(32);
    }];
    
    self.backBtn.tdd_hitEdgeInsets = UIEdgeInsetsMake(-20, -15, -20, -20);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnClick)];
    [self.titleLabel addGestureRecognizer:tap];
}

- (void)layouForLandscape: (BOOL)isLandscape {
    if (isLandscape) {
        [self.backBtnCenterYConstraints setOffset:0];
    } else {
        [self.backBtnCenterYConstraints setOffset:StatusBarHeight / 2];
    }
    [self layoutIfNeeded];
}

- (void)setNaviType:(NaviType)naviType {
    _naviType = naviType;
    if (naviType == kNaviTypeHide) {
        self.hidden = YES;
    } else if (naviType == kNaviTypeBlue) {
        self.hidden = NO;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor tdd_mainColor];
        [self.backBtn setImage:kImageNamed(@"icon_arrow") forState:UIControlStateNormal];
    } else if (naviType == kNaviTypeWhite) {
        self.hidden = NO;
        self.titleLabel.textColor = [UIColor tdd_color000000];
        self.backgroundColor = [UIColor whiteColor];
        [self.backBtn setImage:kImageNamed(@"back_navi_black") forState:UIControlStateNormal];
    } else if (naviType == kNaviTypeGradientBlue) {
        self.hidden = NO;
        self.titleLabel.textColor = [UIColor tdd_color000000];
        self.backgroundColor = [UIColor whiteColor];
        // gradient
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = self.frame;
        gl.startPoint = CGPointMake(0.5, 0.36);
        gl.endPoint = CGPointMake(0.5, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:242/255.0 green:248/255.0 blue:253/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0500].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,2);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 8;
        [self.layer insertSublayer:gl atIndex:0];
        [self.backBtn setImage:kImageNamed(@"back_navi_black") forState:UIControlStateNormal];
    } else if (naviType == kNaviTypeClear) {
        self.hidden = NO;
        self.titleLabel.textColor = UIColor.tdd_title;
        self.backgroundColor = UIColor.clearColor;
        [self.backBtn setImage:[kImageNamed(@"back_navi_black") tdd_imageByTintColor: UIColor.tdd_title] forState:UIControlStateNormal];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)updateSearckKey:(NSString *)searchKey {
    self.searchField.text = searchKey;
    self.searchKey = searchKey;
}

- (void)backBtnClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backClick)]) {
        [self.delegate performSelector:@selector(backClick)];
    }
}

- (void)searchFieldValueChanged {
    // 去掉中文输入产生的空格（不是正常的空格 复制打印的数据）
    NSString *text = [self.searchField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 中文输入法，输入字母点确定会调用2次方法
    if ([self.searchKey isEqualToString:text]) {
        return;
    }
    NSLog(@"搜索 %@    %@", self.searchField.text, text);
    self.searchKey = self.searchField.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchKeyChanged:)]) {
        [self.delegate performSelector:@selector(searchKeyChanged:) withObject:self.searchKey];
    }

}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
//    self.searchKey = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(searchKeyChanged:)]) {
//        [self.delegate performSelector:@selector(searchKeyChanged:) withObject:self.searchKey];
//    }

    return YES;
}

#pragma mark - 懒加载
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        if ([TDD_DiagnosisTools isDebug]) {
            _backBtn.accessibilityIdentifier = @"diagVCBackButton";
        }
    }
    return _backBtn;
}

- (TDD_VXXScrollLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[TDD_VXXScrollLabel alloc] init];
        _titleLabel.font = IS_IPad ? [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold] : [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.userInteractionEnabled = YES;
    }
    return _titleLabel;
}

- (TDD_CustomTextField *)searchField {
    if (!_searchField) {
        _searchField = [[TDD_CustomTextField alloc] init];
        _searchField.layer.cornerRadius = 3;
        _searchField.layer.masksToBounds = YES;
        _searchField.hidden = YES;
        _searchField.backgroundColor = [UIColor tdd_cellBackground];
        _searchField.font = kSystemFont(13);
        _searchField.textColor = [UIColor tdd_title];
        NSMutableAttributedString *placeholder = [NSMutableAttributedString  mutableAttributedStringWithLTRString:TDDLocalized.app_search];
        [placeholder addAttributes:@{ NSForegroundColorAttributeName : [UIColor tdd_colorCCCCCC], NSFontAttributeName : kSystemFont(13) } range:NSMakeRange(0, TDDLocalized.app_search.length)];
        _searchField.attributedPlaceholder = placeholder;
        _searchField.delegate = self;
        [_searchField addTarget:self action:@selector(searchFieldValueChanged) forControlEvents:UIControlEventValueChanged | UIControlEventEditingChanged];
        _searchField.clearButtonMode = UITextFieldViewModeAlways;
        if (isKindOfTopVCI){
            UIButton *clearButton = [_searchField valueForKey:@"_clearButton"];
            if (clearButton){
                [clearButton setImage:kImageNamed(@"textfiled_clear") forState:UIControlStateNormal];
            }
        }
        
        _searchField.leftViewMode = UITextFieldViewModeAlways;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
        UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 16, 16)];
        searchIcon.image = kImageNamed(@"textField_search");
        [leftView addSubview:searchIcon];
        _searchField.leftView = leftView;
    }
    return _searchField;
}

@end
