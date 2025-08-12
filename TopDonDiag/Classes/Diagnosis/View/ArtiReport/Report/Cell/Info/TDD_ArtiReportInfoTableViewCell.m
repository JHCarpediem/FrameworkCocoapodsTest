//
//  TDD_ArtiReportInfoTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/3.
//
//  诊断信息
//

#import "TDD_ArtiReportInfoTableViewCell.h"

@implementation TDD_ArtiReportInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabelArray = [[NSMutableArray alloc] init];
        self.lineView = [[TDD_DashLineView alloc] init];
        self.lineView.hidden = YES;
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
    self.backgroundColor = UIColor.clearColor;
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage tdd_imageDiagReportInfo]];
    if ([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany) {
        bgImageView.image = nil;
    }
    bgImageView.backgroundColor = UIColor.tdd_btnBackground;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(@0);
    }];
        
    NSArray *titleArray = @[
        TDDLocalized.feedback_title,
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
        TDDLocalized.maintenance_bill_number
    ];
    if (isKindOfTopVCI){
        titleArray = @[
            TDDLocalized.feedback_title,
            TDDLocalized.report_license_plate,
            TDDLocalized.report_brand_of_vehicle,
            TDDLocalized.report_model,
            TDDLocalized.report_year,
            TDDLocalized.report_driving_distance,
            TDDLocalized.report_engine,
            TDDLocalized.report_sub_models,
            TDDLocalized.report_diagnosis_time,
            TDDLocalized.report_vin_code,
            [NSString tdd_reportTitleUser],
            [NSString tdd_reportTitleUserPhone]
        ];
    }
    
    self.describeTitleLabel = [[TDD_CustomLabel alloc] init];
    self.describeLicensePlateNumberLabel = [[TDD_CustomLabel alloc] init];
    self.describeBrandLabel = [[TDD_CustomLabel alloc] init];
    self.describeModelLabel = [[TDD_CustomLabel alloc] init];
    self.describeYearLabel = [[TDD_CustomLabel alloc] init];
    self.describeMileageLabel = [[TDD_CustomLabel alloc] init];
    self.describeEngineLabel = [[TDD_CustomLabel alloc] init];
    self.describeEngineSubTypeLabel = [[TDD_CustomLabel alloc] init];
    self.describeDiagnosisTimeLabel = [[TDD_CustomLabel alloc] init];
    self.describeVersionLabel = [[TDD_CustomLabel alloc] init];
    self.describeSoftwareVersionLabel = [[TDD_CustomLabel alloc] init];
    self.VINLabel = [[TDD_CustomLabel alloc] init];
    self.describeDiagnosisPathLabel = [[TDD_CustomLabel alloc] init];
    self.describeCustomerNameLabel = [[TDD_CustomLabel alloc] init];
    self.describeCustomerCallLabel = [[TDD_CustomLabel alloc] init];
    self.repairOrderNumLabel = [[TDD_CustomLabel alloc] init];
    
    NSArray *labelArray = @[
        self.describeTitleLabel,
        self.describeLicensePlateNumberLabel,
        self.describeBrandLabel,
        self.describeModelLabel,
        self.describeYearLabel,
        self.describeMileageLabel,
        self.describeEngineLabel,
        self.describeEngineSubTypeLabel,
        self.describeDiagnosisTimeLabel,
        self.describeVersionLabel,
        self.describeSoftwareVersionLabel,
        self.VINLabel,
        self.describeDiagnosisPathLabel,
        self.describeCustomerNameLabel,
        self.describeCustomerCallLabel,
        self.repairOrderNumLabel,
    ];
    if (isKindOfTopVCI){
        labelArray = @[
            self.describeTitleLabel,
            self.describeLicensePlateNumberLabel,
            self.describeBrandLabel,
            self.describeModelLabel,
            self.describeYearLabel,
            self.describeMileageLabel,
            self.describeEngineLabel,
            self.describeEngineSubTypeLabel,
            self.describeDiagnosisTimeLabel,
            self.VINLabel,
            self.describeCustomerNameLabel,
            self.describeCustomerCallLabel,
        ];
    }
        
    for (int i = 0; i < titleArray.count; i++) {
        if ([titleArray[i] isEqualToString:TDDLocalized.feedback_title]) {
            self.describeTitleLabel.font = [UIFont systemFontOfSize:17];
            self.describeTitleLabel.textColor = [UIColor tdd_title];
            self.describeTitleLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:self.describeTitleLabel];
            self.describeTitleLabel.numberOfLines = 0;
            self.describeTitleLabel.adjustsFontSizeToFitWidth = YES;
            
            self.lineView.lineDotWidth = 2;
            self.lineView.lineDotSpacing = 2;
            self.lineView.backgroundColor = [UIColor clearColor];
            self.lineView.dashLineColor = [UIColor tdd_colorDiagDashLine];
            [self.contentView addSubview: self.lineView];
            
            [self.titleLabelArray addObject: [TDD_CustomLabel new]];
        } else {
            TDD_CustomLabel *titleLabel = [[TDD_CustomLabel alloc] init];
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textColor = [UIColor tdd_title];
            [self.contentView addSubview: titleLabel];
            titleLabel.text = [NSString stringWithFormat:@"%@", titleArray[i]];
            titleLabel.numberOfLines = 0;
            titleLabel.adjustsFontSizeToFitWidth = YES;
            
            TDD_CustomLabel *valueLabel = labelArray[i];
            valueLabel.font = [UIFont systemFontOfSize:14];
            valueLabel.textColor = [UIColor tdd_color666666];
            valueLabel.adjustsFontSizeToFitWidth = YES;
            valueLabel.numberOfLines = 0;
            [self.contentView addSubview: valueLabel];
            [self.titleLabelArray addObject: titleLabel];
        }
        
    }
}

-(void)updateWith:(TDD_ArtiReportCellModel *)model
{
    self.describeTitleLabel.text = model.describe_title;
    self.describeBrandLabel.text = model.describe_brand;
    self.describeModelLabel.text = model.describe_model;
    self.describeYearLabel.text = model.describe_year;
    self.describeMileageLabel.text = model.describe_mileage;
    self.describeEngineLabel.text = model.describe_engine;
    self.describeEngineSubTypeLabel.text = model.describe_engine_subType;
    self.describeDiagnosisPathLabel.text = model.describe_diagnosis_path;
    
    self.describeCustomerNameLabel.text = model.describe_customer_name;
    self.describeLicensePlateNumberLabel.text = model.describe_license_plate_number;
    self.VINLabel.text = model.inputVIN;
    self.describeCustomerCallLabel.text = model.describe_customer_call;
    self.repairOrderNumLabel.text = model.repairOrderNum;
    self.describeVersionLabel.text = model.describe_version;
    self.describeSoftwareVersionLabel.text = model.describe_software_version;
    self.describeDiagnosisTimeLabel.text = model.describe_diagnosis_time;
    
    NSArray *titleArray = @[
        TDDLocalized.feedback_title,
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
        TDDLocalized.maintenance_bill_number
    ];
    if (isKindOfTopVCI){
        titleArray = @[
            TDDLocalized.feedback_title,
            TDDLocalized.report_license_plate,
            TDDLocalized.report_brand_of_vehicle,
            TDDLocalized.report_model,
            TDDLocalized.report_year,
            TDDLocalized.report_driving_distance,
            TDDLocalized.report_engine,
            TDDLocalized.report_sub_models,
            TDDLocalized.report_diagnosis_time,
            TDDLocalized.report_vin_code,
            [NSString tdd_reportTitleUser],
            [NSString tdd_reportTitleUserPhone]
        ];
    }
    
    
    NSArray *valueArray = @[
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_software_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_path],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.repairOrderNum],
    ];
    if (isKindOfTopVCI){
        valueArray = @[
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call]
        ];
    }
    
    
    CGFloat totalHeight = 0;
    for (int i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        NSString *value = valueArray[i];
        NSString *titleAndValue = [NSString stringWithFormat:@"%@%@", title, value];
        CGFloat maxWidth = IphoneWidth - 30;
        CGFloat gap = 10;
        CGFloat oneRowHeight = [NSString tdd_getHeightWithText:@"TEXT" width:maxWidth fontSize:[UIFont systemFontOfSize:14]];
        CGFloat valueHeight = MAX([NSString tdd_getHeightWithText:titleAndValue width:maxWidth fontSize:[UIFont systemFontOfSize:14]], oneRowHeight);
            
        if ([titleArray[i] isEqualToString:TDDLocalized.feedback_title]) {
            valueHeight = 0;
        }
        
        if (i < self.titleLabelArray.count) {
            TDD_CustomLabel *titleLabel = self.titleLabelArray[i];
            titleLabel.tdd_width = IphoneWidth - 30;
            titleLabel.tdd_height = valueHeight;
            titleLabel.tdd_left = 15;
            titleLabel.tdd_top = totalHeight + gap;
//            titleLabel.textColor = [UIColor tdd_title];
            
            NSMutableAttributedString *attributeTitle = [NSMutableAttributedString mutableAttributedStringWithLTRString:title attributes:@{
                NSForegroundColorAttributeName : [UIColor tdd_title],
                    NSFontAttributeName : [UIFont systemFontOfSize:14]
                }];
            NSMutableAttributedString *attributeValue = [NSMutableAttributedString mutableAttributedStringWithLTRString:value attributes:@{
                    NSForegroundColorAttributeName : [UIColor tdd_color666666],
                    NSFontAttributeName : [UIFont systemFontOfSize:14]
                }];
            NSMutableAttributedString *attributeTitleAndValue = [NSMutableAttributedString mutableAttributedStringWithLTR];
            [attributeTitleAndValue appendAttributedString:attributeTitle];
            [attributeTitleAndValue appendAttributedString:attributeValue];
            titleLabel.attributedText = attributeTitleAndValue;
        }
        
        if ([titleArray[i] isEqualToString:TDDLocalized.feedback_title]) {
            self.describeTitleLabel.textColor = [UIColor tdd_title];
            self.describeTitleLabel.tdd_width = IphoneWidth - 30;
            self.describeTitleLabel.tdd_height = valueHeight;
            self.describeTitleLabel.tdd_left = 15;
            self.lineView.tdd_width = IphoneWidth - 30;
            self.lineView.tdd_height = 1;
            self.lineView.tdd_left = 15;
            self.lineView.tdd_top = self.describeTitleLabel.tdd_bottom;
        }
        
        totalHeight = totalHeight + valueHeight + gap;
    }
    
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
}

+(CGFloat)getCellHeightWith:(TDD_ArtiReportCellModel *)model
{
    NSArray *titleArray = @[
        TDDLocalized.feedback_title,
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
        TDDLocalized.maintenance_bill_number
    ];
    if (isKindOfTopVCI){
        titleArray = @[
            TDDLocalized.feedback_title,
            TDDLocalized.report_license_plate,
            TDDLocalized.report_brand_of_vehicle,
            TDDLocalized.report_model,
            TDDLocalized.report_year,
            TDDLocalized.report_driving_distance,
            TDDLocalized.report_engine,
            TDDLocalized.report_sub_models,
            TDDLocalized.report_diagnosis_time,
            TDDLocalized.report_vin_code,
            [NSString tdd_reportTitleUser],
            [NSString tdd_reportTitleUserPhone]
        ];
    }
    
    NSArray *valueArray = @[
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_software_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_path],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.repairOrderNum],
    ];
    if (isKindOfTopVCI){
        valueArray = @[
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call]
        ];
    }
    
    CGFloat totalHeight = 0;
    for (int i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        NSString *value = valueArray[i];
        NSString *titleAndValue = [NSString stringWithFormat:@"%@%@", title, value];
        CGFloat maxWidth = IphoneWidth - 30;
        CGFloat gap = 10;
        CGFloat oneRowHeight = [NSString tdd_getHeightWithText:@"TEXT" width:maxWidth fontSize:[UIFont systemFontOfSize:14]];
        CGFloat valueHeight = MAX([NSString tdd_getHeightWithText:titleAndValue width:maxWidth fontSize:[UIFont systemFontOfSize:14]], oneRowHeight);
        
        if ([titleArray[i] isEqualToString:TDDLocalized.feedback_title]) {
            valueHeight = 0;
        }
        
        totalHeight = totalHeight + valueHeight + gap;
    }
    
    return totalHeight;
}

#pragma mark A4上的计算方法
-(void)updateA4With:(TDD_ArtiReportCellModel *)model
{
    self.describeTitleLabel.text = model.describe_title;
    self.describeBrandLabel.text = model.describe_brand;
    self.describeModelLabel.text = model.describe_model;
    self.describeYearLabel.text = model.describe_year;
    self.describeMileageLabel.text = model.describe_mileage;
    self.describeEngineLabel.text = model.describe_engine;
    self.describeEngineSubTypeLabel.text = model.describe_engine_subType;
    self.describeDiagnosisPathLabel.text = model.describe_diagnosis_path;
    
    self.describeCustomerNameLabel.text = model.describe_customer_name;
    self.describeLicensePlateNumberLabel.text = model.describe_license_plate_number;
    self.VINLabel.text = model.inputVIN;
    self.describeCustomerCallLabel.text = model.describe_customer_call;
    self.repairOrderNumLabel.text = model.repairOrderNum;
    self.describeVersionLabel.text = model.describe_version;
    self.describeSoftwareVersionLabel.text = model.describe_software_version;
    self.describeDiagnosisTimeLabel.text = model.describe_diagnosis_time;
    
    NSArray *titleArray = @[
        TDDLocalized.feedback_title,
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
        TDDLocalized.maintenance_bill_number
    ];
    if (isKindOfTopVCI){
        titleArray = @[
            TDDLocalized.feedback_title,
            TDDLocalized.report_license_plate,
            TDDLocalized.report_brand_of_vehicle,
            TDDLocalized.report_model,
            TDDLocalized.report_year,
            TDDLocalized.report_driving_distance,
            TDDLocalized.report_engine,
            TDDLocalized.report_sub_models,
            TDDLocalized.report_diagnosis_time,
            TDDLocalized.report_vin_code,
            [NSString tdd_reportTitleUser],
            [NSString tdd_reportTitleUserPhone]
        ];
    }
    
    NSArray *valueArray = @[
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_software_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_path],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.repairOrderNum],
    ];
    if (isKindOfTopVCI){
        valueArray = @[
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call]
        ];
    }
    
    CGFloat totalHeight = 0;
    for (int i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        NSString *value = valueArray[i];
        NSString *titleAndValue = [NSString stringWithFormat:@"%@%@", title, value];
        CGFloat maxWidth = A4Width - 30;
        CGFloat gap = 5;
        CGFloat oneRowHeight = [NSString tdd_getHeightWithText:@"TEXT" width:maxWidth fontSize:[UIFont systemFontOfSize:10]];
        CGFloat valueHeight = MAX([NSString tdd_getHeightWithText:titleAndValue width:maxWidth fontSize:[UIFont systemFontOfSize:10]], oneRowHeight);
            
        if ([titleArray[i] isEqualToString:Local(@"feedback_title")]) {
            valueHeight = 0;
        }
        
        if (i < self.titleLabelArray.count) {
            TDD_CustomLabel *titleLabel = self.titleLabelArray[i];
            titleLabel.tdd_width = A4Width - 30;
            titleLabel.tdd_height = valueHeight;
            titleLabel.tdd_left = 15;
            titleLabel.tdd_top = totalHeight + gap;
            
            NSMutableAttributedString *attributeTitle = [NSMutableAttributedString mutableAttributedStringWithLTRString:title attributes:@{
                    NSForegroundColorAttributeName : [UIColor tdd_pdfDtcNormalColor],
                    NSFontAttributeName : [UIFont systemFontOfSize:10]
                }];
            NSMutableAttributedString *attributeValue = [NSMutableAttributedString mutableAttributedStringWithLTRString:value attributes:@{
                    NSForegroundColorAttributeName : [UIColor tdd_reportInfoValueTextColor],
                    NSFontAttributeName : [UIFont systemFontOfSize:10]
                }];
            NSMutableAttributedString *attributeTitleAndValue = [NSMutableAttributedString mutableAttributedStringWithLTR];
            [attributeTitleAndValue appendAttributedString:attributeTitle];
            [attributeTitleAndValue appendAttributedString:attributeValue];
            titleLabel.attributedText = attributeTitleAndValue;
        }
        
        if ([titleArray[i] isEqualToString:Local(@"feedback_title")]) {
            self.describeTitleLabel.textColor = [UIColor tdd_pdfDtcNormalColor];
            self.describeTitleLabel.tdd_width = A4Width - 30;
            self.describeTitleLabel.tdd_height = valueHeight;
            self.describeTitleLabel.tdd_left = 15;
            self.lineView.tdd_width = A4Width - 30;
            self.lineView.tdd_height = 0.5;
            self.lineView.tdd_left = 15;
            self.lineView.tdd_top = self.describeTitleLabel.tdd_bottom;
        }
        
        totalHeight = totalHeight + valueHeight + gap;
    }
    
    self.contentView.backgroundColor = [UIColor whiteColor];
}
/// 获取 Cell 在A4纸上的高度
+(CGFloat)getCellA4HeightWith:(TDD_ArtiReportCellModel *)model
{
    NSArray *titleArray = @[
        TDDLocalized.feedback_title,
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
        TDDLocalized.maintenance_bill_number
    ];
    if (isKindOfTopVCI){
        titleArray = @[
            TDDLocalized.feedback_title,
            TDDLocalized.report_license_plate,
            TDDLocalized.report_brand_of_vehicle,
            TDDLocalized.report_model,
            TDDLocalized.report_year,
            TDDLocalized.report_driving_distance,
            TDDLocalized.report_engine,
            TDDLocalized.report_sub_models,
            TDDLocalized.report_diagnosis_time,
            TDDLocalized.report_vin_code,
            [NSString tdd_reportTitleUser],
            [NSString tdd_reportTitleUserPhone]
        ];
    }
    
    NSArray *valueArray = @[
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_software_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_path],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.repairOrderNum],
    ];
    if (isKindOfTopVCI){
        valueArray = @[
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call]
        ];
    }
    
    CGFloat totalHeight = 0;
    for (int i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        NSString *value = valueArray[i];
        NSString *titleAndValue = [NSString stringWithFormat:@"%@%@", title, value];
        CGFloat maxWidth = A4Width - 30;
        CGFloat gap = 5;
        CGFloat oneRowHeight = [NSString tdd_getHeightWithText:@"TEXT" width:maxWidth fontSize:[UIFont systemFontOfSize:10]];
        CGFloat valueHeight = MAX([NSString tdd_getHeightWithText:titleAndValue width:maxWidth fontSize:[UIFont systemFontOfSize:10]], oneRowHeight);
        
        if ([titleArray[i] isEqualToString:Local(@"feedback_title")]) {
            valueHeight = 0;
        }
        
        totalHeight = totalHeight + valueHeight + gap;
    }
    
    return totalHeight;
}

#pragma mark -- 历史诊断报告
// 更新属性
- (void)updateHistoryReportWithModel:(TDD_ArtiReportCellModel *)model {
    self.describeTitleLabel.text = model.describe_title;
    self.describeBrandLabel.text = model.describe_brand;
    self.describeModelLabel.text = model.describe_model;
    self.describeYearLabel.text = model.describe_year;
    self.describeMileageLabel.text = model.describe_mileage;
    self.describeEngineLabel.text = model.describe_engine;
    self.describeEngineSubTypeLabel.text = model.describe_engine_subType;
    self.describeDiagnosisPathLabel.text = model.describe_diagnosis_path;
    
    self.describeCustomerNameLabel.text = model.describe_customer_name;
    self.describeLicensePlateNumberLabel.text = model.describe_license_plate_number;
    self.VINLabel.text = model.inputVIN;
    self.describeCustomerCallLabel.text = model.describe_customer_call;
    self.repairOrderNumLabel.text = model.repairOrderNum;
    self.describeVersionLabel.text = model.describe_version;
    self.describeSoftwareVersionLabel.text = model.describe_software_version;
    self.describeDiagnosisTimeLabel.text = model.describe_diagnosis_time;
    
    NSArray *titleArray = @[
        TDDLocalized.feedback_title,
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
    ];
    if (isKindOfTopVCI){
        titleArray = @[
            TDDLocalized.feedback_title,
            TDDLocalized.report_license_plate,
            TDDLocalized.report_brand_of_vehicle,
            TDDLocalized.report_model,
            TDDLocalized.report_year,
            TDDLocalized.report_driving_distance,
            TDDLocalized.report_engine,
            TDDLocalized.report_sub_models,
            TDDLocalized.report_diagnosis_time,
            TDDLocalized.report_vin_code,
            [NSString tdd_reportTitleUser],
            [NSString tdd_reportTitleUserPhone]
        ];
    }
    
    
    NSArray *valueArray = @[
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_software_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_path],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call]
    ];
    if (isKindOfTopVCI){
        valueArray = @[
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call]
        ];
    }
    
    
    CGFloat totalHeight = 0;
    for (int i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        NSString *value = valueArray[i];
        NSString *titleAndValue = [NSString stringWithFormat:@"%@%@", title, value];
        CGFloat maxWidth = IphoneWidth - 30;
        CGFloat gap = 10;
        CGFloat oneRowHeight = [NSString tdd_getHeightWithText:@"TEXT" width:maxWidth fontSize:[UIFont systemFontOfSize:14]];
        CGFloat valueHeight = MAX([NSString tdd_getHeightWithText:titleAndValue width:maxWidth fontSize:[UIFont systemFontOfSize:14]], oneRowHeight);
            
        if ([titleArray[i] isEqualToString:TDDLocalized.feedback_title]) {
            valueHeight = 0;
        }
        
        if (i < self.titleLabelArray.count) {
            TDD_CustomLabel *titleLabel = self.titleLabelArray[i];
            titleLabel.tdd_width = IphoneWidth - 30;
            titleLabel.tdd_height = valueHeight + 1;
            titleLabel.tdd_left = 15;
            titleLabel.tdd_top = totalHeight + gap;
//            titleLabel.textColor = [UIColor tdd_title];
            
            NSMutableAttributedString *attributeTitle = [NSMutableAttributedString mutableAttributedStringWithLTRString:title attributes:@{
                NSForegroundColorAttributeName : [UIColor tdd_title],
                    NSFontAttributeName : [UIFont systemFontOfSize:14]
                }];
            NSMutableAttributedString *attributeValue = [NSMutableAttributedString mutableAttributedStringWithLTRString:value attributes:@{
                    NSForegroundColorAttributeName : [UIColor tdd_color666666],
                    NSFontAttributeName : [UIFont systemFontOfSize:14]
                }];
            NSMutableAttributedString *attributeTitleAndValue = [NSMutableAttributedString mutableAttributedStringWithLTR];
            [attributeTitleAndValue appendAttributedString:attributeTitle];
            [attributeTitleAndValue appendAttributedString:attributeValue];
            titleLabel.attributedText = attributeTitleAndValue;
        }
        
        if ([titleArray[i] isEqualToString:TDDLocalized.feedback_title]) {
            self.describeTitleLabel.textColor = [UIColor tdd_title];
            self.describeTitleLabel.tdd_width = IphoneWidth - 30;
            self.describeTitleLabel.tdd_height = valueHeight;
            self.describeTitleLabel.tdd_left = 15;
            self.lineView.tdd_width = IphoneWidth - 30;
            self.lineView.tdd_height = 1;
            self.lineView.tdd_left = 15;
            self.lineView.tdd_top = self.describeTitleLabel.tdd_bottom;
        }
        
        totalHeight = totalHeight + valueHeight + gap;
    }
    
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
}

/// 获取 Cell 的高度
+ (CGFloat)getHistoryReportCellHeightWith:(TDD_ArtiReportCellModel *)model {
    NSArray *titleArray = @[
        TDDLocalized.feedback_title,
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
    ];
    if (isKindOfTopVCI){
        titleArray = @[
            TDDLocalized.feedback_title,
            TDDLocalized.report_license_plate,
            TDDLocalized.report_brand_of_vehicle,
            TDDLocalized.report_model,
            TDDLocalized.report_year,
            TDDLocalized.report_driving_distance,
            TDDLocalized.report_engine,
            TDDLocalized.report_sub_models,
            TDDLocalized.report_diagnosis_time,
            TDDLocalized.report_vin_code,
            [NSString tdd_reportTitleUser],
            [NSString tdd_reportTitleUserPhone]
        ];
    }
    
    NSArray *valueArray = @[
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_software_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_path],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call]
    ];
    if (isKindOfTopVCI){
        valueArray = @[
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call]
        ];
    }
    
    CGFloat totalHeight = 0;
    for (int i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        NSString *value = valueArray[i];
        NSString *titleAndValue = [NSString stringWithFormat:@"%@%@", title, value];
        CGFloat maxWidth = IphoneWidth - 30;
        CGFloat gap = 10;
        CGFloat oneRowHeight = [NSString tdd_getHeightWithText:@"TEXT" width:maxWidth fontSize:[UIFont systemFontOfSize:14]];
        CGFloat valueHeight = MAX([NSString tdd_getHeightWithText:titleAndValue width:maxWidth fontSize:[UIFont systemFontOfSize:14]], oneRowHeight);
        
        if ([titleArray[i] isEqualToString:TDDLocalized.feedback_title]) {
            valueHeight = 0;
        }
        
        totalHeight = totalHeight + valueHeight + gap;
    }
    
    return totalHeight;
}

// 更新属性A4
- (void)updateA4HistoryReportWithModel:(TDD_ArtiReportCellModel *)model {
    self.describeTitleLabel.text = model.describe_title;
    self.describeBrandLabel.text = model.describe_brand;
    self.describeModelLabel.text = model.describe_model;
    self.describeYearLabel.text = model.describe_year;
    self.describeMileageLabel.text = model.describe_mileage;
    self.describeEngineLabel.text = model.describe_engine;
    self.describeEngineSubTypeLabel.text = model.describe_engine_subType;
    self.describeDiagnosisPathLabel.text = model.describe_diagnosis_path;
    
    self.describeCustomerNameLabel.text = model.describe_customer_name;
    self.describeLicensePlateNumberLabel.text = model.describe_license_plate_number;
    self.VINLabel.text = model.inputVIN;
    self.describeCustomerCallLabel.text = model.describe_customer_call;
    self.repairOrderNumLabel.text = model.repairOrderNum;
    self.describeVersionLabel.text = model.describe_version;
    self.describeSoftwareVersionLabel.text = model.describe_software_version;
    self.describeDiagnosisTimeLabel.text = model.describe_diagnosis_time;
    
    NSArray *titleArray = @[
        TDDLocalized.feedback_title,
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
    ];
    if (isKindOfTopVCI){
        titleArray = @[
            TDDLocalized.feedback_title,
            TDDLocalized.report_license_plate,
            TDDLocalized.report_brand_of_vehicle,
            TDDLocalized.report_model,
            TDDLocalized.report_year,
            TDDLocalized.report_driving_distance,
            TDDLocalized.report_engine,
            TDDLocalized.report_sub_models,
            TDDLocalized.report_diagnosis_time,
            TDDLocalized.report_vin_code,
            [NSString tdd_reportTitleUser],
            [NSString tdd_reportTitleUserPhone]
        ];
    }
    
    NSArray *valueArray = @[
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_software_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_path],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call],
    ];
    if (isKindOfTopVCI){
        valueArray = @[
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call]
        ];
    }
    
    CGFloat totalHeight = 0;
    for (int i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        NSString *value = valueArray[i];
        NSString *titleAndValue = [NSString stringWithFormat:@"%@%@", title, value];
        CGFloat maxWidth = A4Width - 30;
        CGFloat gap = 5;
        CGFloat oneRowHeight = [NSString tdd_getHeightWithText:@"TEXT" width:maxWidth fontSize:[UIFont systemFontOfSize:10]];
        CGFloat valueHeight = MAX([NSString tdd_getHeightWithText:titleAndValue width:maxWidth fontSize:[UIFont systemFontOfSize:10]], oneRowHeight);
            
        if ([titleArray[i] isEqualToString:Local(@"feedback_title")]) {
            valueHeight = 0;
        }
        
        if (i < self.titleLabelArray.count) {
            TDD_CustomLabel *titleLabel = self.titleLabelArray[i];
            titleLabel.tdd_width = A4Width - 30;
            titleLabel.tdd_height = valueHeight;
            titleLabel.tdd_left = 15;
            titleLabel.tdd_top = totalHeight + gap;
            
            NSMutableAttributedString *attributeTitle = [NSMutableAttributedString mutableAttributedStringWithLTRString:title attributes:@{
                    NSForegroundColorAttributeName : [UIColor tdd_pdfDtcNormalColor],
                    NSFontAttributeName : [UIFont systemFontOfSize:10]
                }];
            NSMutableAttributedString *attributeValue = [NSMutableAttributedString mutableAttributedStringWithLTRString:value attributes:@{
                    NSForegroundColorAttributeName : [UIColor tdd_reportInfoValueTextColor],
                    NSFontAttributeName : [UIFont systemFontOfSize:10]
                }];
            NSMutableAttributedString *attributeTitleAndValue = [NSMutableAttributedString mutableAttributedStringWithLTR];
            [attributeTitleAndValue appendAttributedString:attributeTitle];
            [attributeTitleAndValue appendAttributedString:attributeValue];
            titleLabel.attributedText = attributeTitleAndValue;
        }
        
        if ([titleArray[i] isEqualToString:Local(@"feedback_title")]) {
            self.describeTitleLabel.textColor = [UIColor tdd_pdfDtcNormalColor];
            self.describeTitleLabel.tdd_width = A4Width - 30;
            self.describeTitleLabel.tdd_height = valueHeight;
            self.describeTitleLabel.tdd_left = 15;
            self.lineView.tdd_width = A4Width - 30;
            self.lineView.tdd_height = 0.5;
            self.lineView.tdd_left = 15;
            self.lineView.tdd_top = self.describeTitleLabel.tdd_bottom;
        }
        
        totalHeight = totalHeight + valueHeight + gap;
    }
    
    self.contentView.backgroundColor = [UIColor whiteColor];
}

/// 获取 Cell 在A4纸上的高度
+ (CGFloat)getHistoryReportCellA4HeightWith:(TDD_ArtiReportCellModel *)model {
    NSArray *titleArray = @[
        TDDLocalized.feedback_title,
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
        TDDLocalized.maintenance_bill_number
    ];
    if (isKindOfTopVCI){
        titleArray = @[
            TDDLocalized.feedback_title,
            TDDLocalized.report_license_plate,
            TDDLocalized.report_brand_of_vehicle,
            TDDLocalized.report_model,
            TDDLocalized.report_year,
            TDDLocalized.report_driving_distance,
            TDDLocalized.report_engine,
            TDDLocalized.report_sub_models,
            TDDLocalized.report_diagnosis_time,
            TDDLocalized.report_vin_code,
            [NSString tdd_reportTitleUser],
            [NSString tdd_reportTitleUserPhone]
        ];
    }
    
    NSArray *valueArray = @[
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_software_version],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_path],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
        [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call],
    ];
    if (isKindOfTopVCI){
        valueArray = @[
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith:model.describe_title],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_license_plate_number],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_brand],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_model],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_year],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_mileage],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_engine_subType],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_diagnosis_time],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.inputVIN],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_name],
            [TDD_ArtiReportInfoTableViewCell getFlatStringWith: model.describe_customer_call]
        ];
    }
    
    CGFloat totalHeight = 0;
    for (int i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        NSString *value = valueArray[i];
        NSString *titleAndValue = [NSString stringWithFormat:@"%@%@", title, value];
        CGFloat maxWidth = A4Width - 30;
        CGFloat gap = 5;
        CGFloat oneRowHeight = [NSString tdd_getHeightWithText:@"TEXT" width:maxWidth fontSize:[UIFont systemFontOfSize:10]];
        CGFloat valueHeight = MAX([NSString tdd_getHeightWithText:titleAndValue width:maxWidth fontSize:[UIFont systemFontOfSize:10]], oneRowHeight);
        
        if ([titleArray[i] isEqualToString:Local(@"feedback_title")]) {
            valueHeight = 0;
        }
        
        totalHeight = totalHeight + valueHeight + gap;
    }
    
    return totalHeight;
}



+ (NSString *)getFlatStringWith:(NSString *)string
{
    return string == nil ? @"" : string;
}

@end
