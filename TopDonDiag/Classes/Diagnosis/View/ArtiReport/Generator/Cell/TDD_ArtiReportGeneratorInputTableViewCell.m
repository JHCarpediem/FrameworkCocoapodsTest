//
//  TDD_ArtiReportGeneratorInputTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/9.
//

#import "TDD_ArtiReportGeneratorInputTableViewCell.h"

@interface TDD_ArtiReportGeneratorInputTableViewCell () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton * mlUnitBtn;
@property (nonatomic, copy) NSArray<NSString *> * datas;
@property (nonatomic, strong) Popover * popover;
@end

@implementation TDD_ArtiReportGeneratorInputTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.diagnosticUnit = [TDD_DiagnosisTools diagnosticUnit];
        [self setupUI];
    }
    return self;
}


-(void)setupUI {
    self.backgroundColor = UIColor.tdd_btnBackground;
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.inputTextField];
    [self.contentView addSubview:self.mlUnitBtn];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(self.contentView);
        make.width.equalTo(IS_IPad ? @160 : @100);
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(15);
        make.right.equalTo(self.mlUnitBtn.mas_left).offset(IS_IPad ? -40 : -10);
        make.height.equalTo(self.contentView);
        make.top.equalTo(@0);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColor.tdd_line;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.height.equalTo(@1);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    //TODO: 新增行驶里程 单位切换
    [self.mlUnitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).inset(IS_IPad ? 40 : 20);
        make.top.bottom.equalTo(self.contentView);
    }];
    if isTopVCI {
        self.mlUnitBtn.userInteractionEnabled = NO;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.mlUnitBtn tdd_setImagePosition:LXMImagePositionRight spacing:8];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (self.isMileage) {
        if ([str isEqualToString:@"."]) return NO;
        if (![NSString tdd_isNum:str] && ![NSString tdd_isEmpty:str]) return NO;
        return str.length <= 12;
    }
    // 车牌号 规则限制
    if ([self.nameLabel.text isEqualToString:TDDLocalized.report_license_plate]) {
        return str.length < 19;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason
{
    if (self.didChangedText) {
        NSString * unit = self.isMileage ? self.diagnosticUnit : @"";
        self.didChangedText([self resultValue:textField.text withUnit:unit]);
    }
    
    if (self.isMileage) {
        self.inputKmValue = 0;
        self.inputMileValue = 0;
        if ([self.diagnosticUnit isEqualToString:@"metric"]) {
            self.inputKmValue = textField.text.doubleValue;
        } else {
            self.inputMileValue = textField.text.doubleValue;
        }
        if (self.didMileageInputChanged) {
            self.didMileageInputChanged(self.diagnosticUnit, textField.text.doubleValue);
        }
    }
}


- (void)unitBtnClick:(UIButton *)unitBtn
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 130, 80) style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.clearColor;
    tableView.rowHeight = 40;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.layer.cornerRadius = 8;
    
    
    
    Popover *popView = [[Popover alloc] init];
    popView.cornerRadius = 8;
    popView.arrowSize = CGSizeZero;
    popView.popoverColor = UIColor.clearColor;
    
    self.popover = popView;
    [popView show:tableView fromView:self.mlUnitBtn];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reportMenuCell"];
    BOOL isUnitKm = [self.diagnosticUnit isEqualToString:@"metric"];
    UIColor *normalColor = [UIColor tdd_reportMilesNormalBackground];
    UIColor *selectColor = [UIColor tdd_reportMilesSelectBackground];
    UIColor *selectTextColor = [UIColor tdd_title];
    BOOL isSelect = (indexPath.row == 0 && isUnitKm) || (indexPath.row == 1 && !isUnitKm);
    
    cell.backgroundColor = isSelect ? selectColor : normalColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = isSelect ? selectTextColor : UIColor.tdd_title;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = self.datas[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * unit = indexPath.row == 0 ? @"metric" : @"imperial";
    
    if (![self.diagnosticUnit isEqualToString:unit]) {
        
        
//        double  value = [self convertValue:self.inputTextField.text fromUnit:self.diagnosticUnit toUnit:unit];
//        NSString * text = [NSString stringWithFormat:@"%.02f", value];
//        self.inputTextField.text = text;
//        NSString * result = [self resultValue:self.inputTextField.text withUnit:unit];
//         
//        if (self.didChangedText) {
//            self.didChangedText(result);
//        }
        
        if (self.didDiagnosticUnitChanged) {
            self.didDiagnosticUnitChanged(unit);
        }
        
        self.diagnosticUnit = unit;
    }
    
    [self.popover dismiss];
}

#pragma - mark  辅助函数

/// 单位转换 计算值  公转英/英转公
/// - Parameters:
///   - value: 需要计算的原始值
///   - fromUnit: 初始单位
///   - toUnit: 目标单位
- (double)convertValue:(NSString *)value fromUnit:(NSString *)fromUnit toUnit: (NSString *)toUnit
{
    double result =  value.doubleValue;
//    if (![NSString tdd_isNum:value]) return result;
//    if ([fromUnit isEqualToString:toUnit]) return result;
//    if ([fromUnit isEqualToString:@"metric"] && [toUnit isEqualToString:@"imperial"]) { // 公转英 1 千米= 0.62137英里
//        if (self.inputMileValue != 0) {
//            result = self.inputMileValue;
//        } else {
//            result *= 0.62137;
//        }
//    } else if ([toUnit isEqualToString:@"metric"] && [fromUnit isEqualToString:@"imperial"]) { // 英转公 1 英里 = 1.60934千米
//        if (self.inputKmValue != 0) {
//            result = self.inputKmValue;
//        } else {
//            result *= 1.60934;
//        }
//    }
    return result;
    
}

/// 获取返回给外界Model的最终值 ： value + unit
/// - Parameters:
///   - value: 一般为textField的值
///   - unit: 单位
- (NSString *)resultValue:(NSString *)value withUnit:(NSString *)unit
{
    NSString * resultUnit = [self unitDisplayWithDiagUnit:unit];
    if (!value || [NSString tdd_isEmpty: value]) {
        resultUnit = @"";
    }
    return [NSString stringWithFormat:@"%@ %@", value, resultUnit];
}


/// 根据userDefault的单位字符串 转换成 显示的单位 metric： Km //  imperial : Mile
/// - Parameter unit: 返回展示的单位 Km / Mile
- (NSString *)unitDisplayWithDiagUnit:(NSString *)unit {
    if ([unit isEqualToString:@"imperial"]) return @"Miles";
    if ([unit isEqualToString:@"metric"]) return @"km";
    return unit;
}

#pragma mark - get/set 方法

- (void)setIsMileage:(BOOL)isMileage
{
    _isMileage = isMileage;
    self.mlUnitBtn.hidden = !isMileage;
    self.inputTextField.keyboardType = isMileage ? UIKeyboardTypeDecimalPad : UIKeyboardTypeDefault;
    
    CGFloat rightInset = isMileage ? 100 : (IS_IPad ? 40 : 10);
    [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(15);
        make.right.equalTo(self.contentView).inset(rightInset);
        make.height.equalTo(self.contentView);
        make.top.equalTo(@0);
    }];
}

- (void)setDiagnosticUnit:(NSString *)diagnosticUnit
{
    _diagnosticUnit = diagnosticUnit;
    NSString * unit = [self unitDisplayWithDiagUnit:diagnosticUnit];
    [self.mlUnitBtn setTitle:unit forState:UIControlStateNormal];
    _mlUnitBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    [self setNeedsLayout];
}

- (void)setInputText:(NSString *)text {
    if (!self.isMileage) {
        self.inputTextField.text = text;
        return;
    }
    
    NSString * temp = [text stringByReplacingOccurrencesOfString:@"km" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"Miles" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"Mile" withString:@""];
    temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([NSString tdd_isNum:temp]) {
        self.inputTextField.text = [NSString stringWithFormat:@"%@", temp];
    } else {
        self.inputTextField.text = @"";
    }
}

#pragma - mark 懒加载
- (NSArray<NSString *> *)datas {
    if (!_datas) {
        _datas = @[@"km", @"Miles"];
    }
    return _datas;
}

- (TDD_CustomLabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[TDD_CustomLabel alloc] init];
        _nameLabel.textColor = [UIColor tdd_title];
        _nameLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.numberOfLines = 0;
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}

- (TDD_CustomTextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [[TDD_CustomTextField alloc] init];
        NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:TDDLocalized.input_hint_report_dialog];
        [attStr addAttributes:@{NSForegroundColorAttributeName: UIColor.placeholderTextColor, NSFontAttributeName: [UIFont systemFontOfSize:14]} range:NSMakeRange(0, attStr.length)];
        _inputTextField.attributedPlaceholder = attStr;
    //    _inputTextField.placeholder = TDDLocalized.input_hint_report_dialog;
        _inputTextField.textColor = [UIColor tdd_title];
        _inputTextField.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
        _inputTextField.delegate = self;
    }
    return _inputTextField;
}

- (UIButton *)mlUnitBtn
{
    if (!_mlUnitBtn) {
        _mlUnitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (!isTopVCI) {
            [_mlUnitBtn setImage:kImageNamed(@"down_arrow") forState:UIControlStateNormal];
        }
        [_mlUnitBtn setTitleColor:[UIColor tdd_title] forState:UIControlStateNormal];
        _mlUnitBtn.titleLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14 weight:UIFontWeightMedium];
        [_mlUnitBtn addTarget:self action:@selector(unitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _mlUnitBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        _mlUnitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _mlUnitBtn;
}
    
@end
