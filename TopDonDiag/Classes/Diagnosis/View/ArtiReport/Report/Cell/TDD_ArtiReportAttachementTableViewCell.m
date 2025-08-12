//
//  TDD_ArtiReportAttachementTableViewCell.m
//  TopDonDiag
//
//  Created by yong liu on 2023/11/21.
//

#import "TDD_ArtiReportAttachementTableViewCell.h"

@implementation TDD_ArtiReportAttachementTableViewCell

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
        
    }
    return self;
}

- (void)fillCellWithAttachementFilePath:(NSString *)filePath fileArray:(NSString *)fileArrayStr isA4:(BOOL)isA4 {

    while (self.contentView.subviews.count > 0) {
        UIView *view = self.contentView.subviews[0];
        [view removeFromSuperview];
    }
    CGFloat imageWidth = IS_IPad ? 120 * HD_Height : 75 * H_Height;
    CGFloat imageSpace = IS_IPad ? 20 * HD_Height : (IphoneWidth - 30 - imageWidth * 4) / 3;
    CGFloat leftGap = IS_IPad ? 40 : 15;
    CGFloat top = IS_IPad ? 20 * HD_Height : 6;
    
    if (isA4 && IS_IPad) {
        imageWidth = 80;
        imageSpace = 15;
        leftGap = 20;
        top = 8;
    }
    
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSString *filePath = [document stringByAppendingFormat:@"/HistoryDiag/Attachement/TD_%@", @(pk)];
    NSArray *fileArray = [fileArrayStr componentsSeparatedByString:@","];
    for (NSInteger i = 0; i < fileArray.count; i++) {
        NSString *fileStr = fileArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftGap + (imageWidth + imageSpace) * i, top, imageWidth, imageWidth)];
        [imageView tdd_addCornerRadius:2];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageWithContentsOfFile:[filePath stringByAppendingFormat:@"/%@", fileStr]];
        [self.contentView addSubview:imageView];
    }
}



@end
