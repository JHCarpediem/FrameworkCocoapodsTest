//
//  TDD_ArtiReportInfoCell.m
//  TopdonDiagnosis
//
//  Created by liuyong on 2025/3/27.
//

#import "TDD_ArtiReportInfoCell.h"


@interface TDD_ArtiReportInfoCell ()

/// label 之间行间距
@property (nonatomic, assign) CGFloat lineSpacing;

/// label 左右间距
@property (nonatomic, assign) CGFloat interItemSpacing;

/// 左右边距
@property (nonatomic, assign) CGFloat labelMargin;


@end

@implementation TDD_ArtiReportInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                  labelMargin:(CGFloat)labelMargin
                  lineSpacing:(CGFloat)lineSpacing
             interItemSpacing:(CGFloat)interItemSpacing {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelMargin = labelMargin;
        self.lineSpacing = lineSpacing;
        self.interItemSpacing = interItemSpacing;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    NSArray *titleArray = [self titleArray];
    InfoItemView *tempView = nil;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        
        InfoItemView *item = [[InfoItemView alloc] init];
        item.tag = 10 + i;
        [self.contentView addSubview:item];
        
        if (IS_IPad) {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo((IphoneWidth - self.labelMargin * 2 - self.interItemSpacing) / 2);
                if (i % 2 == 0) {
                    make.left.equalTo(self.contentView).offset(self.labelMargin);
                } else {
                    make.left.equalTo(tempView.mas_right).offset(self.interItemSpacing);
                }
                if (!tempView) {
                    make.top.equalTo(self.contentView).offset(10);
                } else if (i % 2 == 1) {
                    make.top.equalTo(tempView);
                    make.bottom.greaterThanOrEqualTo(tempView);
                } else {
                    make.top.equalTo(tempView.mas_bottom).offset(self.lineSpacing);
                }
                if (i == titleArray.count - 1) {
                    make.bottom.equalTo(self.contentView).offset(-40);
                }
            }];
        } else {
            
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                if (!tempView) {
                    make.top.equalTo(self.contentView);
                } else {
                    make.top.equalTo(tempView.mas_bottom).offset(self.lineSpacing);
                }
                make.left.equalTo(self.contentView).offset(self.labelMargin);
                make.right.equalTo(self.contentView).offset(-self.labelMargin);
                if (i == titleArray.count - 1) {
                    make.bottom.equalTo(self.contentView).offset(-30);
                }
            }];
        }
        
        tempView = item;
    }
    [self.contentView layoutIfNeeded];
}

- (void)updateUIWithModel:(TDD_ArtiReportCellModel *)model {
    
    NSArray *titleArray = [self titleArray];
    NSArray *valueArray = [self valueArrayWithModel:model];
    
    for (NSInteger i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        NSString *value = @"";
        if (valueArray.count > i) {
            value = valueArray[i];
        }
        InfoItemView *item = [self.contentView viewWithTag:10 + i];
        NSString *content = [NSString stringWithFormat:@"%@ %@", title, value];
        NSMutableAttributedString *attr = [NSMutableAttributedString mutableAttributedStringWithLTRString:content];
        [attr addAttributes:@{ NSForegroundColorAttributeName: [UIColor tdd_title] } range:[content rangeOfString:title]];
        item.contentLabel.attributedText = attr;
    }
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
    [self.contentView layoutIfNeeded];
}

- (NSArray *)titleArray {
    if (IS_IPad) {
        
    }
    NSArray *titleArray = @[
        TDDLocalized.report_license_plate,
        TDDLocalized.report_brand_of_vehicle,
        TDDLocalized.report_model,
        TDDLocalized.report_year,
        TDDLocalized.report_driving_distance,
        TDDLocalized.report_engine,
        TDDLocalized.report_sub_models,
        TDDLocalized.report_diagnosis_time,
        TDDLocalized.report_model_software_version_number,
        TDDLocalized.report_application_software_version,
        TDDLocalized.report_vin_code,
        TDDLocalized.report_diagnosis_path,
        [NSString tdd_reportTitleUser],
        [NSString tdd_reportTitleUserPhone],
//        TDDLocalized.maintenance_bill_number
    ];
    return titleArray;
}

- (NSArray *)valueArrayWithModel:(TDD_ArtiReportCellModel *)model {
    NSArray *valueArray = @[
//        [TDD_ArtiReportInfoCell getFlatStringWith:model.describe_title],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_license_plate_number],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_brand],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_model],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_year],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_mileage],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_engine],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_engine_subType],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_diagnosis_time],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_version],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_software_version],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.inputVIN],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_diagnosis_path],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_customer_name],
        [TDD_ArtiReportInfoCell getFlatStringWith: model.describe_customer_call],
//        [TDD_ArtiReportInfoCell getFlatStringWith: model.repairOrderNum],
    ];
    return valueArray;
}


+ (NSString *)getFlatStringWith:(NSString *)string {
    return string == nil ? @"" : string;
}



@end


@interface InfoItemView()

@end

@implementation InfoItemView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.contentLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.lessThanOrEqualTo(self);
    }];
}

- (TDD_CustomLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[TDD_CustomLabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
        _contentLabel.textColor = [UIColor tdd_color666666];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}





@end
