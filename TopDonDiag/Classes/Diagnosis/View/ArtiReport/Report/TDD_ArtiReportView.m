//
//  TDD_ArtiReportView.m
//  AD200
//
//  Created by 何可人 on 2022/5/6.
//

#import "TDD_ArtiReportView.h"
#import "TDD_ArtiReportPrintHeaderView.h"
#import "TDD_ArtiReportCellModel.h"
#import "TDD_ArtiReportInfoCell.h"
#import "TDD_ArtiReportInfoTopVCITableViewCell.h"
#import "TDD_ArtiReportSummaryTableViewCell.h"
#import "TDD_ArtiReportHeaderTableViewCell.h"
#import "TDD_ArtiReportTextTableViewCell.h"
#import "TDD_ArtiReportRepairHeaderTableViewCell.h"
#import "TDD_ArtiReportRepairSectionTableViewCell.h"
#import "TDD_ArtiReportRepairRowTableViewCell.h"
#import "TDD_ArtiReportCodeTitleTableViewCell.h"
#import "TDD_ArtiReportCodeSectionTableViewCell.h"
#import "TDD_ArtiReportCodeRowTableViewCell.h"
#import "TDD_ArtiReportFlowSectionTableViewCell.h"
#import "TDD_ArtiReportFlowRowTableViewCell.h"

#import "TDD_ArtiLiveDataModel.h"

@interface TDD_ArtiReportView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray<TDD_ArtiReportCellModel*> *items;
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, assign) BOOL modelSaved;

@property (nonatomic, strong) UITableView * A4SizeTableView;

@property (nonatomic, assign) Class infoCellClass;

// 诊断报告列表
@property (nonatomic, strong) TDD_ArtiReportHistoryJKDBModel * dbModel;

@end

@implementation TDD_ArtiReportView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _infoCellClass = isKindOfTopVCI ? [TDD_ArtiReportInfoTopVCITableViewCell class] : [TDD_ArtiReportInfoCell class];
        [self setupUI];
        
    }
    return self;
}

- (void)setDbModel:(TDD_ArtiReportHistoryJKDBModel *)dbModel dbType:(TDD_DBType)dbType {
    _dbModel = dbModel;
    
    self.items = [NSArray yy_modelArrayWithClass:[TDD_ArtiReportCellModel class] json:dbModel.strData];
    [self.items enumerateObjectsUsingBlock:^(TDD_ArtiReportCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:@"TDD_ArtiReportInfoTableViewCell"]) {
            obj.cellHeight = UITableViewAutomaticDimension;//[TDD_ArtiReportInfoTableViewCell getCellHeightWith:obj];
            *stop = YES;
        }
    }];
    // 获取ADAS 图片
//    TDD_DBType dbType = TDD_DATA_BASE_TYPE_DEFAULT;
//    if ([TDD_DiagnosisManage sharedManage].currentSoftware == TDD_SoftWare_TOPSCAN_SINGLE) {
//        dbType = TDD_DATA_BASE_TYPE_GROUP;
//    }
    NSArray <NSString *> *adasImagePaths = [TDD_ArtiReportModel fetchAdasImagePathsWithCreateTime:dbModel.createTime dbType:dbType];
    for (TDD_ArtiReportCellModel *cellModel in self.items) {
        if ([cellModel.identifier isEqualToString:[TDD_ArtiADASReportImagesPreviewCell reuseIdentifier]]) {
            cellModel.adasImages = adasImagePaths;
            break;
        }
    }
    
    // 获取ADAS 燃油图片 TDD_ArtiADASReportFuelCell
    NSString *adasFuelImagePath = [TDD_ArtiReportModel fetchAdasFuelImagePathWithCreateTime:dbModel.createTime];
    for (TDD_ArtiReportCellModel *cellModel in self.items) {
        if ([cellModel.identifier isEqualToString:[TDD_ArtiADASReportFuelPreviewCell reuseIdentifier]]) {
            cellModel.adasFuel.imagePath = adasFuelImagePath.length > 0 ? adasFuelImagePath : @"";
            break;
        }
    }
    
    [self.tableView reloadData];
}

- (void)filterLiveData:(TDD_ArtiReportModel *)reportModel showLiveData:(nullable NSArray *)showItems {
    
    
    
}

- (void)setReportModel:(TDD_ArtiReportModel *)reportModel showLiveData:(nullable NSArray *)showItems
{
    _reportModel = reportModel;
    if (showItems && showItems.count > 0) {
        __block NSMutableArray *tempArray = [NSMutableArray array];
        HLog(@"reportModel.cellModels               ");
        //        TDD_ArtiReportCellModel *cellModel1 = [[TDD_ArtiReportCellModel alloc] init];
        //        cellModel1.headerTitle = [NSString tdd_reportTitleLiveDataHead];
        //        cellModel1.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
        //        cellModel1.cellHeight = 60.0;
        //        cellModel1.cellA4Height = 60;
        //        [tempArray addObject:cellModel1];
        //
        //        [showItems enumerateObjectsUsingBlock:^(TDD_ArtiLiveDataItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //            TDD_ArtiReportCellModel *cellModel = [TDD_ArtiReportModel reportCellModelWithItem:obj];
        //            [tempArray addObject:cellModel];
        //        }];
        for (NSInteger i = 0; i < self.reportModel.cellModels.count; i++) {
            TDD_ArtiReportCellModel *cellModel = self.reportModel.cellModels[i];
            if (![cellModel.identifier isEqualToString:[TDD_ArtiReportFlowRowTableViewCell reuseIdentifier]]) {
                [tempArray addObject:cellModel];
                
            } else {
                [showItems enumerateObjectsUsingBlock:^(TDD_ArtiLiveDataItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (cellModel.liveDatas.count) {
                        NSString *name = cellModel.liveDatas[0];
                        if ([name isEqualToString:obj.strName]) {
                            [tempArray addObject:cellModel];
                            *stop = YES;
                        }
                    }
                }];
                
            }
        }
        HLog(@"reportModel.cellModels               ");
        _reportModel.cellModels = tempArray;
    }
    
    UInt32 createTime = reportModel.reportCreateTime != 0 ? (UInt32)reportModel.reportCreateTime : (UInt32)[NSDate tdd_getTimestampSince1970];
    
    @kWeakObj(self)
    self.reportModel.generatorTapBlock = ^{
        @kStrongObj(self)
        if (self.modelSaved == NO) {
            NSString *groupId = @"";
            if ([TDD_DiagnosisTools softWareIsSingleApp]) {
                groupId = [TDD_DiagnosisManage storeGroupID];
            }
            [self snapshotTableView:createTime groupId:groupId completion:^(BOOL success) {
                [self saveHistory:createTime];
                
                // 保存成功后显示为分享按钮
                if (self.reportModel.buttonArr.count > 0) {
                    TDD_ArtiButtonModel *model = self.reportModel.buttonArr[0];
                    model.strButtonText = TDDLocalized.battery_share;
                    self.reportModel.isReloadButton = YES;
                    [self.reportModel reloadView];
                }
            }];
            
        } else {
            [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.report_already_save];
        }
    };
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    //  LECASON: TEST
    BOOL enableTest = NO;
    
    // 逻辑数据
    if (enableTest == NO) {
        
        // 一些特定信息
        self.reportModel.describe_diagnosis_time = [NSDate tdd_getTimeStringWithInterval:[NSDate tdd_getTimestampSince1970] Format:@"yyyy-MM-dd HH:mm:ss"];
        self.reportModel.describe_version = self.reportModel.carModel.strVersion;
        self.reportModel.describe_diagnosis_time_zone = [NSDate tdd_getTopdonTimeZone];
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        self.reportModel.describe_software_version = [NSString stringWithFormat:@"V%@", currentVersion];
        self.reportModel.system_overview_title = TDDLocalized.report_generalize;
        
        // 诊断信息 固定Cell
        TDD_ArtiReportCellModel *model1 = [[TDD_ArtiReportCellModel alloc] init];
        model1.identifier = [_infoCellClass reuseIdentifier];
        model1.reportType = reportModel.reportType;
        model1.obdEntryType = reportModel.obdEntryType;
        model1.describe_diagnosis_time = self.reportModel.describe_diagnosis_time;
        model1.describe_version = self.reportModel.describe_version;
        model1.describe_software_version = self.reportModel.describe_software_version;
        model1.system_overview_title = self.reportModel.system_overview_title;
        
        model1.describe_title = self.reportModel.describe_title;
        model1.describe_brand = self.reportModel.describe_brand;
        model1.describe_model = self.reportModel.describe_model;
        model1.describe_year = self.reportModel.describe_year;
        model1.describe_mileage = self.reportModel.describe_mileage;
        model1.describe_engine = self.reportModel.describe_engine;
        model1.describe_engine_subType = self.reportModel.describe_engine_subType;
        model1.describe_diagnosis_path = self.reportModel.describe_diagnosis_path;
        
        model1.describe_customer_name = self.reportModel.describe_customer_name;
        model1.describe_license_plate_number = self.reportModel.describe_license_plate_number;
        model1.inputVIN = self.reportModel.inputVIN;
        model1.describe_customer_call = self.reportModel.describe_customer_call;
        model1.repairOrderNum = self.reportModel.repairOrderNum;
        
        if (isKindOfTopVCI) {
            model1.cellHeight = [_infoCellClass getCellHeightWith:model1];
        } else {
            model1.cellHeight = UITableViewAutomaticDimension;
        }
        model1.cellA4Height = [TDD_ArtiReportInfosA4Cell cellHeightWithInfos:model1.infos];
        [tempArray addObject:model1];
        
        // 统计个数
        int scanedSystemCount = 0;
        int errorSystemCount = 0;
        int totalErrorCode = 0;
        int faultCodeCount = 0;
        int flowDataCount = 0;
        
        int repairRowIndex = 1; // 用作显示编号
        for (TDD_ArtiReportCellModel *cellModel in self.reportModel.repairCellModels) {
            if ([cellModel.identifier isEqualToString:[TDD_ArtiReportRepairRowTableViewCell reuseIdentifier]]) {
                scanedSystemCount = scanedSystemCount + 1;
                if (cellModel.rightUDtsNums > 0) {
                    errorSystemCount = errorSystemCount + 1;
                }
                if (cellModel.rightUDtsNums > 0 && cellModel.rightUDtsNums != 999) {
                    totalErrorCode = totalErrorCode + cellModel.rightUDtsNums;
                }
                
                // 赋值编号，如果有系统编号就用系统的，没有就自己按顺序赋值
                //TODO: 诊断报告，所有地方生成的都不显示序号
                //                NSString * cell_header_title;
                //                if (cellModel.system_id.length > 0) {
                //                    cell_header_title = [NSString stringWithFormat:@"%@%@",cellModel.system_id,cellModel.rightUDtsName];
                //                } else {
                //                    cell_header_title = [NSString stringWithFormat:@"%d. %@",repairRowIndex,cellModel.rightUDtsName];
                //                }
                //                cellModel.cell_header_title = cell_header_title;
                cellModel.cell_header_title = cellModel.rightUDtsName;
                repairRowIndex++;
            }
        }
        
        int codeTitleIndex = 1; // 用作显示编号
        for (TDD_ArtiReportCellModel *cellModel in self.reportModel.cellModels) {
            if ([cellModel.identifier isEqualToString:[TDD_ArtiReportCodeRowTableViewCell reuseIdentifier]]) {
                faultCodeCount = faultCodeCount + 1;
            }
            if ([cellModel.identifier isEqualToString:[TDD_ArtiReportFlowRowTableViewCell reuseIdentifier]]) {
                flowDataCount = flowDataCount + 1;
            }
            
            // 赋值编号，如果有系统编号就用系统的，没有就自己按顺序赋值
            if ([cellModel.identifier isEqualToString:[TDD_ArtiReportCodeTitleTableViewCell reuseIdentifier]]) {
                //                NSString * cell_header_title;
                //                if (cellModel.system_id.length > 0) {
                //                    cell_header_title = [NSString stringWithFormat:@"%@%@",cellModel.system_id,cellModel.headerTitle];
                //                } else {
                //                    cell_header_title = [NSString stringWithFormat:@"%d. %@",codeTitleIndex,cellModel.headerTitle];
                //                }
                //                cellModel.cell_header_title = cell_header_title;
                cellModel.cell_header_title = cellModel.headerTitle;
                codeTitleIndex++;
            }
        }
        
        // 概述个数
        self.reportModel.system_overview_content = [NSString stringWithFormat:TDDLocalized.report_overview_content, @(scanedSystemCount), @(errorSystemCount), @(totalErrorCode)];
        
        // 概述
        if (_reportModel.reportType == TDD_ArtiReportTypeSystem || _reportModel.reportType == TDD_ArtiReportTypeAdasSystem) {
            TDD_ArtiReportCellModel *model2 = [[TDD_ArtiReportCellModel alloc] init];
            model2.identifier = [TDD_ArtiReportSummaryTableViewCell reuseIdentifier];
            model2.system_overview_title = self.reportModel.system_overview_title;
            model2.system_overview_content = self.reportModel.system_overview_content;
            NSString *tips = TDDLocalized.report_summarize_tips;
            CGFloat tipsHeight = [NSString tdd_getHeightWithText:tips width:IphoneWidth - 80 fontSize:[UIFont systemFontOfSize:14]];
            CGFloat tipsA4Height = [NSString tdd_getHeightWithText:tips width:A4Width - 80 fontSize:[UIFont systemFontOfSize:10]];
            
            CGFloat contentHeight = [NSString tdd_getHeightWithText:self.reportModel.system_overview_content width:IphoneWidth - 60 fontSize:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]];
            if (IS_IPad) {
                contentHeight = [NSString tdd_getHeightWithText:self.reportModel.system_overview_content width:IphoneWidth - 140 fontSize:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium]];
            }
            if (isKindOfTopVCI) {
                model2.cellHeight = contentHeight + tipsHeight + 125;
                model2.cellA4Height = [NSString tdd_getHeightWithText:self.reportModel.system_overview_content width:A4Width - 60 fontSize:[UIFont systemFontOfSize:10]] + tipsA4Height + 125;
            } else {
                model2.cellHeight = contentHeight + (IS_IPad ? 135 : 105);
                model2.cellA4Height = [NSString tdd_getHeightWithText:self.reportModel.system_overview_content width:A4Width - 60 fontSize:[UIFont systemFontOfSize:10]] + 105;
            }
            
            [tempArray addObject:model2];
        }
        
        // ADAS 执行结果
        BOOL isADAS = [reportModel isAdasReport];
        if (isADAS) {
            // 校验结果
            TDD_ArtiReportCellModel *adasResultSection = [[TDD_ArtiReportCellModel alloc] init];
            // TODO: 国际化
            adasResultSection.headerTitle = @"ADAS执行信息";
            adasResultSection.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
            adasResultSection.cellHeight = IS_IPad ? 80 : 60.0;
            adasResultSection.cellA4Height = 60.0;
            [tempArray addObject:adasResultSection];
            
            TDD_ArtiReportCellModel *adasResult;
            if (!reportModel.adas_result.count) {
                adasResult = [[TDD_ArtiReportCellModel alloc] init];
                adasResult.identifier = [TDD_ArtiADASReportExecuteNoneCell reuseIdentifier];
                adasResult.cellHeight  = 153;
                adasResult.cellA4Height = 153.0;
                
                [tempArray addObject:adasResult];
            } else {
                for (int i = 0; i < reportModel.adas_result.count; i++) {
                    adasResult = [[TDD_ArtiReportCellModel alloc] init];
                    adasResult.identifier = [TDD_ArtiADASReportExecuteCell reuseIdentifier];
                    TDD_ArtiADASReportResult *result = reportModel.adas_result[i];
                    adasResult.adasResult = result;
                    adasResult.cellHeight = [TDD_ArtiADASReportExecuteCell cellHeightWith:result];
                    adasResult.cellA4Height = [TDD_ArtiADASReportExecuteCell a4CellHeightWith:result];
                    [tempArray addObject:adasResult];
                }
                
            }
        }
        
        // 诊断标题 (自己计算个数) => 系统报告状态(59)
        NSString *headerTitle = @"";
        if (_reportModel.reportType == TDD_ArtiReportTypeSystem || _reportModel.reportType == TDD_ArtiReportTypeAdasSystem) {
            headerTitle = [NSString stringWithFormat:@"%@(%d)",[NSString tdd_reportTitleSystemHead], scanedSystemCount];
        } else if (_reportModel.reportType == TDD_ArtiReportTypeDTC || _reportModel.reportType == TDD_ArtiReportTypeAdasDTC) {
            if (self.reportModel.obdEntryType == OET_CARPAL_OBD_ENGINE_CHECK) {
                headerTitle = [NSString stringWithFormat:@"%@(%d)", TDDLocalized.fault_code_report, faultCodeCount];
            } else {
                headerTitle = [NSString stringWithFormat:@"%@(%d)",TDDLocalized.fault_code_report, faultCodeCount];
            }
        } else if (_reportModel.reportType == TDD_ArtiReportTypeDataStream || _reportModel.reportType == TDD_ArtiReportTypeAdasDataStream) {
            headerTitle = [NSString stringWithFormat:@"%@(%d)",[NSString tdd_reportTitleLiveDataHead], flowDataCount];
        }
        
        BOOL hadFlowSection = NO;
        BOOL hadFlowRowCell = NO;
        BOOL hadAddFlowSection = NO;
        NSInteger firstFlowRowIndex = -1;
        NSInteger cellModelsIndex = 0;
        for (TDD_ArtiReportCellModel *cellModel in self.reportModel.cellModels) {
            if ([cellModel.identifier isEqualToString:[TDD_ArtiReportHeaderTableViewCell reuseIdentifier]]) {
                if ([cellModel.headerTitle isEqualToString:[NSString tdd_reportTitleSystemHead]] ||
                    [cellModel.headerTitle isEqualToString:TDDLocalized.fault_code_report] ||
                    [cellModel.headerTitle isEqualToString:[NSString tdd_reportTitleLiveDataHead]]) {
                    cellModel.headerTitle = headerTitle;
                }
            }
            if ([cellModel.identifier isEqualToString:[TDD_ArtiReportFlowSectionTableViewCell reuseIdentifier]]){
                hadFlowSection = YES;
            }
            if ([cellModel.identifier isEqualToString:[TDD_ArtiReportFlowRowTableViewCell reuseIdentifier]] && firstFlowRowIndex == -1){
                hadFlowRowCell = YES;
                firstFlowRowIndex = cellModelsIndex;
            }
            cellModelsIndex ++;
        }
        
        // 添加其它 动态Cell
        for (TDD_ArtiReportCellModel *cellModel in self.reportModel.cellModels) {
            
            if ([cellModel.identifier isEqualToString:[TDD_ArtiReportFlowRowTableViewCell reuseIdentifier]]) {
                
                if (!hadFlowSection && hadFlowRowCell && !hadAddFlowSection){
                    // 如果有数据流，诊断又不调用数据流添加标题的方法，就手动添加一个
                    TDD_ArtiReportCellModel *cellModel2 = [[TDD_ArtiReportCellModel alloc] init];
                    cellModel2.identifier = [TDD_ArtiReportFlowSectionTableViewCell reuseIdentifier];
                    cellModel2.cellHeight = 60.0;
                    cellModel2.cellA4Height = 30.0;
                    cellModel2.headerTitle = @"";//[TDD_CTools CStrToNSString:strSysName];
                    cellModel2.system_id = @"";//[TDD_CTools CStrToNSString:strSysId];
                    hadAddFlowSection = YES;
                    [tempArray addObject:cellModel2];
                }
            }
            [tempArray addObject:cellModel];
            
            // 计算高度
            if ([cellModel.identifier isEqualToString:[TDD_ArtiReportCodeRowTableViewCell reuseIdentifier]]) {
                CGFloat leftHeight = [NSString tdd_getHeightWithText:cellModel.leftTitle width:IphoneWidth * 0.6 fontSize: [UIFont systemFontOfSize:IS_IPad ? 18 : 14]] + 30;
                CGFloat leftA4Height = [NSString tdd_getHeightWithText:cellModel.leftTitle width:A4Width * 0.6 fontSize: [UIFont systemFontOfSize:10]] + 15;
                NSMutableAttributedString *attStr = [TDD_DiagnosisManage getDtcNodeStatusDescription:cellModel.dtcNodeStatus statusStr:cellModel.dtcNodeStatusStr fromTrouble:NO];
                /*
                CGFloat rightHeight = [attStr boundingRectWithSize:CGSizeMake(IphoneWidth * 0.2 - 20, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesDeviceMetrics context:nil].size.height + 15;
                 */
                CGFloat rightHeight = [TDD_ArtiReportCodeRowTableViewCell calRightLabelHeightWithAttributedString:attStr maxWidth:(IphoneWidth * 0.2 - 20) isA4:NO] + 15.0;

                CGFloat rightA4Height = [attStr boundingRectWithSize:CGSizeMake(A4Width * 0.2 - 20, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesDeviceMetrics context:nil].size.height + 15;
                
                cellModel.cellHeight = MAX(leftHeight, rightHeight);
                cellModel.cellA4Height = MAX(leftA4Height, rightA4Height);
            }
            
            if ([cellModel.identifier isEqualToString:[TDD_ArtiReportFlowRowTableViewCell reuseIdentifier]]) {
                CGFloat maxHeight = 60.0;
                CGFloat maxA4Height = 30.0;
                for (int i = 0; i < cellModel.liveDatas.count; i++) {
                    NSString *string = cellModel.liveDatas[i];
                    CGFloat currentHeight = [NSString tdd_getHeightWithText:string width:IphoneWidth * (1.0 / cellModel.liveDatas.count) fontSize: [UIFont systemFontOfSize:IS_IPad ? 18 : 14]] + 40;
                    if (currentHeight > maxHeight) {
                        maxHeight = currentHeight;
                    }
                    
                    CGFloat currentA4Height = [NSString tdd_getHeightWithText:string width:A4Width * (1.0 / cellModel.liveDatas.count) fontSize: [UIFont systemFontOfSize:10]] + 15;
                    if (currentA4Height > maxA4Height) {
                        maxA4Height = currentA4Height;
                    }
                }
                cellModel.cellHeight = maxHeight;
                cellModel.cellA4Height = maxA4Height;
            }
            
            // 维修前 | 维修后状态
            if ([cellModel.identifier isEqualToString:[TDD_ArtiReportRepairHeaderTableViewCell reuseIdentifier]] || [cellModel.identifier isEqualToString:[TDD_ArtiADASReportRepairHeaderCell reuseIdentifier]]) {
                cellModel.repairIndex = self.reportModel.repairIndex;
                cellModel.hasRepairHistory =  self.reportModel.hasRepairHistory;
                
                if (reportModel.isAdasReport) {
                    cellModel.adasPreScanTime = self.reportModel.adasPreScanTime;
                    cellModel.adasPostScanTime = self.reportModel.adasPostScanTime;
                }
            }
            
            // 添加故障码
            if ([cellModel.identifier isEqualToString: [TDD_ArtiReportRepairSectionTableViewCell reuseIdentifier]]) {
                for (TDD_ArtiReportCellModel *cellModel in self.reportModel.repairCellModels) {
                    // 计算高度
                    if ([cellModel.identifier isEqualToString:[TDD_ArtiReportRepairRowTableViewCell reuseIdentifier]]) {
                        cellModel.cellHeight = [NSString tdd_getHeightWithText:cellModel.rightUDtsName width:IphoneWidth * 0.4 - 30 fontSize: [UIFont systemFontOfSize:14]] + 30;
                        cellModel.cellA4Height = [NSString tdd_getHeightWithText:cellModel.rightUDtsName width:A4Width * 0.4 - 30 fontSize: [UIFont systemFontOfSize:10]] + 15;
                    }
                    [tempArray addObject:cellModel];
                }
            }
        }
        
        if (!isADAS) {
            
            // 备注
            if (![NSString tdd_isEmpty:reportModel.adas_msg]) {
                TDD_ArtiReportCellModel *msgSection = [[TDD_ArtiReportCellModel alloc] init];
                msgSection.headerTitle = TDDLocalized.note;
                msgSection.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
                msgSection.cellHeight = IS_IPad ? 80 : 60.0;
                msgSection.cellA4Height = 60.0;
                [tempArray addObject:msgSection];
                
                TDD_ArtiReportCellModel *messageRow = [[TDD_ArtiReportCellModel alloc] init];
                messageRow.identifier = [TDD_ArtiADASReportMessagePreviewCell reuseIdentifier];
                messageRow.adasMessage = reportModel.adas_msg;
                messageRow.cellHeight = [TDD_ArtiADASReportMessagePreviewCell cellHeight: reportModel.adas_msg];
                messageRow.cellA4Height = [TDD_ArtiADASReportMessagePreviewCell a4CellHeight: reportModel.adas_msg];
                [tempArray addObject:messageRow];
            }
            
            // 图片
            if (reportModel.adasImageDatas && reportModel.adasImageDatas.count) {
                TDD_ArtiReportCellModel *imageSection = [[TDD_ArtiReportCellModel alloc] init];
                imageSection.headerTitle = TDDLocalized.picture;
                imageSection.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
                imageSection.cellHeight = IS_IPad ? 80 : 60.0;
                imageSection.cellA4Height = 60.0;
                [tempArray addObject:imageSection];
                
                TDD_ArtiReportCellModel *imgsRow = [[TDD_ArtiReportCellModel alloc] init];
                imgsRow.identifier = [TDD_ArtiADASReportImagesPreviewCell reuseIdentifier];
                imgsRow.adasImages = reportModel.adasImageDatas;
                imgsRow.cellHeight  = TDD_ArtiADASReportImagesPreviewCell.cellHeight;
                imgsRow.cellA4Height = TDD_ArtiADASReportImagesPreviewCell.a4CellHeight;
                
                [tempArray addObject:imgsRow];
                
            }
        }
        
        if (isADAS) {
            
            // 编辑数据 To 预览数据
            if (reportModel.adas_tirePressureData == nil) {
                reportModel.adas_tirePressureData = reportModel.tirePressure.asADASTirePDFData;
            }
            if (reportModel.adas_wheelEyebrowData == nil) {
                reportModel.adas_wheelEyebrowData = reportModel.wheelEyebrow.asADASTirePDFData;
            }
            
            // 消息
            if (![NSString tdd_isEmpty:reportModel.adas_msg]) {
                
                TDD_ArtiReportCellModel *msgSection = [[TDD_ArtiReportCellModel alloc] init];
                msgSection.headerTitle = TDDLocalized.note;
                msgSection.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
                msgSection.cellHeight = IS_IPad ? 80 : 60.0;
                msgSection.cellA4Height = 60.0;
                [tempArray addObject:msgSection];
                
                TDD_ArtiReportCellModel *messageRow = [[TDD_ArtiReportCellModel alloc] init];
                messageRow.identifier = [TDD_ArtiADASReportMessagePreviewCell reuseIdentifier];
                messageRow.adasMessage = reportModel.adas_msg;
                messageRow.cellHeight = [TDD_ArtiADASReportMessagePreviewCell cellHeight: reportModel.adas_msg];
                messageRow.cellA4Height = [TDD_ArtiADASReportMessagePreviewCell a4CellHeight: reportModel.adas_msg];
                [tempArray addObject:messageRow];
            }
            
            // 图片
            if (reportModel.adasImageDatas && reportModel.adasImageDatas.count) {
                TDD_ArtiReportCellModel *imageSection = [[TDD_ArtiReportCellModel alloc] init];
                imageSection.headerTitle = TDDLocalized.picture;
                imageSection.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
                imageSection.cellHeight = IS_IPad ? 80 : 60.0;
                imageSection.cellA4Height = 60.0;
                [tempArray addObject:imageSection];
                
                TDD_ArtiReportCellModel *imgsRow = [[TDD_ArtiReportCellModel alloc] init];
                imgsRow.identifier = [TDD_ArtiADASReportImagesPreviewCell reuseIdentifier];
                imgsRow.adasImages = reportModel.adasImageDatas;
                imgsRow.cellHeight  = TDD_ArtiADASReportImagesPreviewCell.cellHeight;
                imgsRow.cellA4Height = TDD_ArtiADASReportImagesPreviewCell.a4CellHeight;
                
                [tempArray addObject:imgsRow];
                
            }
            
            // 胎压
            
            if (reportModel.adas_tirePressureData) {
                
                TDD_ArtiReportCellModel *tirePressureSection = [[TDD_ArtiReportCellModel alloc] init];
                // TODO: 国际化
                tirePressureSection.headerTitle = @"轮胎压力";
                tirePressureSection.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
                tirePressureSection.cellHeight = IS_IPad ? 80 : 60.0;
                tirePressureSection.cellA4Height = 60.0;
                [tempArray addObject:tirePressureSection];
                
                TDD_ArtiReportCellModel *tirePressureRow = [[TDD_ArtiReportCellModel alloc] init];
                tirePressureRow.identifier = [TDD_ArtiADASReportTirePreviewCell reuseIdentifier];
                tirePressureRow.adasTireData = reportModel.adas_tirePressureData;
                tirePressureRow.cellHeight = [TDD_ArtiADASReportTirePreviewCell height:reportModel.adas_tirePressureData];
                tirePressureRow.cellA4Height = [TDD_ArtiADASReportTirePDFCell a4CellHeight:reportModel.adas_tirePressureData.asPDFPageRowDatas];
                [tempArray addObject:tirePressureRow];
            }
            
            // 轮眉
            
            if (reportModel.adas_wheelEyebrowData) {
                
                TDD_ArtiReportCellModel *wheelEyebrowSection = [[TDD_ArtiReportCellModel alloc] init];
                // TODO: 国际化
                wheelEyebrowSection.headerTitle = @"轮眉高度";
                wheelEyebrowSection.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
                wheelEyebrowSection.cellHeight = IS_IPad ? 80 : 60.0;
                wheelEyebrowSection.cellA4Height = 60.0;
                [tempArray addObject:wheelEyebrowSection];
                
                TDD_ArtiReportCellModel *wheelEyebrowRow = [[TDD_ArtiReportCellModel alloc] init];
                wheelEyebrowRow.identifier = [TDD_ArtiADASReportTirePreviewCell reuseIdentifier];
                wheelEyebrowRow.adasTireData = reportModel.adas_wheelEyebrowData;
                wheelEyebrowRow.cellHeight = [TDD_ArtiADASReportTirePreviewCell height:reportModel.adas_wheelEyebrowData];
                wheelEyebrowRow.cellA4Height =  [TDD_ArtiADASReportTirePDFCell a4CellHeight:reportModel.adas_wheelEyebrowData.asPDFPageRowDatas];;
                [tempArray addObject:wheelEyebrowRow];
            }
            
            // 液位
            if (reportModel.hasFuel) {
                
                if (reportModel.adasHisotryFuel) {
                    /// 校准前
                    reportModel.adasHisotryFuel.type = TDD_ArtiADASReportFuelTypePrevious;
                    
                    TDD_ArtiReportCellModel *historyFuelSection = [[TDD_ArtiReportCellModel alloc] init];
                    historyFuelSection.headerTitle = reportModel.adasHisotryFuel.sectionTitle;
                    historyFuelSection.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
                    historyFuelSection.cellHeight = IS_IPad ? 80 : 60.0;
                    historyFuelSection.cellA4Height = 60.0;
                    [tempArray addObject:historyFuelSection];
                    
                    TDD_ArtiReportCellModel *historyfuelRow = [[TDD_ArtiReportCellModel alloc] init];
                    historyfuelRow.identifier = [TDD_ArtiADASReportFuelPreviewCell reuseIdentifier];
                    
                    historyfuelRow.adasFuel = reportModel.adasHisotryFuel;
                    
                    historyfuelRow.cellHeight   = [TDD_ArtiADASReportFuelPreviewCell cellHeight];
                    historyfuelRow.cellA4Height = [TDD_ArtiADASReportFuelPreviewCell cellHeight];
                    [tempArray addObject:historyfuelRow];
                    
                    /// 校准后
                    reportModel.fuel.type = TDD_ArtiADASReportFuelTypePosterior;
                    
                    TDD_ArtiReportCellModel *fuelSection = [[TDD_ArtiReportCellModel alloc] init];
                    fuelSection.headerTitle = reportModel.fuel.sectionTitle;
                    fuelSection.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
                    fuelSection.cellHeight = IS_IPad ? 80 : 60.0;
                    fuelSection.cellA4Height = 60.0;
                    [tempArray addObject:fuelSection];
                    
                    TDD_ArtiReportCellModel *fuelRow = [[TDD_ArtiReportCellModel alloc] init];
                    fuelRow.identifier = [TDD_ArtiADASReportFuelPreviewCell reuseIdentifier];
                    
                    fuelRow.adasFuel = reportModel.fuel;
                    
                    fuelRow.cellHeight   = [TDD_ArtiADASReportFuelPreviewCell cellHeight];
                    fuelRow.cellA4Height = [TDD_ArtiADASReportFuelPreviewCell cellHeight];
                    [tempArray addObject:fuelRow];
                    
                } else {
                    TDD_ArtiReportCellModel *fuelSection = [[TDD_ArtiReportCellModel alloc] init];
                    fuelSection.headerTitle = reportModel.fuel.sectionTitle;
                    fuelSection.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
                    fuelSection.cellHeight = IS_IPad ? 80 : 60.0;
                    fuelSection.cellA4Height = 60.0;
                    [tempArray addObject:fuelSection];
                    
                    TDD_ArtiReportCellModel *fuelRow = [[TDD_ArtiReportCellModel alloc] init];
                    fuelRow.identifier = [TDD_ArtiADASReportFuelPreviewCell reuseIdentifier];
                    fuelRow.adasFuel = reportModel.fuel;
                    fuelRow.cellHeight   = [TDD_ArtiADASReportFuelPreviewCell cellHeight];
                    fuelRow.cellA4Height = [TDD_ArtiADASReportFuelPreviewCell cellHeight];
                    [tempArray addObject:fuelRow];
                }
                
            }
            
        }
        
        // 免责声明表头 固定Cell
        TDD_ArtiReportCellModel *model3 = [[TDD_ArtiReportCellModel alloc] init];
        model3.headerTitle = TDDLocalized.set_disclaimer;
        model3.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
        model3.cellHeight = IS_IPad ? 80 : 60.0;
        model3.cellA4Height = 60.0;
        [tempArray addObject:model3];
        
        // 免责声明数据 固定Cell
        TDD_ArtiReportCellModel *model4 = [[TDD_ArtiReportCellModel alloc] init];
        model4.subTitle = [NSString stringWithFormat:@"        %@\n        %@",TDDLocalized.report_disclaimer_content_one,TDDLocalized.report_disclaimer_content_two];
        model4.identifier = [TDD_ArtiReportTextTableViewCell reuseIdentifier];
        if (IS_IPad) {
            model4.cellHeight = [NSString tdd_getHeightWithText:model4.subTitle width:IphoneWidth - 80 fontSize:[UIFont systemFontOfSize:18]] + 40;
        } else {
            model4.cellHeight = [NSString tdd_getHeightWithText:model4.subTitle width:IphoneWidth - 30 fontSize:[UIFont systemFontOfSize:14]] + 40;
        }
        model4.cellA4Height = [NSString tdd_getHeightWithText:model4.subTitle width:A4Width - 30 fontSize:[UIFont systemFontOfSize:12]] + 40;
        [tempArray addObject:model4];
        
        // 赋值
        self.items = [tempArray mutableCopy];
    }
    // 测试数据
    else {
        
        int scanedSystemCount = 12;
        int errorSystemCount = 8;
        int totalErrorCode = 20;
        
        _reportModel.report_title = @"诊断报告";
        _reportModel.describe_title = @"2021 BWM 2021 BWM 2021 BWM 2021 BWM 2021 BWM 2021 BWM 2021 BWM 2021 BWM";
        _reportModel.system_overview_title = @"概述";
        _reportModel.system_overview_content = [NSString stringWithFormat:TDDLocalized.report_overview_content, @(scanedSystemCount), @(errorSystemCount), @(totalErrorCode)];
        _reportModel.describe_customer_name = @"林先生 林先生 林先生 林先生 林先生 林先生 林先生";
        _reportModel.reportType = 1;
        _reportModel.describe_diagnosis_path = @"宝马>302>系统>自动扫描宝马>302>系统>自动扫描宝马>302>系统>自动扫描宝马>302>系统>自动扫描宝马>302>系统>自动扫描宝马>302>系统>自动扫描宝马>302>系统>自动扫描宝马>302>系统>自动扫描";
        _reportModel.report_type_title = @"系统报告状态(59)";
        
        TDD_ArtiReportCellModel *model1 = [[TDD_ArtiReportCellModel alloc] init];
        model1.identifier = [_infoCellClass reuseIdentifier];
        model1.cellHeight = [_infoCellClass getCellHeightWith:_reportModel];
        model1.cellA4Height = [_infoCellClass getCellA4HeightWith:_reportModel];
        
        TDD_ArtiReportCellModel *model2 = [[TDD_ArtiReportCellModel alloc] init];
        model2.identifier = [TDD_ArtiReportSummaryTableViewCell reuseIdentifier];
        model2.cellHeight = 170.0;
        model2.cellA4Height = 80.0;
        
        TDD_ArtiReportCellModel *model3 = [[TDD_ArtiReportCellModel alloc] init];
        model3.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
        model3.headerTitle = @"model3";
        model3.cellHeight = IS_IPad ? 80 : 60.0;
        model3.cellA4Height = 30.0;
        
        TDD_ArtiReportCellModel *model4 = [[TDD_ArtiReportCellModel alloc] init];
        model4.identifier = [TDD_ArtiReportTextTableViewCell reuseIdentifier];
        model4.subTitle = @"modle4";
        model4.cellHeight = 80.0;
        model4.cellA4Height = 30;
        
        TDD_ArtiReportCellModel *model5 = [[TDD_ArtiReportCellModel alloc] init];
        model5.identifier = [TDD_ArtiReportRepairHeaderTableViewCell reuseIdentifier];
        model5.cellHeight = IS_IPad ? 50 : 40.0;
        model5.cellA4Height = 30.0;
        model5.leftWidth = 0.3;
        model5.rightWidth = 0.3;
        
        TDD_ArtiReportCellModel *model6 = [[TDD_ArtiReportCellModel alloc] init];
        model6.identifier = [TDD_ArtiReportRepairSectionTableViewCell reuseIdentifier];
        model6.rightUDtsName = @"model6";
        model6.rightUDtsNums = 3;
        model6.cellHeight = IS_IPad ? 60 : 50.0;
        model6.cellA4Height = 30.0;
        model6.leftWidth = 0.3;
        model6.leftTitle = @"fsff";
        model6.rightWidth = 0.3;
        
        TDD_ArtiReportCellModel *model7 = [[TDD_ArtiReportCellModel alloc] init];
        model7.identifier = [TDD_ArtiReportRepairRowTableViewCell reuseIdentifier];
        model7.rightUDtsName = @"model7 iFunbox于2008年8月推出，是最好的iPhone及其他苹果产品的通用文件管理软件之一。以类似windows资源管理器的窗口方式在PC上浏览和管理iPhone、iPad、iPod Touch上的文件和目录，使苹果各类设备得以共享彼此的资源，让您轻松上传或导出电影、音乐、电子书、桌面、照片、以及应用程序。";
        model7.rightUDtsNums = 3;
        model7.cellHeight = [NSString tdd_getHeightWithText:model7.rightUDtsName width:IphoneWidth * 0.4 - 30 fontSize: [UIFont systemFontOfSize:14]] + 30;
        model7.cellA4Height = [NSString tdd_getHeightWithText:model7.rightUDtsName width:A4Width * 0.4 - 30 fontSize: [UIFont systemFontOfSize:10]] + 15;
        model7.leftWidth = 0.3;
        model7.rightWidth = 0.3;
        
        TDD_ArtiReportCellModel *model8 = [[TDD_ArtiReportCellModel alloc] init];
        model8.identifier = [TDD_ArtiReportRepairRowTableViewCell reuseIdentifier];
        model8.rightUDtsName = @"model8";
        model8.rightUDtsNums = 3;
        model8.cellHeight = [NSString tdd_getHeightWithText:model8.rightUDtsName width:IphoneWidth * 0.4 - 30 fontSize: [UIFont systemFontOfSize:14]] + 30;
        model8.cellA4Height = [NSString tdd_getHeightWithText:model8.rightUDtsName width:A4Width * 0.4 - 30 fontSize: [UIFont systemFontOfSize:10]] + 15;
        model8.leftWidth = 0.3;
        model8.rightWidth = 0.3;
        
        TDD_ArtiReportCellModel *model9 = [[TDD_ArtiReportCellModel alloc] init];
        model9.identifier = [TDD_ArtiReportRepairRowTableViewCell reuseIdentifier];
        model9.rightUDtsName = @"model9";
        model9.rightUDtsNums = 3;
        model9.cellHeight = [NSString tdd_getHeightWithText:model9.rightUDtsName width:IphoneWidth * 0.4 - 30 fontSize: [UIFont systemFontOfSize:14]] + 30;
        model9.cellA4Height = [NSString tdd_getHeightWithText:model9.rightUDtsName width:A4Width * 0.4 - 30 fontSize: [UIFont systemFontOfSize:10]] + 15;
        model9.leftWidth = 0.3;
        model9.rightWidth = 0.3;
        
        TDD_ArtiReportCellModel *model10 = [[TDD_ArtiReportCellModel alloc] init];
        model10.identifier = [TDD_ArtiReportRepairRowTableViewCell reuseIdentifier];
        model10.rightUDtsName = @"model10";
        model10.rightUDtsNums = 3;
        model10.cellHeight = [NSString tdd_getHeightWithText:model10.rightUDtsName width:IphoneWidth * 0.4 - 30 fontSize: [UIFont systemFontOfSize:14]] + 30;
        model10.cellA4Height = [NSString tdd_getHeightWithText:model10.rightUDtsName width:A4Width * 0.4 - 30 fontSize: [UIFont systemFontOfSize:10]] + 15;
        model10.leftWidth = 0.3;
        model10.rightWidth = 0.3;
        
        TDD_ArtiReportCellModel *model11 = [[TDD_ArtiReportCellModel alloc] init];
        model11.identifier = [TDD_ArtiReportCodeTitleTableViewCell reuseIdentifier];
        model11.headerTitle = @"model11";
        model11.cellHeight = IS_IPad ? 80 : 60.0;
        model11.cellA4Height = 30.0;
        model11.leftWidth = 0.6;
        model11.rightWidth = 0.2;
        
        TDD_ArtiReportCellModel *model12 = [[TDD_ArtiReportCellModel alloc] init];
        model12.identifier = [TDD_ArtiReportCodeSectionTableViewCell reuseIdentifier];
        model12.cellHeight = IS_IPad ? 60 : 50.0;
        model12.cellA4Height = 30.0;
        model12.leftWidth = 0.6;
        model12.rightWidth = 0.2;
        
        TDD_ArtiReportCellModel *model13 = [[TDD_ArtiReportCellModel alloc] init];
        model13.identifier = [TDD_ArtiReportCodeRowTableViewCell reuseIdentifier];
        model13.headerTitle = @"model13";
        model13.leftTitle = @"model13 .自动扫描界面选择任意系统进入，退出系统没有光标记录，一键清码时也没有系统显示光标。";
        model13.dtcNodeStatus = 1;
        model13.cellHeight = [NSString tdd_getHeightWithText:model13.leftTitle width:IphoneWidth * 0.6 fontSize: [UIFont systemFontOfSize:IS_IPad ? 18 : 14]] + 30;
        model13.cellA4Height = [NSString tdd_getHeightWithText:model13.leftTitle width:A4Width * 0.6 fontSize: [UIFont systemFontOfSize:10]] + 15;
        model13.leftWidth = 0.6;
        model13.rightWidth = 0.2;
        
        TDD_ArtiReportCellModel *model14 = [[TDD_ArtiReportCellModel alloc] init];
        model14.identifier = [TDD_ArtiReportCodeRowTableViewCell reuseIdentifier];
        model14.headerTitle = @"model14";
        model14.leftTitle = @"model14";
        model14.dtcNodeStatus = 1 + 2 + 4 + 8;
        model14.cellHeight = [NSString tdd_getHeightWithText:model14.leftTitle width:IphoneWidth * 0.6 fontSize: [UIFont systemFontOfSize:IS_IPad ? 18 : 14]] + 30;
        model14.cellA4Height = [NSString tdd_getHeightWithText:model14.leftTitle width:A4Width * 0.6 fontSize: [UIFont systemFontOfSize:10]] + 15;
        model14.leftWidth = 0.6;
        model14.rightWidth = 0.2;
        
        TDD_ArtiReportCellModel *model15 = [[TDD_ArtiReportCellModel alloc] init];
        model15.identifier = [TDD_ArtiReportCodeRowTableViewCell reuseIdentifier];
        model15.dtcNodeStatus = 16;
        model15.headerTitle = @"model15 1234567890";
        model15.leftTitle = @"model15 自动扫描界面选择任意系统进入，退出系统没有光标记录，一键清码时也没有系统显示光标 自动扫描界面选择任意系统进入，退出系统没有光标记录，一键清码时也没有系统显示光标";
        model15.cellHeight = [NSString tdd_getHeightWithText:model15.leftTitle width:IphoneWidth * 0.6 fontSize: [UIFont systemFontOfSize:IS_IPad ? 18 : 14]] + 30;
        model15.cellA4Height = [NSString tdd_getHeightWithText:model15.leftTitle width:A4Width * 0.6 fontSize: [UIFont systemFontOfSize:10]] + 15;
        model15.leftWidth = 0.6;
        model15.rightWidth = 0.2;
        
        TDD_ArtiReportCellModel *model16 = [[TDD_ArtiReportCellModel alloc] init];
        model16.identifier = [TDD_ArtiReportCodeRowTableViewCell reuseIdentifier];
        model16.headerTitle = @"model16";
        model16.leftTitle = @"model16";
        model16.cellHeight = 50.0;
        model16.cellA4Height = 30.0;
        model16.leftWidth = 0.6;
        model16.rightWidth = 0.2;
        model16.dtcNodeStatus = 0;
        
        TDD_ArtiReportCellModel *model17 = [[TDD_ArtiReportCellModel alloc] init];
        model17.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
        model17.headerTitle = @"model17";
        model17.cellHeight = IS_IPad ? 80 : 60.0;
        model17.cellA4Height = 30.0;
        
        TDD_ArtiReportCellModel *model18 = [[TDD_ArtiReportCellModel alloc] init];
        model18.identifier = [TDD_ArtiReportFlowRowTableViewCell reuseIdentifier];
        model18.liveDatas = @[@"model18", @"故障报告，故障码系统故障未排在一起，故障状态显示不对", @"model18", @"自动扫描界面选择任意系统进入，退出系统没有光标记录，一键清码时也没有系统显示光标后续产品新增逻辑"];
        model18.cellHeight = 60.0;
        model18.cellA4Height = 30.0;
        
        CGFloat maxHeight = 60.0;
        CGFloat maxA4Height = 30.0;
        for (int i = 0; i < model18.liveDatas.count; i++) {
            NSString *string = model18.liveDatas[i];
            CGFloat currentHeight = [NSString tdd_getHeightWithText:string width:IphoneWidth * (1.0 / model18.liveDatas.count) fontSize: [UIFont systemFontOfSize:14]] + 40;
            CGFloat currentA4Height = [NSString tdd_getHeightWithText:string width:A4Width * (1.0 / model18.liveDatas.count) fontSize: [UIFont systemFontOfSize:10]] + 15;
            if (currentHeight > maxHeight) {
                maxHeight = currentHeight;
            }
            if (currentA4Height > maxA4Height) {
                maxA4Height = currentA4Height;
            }
            
        }
        model18.cellHeight = maxHeight;
        model18.cellA4Height = maxA4Height;
        
        TDD_ArtiReportCellModel *model19 = [[TDD_ArtiReportCellModel alloc] init];
        model19.identifier = [TDD_ArtiReportFlowRowTableViewCell reuseIdentifier];
        model19.liveDatas = @[@"model19", @"model19", @"model19", @"model19"];
        model19.cellHeight = 60.0;
        model19.cellA4Height = 30.0;
        
        TDD_ArtiReportCellModel *model20 = [[TDD_ArtiReportCellModel alloc] init];
        model20.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
        model20.headerTitle = @"model20";
        model20.cellHeight = IS_IPad ? 80 : 60.0;
        model20.cellA4Height = 30.0;
        
        TDD_ArtiReportCellModel *model21 = [[TDD_ArtiReportCellModel alloc] init];
        model21.identifier = [TDD_ArtiReportTextTableViewCell reuseIdentifier];
        model21.subTitle = @"model21";
        model21.cellHeight = 80.0;
        model21.cellA4Height = 80.0;
        
        _items = @[
            model1,
            model2,
            model3,
            model4,
            model5,
            model6,
            model7,
            model8,
            model9,
            model10,
            model11,
            model12,
            model13,
            model14,
            model15,
            model16,
            model17,
            model18,
            model19,
            model20,
            model21
        ];
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:_items];
        if (isKindOfTopVCI){
            [array removeObject:model5];
        }
        _items = [array mutableCopy];
        
        
    }
    
    [self.tableView reloadData];
    [self.A4SizeTableView reloadData];
}

- (void)saveHistory:(UInt32)createTime {
    TDD_ArtiReportHistoryJKDBModel *model = [[TDD_ArtiReportHistoryJKDBModel alloc] init];
    
    NSString *extraVin = @"";
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(carExtraInfo)]) {
        NSDictionary *carExtraInfo =
        [[TDD_DiagnosisManage sharedManage].manageDelegate carExtraInfo];
        if (carExtraInfo && carExtraInfo.allKeys.count > 0) {
            extraVin = carExtraInfo[@"VIN"];
        }
    }
    
    model.VIN = [NSString tdd_isEmpty:self.reportModel.VIN] ? extraVin : self.reportModel.VIN;
    model.VCISerialNumber = [TDD_DiagnosisTools selectedVCISerialNum];
    model.userId = [TDD_DiagnosisTools userID];
    model.describeBrand = self.reportModel.describe_brand;
    model.createTime = createTime;
    if ([NSString tdd_isEmpty:self.reportModel.reportRecordName]) {
        model.displayName =  [self.reportModel generatPdfFileName: self.reportModel.repairIndex];
    } else {
        model.displayName = self.reportModel.reportRecordName;
    }
    model.displayName = [model.displayName tdd_removeFileSpecialString];

    if ([NSString tdd_isEmpty:self.reportModel.a4pdfPath]) {
        NSString *date = [[NSDate dateWithTimeIntervalSince1970:createTime] tdd_stringWithFormat:@"yyyy-MM-dd_HH-mm-ss"];
        model.pdfFileName = [[NSString alloc] initWithFormat:@"%@_%@.pdf", model.displayName, date];
    } else {
        NSArray *components = [self.reportModel.a4pdfPath componentsSeparatedByString:@"/"];
        model.pdfFileName = [components lastObject];
    }
    for (TDD_ArtiReportCellModel *object in self.items) {
        object.reportTypeUpdateFlag = 1; // 设置更新标志位
    }
    model.strData = [self.items yy_modelToJSONString];
    model.reportUrl = self.reportModel.reportUrl;
    model.languageId = (int)[TDD_HLanguage getServiceLanguageId];
    
    model.reportType = self.reportModel.reportType;
    model.repairIndex = self.reportModel.repairIndex;
    
    @kWeakObj(self)
    [self saveADASImagesWithBlock:^{
        @kStrongObj(self)
        if (!self) {
            NSLog(@"保存报告失败：self 已经被销毁");
            return;
        }
        [model save];
    }];
    
    
    //    ArtiReportHistoryJKDBModel *dbModel = [ArtiReportHistoryJKDBModel new];
    //    dbModel.VIN = self.reportModel.VIN;
    //    dbModel.VCISerialNumber = [[DiagnosisManage sharedManage] selectedVCISerialNum];
    //    dbModel.userId = [[[UserDataManage sharedUserDataManage] userModel] userID];
    //    dbModel.describeBrand = self.reportModel.describe_brand;
    //    dbModel.createTime = createTime;
    //
    //    if (self.reportModel.reportRecordName.length > 0) {
    //        dbModel.pdfFileName = [[NSString alloc] initWithFormat:@"%@_%@.pdf", self.reportModel.reportRecordName, @(createTime)];
    //    } else {
    //        dbModel.pdfFileName = [[NSString alloc] initWithFormat:@"report_%@.pdf", @(createTime)];
    //    }
    //    [dbModel.items removeAllObjects];
    //    [dbModel.items addObjectsFromArray:self.items];
    //    NSString *userId = [NSString stringWithFormat:@"%d",[UserDataManage sharedUserDataManage].userModel.userID];
    //        dbModel.bg_tableName = ArtiReportHistoryJKDBModel_bg_tableName(userId);
    //    [dbModel bg_saveAsync:^(BOOL isSuccess) {
    //        NSLog(@"诊断报告存储结果%d",isSuccess);
    //    }];
    
}

- (void)saveADASImagesWithBlock:(void (^)(void))completionBlock {
    [self saveADASAttachImagesWithBlock:^{
        [self saveADASFuelImageWithBlock:^{
            if (completionBlock) { completionBlock(); }
        }];
    }];
}

- (void)saveADASAttachImagesWithBlock:(void (^)(void))completionBlock {
    BOOL maybeHasImages = self.reportModel.adas_image_paths.count == 0;
    // 保存adas图片
    if (maybeHasImages) {
        TDD_DBType dbType = TDD_DATA_BASE_TYPE_DEFAULT;
        if ([TDD_DiagnosisTools softWareIsSingleApp]) {
            dbType = TDD_DATA_BASE_TYPE_GROUP;
        }
        [TDD_ArtiReportModel saveAdasImages: self.reportModel.adasImageDatas dbType:dbType withCreateTime: self.reportModel.reportCreateTime withBlock: ^() {
            if (completionBlock) { completionBlock(); }
        }];
    } else {
        if (completionBlock) { completionBlock(); }
    }
}

- (void)saveADASFuelImageWithBlock:(void (^)(void))completionBlock {
    BOOL maybeHasFuelImage = self.reportModel.fuelImage;
    // 保存adas燃油图片
    if (maybeHasFuelImage) {
        [TDD_ArtiReportModel saveAdasFuelImage: self.reportModel.fuelImage withCreateTime: self.reportModel.reportCreateTime withBlock: ^() {
            if (completionBlock) { completionBlock(); }
        }];
    } else {
        if (completionBlock) { completionBlock(); }
    }
}


- (void)setupUI
{
    self.backgroundColor = UIColor.tdd_reportBackground;
    UIView *bgView = [UIView new];
    [self addSubview:bgView];
    bgView.backgroundColor = UIColor.tdd_reportBackground;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    [bgView addSubview:tableView];
    tableView.backgroundColor = UIColor.clearColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    
    [tableView registerClass:_infoCellClass forCellReuseIdentifier: [_infoCellClass reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportSummaryTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportSummaryTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportHeaderTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportHeaderTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportTextTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportTextTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportRepairHeaderTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportRepairHeaderTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportRepairSectionTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportRepairSectionTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportRepairRowTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportRepairRowTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportCodeTitleTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportCodeTitleTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportCodeSectionTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportCodeSectionTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportCodeRowTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportCodeRowTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportFlowSectionTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportFlowSectionTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportFlowRowTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportFlowRowTableViewCell reuseIdentifier]];
    
    // ADAS
    [tableView registerClass:[TDD_ArtiADASReportMessagePreviewCell class] forCellReuseIdentifier:[TDD_ArtiADASReportMessagePreviewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiADASReportImagesPreviewCell class] forCellReuseIdentifier:[TDD_ArtiADASReportImagesPreviewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiADASReportExecuteNoneCell class] forCellReuseIdentifier:[TDD_ArtiADASReportExecuteNoneCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiADASReportExecuteCell class] forCellReuseIdentifier:[TDD_ArtiADASReportExecuteCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiADASReportTirePreviewCell class] forCellReuseIdentifier:[TDD_ArtiADASReportTirePreviewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiADASReportFuelPreviewCell class] forCellReuseIdentifier:[TDD_ArtiADASReportFuelPreviewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiADASReportRepairHeaderCell class] forCellReuseIdentifier:[TDD_ArtiADASReportRepairHeaderCell reuseIdentifier]];

    [self setupA4];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportCodeTitleTableViewCell reuseIdentifier]]) {
        
        BOOL isLower = [self.items[indexPath.row-1].identifier isEqualToString: [TDD_ArtiReportHeaderTableViewCell reuseIdentifier]];
        if (isLower) {
            self.items[indexPath.row].cellHeight = IS_IPad ? 80 : 30;
        }
    }
    if (tableView == self.tableView) {
        return self.items[indexPath.row].cellHeight;
    } else {
        return self.items[indexPath.row].cellA4Height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if ([self.items[indexPath.row].identifier isEqualToString: [_infoCellClass reuseIdentifier]]) {
        TDD_ArtiReportCellModel *model = self.items[indexPath.row];
         if (self.tableView == tableView) {
             if (isKindOfTopVCI){
                 TDD_ArtiReportInfoTopVCITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportInfoTopVCITableViewCell reuseIdentifier] forIndexPath:indexPath];
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 [cell updateWith:model];
                 return cell;
             }else {
                 TDD_ArtiReportInfoCell *cell = [[TDD_ArtiReportInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[TDD_ArtiReportInfoCell reuseIdentifier] labelMargin:IS_IPad ? 40 : 15 lineSpacing:IS_IPad ? 30 : 15 interItemSpacing:IS_IPad ? 40 : 20];
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 [cell updateUIWithModel:model];
                 return cell;
             }
         } else {
             TDD_ArtiReportInfosA4Cell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportInfosA4Cell reuseIdentifier] forIndexPath:indexPath];
             
             [cell updateWithInfos:model.infos];
             
             return cell;
         }
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportSummaryTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportSummaryTableViewCell reuseIdentifier] forIndexPath:indexPath];
        TDD_ArtiReportCellModel *model = self.items[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (tableView == self.tableView) {
            [cell updateWith:model];
        } else {
            [cell updateA4With:model];
        }
        return cell;
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportHeaderTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportHeaderTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.nameLabel.text = self.items[indexPath.row].headerTitle;
        if (tableView == self.tableView) {
            [cell updateLayout];
        } else {
            [cell updateA4Layout];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportTextTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportTextTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.valueLabel.text = self.items[indexPath.row].subTitle;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (tableView == self.tableView) {
            [cell updateLayout];
        } else {
            [cell updateA4Layout];
        }
        return cell;
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportRepairHeaderTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportRepairHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportRepairHeaderTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (tableView == self.tableView) {
            [cell updateHistoryLabelPercent:self.items[indexPath.row].leftWidth withCurrentLabelPercent:self.items[indexPath.row].rightWidth];
        } else {
            [cell updateA4HistoryLabelPercent:self.items[indexPath.row].leftWidth withCurrentLabelPercent:self.items[indexPath.row].rightWidth];
        }
        TDD_ArtiReportCellModel *model = self.items[indexPath.row];
        if (model.repairIndex == 1) {
            cell.currentLabel.text = TDDLocalized.report_system_type_before;
            cell.historyLabel.text = @"";
        } else if (model.repairIndex == 2 && model.hasRepairHistory == YES) {
            cell.currentLabel.text = TDDLocalized.report_system_type_after;
            cell.historyLabel.text = TDDLocalized.report_system_type_before;
        } else if (model.repairIndex == 2) {
            cell.currentLabel.text = TDDLocalized.report_system_type_after;
            cell.historyLabel.text = @"";
        } else if (model.repairIndex == 3 && model.hasRepairHistory == YES) {
            cell.currentLabel.text = TDDLocalized.report_system_type_ing;
            cell.historyLabel.text = TDDLocalized.report_system_type_before;
        } else if (model.repairIndex == 3) {
            cell.currentLabel.text = TDDLocalized.report_system_type_ing;
            cell.historyLabel.text = @"";
        }
        return cell;
    }
    
    // ADAS repair head
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiADASReportRepairHeaderCell reuseIdentifier]]) {
        TDD_ArtiADASReportRepairHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiADASReportRepairHeaderCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (tableView == self.tableView) {
            [cell updateWithHistoryPercent:self.items[indexPath.row].leftWidth currentPercent:self.items[indexPath.row].rightWidth];
        } else {
            [cell updateA4WithHistoryPercent:self.items[indexPath.row].leftWidth currentPercent:self.items[indexPath.row].rightWidth];
        }
        TDD_ArtiReportCellModel *model = self.items[indexPath.row];
        if (model.repairIndex == 1) {
            [cell updateTextWithHistory:@"" historyTime:@"" current:TDDLocalized.report_system_type_before currentTime: model.adasPostScanTime];
        } else if (model.repairIndex == 2 && model.hasRepairHistory == YES) {
            [cell updateTextWithHistory:TDDLocalized.report_system_type_before historyTime:model.adasPreScanTime current:TDDLocalized.report_system_type_after currentTime:model.adasPostScanTime];
        } else if (model.repairIndex == 2) {
            [cell updateTextWithHistory:@"" historyTime:@"" current:TDDLocalized.report_system_type_after currentTime:model.adasPostScanTime];
        } else if (model.repairIndex == 3 && model.hasRepairHistory == YES) {
            [cell updateTextWithHistory:TDDLocalized.report_system_type_before historyTime:model.adasPreScanTime current:TDDLocalized.report_system_type_ing currentTime:model.adasPostScanTime];
        } else if (model.repairIndex == 3) {
            [cell updateTextWithHistory:@"" historyTime:@"" current:TDDLocalized.report_system_type_ing currentTime:model.adasPostScanTime];
        }
        return cell;
    }
    
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportRepairSectionTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportRepairSectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportRepairSectionTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (tableView == self.tableView) {
            [cell updateLeftLabelPercent:self.items[indexPath.row].leftWidth withRightLabelPercent:self.items[indexPath.row].rightWidth];
        } else {
            [cell updateA4LeftLabelPercent:self.items[indexPath.row].leftWidth withRightLabelPercent:self.items[indexPath.row].rightWidth];
        }
        return cell;
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportRepairRowTableViewCell reuseIdentifier]]) {
        // 维修前后
        TDD_ArtiReportRepairRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportRepairRowTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (tableView == self.tableView) {
            [cell updateLeftLabelPercent:self.items[indexPath.row].leftWidth withRightLabelPercent:self.items[indexPath.row].rightWidth];
        } else {
            [cell updateA4LeftLabelPercent:self.items[indexPath.row].leftWidth withRightLabelPercent:self.items[indexPath.row].rightWidth];
        }
        [cell updateWith:self.items[indexPath.row]];
        return cell;
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportCodeTitleTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportCodeTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportCodeTitleTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.nameLabel.text = self.items[indexPath.row].cell_header_title;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        BOOL isLower = [self.items[indexPath.row-1].identifier isEqualToString: [TDD_ArtiReportHeaderTableViewCell reuseIdentifier]];
        cell.isLower = isLower;
                        
        if (tableView == self.tableView) {
            [cell updateLayout];
        } else {
            [cell updateA4Layout];
        }
        
        return cell;
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportCodeSectionTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportCodeSectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportCodeSectionTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (tableView == self.tableView) {
            [cell updateLeftLabelPercent:self.items[indexPath.row].leftWidth withRightLabelPercent:self.items[indexPath.row].rightWidth];
            if (!IS_IPad) {
                cell.nameLabel.textAlignment = NSTextAlignmentCenter;
            } else {
                cell.nameLabel.textAlignment = NSTextAlignmentLeft;
            }
        } else {
            [cell updateA4LeftLabelPercent:self.items[indexPath.row].leftWidth withRightLabelPercent:self.items[indexPath.row].rightWidth];
            cell.nameLabel.textAlignment = NSTextAlignmentCenter;
        }
        cell.nameLabel.text = TDDLocalized.report_fault_code;
        cell.leftLabel.text = TDDLocalized.trouble_desc;
        cell.rightLabel.text = TDDLocalized.vci_status;
        return cell;
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportCodeRowTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportCodeRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportCodeRowTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftLabel.text = self.items[indexPath.row].leftTitle;
        cell.nameLabel.text = self.items[indexPath.row].headerTitle;
        NSAttributedString *pdfAttri = [self getDtcNodeStatusDescription:self.items[indexPath.row].dtcNodeStatus statusStr:self.items[indexPath.row].dtcNodeStatusStr isPDF:YES];
        NSAttributedString *normalAttri = [self getDtcNodeStatusDescription:self.items[indexPath.row].dtcNodeStatus statusStr:self.items[indexPath.row].dtcNodeStatusStr isPDF:NO];
        if (tableView == self.tableView) {
            [cell updateRightLabelWithAttributedString:normalAttri isA4:NO];
            [cell updateLeftLabelPercent:self.items[indexPath.row].leftWidth withRightLabelPercent:self.items[indexPath.row].rightWidth];
            if (!IS_IPad) {
                cell.nameLabel.textAlignment = NSTextAlignmentCenter;
            } else {
                cell.nameLabel.textAlignment = NSTextAlignmentLeft;
            }
        } else {
            [cell updateRightLabelWithAttributedString:pdfAttri isA4:YES];
            [cell updateA4LeftLabelPercent:self.items[indexPath.row].leftWidth withRightLabelPercent:self.items[indexPath.row].rightWidth];
            cell.nameLabel.textAlignment = NSTextAlignmentCenter;
        }
        return cell;
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportFlowSectionTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportFlowSectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportFlowSectionTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *defaultTitles = @[TDDLocalized.diagnosis_name, TDDLocalized.report_data_stream_number, TDDLocalized.diagnosis_unit, TDDLocalized.report_data_stream_reference];
        
        if (tableView == self.tableView) {
            [cell updateWith:defaultTitles];
        } else {
            [cell updateA4With:defaultTitles];
        }
        return cell;
    }
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiReportFlowRowTableViewCell reuseIdentifier]]) {
        TDD_ArtiReportFlowRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiReportFlowRowTableViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (tableView == self.tableView) {
            [cell updateWith: self.items[indexPath.row].liveDatas];
        } else {
            [cell updateA4With:self.items[indexPath.row].liveDatas];
        }
        return cell;
    }
    
    // ADAS
    
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiADASReportMessagePreviewCell reuseIdentifier]]) {
        TDD_ArtiADASReportMessagePreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiADASReportMessagePreviewCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        TDD_ArtiReportCellModel *cellModel = self.items[indexPath.row];
        if (tableView == self.tableView) {
            [cell update: cellModel.adasMessage];
        } else {
            [cell updateA4: cellModel.adasMessage];
        }
        return cell;
    }
    
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiADASReportImagesPreviewCell reuseIdentifier]]) {
        TDD_ArtiADASReportImagesPreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiADASReportImagesPreviewCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        TDD_ArtiReportCellModel *cellModel = self.items[indexPath.row];
        if (tableView == self.tableView) {
            [cell update: cellModel.adasImages];
        } else {
            [cell updateA4: cellModel.adasImages];
        }
        return cell;
    }
    
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiADASReportExecuteNoneCell reuseIdentifier]]) {
        TDD_ArtiADASReportExecuteNoneCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiADASReportExecuteNoneCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (tableView == self.tableView) {
            [cell update];
        } else {
            [cell updateA4];
        }
        return cell;
    }
    
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiADASReportExecuteCell reuseIdentifier]]) {
        TDD_ArtiADASReportExecuteCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiADASReportExecuteCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (tableView == self.tableView) {
            [cell updateWith: self.items[indexPath.row].adasResult];
        } else {
            [cell updateA4With:self.items[indexPath.row].adasResult];
        }
        return cell;
    }
   
    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiADASReportTirePreviewCell reuseIdentifier]]) {
        if (tableView == self.tableView) {
            TDD_ArtiADASReportTirePreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiADASReportTirePreviewCell reuseIdentifier] forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            TDD_ArtiReportCellModel *cellModel = self.items[indexPath.row];
            
            [cell update: cellModel.adasTireData];
            return cell;
        } else {
            TDD_ArtiADASReportTirePDFCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiADASReportTirePDFCell reuseIdentifier] forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            TDD_ArtiReportCellModel *cellModel = self.items[indexPath.row];
            
            [cell update: cellModel.adasTireData.asPDFPageRowDatas];
            return cell;
        }
    }

    if ([self.items[indexPath.row].identifier isEqualToString: [TDD_ArtiADASReportFuelPreviewCell reuseIdentifier]]) {
        TDD_ArtiADASReportFuelPreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiADASReportFuelPreviewCell reuseIdentifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        TDD_ArtiReportCellModel *cellModel = self.items[indexPath.row];
        
        if (tableView == self.tableView) {
            [cell update: cellModel.adasFuel];
        } else {
            [cell updateA4: cellModel.adasFuel];
        }
        if (_reportModel.fuelImage) {
            [cell updateImage: _reportModel.fuelImage];
        } else {
            [cell setupImageWithPath: cellModel.adasFuel.imagePath];
        }
        return cell;
    }

    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSMutableAttributedString *)getDtcNodeStatusDescription:(uint32_t)dtcNodeStatus statusStr:(NSString *)dtcNodeStatusStr isPDF:(BOOL)isPDF
{
    
    UIColor *redColor = [UIColor tdd_colorF5222D];
    UIColor *blueColor = [UIColor new];
    UIColor *blackColor = [UIColor new];
    if (isPDF){
        blueColor = [UIColor tdd_pdfDtcStatusNormalColor];
        blackColor = [UIColor tdd_pdfDtcNormalColor];
    }else {
        blueColor = [UIColor tdd_dtcStatusNormalColor];
        blackColor = [UIColor tdd_title];
    }
    UIFont *font = isPDF ? [UIFont systemFontOfSize: 10] : [UIFont systemFontOfSize:14];
    NSMutableArray *dtcCodes = [[NSMutableArray alloc] init];
    
    UIColor *statusColor = blueColor;
    if (dtcNodeStatus == DF_DTC_STATUS_OTHERS) {
        [dtcCodes addObject:@""];
        statusColor = blueColor;
    } else {
        if (dtcNodeStatus & DF_DTC_STATUS_CURRENT) {
            [dtcCodes addObject:TDDLocalized.report_trouble_code_status_curr];
            statusColor = redColor;
        }
        if (dtcNodeStatus & DF_DTC_STATUS_NA) {
            if (isKindOfTopVCI) {
                [dtcCodes addObject:TDDLocalized.diag_ignore];
            }else {
                [dtcCodes addObject:@"N/A"];
            }
            
            statusColor = blueColor;
        }
        if (dtcNodeStatus & DF_DTC_STATUS_HISTORY) {
            [dtcCodes addObject:TDDLocalized.report_trouble_code_status_his];
            statusColor = blueColor;
        }
        if (dtcNodeStatus & DF_DTC_STATUS_PENDING) {
            [dtcCodes addObject:TDDLocalized.report_trouble_code_status_pending];
            statusColor = blueColor;
        }
        if (dtcNodeStatus & DF_DTC_STATUS_TEMP) {
            [dtcCodes addObject:TDDLocalized.report_trouble_code_status_temporary];
            statusColor = blueColor;
        }
    }
    
    
    //TODO: 适配新版
    if (![NSString tdd_isEmpty:dtcNodeStatusStr]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 6;
        paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        return [[NSMutableAttributedString alloc] initWithString:dtcNodeStatusStr attributes:@{ NSForegroundColorAttributeName : statusColor, NSFontAttributeName : font, NSParagraphStyleAttributeName : paragraphStyle }];
    }
    
    NSString *result = [dtcCodes componentsJoinedByString: @"&"];
    NSMutableAttributedString *dtcAttributedString = [NSMutableAttributedString mutableAttributedStringWithLTRString:result];
    [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : blackColor, NSFontAttributeName : font } range:NSMakeRange(0, result.length)];
    [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : redColor } range:[result rangeOfString:TDDLocalized.report_trouble_code_status_curr]];
    [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : blueColor } range:[result rangeOfString:TDDLocalized.report_trouble_code_status_his]];
    [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : blueColor } range:[result rangeOfString:TDDLocalized.report_trouble_code_status_pending]];
    [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : blueColor } range:[result rangeOfString:TDDLocalized.report_trouble_code_status_temporary]];
    if (isKindOfTopVCI) {
        [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : blueColor } range:[result rangeOfString:TDDLocalized.diag_ignore]];
    }else {
        [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : blueColor } range:[result rangeOfString:@"N/A"]];
    }

    return dtcAttributedString;
}

- (void)snapshotTableView:(UInt32)createTime groupId:(NSString *)groupId completion:(void(^)(BOOL success))completion {
    NSLog(@"snapshotTableView: START");
    
    [TDD_HTipManage showLoadingView];
    // 修复滑动后生成报告空白问题
//    [self.tableView setContentOffset:CGPointMake(0, 0)];
    // 修复滑动后生成报告空白问题
    [self.A4SizeTableView setContentOffset:CGPointMake(0, 0)];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(1 * NSEC_PER_SEC));
    dispatch_queue_t queue = dispatch_get_main_queue();//主队列
    dispatch_after(time, queue, ^{
        [self pdfFromUITableView:createTime groupId:groupId];
        NSLog(@"snapshotTableView: STOP");
        [TDD_HTipManage deallocView];
        [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.save_report_success];
        self.modelSaved = YES;
        if (completion) {
            completion(YES);
        }
    });
}


#pragma mark A4尺寸调用的代码
-(void)pdfFromUITableView:(UInt32)createTime groupId:(NSString *)groupId
{
    // A4尺寸打印文档的保存路径
    NSURL * documentPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    if (![NSString tdd_isEmpty:groupId]) {
        NSURL *tempDocumentPath = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:groupId];
        if (tempDocumentPath) {
            documentPath = tempDocumentPath;
        } else {
            [[NSUserDefaults alloc] initWithSuiteName:groupId];
            NSURL *tempDocumentPath1 = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:groupId];
            NSLog(@"获取不到组路径 groupID: %@ - tempDocumentPath1 %@", groupId,tempDocumentPath1);
        }
    }
    
    NSString *filePath = [[documentPath path] stringByAppendingPathComponent:@"A4Size_pdf"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *pdfFileName = self.reportModel.reportRecordName;
    if ([NSString tdd_isEmpty:pdfFileName]) {
        pdfFileName = [self.reportModel generatPdfFileName: self.reportModel.repairIndex];
    }
    
    pdfFileName = [pdfFileName tdd_removeFileSpecialString];
    if (pdfFileName.length > 50) {
        pdfFileName = [pdfFileName substringToIndex:50];
    }
    NSString *date = [[NSDate dateWithTimeIntervalSince1970:createTime] tdd_stringWithFormat:@"yyyy-MM-dd_HH-mm-ss"];
    pdfFileName = [[NSString alloc] initWithFormat:@"%@_%@.pdf", pdfFileName, date];
//    if (self.reportModel.reportRecordName.length > 0) {
//        pdfFileName = [[NSString alloc] initWithFormat:@"%@_%@.pdf", self.reportModel.reportRecordName, @(createTime)];
//    }
    NSString *pdfFilePath = [[[NSURL URLWithString:filePath] path]
                             stringByAppendingPathComponent:pdfFileName];
    // 记录下保存的位置
    self.reportModel.a4pdfPath = pdfFilePath;
    
    // 页眉高度
    CGFloat pageHeaderHeight = 140.0 / 1280.0 * A4Width;
    // 标题栏高度
    CGFloat titleHeight = 50;
    // 页脚高度
    CGFloat pageFooterHeight = 30;
    // 页脚与内容的间隔
    CGFloat pageFooterSpace = 10;
    // 分组
    NSMutableArray *groupArray = [[NSMutableArray alloc] init];
    __block NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    __block CGFloat pageHeight = titleHeight; // 首页需要额外加一个标题栏的高度
    [self.items enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        
        TDD_ArtiReportCellModel *model = (TDD_ArtiReportCellModel *)object;
        pageHeight += model.cellA4Height;
        
        // 计算高度
        CGFloat height = pageHeight + pageHeaderHeight + pageFooterHeight + pageFooterSpace;
        if (height > A4Height) { // 大于A4纸的高度就翻页
            
            [groupArray addObject:[itemArray mutableCopy]];
            pageHeight = model.cellA4Height;
            itemArray = [[NSMutableArray alloc] init];
            [itemArray addObject:object];
        } else {
            [itemArray addObject:object];
        }
        
        if (index == self.items.count - 1) { // 最后一页
            [groupArray addObject:[itemArray mutableCopy]];
            itemArray = [[NSMutableArray alloc] init];
        }
    }];
    
    // 开始页面
    UIGraphicsBeginPDFContextToFile(self.reportModel.a4pdfPath, CGRectMake(0, 0, A4Width, A4Height), nil);
    // 当前页码
    CGFloat currentPageIndex = 0;
    // 总高度
    CGFloat totalCellHeight = 0;
    
    for (int i = 0; i < groupArray.count; i++) {
        @autoreleasepool {
            NSArray<TDD_ArtiReportCellModel*> *tempArray = groupArray[i];
            
            // 当前页的高度
            CGFloat currentPageHeight = 0;
            
            // 开启一个A4纸尺寸的画布
            UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, A4Width, A4Height), nil);
            
            // 获取当前上下文
            CGContextRef headFootContext = UIGraphicsGetCurrentContext();
            
            if isKindOfTopVCI {
                CGContextSaveGState(headFootContext);
                CGContextSetFillColorWithColor(headFootContext, [UIColor whiteColor].CGColor); // [UIColor tdd_colorWithHex:0x232F3D]
                CGContextFillRect(headFootContext, CGRectMake(0, 0, A4Width, A4Height));
                CGContextRestoreGState(headFootContext);
            }
    
            
            // 绘制每一页的页眉
            UIImage *qrImage = nil;
//            if (i == 0 && ![NSString tdd_isEmpty:self.reportModel.reportUrl]) {
//                qrImage = [TDD_QRCodeGenerator generateQRCodeFrom: self.reportModel.reportUrl];
//            }
            TDD_ArtiReportPrintHeaderView *headerView = [[TDD_ArtiReportPrintHeaderView alloc] initWithFrame:CGRectMake(0, 0, A4Width, pageHeaderHeight)];
            headerView.reportModel = self.reportModel;
            headerView.appLogoImage = isKindOfTopVCI ? UIImage.tdd_imageDiagReportHeaderLogo : qrImage;
            [headerView layoutIfNeeded];
            
            CGContextSaveGState(headFootContext);
            CGContextTranslateCTM(headFootContext, 0, currentPageHeight);
//            [headerView.layer renderInContext:headFootContext];
            [headerView drawIn:headFootContext];
            CGContextRestoreGState(headFootContext);
            
            currentPageHeight += pageHeaderHeight;
            
            // 首页需要加标题栏
            if (i == 0) {
                UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, A4Width, titleHeight)];
                titleView.backgroundColor = [UIColor whiteColor];
                TDD_CustomLabel * titleLabel = [[TDD_CustomLabel alloc] initWithFrame:CGRectMake(0, 0, A4Width, titleHeight - 1)];
                titleLabel.center = titleView.center;
                titleLabel.font = [UIFont boldSystemFontOfSize:20];
                titleLabel.textColor = [UIColor tdd_pdfDtcNormalColor];
                titleLabel.text = [NSString tdd_reportTitleDiagnosed];
                titleLabel.textAlignment = NSTextAlignmentCenter;
                
//                UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleHeight - 1, A4Width, 1)];
//                lineView.backgroundColor = UIColor.blackColor;
                TDD_DashLineView *lineView = [[TDD_DashLineView alloc] initWithFrame:CGRectMake(25.0, titleHeight - 1, A4Width - 50.0, 0.5)];
                lineView.dashLineColor = [UIColor tdd_colorWithHex:0x313131];
                lineView.lineDotWidth = 3;
                lineView.lineDotSpacing = 2;
                lineView.backgroundColor = UIColor.clearColor;
                
                [titleView addSubview:titleLabel];
                [titleView addSubview:lineView];
                
                CGContextSaveGState(headFootContext);
                CGContextTranslateCTM(headFootContext, 0, currentPageHeight);
                [titleView drawIn:headFootContext];
//                [titleView.layer renderInContext:headFootContext];
                CGContextRestoreGState(headFootContext);
                
                currentPageHeight += titleHeight;
                
            }
            
            // 绘制每一页的内容
            for (int j = 0; j < tempArray.count; j++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentPageIndex inSection:0];
                currentPageIndex += 1;
                
                [self.A4SizeTableView setContentOffset:CGPointMake(0, totalCellHeight)];
                UITableViewCell *currentCell = [self.A4SizeTableView cellForRowAtIndexPath:indexPath];
                
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextSaveGState(context);
                CGContextTranslateCTM(context, 0, currentPageHeight);
//                [currentCell.layer renderInContext:context];
                [currentCell.contentView drawIn:context];
                
                CGContextRestoreGState(context);
                currentPageHeight = currentPageHeight + tempArray[j].cellA4Height;
                totalCellHeight = totalCellHeight + tempArray[j].cellA4Height;
                
            }
            

            // 绘制每一页的页脚
            currentPageHeight += pageFooterSpace;
//            CGContextTranslateCTM(headFootContext, 0, currentPageHeight);
            CGContextSaveGState(headFootContext);
            CGContextTranslateCTM(headFootContext, 0, A4Height - pageFooterHeight);
            
            UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, A4Width, pageFooterHeight)];
            
            UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage tdd_imageDiagReportPageFooter]];
            bgImageView.frame = footerView.bounds;
            
            TDD_CustomLabel * pageLabel = [[TDD_CustomLabel alloc] initWithFrame:CGRectMake(0, 0, 100, pageFooterHeight - 10)];
            pageLabel.center = CGPointMake(footerView.center.x, pageLabel.center.y);
            pageLabel.font = [UIFont systemFontOfSize:12];
            pageLabel.textColor = [UIColor tdd_pdfDtcNormalColor];
            pageLabel.text = [NSString stringWithFormat:TDDLocalized.pages_no,i+1];
            pageLabel.textAlignment = NSTextAlignmentCenter;
            
            [footerView addSubview:bgImageView];
            [footerView addSubview:pageLabel];
            
//            [footerView.layer renderInContext:headFootContext];
            [footerView drawIn:headFootContext];
            CGContextRestoreGState(headFootContext);

            // 全屏水印
            if isKindOfTopVCI {
                CGContextRef watermarkContext = headFootContext;
                CGContextSaveGState(watermarkContext);
                CGContextTranslateCTM(watermarkContext, 0, 0);
                
                UIImageView *fullPageWatermarkView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, A4Width, A4Height)];
                fullPageWatermarkView.image = UIImage.tdd_imageDiagReportPageWatermark;
                if ([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany) {
                    fullPageWatermarkView.image = nil;
                }
                [fullPageWatermarkView layoutIfNeeded];

                [fullPageWatermarkView drawIn: watermarkContext];
                
                CGContextRestoreGState(watermarkContext);
            }
            
        }
    }
    
    // 结束页面
    UIGraphicsEndPDFContext();
    
    [self.A4SizeTableView setContentOffset:CGPointMake(0, 0)];
}

- (void)setupA4
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, A4Width, A4Height) style:UITableViewStylePlain];
//    tableView.backgroundColor = UIColor.tdd_reportBackground;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
    [self insertSubview:tableView atIndex:0];
    self.A4SizeTableView = tableView;
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 35;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    

    [tableView registerClass:_infoCellClass forCellReuseIdentifier: [_infoCellClass reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportInfosA4Cell class] forCellReuseIdentifier: [TDD_ArtiReportInfosA4Cell reuseIdentifier]];

    [tableView registerClass:[TDD_ArtiReportSummaryTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportSummaryTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportHeaderTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportHeaderTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportTextTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportTextTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportRepairHeaderTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportRepairHeaderTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportRepairSectionTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportRepairSectionTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportRepairRowTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportRepairRowTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportCodeTitleTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportCodeTitleTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportCodeSectionTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportCodeSectionTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportCodeRowTableViewCell class] forCellReuseIdentifier: [TDD_ArtiReportCodeRowTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportFlowSectionTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportFlowSectionTableViewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiReportFlowRowTableViewCell class] forCellReuseIdentifier:[TDD_ArtiReportFlowRowTableViewCell reuseIdentifier]];
    
    // ADAS
    [tableView registerClass:[TDD_ArtiADASReportMessagePreviewCell class] forCellReuseIdentifier:[TDD_ArtiADASReportMessagePreviewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiADASReportImagesPreviewCell class] forCellReuseIdentifier:[TDD_ArtiADASReportImagesPreviewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiADASReportExecuteNoneCell class] forCellReuseIdentifier:[TDD_ArtiADASReportExecuteNoneCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiADASReportExecuteCell class] forCellReuseIdentifier:[TDD_ArtiADASReportExecuteCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiADASReportTirePDFCell class] forCellReuseIdentifier:[TDD_ArtiADASReportTirePDFCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiADASReportFuelPreviewCell class] forCellReuseIdentifier:[TDD_ArtiADASReportFuelPreviewCell reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiADASReportRepairHeaderCell class] forCellReuseIdentifier:[TDD_ArtiADASReportRepairHeaderCell reuseIdentifier]];

}

@end

