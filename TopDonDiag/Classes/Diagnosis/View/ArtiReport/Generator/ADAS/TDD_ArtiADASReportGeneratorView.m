//
//  TDD_ArtiADASReportGeneratorView.m
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/11.
//

#import "TopdonDiagnosis/TopdonDiagnosis-Swift.h"

#import "TDD_ArtiADASReportGeneratorView.h"
#import "TDD_ArtiReportModel.h"
#import "TDD_ButtonTableView.h"
#import "TDD_UnitConversion.h"
#import "TDD_ArtiReportGeneratorCellModel.h"
#import "TDD_ArtiReportGeneratorInputTableViewCell.h"
#import "TDD_ArtiReportGeneratorSectionTableViewCell.h"
#import "TDD_ArtiReportGeneratorTextTableViewCell.h"
#import "TDD_RepairSelectView.h"
#import "TDD_ArtiReportGeneratorSelectTableViewCell.h"

#import "TDD_ArtiReportGeneratorMessageCell.h"
@import IQKeyboardManager;


@interface TDD_ArtiADASReportGeneratorView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) TDD_ButtonTableView * tableView;
@property (nonatomic, strong) NSArray<TDD_ArtiReportCellModel*> *items;
@property (nonatomic, copy) NSString * diagnosticUnit;
@property (nonatomic, assign) double inputMileValue;
@property (nonatomic, assign) double inputKmValue;

@end

@implementation TDD_ArtiADASReportGeneratorView

- (instancetype)init
{
    if (self = [super init]) {
        self.diagnosticUnit = [TDD_DiagnosisTools diagnosticUnit];
        [self setupUI];
    }
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow: newWindow];
    
    if (newWindow) {
        IQKeyboardManager.sharedManager.enable = YES;
    } else {
        IQKeyboardManager.sharedManager.enable = NO;
    }
}

- (void)setReportModel:(TDD_ArtiReportModel *)reportModel
{
    //TODO: 诊断库传过来的里程值为km值，报告显示是转换成APP设置的单位
    NSString *mileage = [self getMileageValue:reportModel.describe_mileage];
    reportModel.describe_mileage = [[TDD_UnitConversion diagUnitConversionWithUnit:@"km" value:mileage] value];
    _reportModel = reportModel;
    
    reportModel.reportCreateTime = reportModel.reportCreateTime == 0 ? [NSDate tdd_getTimestampSince1970] : reportModel.reportCreateTime;
    
    // 添加里程单位
    [self updateMileageUint];
    
    NSArray *inputTitles = @[TDDLocalized.report_brand_of_vehicle, TDDLocalized.report_model, TDDLocalized.report_year, [NSString stringWithFormat:@"%@", TDDLocalized.report_driving_distance], TDDLocalized.report_vin_code, TDDLocalized.report_engine, TDDLocalized.report_sub_models, TDDLocalized.report_license_plate, [NSString tdd_reportTitleUser], [NSString tdd_reportTitleUserPhone]];
    
    NSMutableArray *tempItems = [[NSMutableArray alloc] init];
    
    // 诊断报告类型才需要添加维修前维修后(TopVCI 不需要) - 单系统不需要校准前后对比
    if ((_reportModel.reportType == TDD_ArtiReportTypeSystem || _reportModel.reportType == TDD_ArtiReportTypeAdasSystem) && !isTopVCI) {
        TDD_ArtiReportGeneratorCellModel *sectionPrePostScan = [[TDD_ArtiReportGeneratorCellModel alloc] init];
        sectionPrePostScan.identifier = [TDD_ArtiReportGeneratorSelectTableViewCell reuseIdentifier];
        sectionPrePostScan.cellHeight = 80.0;
        [tempItems addObject:sectionPrePostScan];
        if (_reportModel.repairIndex == 0) {
            _reportModel.repairIndex = 1;
        }
    }
    
    // 诊断报告标题
    TDD_ArtiReportGeneratorCellModel *sectionReportName = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    sectionReportName.identifier = [TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier];
    sectionReportName.cellHeight = 40.0;
    sectionReportName.sectionTitleName = [NSString stringWithFormat:@"%@:", TDDLocalized.report_name];
    [tempItems addObject:sectionReportName];
    
    TDD_ArtiReportGeneratorCellModel *rowReportName = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    rowReportName.identifier = [TDD_ArtiReportGeneratorTextTableViewCell reuseIdentifier];
    [self updateReportName:_reportModel.repairIndex];
    rowReportName.text = _reportModel.reportRecordName;
    rowReportName.cellHeight = [NSString tdd_getHeightWithText:rowReportName.text width:IphoneWidth - 30 fontSize:[UIFont systemFontOfSize:14]] + 30;
    [tempItems addObject:rowReportName];
    
    // 车辆信息
    TDD_ArtiReportGeneratorCellModel *sectionVehicleInfo = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    sectionVehicleInfo.identifier = [TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier];
    sectionVehicleInfo.cellHeight = 40.0;
    sectionVehicleInfo.sectionTitleName = [NSString stringWithFormat:@"%@:", TDDLocalized.report_car_info];
    [tempItems addObject:sectionVehicleInfo];
    
    for (int i = 0; i < inputTitles.count; i++) {
        TDD_ArtiReportGeneratorCellModel *model = [[TDD_ArtiReportGeneratorCellModel alloc] init];
        model.identifier = [TDD_ArtiReportGeneratorInputTableViewCell reuseIdentifier];
        model.cellHeight = 50.0;
        model.inputTitleName = [NSString stringWithFormat:@"%@", inputTitles[i]];
        [self updateTDD_ArtiReportGeneratorCellModel:inputTitles[i] withModel:model];
        [tempItems addObject:model];
    }
    
    // 留言
    TDD_ArtiReportGeneratorCellModel *sectionMessage = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    sectionMessage.identifier = [TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier];
    sectionMessage.cellHeight = 40.0;
    sectionMessage.sectionTitleName = TDDLocalized.note;
    [tempItems addObject:sectionMessage];
    
    TDD_ArtiReportGeneratorCellModel *rowMessage = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    rowMessage.identifier = [TDD_ArtiReportGeneratorMessageCell reuseIdentifier];
    rowMessage.cellHeight = 140.0;
    [tempItems addObject:rowMessage];
    
    // 图片
    TDD_ArtiReportGeneratorCellModel *sectionImage = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    sectionImage.identifier = [TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier];
    sectionImage.cellHeight = 40.0;
    sectionImage.sectionTitleName = [self adasImageTitleWithImageCount: reportModel.adasImageDatas.count];
    [tempItems addObject:sectionImage];
    
    TDD_ArtiReportGeneratorCellModel *rowImage = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    rowImage.identifier = [TDD_ArtiReportImageCell reuseIdentifier];
    rowImage.cellHeight = 115.0;
    [tempItems addObject:rowImage];
    
    // 轮胎压力
    TDD_ArtiReportGeneratorCellModel *tirePressure = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    tirePressure.identifier = [TDD_ArtiADASReportTireCell reuseIdentifier];
    tirePressure.tirePressure = reportModel.tirePressure;
    tirePressure.cellHeight = 432.0;
    [tempItems addObject:tirePressure];
    
    // 轮眉高度
    TDD_ArtiReportGeneratorCellModel *wheelEyebrow = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    wheelEyebrow.identifier = [TDD_ArtiADASReportTireCell reuseIdentifier];
    wheelEyebrow.wheelEyebrow = reportModel.wheelEyebrow;
    wheelEyebrow.cellHeight = 432.0;
    [tempItems addObject:wheelEyebrow];
    
    // 燃油表
    TDD_ArtiReportGeneratorCellModel *fuel = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    fuel.identifier = [TDD_ArtiADASReportFuelCell reuseIdentifier];
    fuel.cellHeight = 243.5;
    [tempItems addObject:fuel];
    
    self.items = [tempItems copy];
    
    [self.tableView reloadData];
}

- (void)updateReportName: (int)repairIndex {
    // 维修前 --> 校准前
    // 维修后 --> 校准后
    NSString *reportName = [_reportModel generatPdfFileName:repairIndex];
    NSString *beforRepair = [_reportModel generatPdfFileName:1];
    NSString *afterRepair = [_reportModel generatPdfFileName:2];
    reportName = [[reportName replaceBeforeMaintenanceToCalibration] replaceAfterMaintenanceToCalibration];
    beforRepair = [beforRepair replaceBeforeMaintenanceToCalibration];
    afterRepair = [afterRepair replaceAfterMaintenanceToCalibration];

    NSString *noneRepair = [_reportModel generatPdfFileName:0];
    
    NSArray *arr = @[beforRepair, afterRepair, noneRepair];
    NSString *originName= _reportModel.reportRecordName;
    
    BOOL isContain = [arr containsObject:originName];
    
    if (![NSString tdd_isEmpty:_reportModel.reportRecordName] && !isContain) {
        return;
    }
    _reportModel.reportRecordName = reportName;
    _reportModel.repairIndex = repairIndex;
    [self.items enumerateObjectsUsingBlock:^(TDD_ArtiReportCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:[TDD_ArtiReportGeneratorTextTableViewCell reuseIdentifier]]) {
            if ([obj isKindOfClass:[TDD_ArtiReportGeneratorCellModel class]]) {
                ((TDD_ArtiReportGeneratorCellModel *)obj).text = reportName;
                *stop = YES;
            }
        }
    }];
}

-(void)updateReportModelWith:(NSString *)title withValue:(NSString *)value
{
    if ([title isEqualToString: TDDLocalized.report_brand_of_vehicle]) {
        _reportModel.describe_brand = [value mutableCopy];
    } else if ([title isEqualToString: TDDLocalized.report_model]) {
        _reportModel.describe_model = [value mutableCopy];
    } else if ([title isEqualToString: TDDLocalized.report_year]) {
        _reportModel.describe_year = [value mutableCopy];
    } else if ([title isEqualToString: [NSString stringWithFormat:@"%@", TDDLocalized.report_driving_distance]]) {
        _reportModel.describe_mileage = [value mutableCopy];
        [self updateMileageUint];
    } else if ([title isEqualToString: TDDLocalized.report_vin_code]) {
        _reportModel.inputVIN = [value mutableCopy];
    } else if ([title isEqualToString: TDDLocalized.report_engine]) {
        _reportModel.describe_engine = [value mutableCopy];
    } else if ([title isEqualToString: TDDLocalized.report_sub_models]) {
        _reportModel.describe_engine_subType = [value mutableCopy];
    } else if ([title isEqualToString: TDDLocalized.report_license_plate]) {
        _reportModel.describe_license_plate_number = [value mutableCopy];
    } else if ([title isEqualToString: [NSString tdd_reportTitleUser]]) {
        _reportModel.describe_customer_name = [value mutableCopy];
    } else if ([title isEqualToString: [NSString tdd_reportTitleUserPhone]]) {
        _reportModel.describe_customer_call = [value mutableCopy];
    }
}

-(void)updateTDD_ArtiReportGeneratorCellModel:(NSString *)title withModel:(TDD_ArtiReportGeneratorCellModel*)model
{
    if ([title isEqualToString: TDDLocalized.report_brand_of_vehicle]) {
        model.inputValue = _reportModel.describe_brand;
    } else if ([title isEqualToString: TDDLocalized.report_model]) {
        model.inputValue = _reportModel.describe_model;
    } else if ([title isEqualToString: TDDLocalized.report_year]) {
        model.inputValue = _reportModel.describe_year;
    } else if ([title isEqualToString: [NSString stringWithFormat:@"%@", TDDLocalized.report_driving_distance]]) {
        model.inputValue = _reportModel.describe_mileage;
    } else if ([title isEqualToString: TDDLocalized.report_vin_code]) {
        model.inputValue = _reportModel.inputVIN;
    } else if ([title isEqualToString: TDDLocalized.report_engine]) {
        model.inputValue = _reportModel.describe_engine;
    } else if ([title isEqualToString: TDDLocalized.report_sub_models]) {
        model.inputValue = _reportModel.describe_engine_subType;
    } else if ([title isEqualToString: TDDLocalized.report_license_plate]) {
        model.inputValue = _reportModel.describe_license_plate_number;
    } else if ([title isEqualToString: [NSString tdd_reportTitleUser]]) {
        model.inputValue = _reportModel.describe_customer_name;
    } else if ([title isEqualToString: [NSString tdd_reportTitleUserPhone]]) {
        model.inputValue = _reportModel.describe_customer_call;
    }
}

- (void)setupUI
{
    self.backgroundColor = UIColor.tdd_viewControllerBackground;
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportGeneratorInputTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportGeneratorInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportGeneratorInputTableViewCell reuseIdentifier] forIndexPath:indexPath];
        if ([self.items[indexPath.row] isKindOfClass:[TDD_ArtiReportGeneratorCellModel class]]) {
            TDD_ArtiReportGeneratorCellModel *cellModel = (TDD_ArtiReportGeneratorCellModel *)self.items[indexPath.row];
            BOOL isMileage = [cellModel.inputTitleName isEqualToString:TDDLocalized.report_driving_distance];
            cell.isMileage = isMileage;
//            if ([cellModel.inputTitleName isEqualToString:TDDLocalized.report_driving_distance] || [cellModel.inputTitleName isEqualToString:TDDLocalized.report_vin_code]){
//                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",cellModel.inputTitleName]];
//                [attStr yy_setColor:[UIColor tdd_colorWithHex:0xFF0000] range:NSMakeRange(0, 1)];
//                cell.nameLabel.attributedText = attStr;
//            }else {
                cell.nameLabel.text = cellModel.inputTitleName;
//            }
            
            //            cell.inputTextField.text = cellModel.inputValue;
            [cell setInputText:cellModel.inputValue];
            cell.diagnosticUnit = self.diagnosticUnit;
            @kWeakObj(self)
            if (isMileage) {
                cell.didMileageInputChanged = ^(NSString * unit, double value) {
                    @kStrongObj(self)
                    if ([unit isEqualToString:@"metric"]) {
                        self.inputKmValue = value;
                        self.inputMileValue = 0;
                    } else {
                        self.inputKmValue = 0;
                        self.inputMileValue = value;
                    }
                };
                
                cell.didDiagnosticUnitChanged = ^(NSString * unit) {
                    @kStrongObj(self)
                    if ([NSString tdd_isEmpty:unit]) { return; }
                    self.diagnosticUnit = unit;
                    [self updateMileageUint];
                };
            }
            
            cell.didChangedText = ^(NSString * _Nonnull changedText) {
                @kStrongObj(self)
                if ([NSString tdd_isEmpty:changedText]) { return; }
                cellModel.inputValue = changedText;
                [self updateReportModelWith:cellModel.inputTitleName withValue:changedText];
            };
            if ([cell.nameLabel.text hasPrefix:@"*"]) {
                NSMutableAttributedString *string = [NSMutableAttributedString mutableAttributedStringWithLTRString:cell.nameLabel.text];
                NSRange range = [cell.nameLabel.text rangeOfString:@"*"];
                [string addAttribute:NSForegroundColorAttributeName
                               value:[UIColor tdd_colorFF0000]
                               range:range];
                [cell.nameLabel setAttributedText:string];
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportGeneratorSectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier] forIndexPath:indexPath];
        if ([self.items[indexPath.row] isKindOfClass:[TDD_ArtiReportGeneratorCellModel class]]) {
            TDD_ArtiReportGeneratorCellModel *cellModel = (TDD_ArtiReportGeneratorCellModel *)self.items[indexPath.row];
            cell.nameLabel.text = cellModel.sectionTitleName;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportGeneratorTextTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportGeneratorTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportGeneratorTextTableViewCell reuseIdentifier] forIndexPath:indexPath];
        if ([self.items[indexPath.row] isKindOfClass:[TDD_ArtiReportGeneratorCellModel class]]) {
            TDD_ArtiReportGeneratorCellModel *cellModel = (TDD_ArtiReportGeneratorCellModel *)self.items[indexPath.row];
            cell.inputTextField.text = cellModel.text;
            @kWeakObj(self)
            cell.didChangedText = ^(NSString * _Nonnull changedText) {
                @kStrongObj(self)
                if ([NSString tdd_isEmpty:changedText]) { return; }
                cellModel.inputValue = changedText;
                cellModel.text = changedText;
                self.reportModel.reportRecordName = changedText;
            };
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportGeneratorSelectTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportGeneratorSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportGeneratorSelectTableViewCell reuseIdentifier] forIndexPath:indexPath];
        if ([self.items[indexPath.row] isKindOfClass:[TDD_ArtiReportGeneratorCellModel class]]) {
            TDD_ArtiReportGeneratorCellModel *cellModel = (TDD_ArtiReportGeneratorCellModel *)self.items[indexPath.row];
            cell.isADAS = YES;
            cell.selectedIndex = MAX(0, cellModel.repairIndex - 1);
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportGeneratorMessageCell reuseIdentifier]]) {
        TDD_ArtiReportGeneratorMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportGeneratorMessageCell reuseIdentifier] forIndexPath:indexPath];
        if ([self.items[indexPath.row] isKindOfClass:[TDD_ArtiReportGeneratorCellModel class]]) {
            TDD_ArtiReportGeneratorCellModel *cellModel = (TDD_ArtiReportGeneratorCellModel *)self.items[indexPath.row];
            
            @kWeakObj(self)
            cell.didChangedText = ^(NSString * _Nonnull message) {
                @kStrongObj(self)
                if (!self) { return; }
                self.reportModel.adas_msg = message;
            };
            
            NSString *msg = self.reportModel.adas_msg;
//            if (![NSString tdd_isEmpty:msg]) {
            cell.textView.text = msg;
//            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportImageCell reuseIdentifier]]) {
        TDD_ArtiReportImageCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportImageCell reuseIdentifier] forIndexPath:indexPath];
        
        if ([self.items[indexPath.row] isKindOfClass:[TDD_ArtiReportGeneratorCellModel class]]) {
            TDD_ArtiReportGeneratorCellModel *cellModel = (TDD_ArtiReportGeneratorCellModel *)self.items[indexPath.row];
            
            cell.viewController = self.owningViewController;
            cell.maxPhotoCount = 4;
            @kWeakObj(self)
            cell.onImagesChanged = ^(NSArray<UIImage *> * _Nonnull imgs) {
                @kStrongObj(self)
                self.reportModel.adasImageDatas = imgs;
                
                // 刷新 图片 section
                TDD_ArtiReportGeneratorCellModel * section = self.items[indexPath.row - 1];
                if ([section isKindOfClass:[TDD_ArtiReportGeneratorCellModel class]] && [section.identifier isEqualToString: [TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier]]) {
                    section.sectionTitleName = [self adasImageTitleWithImageCount: imgs.count];
                    NSIndexPath * sectionIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                    [self.tableView reloadRowsAtIndexPaths:@[sectionIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                }
            };
            
            cell.onNotAuthorized = ^(NSString *tips) {
                @kStrongObj(self)
                if (!self) { return; }
                [TDD_HTipManage showBottomTipViewWithTitle:tips];
            };
            
            if (self.reportModel.adasImageDatas) {
                [cell update: self.reportModel.adasImageDatas];
            } else {
                [cell update: @[]];
            }
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiADASReportTireCell reuseIdentifier]]) {
        TDD_ArtiADASReportTireCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiADASReportTireCell reuseIdentifier] forIndexPath:indexPath];
     
        if ([self.items[indexPath.row] isKindOfClass:[TDD_ArtiReportGeneratorCellModel class]]) {
            TDD_ArtiReportGeneratorCellModel *cellModel = (TDD_ArtiReportGeneratorCellModel *)self.items[indexPath.row];
            
            @kWeakObj(self)
            cell.onExpandChanged = ^(BOOL isFlod) {
                @kStrongObj(self)
                TDD_ArtiReportGeneratorCellModel *cellModel = (TDD_ArtiReportGeneratorCellModel *)self.items[indexPath.row];
                if (isFlod) {
                    cellModel.cellHeight = 58.0;
                } else {
                    cellModel.cellHeight = 432.0;
                }
     
                [self.tableView performBatchUpdates:^{
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationFade];
                } completion:^(BOOL finished) {
                    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:true];
                }];
                
            };
            
            cell.onSelectedIndex = ^(NSInteger) {
                @kStrongObj(self)
                [self.tableView performBatchUpdates:^{
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationFade];
                } completion:^(BOOL finished) {}];
            };
            
            if (cellModel.tirePressure) {
                [cell updateWithUnit: cellModel.tirePressure];
            } else if (cellModel.wheelEyebrow) {
                [cell updateWithUnit: cellModel.wheelEyebrow];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiADASReportFuelCell reuseIdentifier]]) {
        TDD_ArtiADASReportFuelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiADASReportFuelCell reuseIdentifier] forIndexPath:indexPath];
        
        if ([self.items[indexPath.row] isKindOfClass:[TDD_ArtiReportGeneratorCellModel class]]) {
            TDD_ArtiReportGeneratorCellModel *cellModel = (TDD_ArtiReportGeneratorCellModel *)self.items[indexPath.row];
            
            cell.viewController = self.owningViewController;
            @kWeakObj(self)
            cell.onExpandChanged = ^(BOOL isFlod) {
                @kStrongObj(self)
                TDD_ArtiReportGeneratorCellModel *cellModel = (TDD_ArtiReportGeneratorCellModel *)self.items[indexPath.row];
                if (isFlod) {
                    cellModel.cellHeight = 58.0;
                } else {
                    cellModel.cellHeight = 243.5;
                }
     
                [self.tableView performBatchUpdates:^{
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationFade];
                } completion:^(BOOL finished) {
                    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:true];
                }];
            };
            cell.onImageChanged = ^(UIImage * img) {
                @kStrongObj(self)
                self.reportModel.fuelImage = img;
            };
            
            cell.onNotAuthorized = ^(NSString * tips) {
                @kStrongObj(self)
                if (!self) { return; }
                [TDD_HTipManage showBottomTipViewWithTitle:tips];
            };
            
            [cell updateWithFuel:self.reportModel.fuel];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportGeneratorSelectTableViewCell reuseIdentifier]]) {
        __block TDD_ArtiReportGeneratorSelectTableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
        [tableViewCell arrowImageRotate];
        
        CGRect rectOfCell = [tableView rectForRowAtIndexPath:indexPath];
        CGRect rectOfCellInSuperview = [tableView convertRect:rectOfCell toView:tableView.superview];
        
        TDD_RepairSelectView *selectView = [[TDD_RepairSelectView alloc] initWithTableViewRect:rectOfCellInSuperview];
        selectView.isADAS = YES;
        selectView.selectIndex = self.reportModel.repairIndex - 1;
        selectView.didSelectIndex = ^(int index) {
            if ([self.items[indexPath.row] isKindOfClass:[TDD_ArtiReportGeneratorCellModel class]]) {
                TDD_ArtiReportGeneratorCellModel *cellModel = (TDD_ArtiReportGeneratorCellModel *)self.items[indexPath.row];
                cellModel.repairIndex = index + 1;
                [self updateReportName:index + 1];
                [tableView reloadData];
            }
            [tableViewCell arrowImageRotate];
        };
        [selectView show];
    }
}

//TODO: 默认里程单位
- (void)updateMileageUint
{
    NSString *mile = _reportModel.describe_mileage;
    NSString * temp = [mile stringByReplacingOccurrencesOfString:@"km" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"Miles" withString:@""];
    temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([NSString tdd_isEmpty:temp]) return;
    _reportModel.describe_mileage = [NSString stringWithFormat:@"%@ %@", temp, [self unitDisplayWithDiagUnit:self.diagnosticUnit]];
}

- (NSString *)unitDisplayWithDiagUnit:(NSString *)unit {
    if ([unit isEqualToString:@"imperial"]) return @"Miles";
    if ([unit isEqualToString:@"metric"]) return @"km";
    return unit;
}

- (NSString *)getMileageValue: (NSString *)mileage
{
    if ([NSString tdd_isEmpty:mileage]) return mileage;
    
    NSString * temp = [mileage.lowercaseString stringByReplacingOccurrencesOfString:@"km" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"mile" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"miles" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"mi." withString:@""];
    temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return temp;
}

- (NSString *)adasImageTitleWithImageCount:(NSInteger)imageCount {
    NSString *imageTitle = TDDLocalized.picture;
    NSString *sectionTitleName = [NSString stringWithFormat:@"%@ (%zd/4)",imageTitle, imageCount];
    return sectionTitleName;
}

#pragma mark - Lazy Load

- (TDD_ButtonTableView *)tableView {
    if (!_tableView) {
        TDD_ButtonTableView *tableView = [[TDD_ButtonTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = UIColor.clearColor;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.bounces = YES;
        tableView.delaysContentTouches = NO;
        
        
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 35;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        
        [tableView registerClass:[TDD_ArtiReportGeneratorInputTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportGeneratorInputTableViewCell reuseIdentifier]];
        [tableView registerClass:[TDD_ArtiReportGeneratorSectionTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier]];
        [tableView registerClass:[TDD_ArtiReportGeneratorTextTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportGeneratorTextTableViewCell reuseIdentifier]];
        [tableView registerClass:[TDD_ArtiReportGeneratorSelectTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportGeneratorSelectTableViewCell reuseIdentifier]];
        [tableView registerClass:[TDD_ArtiReportGeneratorMessageCell class] forCellReuseIdentifier:[TDD_ArtiReportGeneratorMessageCell reuseIdentifier]];
        [tableView registerClass:[TDD_ArtiReportImageCell class] forCellReuseIdentifier:[TDD_ArtiReportImageCell reuseIdentifier]];
        [tableView registerClass:[TDD_ArtiADASReportTireCell class] forCellReuseIdentifier:[TDD_ArtiADASReportTireCell reuseIdentifier]];
        [tableView registerClass:[TDD_ArtiADASReportFuelCell class] forCellReuseIdentifier:[TDD_ArtiADASReportFuelCell reuseIdentifier]];

        _tableView = tableView;
    }
    return _tableView;
}

@end
