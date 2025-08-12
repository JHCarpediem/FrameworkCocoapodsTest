//
//  TDD_ArtiReportGeneratorTextTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/9.
//

#import "TDD_ArtiReportGeneratorTextTableViewCell.h"

@implementation TDD_ArtiReportGeneratorTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI
{
    self.backgroundColor = UIColor.tdd_btnBackground;

//    self.nameLabel = [[TDD_CustomLabel alloc] init];
//    self.nameLabel.textColor = [UIColor tdd_title];
//    self.nameLabel.font = [UIFont systemFontOfSize:14];
//    self.nameLabel.textAlignment = NSTextAlignmentLeft;
//    self.nameLabel.backgroundColor = [UIColor clearColor];
//    self.nameLabel.numberOfLines = 0;
//    self.nameLabel.hidden = YES;
//    [self.contentView addSubview:self.nameLabel];
//
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(@15);
//        make.right.bottom.equalTo(@-15);
//    }];
  
    self.inputTextField = [[TDD_CustomTextField alloc] init];
    self.inputTextField.placeholder = TDDLocalized.input_hint_report_dialog;
    self.inputTextField.textColor = [UIColor tdd_title];
    self.inputTextField.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
    self.inputTextField.delegate = self;
    [self.inputTextField addTarget:self action:@selector(inputTextFieldEditingChanged) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:self.inputTextField];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IS_IPad ? @40 : @15);
        make.top.equalTo(IS_IPad ? @20 : @15);
        make.center.equalTo(self.contentView);
    }];
}

- (void)inputTextFieldEditingChanged {
    
    self.inputTextField.text = [TDD_DiagnosisTools softWareIsCarPalSeries] ? [self.inputTextField.text tdd_removeContainSpaceFileSpecialString] : [self.inputTextField.text tdd_removeFileSpecialString];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason
{
    if (self.didChangedText) {
        self.didChangedText(textField.text);
    }
}
@end
