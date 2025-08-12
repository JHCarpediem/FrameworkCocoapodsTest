//
//  TDD_ArtiSystemView.m
//  AD200
//
//  Created by 何可人 on 2022/5/25.
//

#import "TDD_ArtiSystemView.h"
#import "TDD_ArtiSystemCellView.h"
#import "TDD_ButtonTableView.h"

#import "TDD_ArtiSystemScanView.h"
#import "TDD_ArtiSystemScoreView.h"
@interface TDD_ArtiSystemView ()<UITableViewDelegate,UITableViewDataSource,TDD_ArtiSystemCellViewDelegate>


@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * cellArr;

@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, strong) NSMutableDictionary * cellHightDic;

@property (nonatomic, strong) TDD_ArtiSystemScanView *scanView;

@property (nonatomic, strong) TDD_ArtiSystemScoreView *scoreView;

@property (nonatomic, assign) CGFloat scale;

@end

@implementation TDD_ArtiSystemView


- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = UIColor.tdd_systemBackgroundColor;
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI {
    
    _scale = IS_IPad ? HD_Height : H_Height;
    if (!isKindOfTopVCI) {
        [self addSubview:self.scanView];
    }
    
    TDD_ButtonTableView *tableView = [[TDD_ButtonTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.clearColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self).offset(0);
    }];
    
    //设行高为自动计算
    tableView.rowHeight = UITableViewAutomaticDimension;
    //预计行高
    tableView.estimatedRowHeight = 60 * _scale;
    
    tableView.estimatedSectionFooterHeight = 0;
    
    tableView.estimatedSectionHeaderHeight = 0;
    
    if (@available(iOS 15.0, *)) {
        tableView.prefetchingEnabled = NO;
    } else {
        // Fallback on earlier versions
    }
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor tdd_systemLineColor];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    static NSString *identify =@"cellIdentify";
    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    NSString *identify = [NSString stringWithFormat:@"Cell%d%d", (int)[indexPath section], (int)[indexPath row]];//以indexPath来唯一确定
    UITableViewCell *cell = nil;
    if (self.cellArr.count < 30) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [self.cellArr addObject:cell];
    }else{
        cell = self.cellArr[indexPath.row % 30];
    }
    
    [self configureCell:cell atIndexpath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexpath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    TDD_ArtiSystemCellView * cellView = [cell.contentView viewWithTag:1000];
    
    if (!cellView) {
        cellView = [[TDD_ArtiSystemCellView alloc] init];
        cellView.tag = 1000;
        cellView.delegate = self;
        [cell.contentView addSubview:cellView];
        
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    
    int row = (int)indexPath.row;
    
    if (row >= self.dataArr.count) {
        return;
    }
    
    ArtiSystemItemModel * itemModel = self.dataArr[row];
    
    //    NSLog(@"itemModel----%f-----:%ld----%d---%@--%@", cell.frame.origin.y, indexPath.row, itemModel.uIndex, itemModel.strItem, itemModel.strStatus);
    
    cellView.index = (int)indexPath.row;
    
    cellView.isShowTranslated = self.systemModel.isShowTranslated;
    
    cellView.systemItemModel = itemModel;
    
    // 设置系统正在扫描状态
    if (self.systemModel.selectItem == itemModel.uIndex) {
        [cellView highlightBackView];
    } else {
        [cellView cancelHighlightBackView];
    }
    
    // 设置记录选中状态
    if ([self.systemModel.selectArray containsObject:@(itemModel.uIndex)]) {
        [cellView setTitleLabelTextColor: [UIColor tdd_reportCodeTitleTextColor]];
    }else {
        [cellView setTitleLabelTextColor:[UIColor tdd_title]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.cellHightDic setObject:@(cell.frame.size.height) forKey:[NSString stringWithFormat:@"%ld_%ld",(long)indexPath.section, (long)indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [[self.cellHightDic objectForKey:[NSString stringWithFormat:@"%ld_%ld",(long)indexPath.section, (long)indexPath.row]] floatValue];
    
    if (height == 0) {
        return (IS_IPad ? 67  : 50) * _scale;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    TDD_ArtiSystemCellView * cellView = [cell.contentView viewWithTag:1000];
    
    [cellView highlightBackView];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    TDD_ArtiSystemCellView * cellView = [cell.contentView viewWithTag:1000];
    
    [cellView cancelHighlightBackView];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.systemModel.scanStatus == DF_SYS_SCAN_START || self.systemModel.clearStatus == DF_SYS_CLEAR_START) {
        return;
    }
    //软件过期
    if ([TDD_DiagnosisTools isLimitedTrialFuction] && ![TDD_DiagnosisTools softWareIsCarPalSeries]) {
        [TDD_DiagnosisTools showSoftExpiredToBuyAlert:nil];
        return;
    }
    int row = (int)indexPath.row;
    
    if (row >= self.dataArr.count) {
        return;
    }
    
    ArtiSystemItemModel * itemModel = self.dataArr[row];
    
    self.systemModel.selectItem = itemModel.uIndex;
    
    if isKindOfTopVCI {
        if (itemModel.uResult >= DF_ENUM_DTCNUM) {
            self.systemModel.returnID = itemModel.uIndex + DF_ID_SYS_DTC_0;
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:[TDD_DiagnosisTools selectedVCISerialNum] forKey:@"SN"];
            [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carBrand?:@"" forKey:@"Make"];
            [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carModel?:@"" forKey:@"Model"];
            [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carYear?:@"" forKey:@"Year"];
            [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVIN?:@"" forKey:@"VIN"];
            [dic setObject:itemModel.strItem?:@"" forKey:@"System"];
            [TDD_Statistics event:Event_Cus_ReadCode attributes:dic];
        } else {
            self.systemModel.returnID = DF_ID_NOKEY;
        }
    } else {
        self.systemModel.returnID = itemModel. uIndex;
    }

    HLog("systemModel返回值：%d", self.systemModel.returnID);
    
    if (![self.systemModel.selectArray containsObject:@(itemModel.uIndex)]) {
        [self.systemModel.selectArray addObject:@(itemModel.uIndex)];
        [TDD_ArtiModelBase updateModel:self.systemModel];
    }
    
    [tableView reloadData];
    
    [self.systemModel conditionSignal];
}

- (void)ArtiSystemCellViewBottomButtonClick:(TDD_ArtiSystemCellView *)cellView
{
    if (self.systemModel.scanStatus == DF_SYS_SCAN_START || self.systemModel.clearStatus == DF_SYS_CLEAR_START) {
        return;
    }
    //软件过期
    if ([TDD_DiagnosisTools isLimitedTrialFuction] && ![TDD_DiagnosisTools softWareIsCarPalSeries]) {
        [TDD_DiagnosisTools showSoftExpiredToBuyAlert:nil];
        return;
    }
    ArtiSystemItemModel * itemModel = cellView.systemItemModel;
    
    self.systemModel.selectItem = itemModel.uIndex;
    
    if isKindOfTopVCI {
        if (itemModel.uResult >= DF_ENUM_DTCNUM) {
            self.systemModel.returnID = itemModel.uIndex + DF_ID_SYS_DTC_0;
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:[TDD_DiagnosisTools selectedVCISerialNum] forKey:@"SN"];
            [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carBrand?:@"" forKey:@"Make"];
            [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carModel?:@"" forKey:@"Model"];
            [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carYear?:@"" forKey:@"Year"];
            [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVIN?:@"" forKey:@"VIN"];
            [dic setObject:itemModel.strItem?:@"" forKey:@"System"];
            [TDD_Statistics event:Event_Cus_ReadCode attributes:dic];
        } else {
            self.systemModel.returnID = DF_ID_NOKEY;
        }
    } else {
        self.systemModel.returnID = itemModel.uIndex;
    }
    HLog("systemModel返回值：%d", self.systemModel.returnID);
    
    if (![self.systemModel.selectArray containsObject:@(itemModel.uIndex)]) {
        [self.systemModel.selectArray addObject:@(itemModel.uIndex)];
        [TDD_ArtiModelBase updateModel:self.systemModel];
    }
    
    [self.tableView reloadData];
    
    [self.systemModel conditionSignal];
}

- (void)ArtiSystemCellViewAdasButtonClick:(TDD_ArtiSystemCellView *)cellView {
    ArtiSystemItemModel * itemModel = cellView.systemItemModel;
    self.systemModel.returnID = itemModel.uIndex + DF_ID_SYS_ADAS_0;
    HLog("点击 adas systemModel返回值：%d", self.systemModel.returnID);
    if (![self.systemModel.selectArray containsObject:@(itemModel.uIndex)]) {
        [self.systemModel.selectArray addObject:@(itemModel.uIndex)];
        [TDD_ArtiModelBase updateModel:self.systemModel];
    }
    
    [self.tableView reloadData];
    
    [self.systemModel conditionSignal];
}

#pragma mark - 设置model
- (void)setSystemModel:(TDD_ArtiSystemModel *)systemModel
{

    
    int row = -1;
    
    BOOL isScrollToSelect = NO;
    
    BOOL isScroll = NO;
    
    if (systemModel.scanStatus == DF_SYS_SCAN_START || systemModel.clearStatus == DF_SYS_CLEAR_START) {
        isScrollToSelect = YES;
    } else {
        if (_systemModel !=  systemModel) {
            isScroll = YES;
        }else {
            isScroll = NO;
        }
    }
    
    _systemModel = systemModel;
    _scanView.etype = _systemModel.eType;

    
    if (_systemModel.isAutoScanEnable) {
        for (TDD_ArtiButtonModel *model in _systemModel.buttonArr) {
            if (model.uButtonId == DF_ID_SYS_START) {
                [_systemModel.delegate ArtiSystemSetAutoEnable:model];
                _systemModel.isAutoScanEnable = NO;
                break;
            }
        }
        
    }
    
    if (systemModel.isDisplayRefresh) {
        systemModel.isDisplayRefresh = NO;
        
        self.dataArr = @[].mutableCopy;
        
        [self.tableView reloadData];
        
        [self.tableView layoutIfNeeded];
        
        [self performSelector:@selector(setSystemModel:) withObject:systemModel afterDelay:0.1];
        
        return;
    }
    
    self.dataArr = systemModel.itemArr.mutableCopy;
    
    //无结果数量
    NSInteger noDataCount = 0;
    
    if (systemModel.isShowActual) {
        //显示实际，删掉不存在的数据
        NSArray * itemArr = [systemModel GetNoDataItems];
        noDataCount = itemArr.count;
        [self.dataArr removeObjectsInArray:itemArr];
    }
    
    //有结果数量
    NSInteger resultCount = 0;
    
    for (int i = 0; i < self.dataArr.count; i ++) {
        ArtiSystemItemModel * itemModel = self.dataArr[i];
        if (itemModel.uIndex == systemModel.selectItem) {
            row = i;
        }
        if (itemModel.uResult>0){
            resultCount++;
        }
    }
    
    if (isKindOfTopVCI) {
        //算分
        if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(diagnosisCustomLoadingView:)]
            && [[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(diagnosisCustomLoadingViewRect:)]) {
            CGRect loadingViewRect = CGRectZero;
            if (!self.scoreView.loadingView){
                UIView *loadingView = [[TDD_DiagnosisManage sharedManage].manageDelegate diagnosisCustomLoadingView:TDD_CustomLoadingType_ScanSystem];
                loadingViewRect = [[TDD_DiagnosisManage sharedManage].manageDelegate diagnosisCustomLoadingViewRect:TDD_CustomLoadingType_ScanSystem];
                self.scoreView.loadingView = loadingView;
                if (_systemModel.score > 0) {
                    [self handleScanResultScore];
                }
            }

            if (self.scoreView.loadingView && systemModel.hadScan){
                if (self.scoreView.hidden) {
                    self.scoreView.hidden = NO;
                    [self.scoreView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.left.right.equalTo(self);
                        make.height.mas_greaterThanOrEqualTo(230 * _scale);
                    }];
                    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.bottom.equalTo(self);
                        make.top.equalTo(self.scoreView.mas_bottom);
                    }];
                    
                }
                
            }else {
                if (self.scoreView.hidden == NO){
                    self.scoreView.hidden = YES;
                    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.bottom.equalTo(self);
                        make.top.equalTo(self).offset(0);
                    }];
                }
            }
            
            if (_systemModel.isStartScan && _systemModel.scanStatus == 2){
                [self handleScanResultScore];
                
            }else if (_systemModel.scanStatus == DF_SYS_SCAN_PAUSE){
                [self.scoreView stopLoading];
            }else if (_systemModel.scanStatus == DF_SYS_SCAN_START){
                _systemModel.score = 0;
                if (!self.scoreView.isLoading){
                    [self.scoreView startLoading];
                }
                
            }
            
            if (_systemModel.clearStatus == DF_SYS_CLEAR_START && _systemModel.isStartClear){
                _systemModel.score = 0;
                if (!self.scoreView.isLoading){
                    [self.scoreView startLoading];
                }
            }else if (_systemModel.clearStatus == DF_SYS_CLEAR_FINISH && _systemModel.isStartClear){
                [self handleScanResultScore];
                
            }
        }
    }else {
        resultCount += noDataCount;
        //扫描进度
        BOOL showScanView = NO;
            
        if (self.systemModel.itemArr.count == 0 && !_scanView.isHidden){
            if (systemModel.isShowActual){
                [self.scanView setProgress:1];
            }else{
                [self.scanView setProgress:0];
            }
            
        }else {
            if (systemModel.clearStatus != -1 && systemModel.scanStatus != DF_SYS_SCAN_START){
                showScanView = YES;
                //显示清码进度
                if (systemModel.clearStatus == DF_SYS_CLEAR_FINISH){
                    [self.scanView setProgress:1];
                }else {
                    if (systemModel.clearStartDtcRowCount > 0) {
                        CGFloat progress = systemModel.clearStartFinishRowCount * 1.0 /systemModel.clearStartDtcRowCount;
                        [self.scanView setProgress:progress];
                    }else {
                        NSLog(@"setProgress systemModel.clearStartDtcRowCount 为空")
                    }

                }
                
            }else if (systemModel.hadScan){
                //显示扫码进度
                showScanView = YES;
                if (self.systemModel.itemArr.count > 0) {
                    CGFloat progress = resultCount * 1.0 /self.systemModel.itemArr.count;
                    [self.scanView setProgress:progress];
                }else {
                    NSLog(@"setProgress systemModel.itemArr.count 为空")
                }

            }
        }
        if (showScanView){
            self.scanView.hidden = NO;
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset((IS_IPad ? 130 : 110) * _scale);
            }];
        }else {
            self.scanView.hidden = YES;
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(0);
            }];

        }
    }
    
    [self.tableView reloadData];
    
    [self.tableView layoutIfNeeded];
    
    if (self.dataArr.count > 0) {
        if ((systemModel.isStartScan && systemModel.scanStatus == DF_SYS_SCAN_FINISH) || (systemModel.isStartClear && systemModel.clearStatus == DF_SYS_CLEAR_FINISH)) {
            if (systemModel.isStartScan && systemModel.scanStatus == DF_SYS_SCAN_FINISH) {
                systemModel.isStartScan = NO;
            }
            
            if (systemModel.isStartClear && systemModel.clearStatus == DF_SYS_CLEAR_FINISH) {
                systemModel.isStartClear = NO;
            }
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }else {
            if (row >= 0) {
                if (self.dataArr.count > row && [self.tableView numberOfRowsInSection:0] > row && (isScrollToSelect || isScroll)) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                        });
                    });
                }
            }
        }
    }
    
    if (!systemModel.bIsLock) {
        [systemModel conditionSignalWithTime:0.1];
    }
}

- (void )handleScanResultScore {

    NSInteger score = 0;

    NSInteger nubCount = 0;
    NSInteger notExistSystemCount = 0;
    //（n÷（2+n）））
    NSMutableArray *deductScoreArr = @[].mutableCopy;
    for (int i = 0; i < self.dataArr.count; i ++) {
        ArtiSystemItemModel * itemModel = self.dataArr[i];
        int nub = itemModel.uResult - DF_ENUM_DTCNUM;
        if (nub < 0) {
            nub = 0;
        }

        nubCount += nub;
        //不存在系统(结果为空当作不存在系统)
        if (itemModel.uResult == DF_ENUM_NOTEXIST || itemModel.uResult <= 0){
            notExistSystemCount += 1;
        }else {
            if (nub > 0){
                [deductScoreArr addObject:@(nub / (nub + 2.0))];
            }
        }
    }

    if ([[TDD_DiagnosisManage sharedManage].carModel.strVehicle.uppercaseString isEqualToString:@"EOBD"]){
        //EOBD 特殊计分
        if (self.dataArr.count == notExistSystemCount){
            score = 0;
        }else if (nubCount == 0){
            score = 100;
        }else {
            score = MAX(0, 95 - nubCount*2);
        }
    }else {
        //正常计分
//        n=0：100分
//        n≥1：95-∑（（40÷系统数 ）x（n÷（5+n）））//旧版
//        n≥1：92-∑（（40÷系统数 ）x（n÷（2+n）））//新版
        if (self.dataArr.count == notExistSystemCount){
            score = 0;
        }else if (nubCount == 0){
            score = 100;
        } else {
            CGFloat sum = 0.0;
            CGFloat preParam = 40.0 / (self.dataArr.count - notExistSystemCount);
            
            HLog(@"%@ - 评分 - 系统数计算参数:%f", [self class],preParam);
            for (NSNumber *deductScore in deductScoreArr) {
                HLog(@"%@ - 评分 - 故障码计算参数:%@", [self class],deductScore);
                CGFloat singleParam = preParam * deductScore.floatValue;
                sum = sum + singleParam;
                HLog(@"%@ - 评分 - 单系统扣分:%f - 计算过程总扣分:%f", [self class],singleParam,sum);
            }
            score = floor(92 - sum);
        }

    }
    HLog(@"%@ - 评分 - 总分:%ld", [self class],(long)score);
    
    _systemModel.score = score;
    self.scoreView.score = score;
    

}

- (void)startTimer
{
    [self.scoreView startLoading];
}

- (void)stopTimer
{
    [self.scoreView stopLoading];
}


- (void)removeFromSuperview
{
    [super removeFromSuperview];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self stopTimer];
}


- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    
    return _dataArr;
}

- (NSMutableArray *)cellArr
{
    if (!_cellArr) {
        _cellArr = [[NSMutableArray alloc] init];
    }
    
    return _cellArr;
}

- (NSMutableDictionary *)cellHightDic
{
    if (!_cellHightDic) {
        _cellHightDic = [[NSMutableDictionary alloc] init];
    }
    
    return _cellHightDic;
}

- (TDD_ArtiSystemScanView *)scanView {
    if (!_scanView) {
        _scanView = [[TDD_ArtiSystemScanView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, (IS_IPad ? 120 : 100) * _scale)];
        _scanView.hidden = YES;
    }
    
    return _scanView;
}

- (TDD_ArtiSystemScoreView *)scoreView {
    if (!_scoreView) {
        _scoreView = [[TDD_ArtiSystemScoreView alloc] initWithFrame:CGRectZero];
        _scoreView.hidden = YES;
        [self addSubview:_scoreView];
    }
    return _scoreView;
}
@end
