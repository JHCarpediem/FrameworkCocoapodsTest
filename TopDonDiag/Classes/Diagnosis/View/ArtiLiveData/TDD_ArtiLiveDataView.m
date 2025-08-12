//
//  TDD_ArtiLiveDataView.m
//  AD200
//
//  Created by 何可人 on 2022/5/30.
//

#import "TDD_ArtiLiveDataView.h"
#import "TDD_ArtiLiveDataCellView.h"
#import "TDD_ArtiLiveDataSetModel.h"
#import "TDD_ArtiLiveDataRecordeView.h"
#import "TDD_DataFlowModel.h"
#import "TDD_ArtiGlobalModel.h"
#import "TDD_StdCommModel.h"
#import "TDD_ArtiLiveDataMoreChartModel.h"
#import "TDD_ButtonTableView.h"
#import "TDD_ArtiLiveDataRecordeSaveModel.h"

#import "TDD_HChartModel.h"
#import "TDD_BaseViewController.h"
#import "TDD_EmptyView.h"

@interface TDD_ArtiLiveDataView ()<UITableViewDelegate,UITableViewDataSource,TDD_ArtiLiveDataModelDelegata,TDD_ArtiLiveDataCellViewDelegate>

@property (nonatomic, strong) TDD_ButtonTableView * tableView;

@property (nonatomic, strong) NSMutableArray * cellArr;

@property (nonatomic, strong) TDD_EmptyView * emptyView;

@property (nonatomic, strong) TDD_ArtiLiveDataRecordeView * recordeView;

@property (nonatomic,assign) BOOL isScroll;

@property (nonatomic,assign) BOOL isRecorde;

@property (nonatomic, strong) TDD_DataFlowModel * dataFlowModel;

@property (nonatomic, strong) NSMutableDictionary * cellHightDic;

@property (nonatomic, strong) dispatch_semaphore_t recordSemaphore;

@property (nonatomic, strong) dispatch_queue_t recordQueue;

@property (nonatomic, strong) NSMutableArray *saveModelArr;
/// 首次获取刷新项
@property (nonatomic,assign) BOOL isFirstGetUpdateItem;

@end

@implementation TDD_ArtiLiveDataView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = UIColor.tdd_viewControllerBackground;
        _isFirstGetUpdateItem = YES;
        self.recordSemaphore = dispatch_semaphore_create(2);
        self.recordQueue = dispatch_queue_create("ArtiLiveDataRecordQueue", DISPATCH_QUEUE_SERIAL);
        self.saveModelArr = [NSMutableArray array];
        [self creatUI];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recordeButtonClick) name:@"ArtiLiveData_RecordeButtonClick" object:nil];
    }
    
    return self;
}

- (void)creatUI{
    TDD_ButtonTableView *tableView = [[TDD_ButtonTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.clearColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
//    tableView.showsVerticalScrollIndicator = YES;
//    tableView.showsHorizontalScrollIndicator = YES;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //设行高为自动计算
    tableView.rowHeight = UITableViewAutomaticDimension;
    //预计行高
    tableView.estimatedRowHeight = 95 * H_Height;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    //[self.tableView setContentInset:UIEdgeInsetsMake(15 * H_Height, 0, 0, 0)];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerIdentify"];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDragWithAccessory;
    if (![TDD_DiagnosisTools softWareIsCarPalSeries]) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, 10)];
        footView.backgroundColor = UIColor.clearColor;
        UIColor *sepLineColor = [UIColor tdd_liveDataSepLineColor];
        [footView tdd_addLine:TDD_LinePositionTypeBottom lineTag:888888 lineWidth:10 lineColor:sepLineColor edgeInsets:UIEdgeInsetsZero];
        UIView *lineView = [footView viewWithTag:888888];
        [lineView tdd_addLine:TDD_LinePositionTypeTop lineTag:10000001 lineWidth:0.5 lineColor:UIColor.tdd_line edgeInsets:UIEdgeInsetsZero];
        [lineView tdd_addLine:TDD_LinePositionTypeBottom lineTag:10000001 lineWidth:0.5 lineColor:UIColor.tdd_line edgeInsets:UIEdgeInsetsZero];
        tableView.tableFooterView = footView;
    }

    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, 10)];
    footView.backgroundColor = UIColor.clearColor;
    UIColor *sepLineColor = [UIColor tdd_liveDataSepLineColor];
    [footView tdd_addLine:TDD_LinePositionTypeBottom lineTag:888888 lineWidth:10 lineColor:sepLineColor edgeInsets:UIEdgeInsetsZero];
    UIView *lineView = [footView viewWithTag:888888];
    [lineView tdd_addLine:TDD_LinePositionTypeTop lineTag:10000001 lineWidth:0.5 lineColor:UIColor.tdd_line edgeInsets:UIEdgeInsetsZero];
    [lineView tdd_addLine:TDD_LinePositionTypeBottom lineTag:10000001 lineWidth:0.5 lineColor:UIColor.tdd_line edgeInsets:UIEdgeInsetsZero];
    tableView.tableFooterView = footView;
    
    [self addSubview:self.emptyView];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.freezeModel) {
        return self.freezeModel.groupArr.count;
    }
    return self.liveDataModel.showItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identify = [NSString stringWithFormat:@"Cell%d%d", (int)[indexPath section], (int)[indexPath row]];//以indexPath来唯一确定
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        if (self.cellArr.count < 15) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            [self.cellArr addObject:cell];
        }else{
            cell = self.cellArr[indexPath.row % 15];
        }
    }
    [self configureCell:cell atIndexpath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexpath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    TDD_ArtiLiveDataCellView * cellView = [cell.contentView viewWithTag:1000];
    if (!cellView) {
        cellView = [[TDD_ArtiLiveDataCellView alloc] init];
        cellView.tag = 1000;
        cellView.delegate = self;
        [cell.contentView addSubview:cellView];
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        
    }
    
    if (self.freezeModel) {
        int row = (int)indexPath.row;
        if (row >= self.freezeModel.groupArr.count) {
            return;
        }
        TDD_ArtiFreezeItemModel * itemModel = self.freezeModel.groupArr[row];
        cellView.isShowTranslated = self.freezeModel.isShowTranslated;
        cellView.freezeItemModel = itemModel;
        
    }else {
        cellView.isPlay = self.isPlay;
        int row = (int)indexPath.row;
        if (row >= self.liveDataModel.showItems.count) {
            return;
        }
        TDD_ArtiLiveDataItemModel * itemModel = self.liveDataModel.showItems[row];
        cellView.model = self.liveDataModel;
        cellView.itemModel = itemModel;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.cellHightDic setObject:@(cell.frame.size.height) forKey:[NSString stringWithFormat:@"%ld_%ld",(long)indexPath.section, (long)indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [[self.cellHightDic objectForKey:[NSString stringWithFormat:@"%ld_%ld",(long)indexPath.section, (long)indexPath.row]] floatValue];
    
    if (height == 0) {
        return 95 * H_Height;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.liveDataModel.scrollRow = (int)indexPath.row;
}

#pragma mark - 设置model
- (void)setLiveDataModel:(TDD_ArtiLiveDataModel *)liveDataModel {
    NSLog(@"调用了setLiveData");
    
    //录制中
    if (self.isRecorde) {
        NSString *createTime = self.dataFlowModel.createTime;
        NSString *recordChangeDictStr = [liveDataModel.recordChangeDict yy_modelToJSONString];
        NSString *recordChangeItemDictStr = [liveDataModel.recordChangeItemDict yy_modelToJSONString];
        @autoreleasepool {
            TDD_ArtiLiveDataRecordeModel *recordMode = [[TDD_ArtiLiveDataRecordeModel alloc] init];
            recordMode.createTime = createTime;
            //保存录制过程中修改的数据
            recordMode.recordChangeDictStr = recordChangeDictStr;
            recordMode.recordChangeItemDictStr = [liveDataModel.recordChangeItemDict yy_modelToJSONString];
            //缓存后重置
            liveDataModel.recordChangeDict = @{}.mutableCopy;
            liveDataModel.recordChangeItemDict = @{}.mutableCopy;
            [recordMode save];
        }
    }

    BOOL isScroll = NO;
    if (self->_liveDataModel != liveDataModel) {
        if (!self.isPlay) {
            isScroll = YES;
        }
        self->_liveDataModel = liveDataModel;
        self->_liveDataModel.delegate = self;
        
    }
    
    [self.tableView reloadData];
    if (isScroll && liveDataModel.showItems.count > 0) {
        //数据刷新滚动到首行
        [self.tableView layoutIfNeeded];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
    }
    self.emptyView.hidden = self.liveDataModel.showItems.count > 0;
    _tableView.tableFooterView.hidden = !self.emptyView.hidden;
    [liveDataModel conditionSignalWithTime:0.1];
    
    self.emptyView.hidden = self.liveDataModel.showItems.count > 0;
}

- (void)setupTableFootView {
    
    NSArray *array;
    if (self.freezeModel) {
        array = self.freezeModel.groupArr;
    } else {
        array = self.liveDataModel.showItems;
    }
    if (array.count == 0) {
        self.tableView.tableFooterView = [[UIView alloc] init];
    } else {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, 10)];
        footView.backgroundColor = UIColor.clearColor;
        UIColor *sepLineColor = [UIColor tdd_liveDataSepLineColor];
        [footView tdd_addLine:TDD_LinePositionTypeBottom lineTag:888888 lineWidth:10 lineColor:sepLineColor edgeInsets:UIEdgeInsetsZero];
        UIView *lineView = [footView viewWithTag:888888];
        [lineView tdd_addLine:TDD_LinePositionTypeTop lineTag:10000001 lineWidth:0.5 lineColor:UIColor.tdd_line edgeInsets:UIEdgeInsetsZero];
        [lineView tdd_addLine:TDD_LinePositionTypeBottom lineTag:10000001 lineWidth:0.5 lineColor:UIColor.tdd_line edgeInsets:UIEdgeInsetsZero];
        self.tableView.tableFooterView = footView;
    }
}

- (void)setFreezeModel:(TDD_ArtiFreezeModel *)freezeModel
{
    if (_freezeModel != freezeModel) {
        _freezeModel = freezeModel;
        
    }
    [self.tableView reloadData];
    
    self.emptyView.hidden = self.freezeModel.groupArr.count > 0;
}

#pragma mark TDD_ArtiLiveDataModelDelegata
/// 获取需要刷新项
- (NSArray *)GetUpdateItems
{
    __block NSArray * indexPaths;
    //获取当前屏幕显示的 cell
    if ([NSThread isMainThread]) {
        [self.tableView layoutIfNeeded];
        indexPaths = [self.tableView indexPathsForVisibleRows];
    }else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView layoutIfNeeded];
            indexPaths = [self.tableView indexPathsForVisibleRows];
        });
    }
    
    NSMutableArray * resultArr = [[NSMutableArray alloc] init];
    
    //把当前屏幕的 cell 加到数组
    for (NSIndexPath * indexPath in indexPaths) {
        int row = (int)indexPath.row;
        if (row >= self.liveDataModel.showItems.count) {
            continue;
        }
        TDD_ArtiLiveDataItemModel * itemModel = self.liveDataModel.showItems[row];
        [resultArr addObject:@(itemModel.index)];
    }
    if (_isFirstGetUpdateItem) {
        //初次获取时如果屏幕的 cell 少于 10 个时，补成最多 10 个
        if (resultArr.count < 10) {
            for (TDD_ArtiLiveDataItemModel *itemModel in self.liveDataModel.showItems) {
                if (![resultArr containsObject:@(itemModel.index)]) {
                    [resultArr addObject:@(itemModel.index)];
                    if (resultArr.count >= 10) {
                        break;
                    }
                }
            }
        }
        //改为非初次获取
        _isFirstGetUpdateItem = NO;
    }
    
    return resultArr;
}

/// 获取搜索项
- (NSArray *)GetSearchItems {
    
    NSMutableArray * resultArr = [[NSMutableArray alloc] init];
    if (![NSString tdd_isEmpty:self.liveDataModel.searchKey] && self.liveDataModel.searchItems.count > 0) {
        NSMutableArray * arr = self.liveDataModel.searchItems.mutableCopy;
        for (TDD_ArtiLiveDataItemModel *model in arr) {
            if (model.index >= 0){
                [resultArr addObject:@(model.index)];
            }
        }
    }
    return resultArr;
}

/// 获取选中项
- (NSArray *)GetSelectedItems {
    
    NSMutableArray * resultArr = [[NSMutableArray alloc] init];
    if (self.liveDataModel.selectItmes.count > 0) {
        NSMutableArray * arr = self.liveDataModel.selectItmes.mutableCopy;
        for (TDD_ArtiLiveDataItemModel *model in arr) {
            if (model.index >= 0){
                [resultArr addObject:@(model.index)];
            }
        }
    }
    return resultArr;
}

/// 获取修改过范围的项
- (NSArray *)GetModifyLimitItems {
    NSMutableArray * resultArr = [[NSMutableArray alloc] init];
    NSMutableArray * arr = self.liveDataModel.showItems.mutableCopy;
    for (TDD_ArtiLiveDataItemModel *model in arr) {
        if (model.index >= 0 && model.setHasChange){
            [resultArr addObject:@(model.index)];
        }
    }

    return resultArr;
}

- (NSArray *)GetReportItems {
    
    NSMutableArray * resultArr = [[NSMutableArray alloc] init];
    NSMutableArray * arr = self.liveDataModel.showItems.mutableCopy;
    for (TDD_ArtiLiveDataItemModel *model in arr) {
        if (model.index >= 0){
            [resultArr addObject:@(model.index)];
        }
    }
    
    return resultArr;
    
}

- (BOOL)GetItemIsUpdateWithUIndex:(uint32_t)uIndex
{
    return YES;
}

#pragma mark - cellView代理
#pragma mark 设置按钮点击回调
- (void)TDD_ArtiLiveDataCellViewMoreButtonClick:(TDD_ArtiLiveDataItemModel *)itemModel
{
    if (self.isRecorde) {
        [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.live_record_switch_tip];
        return;
    }
    self.liveDataModel.isShowOtherView = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TDD_ArtiLiveDataSetModel * setModel = [[TDD_ArtiLiveDataSetModel alloc] init];
        setModel.itemModel = itemModel;
        setModel.liveDataModel = self.liveDataModel;
        setModel.strTitle = TDDLocalized.app_setting;
        setModel.isHideBottomView = YES;
        [setModel show];
    });
    
    [TDD_Statistics event:Event_ClickLiveDataSet attributes:nil];
}

- (void)TDD_ArtiLiveDataCellViewChartButtonClick:(TDD_ArtiLiveDataItemModel *)itemModel
{
    if (self.isRecorde) {
        [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.live_record_switch_tip];
        return;
    }
    HLog(@"点击charts");
    self.liveDataModel.isShowOtherView = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TDD_ArtiLiveDataMoreChartModel * chartModel = [[TDD_ArtiLiveDataMoreChartModel alloc] init];
        chartModel.liveDataModel = self.liveDataModel;
        chartModel.selectItmes = @[itemModel].mutableCopy;
        chartModel.strTitle = TDDLocalized.liveData_chart_more;
        [chartModel show];
    });
}

#pragma mark 保存数据流
- (void)recordeButtonClick
{
    HLog(@"点击保存数据流");
    [TDD_HTipManage showLoadingView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.liveDataModel.isRecording = YES;
        [self.liveDataModel reloadButtonData];
        TDD_ArtiLiveDataModel * model = [self.liveDataModel yy_modelCopy];
        model = [model copy];
        model.isSearch = self.liveDataModel.isSearch;
        //保存记录目录
        TDD_DataFlowModel * dataFlowModel = [[TDD_DataFlowModel alloc] init];
        dataFlowModel.createTime = [NSString stringWithFormat:@"%.0f", [NSDate tdd_getTimestampSince1970]];
        dataFlowModel.sn = [TDD_DiagnosisTools selectedVCISerialNum];
        dataFlowModel.VIN = [TDD_ArtiGlobalModel GetVIN];
        dataFlowModel.app_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];;
        dataFlowModel.vci_version = [TDD_EADSessionController sharedController].vciInitModel.fwVersion;
        dataFlowModel.vehicle_name = self.carModel.strVehicle;
        dataFlowModel.vehicle_version = self.carModel.strVersion;
        dataFlowModel.firstStrData = [model yy_modelToJSONString];
        dataFlowModel.dataVersion = @"V2.00";
        self.dataFlowModel = dataFlowModel;
        self.isRecorde = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [TDD_HTipManage deallocView];
            TDD_ArtiLiveDataRecordeView * view = [[TDD_ArtiLiveDataRecordeView alloc] init];
            self.recordeView = view;
            
            __weak typeof(view) weakView = view;
            @kWeakObj(self)
            view.stopBlock = ^{
                @kStrongObj(self)
                self.isRecorde = NO;
                self.liveDataModel.isRecording = NO;
                [self.liveDataModel reloadButtonData];
            };
            
            view.completeBlock = ^(NSString * _Nullable text, BOOL isOK, BOOL isBack) {
                @kStrongObj(self)
                [TDD_HTipManage showLoadingView];
                self.liveDataModel.isRecording = NO;
                [self.liveDataModel reloadButtonData];
                [self recordComplete:text success:isOK isBack:isBack recordView:weakView];
            };
            
            [FLT_APP_WINDOW addSubview:view];
        });
    });
}
///录制完成
- (void)recordComplete:(NSString *)title success:(BOOL)success isBack:(BOOL)isBack recordView:(TDD_ArtiLiveDataRecordeView *)recordView{//
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int index = 0;
        self.dataFlowModel.name = title;
        BOOL isSave = NO;
        BOOL isSaved = NO;
        int pageSize = 200;
        if (!success) {
            while (1) {
                @autoreleasepool {
                    //分页读取 数据库数据 防止数据量过大 导致OOM 内存过大崩溃
                    NSArray * saveArr = [TDD_ArtiLiveDataRecordeModel findByCriteria:[NSString stringWithFormat:@"where createTime = '%@' LIMIT (%d * %d) , %d", self.dataFlowModel.createTime, index, pageSize, pageSize]];
                    if (!success) {
                        [TDD_ArtiLiveDataRecordeModel deleteObjects:saveArr];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [TDD_HTipManage deallocView];
                            if (isBack){
                                //返回上一页
                                TDD_BaseViewController *diagVC = (TDD_BaseViewController *)[UIViewController tdd_topViewController];
                                if ([diagVC isKindOfClass:[TDD_BaseViewController class]]) {
                                    [diagVC backClick];
                                }
                                
                            }
                        });
                        return;
                    }
                    // 当取出的数组数量不满一页 表示数据全部取完了 退出循环
                    if (saveArr.count < pageSize) {
                        break;
                    }
                }
                index += 1;
            }
        }else {
            if (!isSaved) {
                isSave = [self.dataFlowModel save];
                isSaved = YES;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isSave) {
                [TDD_HTipManage deallocView];
                [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.tip_save_success];
                [recordView unInit];
            }else {
                [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.liveData_save_error];
            }
            if (isBack){
                TDD_BaseViewController *diagVC = (TDD_BaseViewController *)[UIViewController tdd_topViewController];
                if ([diagVC isKindOfClass:[TDD_BaseViewController class]]) {
                    [diagVC backClick];
                }
            }
        });
    });
}

- (void)autoSaveVideo {
    if (self.recordeView) {
        [self.recordeView autoStopVideo];
        [TDD_HTipManage deallocView];
    }
}

#pragma Lazy
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

- (TDD_EmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[TDD_EmptyView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight - NavigationHeight - 60)];
        [_emptyView setEmptyImageWidth:200 height:200];
        _emptyView.hidden = YES;
    }
    return _emptyView;
}

- (void)dealloc
{
    self.liveDataModel.delegate = nil;
    HLog(@"%s", __func__);
}

- (void)removeFromSuperview
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"VCdealloc" object:[self class]];
    [super removeFromSuperview];
}

@end
