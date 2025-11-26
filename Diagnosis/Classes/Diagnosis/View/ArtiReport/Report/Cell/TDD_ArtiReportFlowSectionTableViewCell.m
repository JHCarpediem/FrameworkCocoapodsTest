//
//  TDD_ArtiReportFlowSectionTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/8.
//
//  数据流 表头
//

#import "TDD_ArtiReportFlowSectionTableViewCell.h"

@interface TDD_ArtiReportFlowSectionTableViewCell ()

@property (nonatomic, strong)  NSMutableArray<UILabel*> *labels;

@end

@implementation TDD_ArtiReportFlowSectionTableViewCell

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
    self.contentView.backgroundColor = [UIColor tdd_cellBackground];
    self.labels = [[NSMutableArray alloc] init];
    int defaultModelCount = 4;
    for (int i = 0; i < defaultModelCount; i++) {
        TDD_CustomLabel *label = [[TDD_CustomLabel alloc] init];
        label.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor tdd_color666666];
        label.numberOfLines = 0;
        [self.labels addObject:label];
        [self.contentView addSubview:label];
    }
}

-(void)updateWith:(NSArray *)models
{
    
    CGFloat labelWidth = IphoneWidth / models.count;
    CGFloat labelHeight = self.contentView.tdd_height;
    
    if (models == nil || models.count == 0) {
        return;
    }
    
    for (int i = 0; i < models.count; i++) {
        if (i < self.labels.count) {
            TDD_CustomLabel *label = self.labels[i];
            label.textColor = [UIColor tdd_color666666];
            label.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
            if (i < models.count) {
                label.text = models[i];
            }
            label.tdd_width = labelWidth;
            label.tdd_height = labelHeight;
            if (i > 0) {
                label.tdd_left = self.labels[i-1].tdd_right;
            }
        }
    }
    
    self.contentView.backgroundColor = UIColor.tdd_cellBackground;
}

-(void)updateA4With:(NSArray *)models
{
    
    CGFloat labelWidth = A4Width / models.count;
    CGFloat labelHeight = self.contentView.tdd_height;
    
    if (models == nil || models.count == 0) {
        return;
    }
    
    for (int i = 0; i < models.count; i++) {
        if (i < self.labels.count) {
            TDD_CustomLabel *label = self.labels[i];
            label.textColor = [UIColor tdd_reportCodeSectionTextColor];
            label.font = [UIFont systemFontOfSize:10];
            if (i < models.count) {
                label.text = models[i];
            }
            label.tdd_width = labelWidth;
            label.tdd_height = labelHeight;
            if (i > 0) {
                label.tdd_left = self.labels[i-1].tdd_right;
            }
        }
    }
    
    self.contentView.backgroundColor = [UIColor tdd_reportCodeSectionBackground];
}

@end
