//
//  TDD_ArtiReportCodeRowTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/4.
//
//  故障码表头
//

#import "TDD_ArtiReportCodeRowTableViewCell.h"

@interface TDD_ArtiReportCodeRowTableViewCell()

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation TDD_ArtiReportCodeRowTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI
{
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
    
    self.nameLabel = [[TDD_CustomLabel alloc] init];
    self.nameLabel.textColor = [UIColor tdd_title];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.nameLabel];
    
    self.leftLabel = [[TDD_CustomLabel alloc] init];
    self.leftLabel.textColor = [UIColor tdd_title];
    self.leftLabel.font = [UIFont systemFontOfSize:14];
    self.leftLabel.textAlignment = NSTextAlignmentLeft;
    self.leftLabel.adjustsFontSizeToFitWidth = YES;
    self.leftLabel.backgroundColor = [UIColor clearColor];
    self.leftLabel.numberOfLines = 0;
    [self.contentView addSubview:self.leftLabel];
    
    self.rightLabel = [[TDD_CustomLabel alloc] init];
    self.rightLabel.textColor = [UIColor tdd_title];
    self.rightLabel.font = [UIFont systemFontOfSize:14];
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    self.rightLabel.adjustsFontSizeToFitWidth = YES;
    self.rightLabel.backgroundColor = [UIColor clearColor];
    self.rightLabel.numberOfLines = 0;
    [self.contentView addSubview:self.rightLabel];
    
    UIView *bottomLine = [[UIView alloc] init];
    self.bottomLine = bottomLine;
    bottomLine.backgroundColor = UIColor.tdd_line;
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.height.equalTo(@0.5);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

-(void)updateLeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent {
    
//    CGFloat leftGap = IS_IPad ? 40 : 15;
//    CGFloat allLabelWidth = IphoneWidth - leftGap * 2;
    
    CGFloat leftGap = IS_IPad ? 40 : 0;
    CGFloat allLabelWidth = IphoneWidth - leftGap * 2;    
    self.nameLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 15];
    self.leftLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 15];
    self.rightLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 15];
    
    self.rightLabel.tdd_width = allLabelWidth * rightPercent;
    self.rightLabel.tdd_height = self.contentView.tdd_height;
    self.rightLabel.tdd_right = IphoneWidth - leftGap;
    self.rightLabel.tdd_top = 0;
    
    self.leftLabel.tdd_width = allLabelWidth * leftPercent;
    self.leftLabel.tdd_height = self.contentView.tdd_height;
    self.leftLabel.tdd_right = self.rightLabel.tdd_left;
    self.leftLabel.tdd_top = self.rightLabel.tdd_top;
    
    self.nameLabel.tdd_width = allLabelWidth - self.leftLabel.tdd_width - self.rightLabel.tdd_width - 10;
    self.nameLabel.tdd_height = self.contentView.tdd_height;
    self.nameLabel.tdd_left = leftGap + 5;
    self.nameLabel.tdd_top = 0;
    
    self.nameLabel.textColor = [UIColor tdd_title];
    self.leftLabel.textColor = [UIColor tdd_title];
//    self.rightLabel.textColor = [UIColor tdd_title];
    self.bottomLine.backgroundColor = UIColor.tdd_line;
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
}

-(void)updateA4LeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent
{
    self.nameLabel.font = [UIFont systemFontOfSize:10];
    self.leftLabel.font = [UIFont systemFontOfSize:10];
    self.rightLabel.font = [UIFont systemFontOfSize:10];
    
    self.rightLabel.tdd_width = A4Width * rightPercent - 20;
    self.rightLabel.tdd_height = self.contentView.tdd_height;
    self.rightLabel.tdd_right = A4Width - 10;
    self.rightLabel.tdd_top = 0;
    
    self.leftLabel.tdd_width = A4Width * leftPercent;
    self.leftLabel.tdd_height = self.contentView.tdd_height;
    self.leftLabel.tdd_right = self.rightLabel.tdd_left;
    self.leftLabel.tdd_top = self.rightLabel.tdd_top;
    
    float leftGap = 0;
    self.nameLabel.tdd_width = A4Width - self.leftLabel.tdd_width - self.rightLabel.tdd_width - leftGap - 20;
    self.nameLabel.tdd_height = self.contentView.tdd_height;
    self.nameLabel.tdd_left = leftGap + 5;
    self.nameLabel.tdd_top = 0;
    
    self.nameLabel.textColor = [UIColor tdd_pdfDtcNormalColor];
    self.leftLabel.textColor = [UIColor tdd_pdfDtcNormalColor];
//    self.rightLabel.textColor = isKindOfTopVCI ? UIColor.blackColor : [UIColor tdd_title];
    self.bottomLine.backgroundColor = [UIColor tdd_ColorEEEEEE];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    HLog("codeRowWidth: %f -- %f", self.rightLabel.tdd_width, self.rightLabel.tdd_centerX);
}

-(void)updateLeftLabelColor:(UIColor *)leftColor withRightColor:(UIColor *)rightColor
{
    self.leftLabel.textColor = leftColor;
    self.rightLabel.textColor = rightColor;
}

+ (CGFloat)calRightLabelHeightWithAttributedString:(NSAttributedString *)attributedString maxWidth: (CGFloat)maxwidth isA4:(BOOL)isA4 {
    TDD_CustomLabel *label = [[TDD_CustomLabel alloc] initWithFrame:CGRectMake(0, 0, maxwidth, CGFLOAT_MAX)];
    label.numberOfLines = isA4 ? 0 : 2;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.adjustsFontSizeToFitWidth = NO;
    label.preferredMaxLayoutWidth = maxwidth;
    label.minimumScaleFactor = 0.0;
    
    UIFont *font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
    if (attributedString && attributedString.length > 0) {
        
        NSRange effectiveRange;
        UIFont *fetchFont = [self fontInAttributedString:attributedString atIndex:0 effectiveRange:&effectiveRange];
        if (fetchFont) {
            font = fetchFont;
        }
    }
    
    label.font = font;
    label.attributedText = attributedString;
    
    [label sizeToFit];
    
    return label.frame.size.height;
}

- (void)updateRightLabelWithAttributedString:(NSAttributedString *)attributedString isA4:(BOOL)isA4 {
    self.rightLabel.numberOfLines = isA4 ? 0 : 2;
    self.rightLabel.adjustsFontSizeToFitWidth = isA4 ? YES : NO;
    self.rightLabel.attributedText = attributedString;
    self.rightLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
}

+ (UIFont *)fontInAttributedString:(NSAttributedString *)attributedString atIndex:(NSUInteger)index effectiveRange:(NSRangePointer)range {
    NSDictionary *attributes = [attributedString attributesAtIndex:index effectiveRange:range];
    UIFont *font = attributes[NSFontAttributeName];
    return font;
}

@end

