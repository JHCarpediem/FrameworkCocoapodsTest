//
//  ArtiReportPrintHeaderView.m
//  AD200
//
//  Created by lk_ios2023001 on 2023/5/15.
//

#import "TDD_ArtiReportPrintHeaderView.h"
#import "TDD_ArtiReportModel.h"

@interface TDD_ArtiReportPrintHeaderView()

@property (nonatomic, strong) UIImageView *logoImageView;

@end

@implementation TDD_ArtiReportPrintHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIImageView * bgImageView = [[UIImageView alloc] initWithImage:[UIImage tdd_imageDiagReportPageHeader]];
//    bgImageView.frame = CGRectMake(0, 0, self.width, self.height);
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    UIView * rightView = [[UIView alloc] init]; // WithFrame:CGRectMake(CGRectGetMaxX(bgImageView.frame) + 15, 0, self.tdd_width - (CGRectGetMaxX(bgImageView.frame) + 15 * 2), self.height)
    
    UIImageView * iconImageView = [[UIImageView alloc] initWithImage:kImageNamed(@"arti_reportTable_head_icon")];
//    iconImageView.frame = CGRectMake(40, 0, 35, 35);
//    iconImageView.center = CGPointMake(iconImageView.center.x, self.center.y);
    
    // 报告编号
    TDD_CustomLabel * serialLabel = [[TDD_CustomLabel alloc] init]; // WithFrame:CGRectMake(0, 0, rightView.width, 20)
    serialLabel.numberOfLines = 0;
    serialLabel.font = [UIFont systemFontOfSize:10];
    serialLabel.textColor = [UIColor whiteColor];
    // 创建日期
    TDD_CustomLabel * dateLabel = [[TDD_CustomLabel alloc] init]; // WithFrame:CGRectMake(0, CGRectGetMaxY(serialLabel.frame) + 10, rightView.width, 20)
    dateLabel.numberOfLines = 0;
    dateLabel.font = [UIFont systemFontOfSize:10];
    dateLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:bgImageView];
    [self addSubview:iconImageView];
    [self addSubview:rightView];
    [rightView addSubview:serialLabel];
    [rightView addSubview:dateLabel];
    
    self.serialLabel = serialLabel;
    self.timeLabel = dateLabel;
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(15);
        make.right.equalTo(@-15);
        make.centerY.equalTo(@0);
        make.height.lessThanOrEqualTo(self.mas_height);
    }];

    [serialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.right.equalTo(@0);
    }];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(serialLabel);
        make.top.equalTo(serialLabel.mas_bottom).offset(10);
        make.bottom.equalTo(@0);
    }];
    
    NSTimeInterval stampTime = [NSDate tdd_getTimestampSince1970];
    
    if ([TDD_DiagnosisManage sharedManage].currentSoftware == TDDSoftwareDeepScan) {
        serialLabel.text = [NSString stringWithFormat:@"%@ : %.0f",TDDLocalized.report_head_number, stampTime];
    } else {
        serialLabel.text = [NSString stringWithFormat:@"%@ : TD%.0f",TDDLocalized.report_head_number, stampTime];
    }
    
    dateLabel.text = [NSString stringWithFormat:@"%@ : %@",TDDLocalized.report_head_create_date, [NSDate tdd_getTimeStringWithInterval:stampTime Format:@"yyyy-MM-dd"]];
}

- (void)setReportModel:(TDD_ArtiReportModel *)reportModel
{
    _reportModel = reportModel;
    
    self.serialLabel.text = [NSString stringWithFormat:@"%@ : %@", TDDLocalized.report_head_number, reportModel.report_number];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@ : %@",TDDLocalized.report_head_create_date, [NSDate tdd_getTimeStringWithInterval:reportModel.reportCreateTime Format:@"yyyy-MM-dd"]];
}

- (void)setAppLogoImage:(UIImage *)appLogoImage {
    if (appLogoImage) {
        self.logoImageView.image = appLogoImage;
        if (!_logoImageView.superview) { [self addSubview:_logoImageView]; }
        [_logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-24.0));
            make.centerY.equalTo(@(0));
            make.size.equalTo(@(60.0));
        }];
    } else {
        _logoImageView.image = nil;
    }
}

#pragma mark - 懒加载

- (UIImageView *) logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithFrame: CGRectZero];
    }
    return _logoImageView;
}

@end
