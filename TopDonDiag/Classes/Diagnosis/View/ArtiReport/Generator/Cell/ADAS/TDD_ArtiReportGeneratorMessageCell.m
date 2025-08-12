//
//  TDD_ArtiReportGeneratorMessageCell.m
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/11.
//

#import "TDD_ArtiReportGeneratorMessageCell.h"

@implementation TDD_ArtiReportGeneratorMessageCell // height: 140

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    self.backgroundColor = UIColor.tdd_btnBackground;
    
    [self.contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IS_IPad ? @40 : @15);
        make.top.equalTo(IS_IPad ? @20 : @13);
        make.right.equalTo(IS_IPad ? @-40 : @-15);
        make.bottom.equalTo(IS_IPad ? @-20 : @-13);
    }];
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(TDD_CustomTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return textView.text.length + (text.length - range.length) <= 1000;
}

- (void)textViewDidEndEditing:(TDD_CustomTextView *)textView {
    self.textView.text = [self.textView.text tdd_removeContainSpaceFileSpecialString];
    if (self.didChangedText) {
        self.didChangedText(self.textView.text);
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.beginEditing) {
        self.beginEditing();
    }
}

#pragma mark - Lazy Load

- (TDD_PlaceholderTextView *)textView {
    if (!_textView) {
        _textView = [[TDD_PlaceholderTextView alloc] init];
        _textView.placeholder = TDDLocalized.input_hint_report_dialog;
        _textView.placeholderColor = ([TDD_DiagnosisTools softWareIsTopVCI] || [TDD_DiagnosisTools softWareIsCarPalSeries]) ? [UIColor tdd_colorWithHex:0xFFFFFF alpha:0.5] : [UIColor tdd_colorCCCCCC];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = [UIColor tdd_title];
        _textView.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
        _textView.delegate = self;
    }
    return _textView;
}

@end
