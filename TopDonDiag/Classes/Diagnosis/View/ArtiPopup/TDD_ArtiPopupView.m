//
//  TDD_ArtiPopupView.m
//  TopDonDiag
//
//  Created by fench on 2023/8/29.
//

#import "TDD_ArtiPopupView.h"
#import "TDD_ButtonTableView.h"
#import "TDD_ArtiPopupCellView.h"
#import "TDD_ArtiPopupSuggestCellView.h"
#import "TDD_LoadingView.h"
#import "TDD_ArtiTroubleAIGuildView.h"
#import "TDD_DiagnosisViewController.h"
@interface TDD_ArtiPopupView () <UITableViewDelegate, UITableViewDataSource, TDD_ArtiPopupCellViewDelegate,TDD_ArtiPopupSuggestCellViewDelegate>
@property (nonatomic, strong) TDD_ButtonTableView * tableView;
@property (nonatomic, strong) NSMutableArray *faultCodeList;
@property (nonatomic, strong) NSMutableDictionary *resultDict;
@property (nonatomic, assign) BOOL isEobdEngine;
@property (nonatomic, assign) BOOL showSuggestView;
@end

@implementation TDD_ArtiPopupView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor tdd_popupBackground];
        _showSuggestView = [TDD_DiagnosisManage sharedManage].carModel.supportProfessionalTrouble;
        if ([[TDD_DiagnosisManage sharedManage].carModel.strVehicle isEqualToString:@"EOBD"] && [TDD_ArtiGlobalModel sharedArtiGlobalModel].obdEntryType == OET_CARPAL_OBD_ENGINE_CHECK && [TDD_DiagnosisTools softWareIsCarPalSeries]) {
            //carpal 发动机检测的troubleModel 进popView(部分 app trouble与 popup 样式相近 如 carpal) 并且提前使用接口批量获取故障码进入 app 的服务故障码页面
            self.isEobdEngine = YES;
            _showSuggestView = YES;
        }
        [self creatTableView];
    }
    return self;
}

- (void)creatTableView{
    TDD_ButtonTableView *tableView = [[TDD_ButtonTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //设行高为自动计算
    tableView.rowHeight = UITableViewAutomaticDimension;
    //预计行高
    tableView.estimatedRowHeight = 175 * H_Height;

    tableView.estimatedSectionFooterHeight = 0;

    tableView.estimatedSectionHeaderHeight = 0;
    
    [self.tableView setContentInset:UIEdgeInsetsMake(15 * H_Height, 0, 0, 0)];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerIdentify"];
}

- (void)setPopupModel:(TDD_ArtiPopupModel *)popupModel
{
    _popupModel = popupModel;
    [self.tableView reloadData];
}

- (void)setTroubleModel:(TDD_ArtiTroubleModel *)troubleModel {
    _troubleModel = troubleModel;
    [self.tableView reloadData];

    //Carpal2.50版本不需要提前获取
//    if (_isEobdEngine) {
//        //carpal 发动机检测的troubleModel 进popView(部分 app trouble与 popup 样式相近 如 carpal) 并且提前使用接口批量获取故障码进入 app 的服务故障码页面
//        [self loadTroubleList:nil];
//    }

}


/// 根据OBD 获取故障码列表
/// - Parameter faultCode: 故障码
- (void)loadTroubleList:(NSString *)faultCode index:(NSInteger )index {
    
    NSMutableDictionary *param = @{}.mutableCopy;
    NSMutableArray *codeArr = @[].mutableCopy;
    if ([NSString tdd_isEmpty:faultCode]) {
        [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.home_no_data_tips];
        HLog(@"loadTroubleList faultCode为空");
        return;
    }
    [codeArr addObject:faultCode];
    

    [param setValue:codeArr forKey:@"faultCodes"];
    TDD_ArtiTroubleItemModel *item;
    if (_troubleModel.itemArr.count <= index) {
        HLog(@"ArtiTroubleGotoAI 数组越界")
        item = TDD_ArtiTroubleItemModel.new;
    }else {
        item = _troubleModel.itemArr[index];
    }
    NSString * componentLocation = item.strTroubleDesc?:@"";
    [param setValue:componentLocation forKey:@"componentLocation"];
    kWeakSelf(self);
    [TDD_HTipManage showLoadingView];
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_LoadTroubleCodeList param:param completeHandle:^(id  _Nonnull result) {
        kStrongSelf(self);
        [TDD_HTipManage deallocView];
        strongself.faultCodeList = @[].mutableCopy;
        strongself.resultDict = @{}.mutableCopy;
        if (result && [result isKindOfClass:[NSArray class]]){
            NSArray *resultArr = result;
            if (resultArr.count == 1) {
                NSDictionary *dict = resultArr.firstObject;
                NSMutableDictionary *mDict = dict.mutableCopy;
                [mDict setValue:componentLocation forKey:@"componentLocation"];
                [self.troubleModel.delegate ArtiTroubleToTroubleDetail:@[mDict]];
            }else {
                [self.troubleModel.delegate ArtiTroubleGotoAI:self.troubleModel itemIndex:index];
            }
        }else {
            [self.troubleModel.delegate ArtiTroubleGotoAI:self.troubleModel itemIndex:index];
        }

        
    }];
}

- (void)loadAITroubleCodeInfo:(NSString *)code desc:(NSString *)desc {
    NSDictionary *param =  @{@"faultCode":code?:@"", @"componentLocation":desc?:@"",@"carBrandDetailName":TDD_ArtiGlobalModel.sharedArtiGlobalModel.carBrand?:@"",@"carYear":TDD_ArtiGlobalModel.sharedArtiGlobalModel.carYear?:@"",@"carModelDetailName":TDD_ArtiGlobalModel.sharedArtiGlobalModel.carModel?:@""};
    
    kWeakSelf(self);
    [TDD_HTipManage showLoadingView];
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_LoadAITroubleCodeInfo param:param completeHandle:^(id  _Nonnull result) {
        kStrongSelf(self);
        [TDD_HTipManage deallocView];

        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.troubleModel) {
        return self.troubleModel.itemArr.count;
    }
    return self.popupModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify =@"cellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    [self configureCell:cell atIndexpath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexpath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor clearColor];
//    cell.fd_enforceFrameLayout = NO;
    
    UIView * cellView = [cell.contentView viewWithTag:1000];
    
    if (!cellView) {
        if (self.troubleModel){
            cellView = [[TDD_ArtiPopupSuggestCellView alloc] init];
            ((TDD_ArtiPopupSuggestCellView *)cellView).delegate = self;
        }else {
            if ([TDD_DiagnosisTools softWareIsCarPalSeries]){
                cellView = [[TDD_ArtiPopupSuggestCellView alloc] init];
                ((TDD_ArtiPopupSuggestCellView *)cellView).delegate = self;
            }else {
                cellView = [[TDD_ArtiPopupCellView alloc] init];
                ((TDD_ArtiPopupCellView *)cellView).delegate = self;
            }

        }
        
        cellView.tag = 1000;
        
        [cell.contentView addSubview:cellView];
        
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    
    NSInteger index = indexPath.row;
    if (self.troubleModel){
        if (index >= self.troubleModel.itemArr.count) {
            return;
        }
        TDD_ArtiTroubleItemModel * itemModel = self.troubleModel.itemArr[index];
        ((TDD_ArtiPopupSuggestCellView *)cellView).isShowTranslated = self.troubleModel.isShowTranslated;
        ((TDD_ArtiPopupSuggestCellView *)cellView).troubleItemModel = itemModel;


    }else {
        if (index >= self.popupModel.items.count) {
            return;
        }
        TDD_ArtiPopupItemModel * itemModel = self.popupModel.items[index];
        if ([TDD_DiagnosisTools softWareIsCarPalSeries]){
            ((TDD_ArtiPopupSuggestCellView *)cellView).isShowTranslated = self.popupModel.isShowTranslated;
            ((TDD_ArtiPopupSuggestCellView *)cellView).itemModel = itemModel;
        }else {
            ((TDD_ArtiPopupCellView *)cellView).isShowTranslated = self.popupModel.isShowTranslated;
            ((TDD_ArtiPopupCellView *)cellView).itemModel = itemModel;

        }
    }
    //AI 引导
    if ((([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany) || ([TDD_DiagnosisManage sharedManage].functionConfigMask & 1) || ([TDD_DiagnosisTools softWareIsCarPalSeries])) && indexPath.row == 0 && [cellView isKindOfClass:[TDD_ArtiPopupSuggestCellView class]]) {
        BOOL isShowGuild = [[NSUserDefaults standardUserDefaults] boolForKey:TDDDidShowTroubleGuild];
        if (!isShowGuild) {
            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
                [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [((TDD_ArtiPopupSuggestCellView *)cellView) showGuildView];
                });
                
            });
        }
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

- (NSMutableArray *)faultCodeList {
    if (!_faultCodeList) {
        _faultCodeList = [[NSMutableArray alloc] init];
    }
    return _faultCodeList;
}

- (NSMutableDictionary *)resultDict {
    if (!_resultDict) {
        _resultDict = [[NSMutableDictionary alloc] init];
    }
    return _resultDict;
}

#pragma TDD_ArtiPopupCellViewDelegate

- (void)ArtiPopupToTroubleDetailClick:(TDD_ArtiPopupCellView *)cellView {
    UITableViewCell * cell = (UITableViewCell *)cellView;
    
    while (![cell isKindOfClass:[UITableViewCell class]]) {
        cell = (UITableViewCell *)cell.superview;
        if (cell == nil) {
            return;
        }
    }
    if ([self.popupModel.delegate respondsToSelector:@selector(ArtiPopupToTroubleDetail:)]){
        [self.popupModel.delegate ArtiPopupToTroubleDetail:cellView.itemModel.code];
    }
}

#pragma mark TDD_ArtiPopupSuggestCellViewDelegate
- (void)ArtiPopupSuggestCellMoreButtonClick:(TDD_ArtiPopupSuggestCellView *)cellView {
    UITableViewCell * cell = (UITableViewCell *)cellView;
    
    while (![cell isKindOfClass:[UITableViewCell class]]) {
        cell = (UITableViewCell *)cell.superview;
        if (cell == nil) {
            return;
        }
    }
    
    cellView.itemModel.isShowMore = YES;
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    if (indexPath) {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

- (void)ArtiPopupToSuggestDetailClick:(TDD_ArtiPopupSuggestCellView *)cellView {
    UITableViewCell * cell = (UITableViewCell *)cellView;
    
    while (![cell isKindOfClass:[UITableViewCell class]]) {
        cell = (UITableViewCell *)cell.superview;
        if (cell == nil) {
            return;
        }
    }
    
    if ([self.troubleModel.delegate respondsToSelector:@selector(ArtiTroubleToTroubleDetail:)]) {
        if (![NSString tdd_isEmpty:cellView.troubleItemModel.strTroubleCode]){
            NSArray *arr = self.resultDict[cellView.troubleItemModel.strTroubleCode];
            [self.troubleModel.delegate ArtiTroubleToTroubleDetail:arr?:@[]];
        }
    }else if ([self.popupModel.delegate respondsToSelector:@selector(ArtiPopupToTroubleDetail:)]){
        [self.popupModel.delegate ArtiPopupToTroubleDetail:cellView.itemModel.code];
    }
}

- (void)ArtiPopupToTroubleXMLDetailClick:(TDD_ArtiPopupSuggestCellView *)cellView {
    UITableViewCell * cell = (UITableViewCell *)cellView;
    
    while (![cell isKindOfClass:[UITableViewCell class]]) {
        cell = (UITableViewCell *)cell.superview;
        if (cell == nil) {
            return;
        }
    }
    if (self.troubleModel) {
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        
        self.troubleModel.returnID = 0x40000000 + (uint32_t)indexPath.row;
        
        [self.troubleModel conditionSignal];
    }

}

- (void)ArtiPopupFuctionButtonClick:(UIButton *)button {
    
    UITableViewCell * cell = (UITableViewCell *)button.superview;
    
    while (![cell isKindOfClass:[UITableViewCell class]]) {
        cell = (UITableViewCell *)cell.superview;
        if (cell == nil) {
            return;
        }
    }
    
    if (button.tag == 103) {
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        if (self.troubleModel) {
            self.troubleModel.returnID = (uint32_t)indexPath.row;
            
            [self.troubleModel conditionSignal];
        }else if (self.popupModel){
            self.popupModel.returnID = (uint32_t)indexPath.row;
            
            [self.popupModel conditionSignal];
        }

    }
    
    if (button.tag == 104) {
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        NSString *code = @"";
        NSString *desc = @"";
        if (self.troubleModel) {
            if (indexPath.row < self.troubleModel.itemArr.count) {
                TDD_ArtiTroubleItemModel * itemModel = self.troubleModel.itemArr[indexPath.row];
                code = itemModel.strTroubleCode;
                desc = itemModel.strTroubleDesc;
            }
            
        }else {
            if (indexPath.row < self.popupModel.items.count) {
                TDD_ArtiPopupItemModel *itemModel = self.popupModel.items[indexPath.row];
                code = itemModel.code;
                desc = itemModel.content;
            }
        }
        NSString *referrer = @"HealthCheckCode";
        if (_isEobdEngine) {
            referrer = @"EngineCode";
            [self loadTroubleList:code index:indexPath.row];
        }else {
            //调 AI 接口
            [self loadAITroubleCodeInfo:code desc:desc];
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:referrer forKey:@"Referrer"];
        [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carBrand?:@"" forKey:@"Make"];
        [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carModel?:@"" forKey:@"Model"];
        [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carYear?:@"" forKey:@"Year"];
        [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVIN?:@"" forKey:@"VIN"];
        [dic setObject:code?:@"" forKey:@"Code"];
        [TDD_Statistics event:Event_Cus_ClickTopFix attributes:dic];
    }
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    
    if (_popupModel.items.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"VCdealloc" object:[self class]];
    [TDD_LoadingView resetStatic];
}


@end
