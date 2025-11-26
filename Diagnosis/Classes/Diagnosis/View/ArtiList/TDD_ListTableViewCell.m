//
//  TDD_ListTableViewCell.m
//  AD200
//
//  Created by AppTD on 2022/11/18.
//

#import "TDD_ListTableViewCell.h"

@implementation TDD_ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:NO];
    NSLog(@"%d", hidden);
}

@end
