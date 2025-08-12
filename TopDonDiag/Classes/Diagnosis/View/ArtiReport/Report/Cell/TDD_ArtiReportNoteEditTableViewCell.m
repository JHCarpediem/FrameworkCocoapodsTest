//
//  TDD_ReportNoteEditTableViewCell.m
//  TopdonDiagnosis
//
//  Created by liuyong on 2024/7/1.
//

#import "TDD_ArtiReportNoteEditTableViewCell.h"

@interface TDD_ArtiReportNoteEditTableViewCell ()<UITextViewDelegate>

@property (nonatomic, strong) TDD_CustomTextView *textView;

@end

@implementation TDD_ArtiReportNoteEditTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(IS_IPad ? 40 : 20);
        make.top.equalTo(self.contentView).offset(IS_IPad ? 10 : 0);
    }];
    
}

- (void)setNote:(NSString *)note {
    if ([NSString tdd_isEmpty:note]) {
        note = TDDLocalized.please_enter;
        self.textView.textColor = [UIColor placeholderTextColor];
    }
    self.textView.text = note;
}

#pragma mark - UITextViewDelegate  ///限制1000个字符
- (void)textViewDidChange:(TDD_CustomTextView *)textView{
    NSLog(@"%s--%@",__func__,textView.text);
    if (self.textView.text.length > 1000) {
        self.textView.text = [self.textView.text substringToIndex:1000];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(reportInfoChangedNote:)]) {
        [self.delegate reportInfoChangedNote:self.textView.text];
    }
}

- (BOOL)textView:(TDD_CustomTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return textView.text.length + (text.length - range.length) <= 1000;
}

- (void)textViewDidEndEditing:(TDD_CustomTextView *)textView
{
    if (textView.text.length < 1) {
        textView.text = TDDLocalized.please_enter;
        textView.textColor = [UIColor placeholderTextColor];
    }
}
- (void)textViewDidBeginEditing:(TDD_CustomTextView *)textView
{
    if ([textView.text isEqualToString:TDDLocalized.please_enter]) {
        textView.text= @"";
        textView.textColor = [UIColor tdd_title];
    }
}

- (TDD_CustomTextView *)textView {
    if (!_textView) {
        _textView = [[TDD_CustomTextView alloc] init];
        _textView.textColor = [UIColor tdd_color666666];
        _textView.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
        _textView.contentInset = UIEdgeInsetsMake(3, 10, 3, 10);
        _textView.delegate = self;
        _textView.layer.cornerRadius = 3;
        _textView.layer.borderWidth = 0.5;
        _textView.layer.borderColor = [UIColor tdd_colorCCCCCC].CGColor;
    }
    return _textView;
}

@end
