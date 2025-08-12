//
//  TDD_ArtiReportFlowRowTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/8.
//

#import "TDD_ArtiReportFlowRowTableViewCell.h"
#import "TDD_DashLineView.h"

@interface TDD_ArtiReportFlowRowTableViewCell ()

@property (nonatomic, strong)  NSMutableArray<UILabel*> *labels;
@property (nonatomic, strong) TDD_DashLineView *lineView;

@end

@implementation TDD_ArtiReportFlowRowTableViewCell

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
    
    self.lineView = [[TDD_DashLineView alloc] init];
    self.lineView.lineDotWidth = 2;
    self.lineView.lineDotSpacing = 2;
    self.lineView.backgroundColor = [UIColor clearColor];
    self.lineView.dashLineColor = [UIColor tdd_subTitle];
    [self.contentView addSubview:self.lineView];
}

-(void)updateWith:(NSArray *)models
{
    
    if (models == nil || models.count == 0) {
        return;
    }
    
    CGFloat labelWidth = IphoneWidth / models.count;
    CGFloat labelHeight = self.contentView.tdd_height;

    for (int i = 0; i < models.count; i++) {
        if (i < self.labels.count) {
            TDD_CustomLabel *label = self.labels[i];
            label.textColor = [UIColor tdd_color666666];
            if (i < models.count) {
                label.text = models[i];
            }
            label.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
            label.tdd_width = labelWidth;
            label.tdd_height = labelHeight;
            if (i > 0) {
                label.tdd_left = self.labels[i-1].tdd_right;
            }
            
            if (i == models.count - 1) {
                label.tdd_width = labelWidth - 10;
            }
        }
    }
    
    self.lineView.tdd_width = IphoneWidth;
    self.lineView.tdd_height = 0.5;
    self.lineView.tdd_left = 0;
    self.lineView.tdd_bottom = self.contentView.tdd_height;
    self.lineView.dashLineColor = [UIColor tdd_subTitle];
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
}

-(void)updateA4With:(NSArray *)models
{
    
    if (models == nil || models.count == 0) {
        return;
    }
    
    CGFloat labelWidth = A4Width / models.count;
    CGFloat labelHeight = self.contentView.tdd_height;

    for (int i = 0; i < models.count; i++) {
        if (i < self.labels.count) {
            TDD_CustomLabel *label = self.labels[i];
            label.textColor = [UIColor tdd_reportCodeSectionTextColor];
            if (i < models.count) {
                label.text = models[i];
            }
            label.font = [UIFont systemFontOfSize:10];
            label.tdd_width = labelWidth;
            label.tdd_height = labelHeight;
            if (i > 0) {
                label.tdd_left = self.labels[i-1].tdd_right;
            }
            
            if (i == models.count - 1) {
                label.tdd_width = labelWidth - 10;
            }
        }
    }
    
    self.lineView.tdd_width = A4Width;
    self.lineView.tdd_height = 1;
    self.lineView.tdd_left = 0;
    self.lineView.tdd_bottom = self.contentView.tdd_height;
    self.lineView.dashLineColor = [UIColor tdd_color999999];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

@end
