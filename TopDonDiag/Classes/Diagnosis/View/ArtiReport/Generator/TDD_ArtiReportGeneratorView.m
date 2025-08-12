//
//  TDD_ArtiReportGeneratorView.m
//  AD200
//
//  Created by lecason on 2022/8/8.
//

#import "TDD_ArtiReportGeneratorView.h"
#import "TDD_ButtonTableView.h"
#import "TDD_UnitConversion.h"
#import "TDD_ArtiReportGeneratorCellModel.h"
#import "TDD_ArtiReportGeneratorInputTableViewCell.h"
#import "TDD_ArtiReportGeneratorSectionTableViewCell.h"
#import "TDD_ArtiReportGeneratorTextTableViewCell.h"
#import "TDD_RepairSelectView.h"
#import "TDD_ArtiReportGeneratorSelectTableViewCell.h"
#import "TDD_ArtiReportGeneratorMessageCell.h"


@interface TDD_ArtiReportGeneratorView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) TDD_ButtonTableView * tableView;
@property (nonatomic, strong) NSArray<TDD_ArtiReportCellModel*> *items;
@property (nonatomic, copy) NSString * diagnosticUnit;
@property (nonatomic, assign) double inputMileValue;
@property (nonatomic, assign) double inputKmValue;
@end

@implementation TDD_ArtiReportGeneratorView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.diagnosticUnit = [TDD_DiagnosisTools diagnosticUnit];
        [self setupUI];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- 键盘监听事件

- (void)keyboardShow:(NSNotification *)noti
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:noti.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationTime animations:^{
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.bottom.equalTo(@(-keyBoardHeight + (58 * H_Height + iPhoneX_D)));
        }];
    }];

}

- (void)keyboardHide:(NSNotification *)noti
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:noti.userInfo];
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationTime animations:^{
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.bottom.equalTo(@(0));
        }];
    }];
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
    
    NSMutableArray *inputTitles = @[
        TDDLocalized.report_brand_of_vehicle,
        TDDLocalized.report_model,
        TDDLocalized.report_year,
        [NSString stringWithFormat:@"%@", TDDLocalized.report_driving_distance],
        TDDLocalized.report_vin_code,
        TDDLocalized.report_engine,
        TDDLocalized.report_sub_models,
        TDDLocalized.report_license_plate,
        [NSString tdd_reportTitleUser],
        [NSString tdd_reportTitleUserPhone],
        TDDLocalized.maintenance_bill_number
    ].mutableCopy;
        
    if ([TDD_DiagnosisTools softWareIsCarPal]) {
        [inputTitles removeObject:TDDLocalized.maintenance_bill_number];
    }
    // CarPal (不是 CarPalGuru ), 数据流报告和发动机 去掉车辆品牌、型号、年款、发动机、子型号
    if ([TDD_DiagnosisTools softWareIsCarPal] && (reportModel.reportType == 3 || (reportModel.reportType == 2 && reportModel.obdEntryType == OET_CARPAL_OBD_ENGINE_CHECK))) {
        inputTitles = @[
            [NSString stringWithFormat:@"%@", TDDLocalized.report_driving_distance],
            TDDLocalized.report_vin_code,
            TDDLocalized.report_license_plate,
            [NSString tdd_reportTitleUser],
            [NSString tdd_reportTitleUserPhone]
        ].mutableCopy;
    }

    
    NSMutableArray *tempItems = [[NSMutableArray alloc] init];
 
    // 诊断报告类型才需要添加维修前维修后(TopVCI 不需要)
    if (_reportModel.reportType == 1 && !isKindOfTopVCI) {
        TDD_ArtiReportGeneratorCellModel *sectionModel0 = [[TDD_ArtiReportGeneratorCellModel alloc] init];
        sectionModel0.identifier = [TDD_ArtiReportGeneratorSelectTableViewCell reuseIdentifier];
        sectionModel0.cellHeight = 80.0;
        [tempItems addObject:sectionModel0];
        if (_reportModel.repairIndex == 0) {
            _reportModel.repairIndex = 1;
        }
    }
    
    TDD_ArtiReportGeneratorCellModel *sectionModel2 = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    sectionModel2.identifier = [TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier];
    sectionModel2.cellHeight = IS_IPad ? 70 : 40.0;
    sectionModel2.sectionTitleName = [NSString stringWithFormat:@"%@:", TDDLocalized.report_name];
    [tempItems insertObject:sectionModel2 atIndex:0];
    
    TDD_ArtiReportGeneratorCellModel *sectionModel3 = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    sectionModel3.identifier = [TDD_ArtiReportGeneratorTextTableViewCell reuseIdentifier];
    
    // 诊断报告标题
    [self updateReportName:_reportModel.repairIndex];
    sectionModel3.text = _reportModel.reportRecordName;
    
    if (IS_IPad) {
        sectionModel3.cellHeight = [NSString tdd_getHeightWithText:sectionModel3.text width:IphoneWidth - 80 fontSize:[UIFont systemFontOfSize:18]] + 40;
    } else {
        sectionModel3.cellHeight = [NSString tdd_getHeightWithText:sectionModel3.text width:IphoneWidth - 30 fontSize:[UIFont systemFontOfSize:14]] + 30;
    }
    if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
        [tempItems insertObject:sectionModel3 atIndex:1];
    }else {
        [tempItems addObject:sectionModel3];
    }

    
    TDD_ArtiReportGeneratorCellModel *sectionModel1 = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    sectionModel1.identifier = [TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier];
    sectionModel1.cellHeight = IS_IPad ? 70 : 40.0;
    sectionModel1.sectionTitleName = [NSString stringWithFormat:@"%@:", TDDLocalized.report_car_info];
    [tempItems addObject:sectionModel1];

    for (int i = 0; i < inputTitles.count; i++) {
        TDD_ArtiReportGeneratorCellModel *model = [[TDD_ArtiReportGeneratorCellModel alloc] init];
        model.identifier = [TDD_ArtiReportGeneratorInputTableViewCell reuseIdentifier];
        model.cellHeight = IS_IPad ? 60 : 50.0;
        model.inputTitleName = [NSString stringWithFormat:@"%@", inputTitles[i]];
        [self updateTDD_ArtiReportGeneratorCellModel:inputTitles[i] withModel:model];
        
        [tempItems addObject:model];
    }
    
    // 留言
    TDD_ArtiReportGeneratorCellModel *sectionMessage = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    sectionMessage.identifier = [TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier];
    sectionMessage.cellHeight = IS_IPad ? 70 : 40.0;
    sectionMessage.sectionTitleName = TDDLocalized.note;
    [tempItems addObject:sectionMessage];
    
    TDD_ArtiReportGeneratorCellModel *rowMessage = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    rowMessage.identifier = [TDD_ArtiReportGeneratorMessageCell reuseIdentifier];
    rowMessage.cellHeight = IS_IPad ? 200 : 140.0;
    [tempItems addObject:rowMessage];
    
    // 图片
    TDD_ArtiReportGeneratorCellModel *sectionImage = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    sectionImage.identifier = [TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier];
    sectionImage.cellHeight = IS_IPad ? 70 : 40.0;
    sectionImage.sectionTitleName = [self adasImageTitleWithImageCount: reportModel.adasImageDatas.count];
    [tempItems addObject:sectionImage];
    
    TDD_ArtiReportGeneratorCellModel *rowImage = [[TDD_ArtiReportGeneratorCellModel alloc] init];
    rowImage.identifier = [TDD_ArtiReportImageCell reuseIdentifier];
    rowImage.cellHeight = IS_IPad ? 160 : 115.0;
    [tempItems addObject:rowImage];
    
    
    self.items = [tempItems copy];
    
    [self.tableView reloadData];
}

- (void)updateReportName: (int)repairIndex {
    NSString *reportName = [_reportModel generatPdfFileName:repairIndex];
    NSString *beforRepair = [_reportModel generatPdfFileName:1];
    NSString *afterRepair = [_reportModel generatPdfFileName:2];
    NSString *noneRepair = [_reportModel generatPdfFileName:0];
    NSString *repairing = [_reportModel generatPdfFileName:3];
    
    NSArray *arr = @[beforRepair, afterRepair, noneRepair, repairing];
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

- (NSString *)adasImageTitleWithImageCount:(NSInteger)imageCount {
    NSString *imageTitle = TDDLocalized.picture;
    NSString *sectionTitleName = [NSString stringWithFormat:@"%@ (%zd/4)",imageTitle, imageCount];
    return sectionTitleName;
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
    } else if ([title isEqualToString: TDDLocalized.maintenance_bill_number]) {
        _reportModel.repairOrderNum = value.mutableCopy;
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
    } else if ([title isEqualToString: TDDLocalized.maintenance_bill_number]) {
        model.inputValue = _reportModel.repairOrderNum;
    }
}

- (void)setupUI
{
    self.backgroundColor = UIColor.tdd_viewControllerBackground;
    
    TDD_ButtonTableView *tableView = [[TDD_ButtonTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.clearColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = YES;
    tableView.delaysContentTouches = NO;
    if ([TDD_DiagnosisTools isDebug]) {
        tableView.accessibilityIdentifier = @"diagReportBuildTableView";
    }
    
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    [tableView registerClass:[TDD_ArtiReportGeneratorInputTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportGeneratorInputTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportGeneratorSectionTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportGeneratorTextTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportGeneratorTextTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportGeneratorSelectTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportGeneratorSelectTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportGeneratorInputTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportGeneratorInputTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportGeneratorMessageCell class] forCellReuseIdentifier:[TDD_ArtiReportGeneratorMessageCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportImageCell class] forCellReuseIdentifier:[TDD_ArtiReportImageCell reuseIdentifier]];
    
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
            
            cell.nameLabel.text = cellModel.inputTitleName;
            if ([TDD_DiagnosisTools isDebug]) {
                NSString *identify = [self getUITestIdentifyStrFrom:cellModel.inputTitleName];
                if (![NSString tdd_isEmpty:identify]) {
                    cell.inputTextField.accessibilityIdentifier = [self getUITestIdentifyStrFrom:cellModel.inputTitleName];
                }
            }

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
                    self.diagnosticUnit = unit;
                    [self updateMileageUint];
                };
            }
            
            cell.didChangedText = ^(NSString * _Nonnull changedText) {
                @kStrongObj(self)
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
            
            cell.beginEditing = ^{
                @kStrongObj(self)
                if (!self) { return; }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                });
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
            
            cell.viewController = [UIViewController tdd_topViewController];
            cell.maxPhotoCount = 4;
            @kWeakObj(self)
            cell.onImagesChanged = ^(NSArray<UIImage *> * _Nonnull imgs) {
                @kStrongObj(self)
                if (!self) { return; }
                self.reportModel.adasImageDatas = imgs;
                
                // 刷新 图片 section
                TDD_ArtiReportGeneratorCellModel * section = self.items[indexPath.row - 1];
                if ([section isKindOfClass:[TDD_ArtiReportGeneratorCellModel class]] && [section.identifier isEqualToString: [TDD_ArtiReportGeneratorSectionTableViewCell reuseIdentifier]]) {
                    section.sectionTitleName = [self adasImageTitleWithImageCount: imgs.count];
                    NSIndexPath * sectionIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                    [self.tableView reloadRowsAtIndexPaths:@[sectionIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                    [self.tableView scrollToRowAtIndexPath:sectionIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
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
        CGRect rectOfCellInSuperview = [tableView convertRect:rectOfCell toView:nil];

        TDD_RepairSelectView *selectView = [[TDD_RepairSelectView alloc] initWithTableViewRect:rectOfCellInSuperview];
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

- (NSString *)getUITestIdentifyStrFrom:(NSString *)title {

    return [[self uiTextIdentifyDict] valueForKey:title];
}

- (NSDictionary *)uiTextIdentifyDict {
    
    return @{TDDLocalized.report_vin_code:@"diagReportInputVinTextField",TDDLocalized.report_sub_models:@"diagReportInputSubModelTextField",TDDLocalized.report_license_plate:@"diagReportInputLicenseTextField",[NSString tdd_reportTitleUser]:@"diagReportInputUserTextField",[NSString tdd_reportTitleUserPhone]:@"diagReportInputUserPhoneTextField",TDDLocalized.maintenance_bill_number:@"diagReportInputBillNumberTextField"};
}
@end

