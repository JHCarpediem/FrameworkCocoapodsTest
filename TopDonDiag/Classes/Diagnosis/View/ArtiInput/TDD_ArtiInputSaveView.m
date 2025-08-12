//
//  TDD_ArtiInputSaveView.m
//  AD200
//
//  Created by 何可人 on 2022/5/12.
//

#import "TDD_ArtiInputSaveView.h"
#import "TDD_ArtiInputSaveModel.h"
#import "TDD_ArtiInputSaveCellView.h"
@interface TDD_ArtiInputSaveView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat leftSpace;
@end

@implementation TDD_ArtiInputSaveView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
        _leftSpace = (IS_IPad ? 40 : 20) * _scale;
        self.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
        
        [self creatTableView];
    }
    
    return self;
}

- (void)creatTableView{
    UIView * backView = [[UIView alloc] init];
    backView.backgroundColor = UIColor.clearColor;//[HBlackColor colorWithAlphaComponent:0.5];
    [self addSubview:backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(remove)];
    [backView addGestureRecognizer:tap];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView * whiterView = [[UIView alloc] init];
    whiterView.backgroundColor = UIColor.tdd_btnBackground;
    whiterView.layer.cornerRadius = 5;
    whiterView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1400].CGColor;
    whiterView.layer.shadowOffset = CGSizeMake(0,2);
    whiterView.layer.shadowOpacity =  1;
    whiterView.layer.shadowRadius = 4.f;
    [self addSubview:whiterView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor tdd_inputHistoryCellBackground];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
    tableView.layer.cornerRadius = 4 * _scale;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(IphoneWidth - _leftSpace * 2 * _scale, IphoneHeight / 2));
    }];
    
    [whiterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableView).insets(UIEdgeInsetsMake(-2 * _scale, -1 * _scale, -2 * _scale, -1 * _scale));
    }];
    
    //设行高为自动计算
    tableView.rowHeight = UITableViewAutomaticDimension;
    //预计行高
    tableView.estimatedRowHeight = 44 * _scale;
    
//    self.tableView.fd_debugLogEnabled = YES;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
}

- (void)setClickPoint:(CGPoint)clickPoint {
    _clickPoint = clickPoint;

}

- (void)setItemModel:(ArtiInputItemModel *)itemModel
{
    [self setItemModel:itemModel shouldHide:true];

}

- (void)setItemModel:(ArtiInputItemModel *)itemModel shouldHide:(BOOL )shouldHide {
    
    _itemModel = itemModel;
    if (itemModel.isDropDownBox) {
        NSMutableArray * dataArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < itemModel.vctValue.count; i ++) {
            TDD_ArtiInputSaveModel * model = [[TDD_ArtiInputSaveModel alloc] init];
            model.value = itemModel.vctValue[i];
            [dataArr addObject:model];
        }
        self.dataArr = dataArr;
    }else {
        self.dataArr = [TDD_ArtiInputSaveModel findByCriteria:[NSString stringWithFormat:@"WHERE path = '%@' and mask = '%@'", TDD_ArtiGlobalModel.sharedArtiGlobalModel.CarName, itemModel.strMask]];
        self.dataArr = [[self.dataArr reverseObjectEnumerator] allObjects];
    }
    if (shouldHide) {
        shouldHide = self.superview;
    }
    if (self.dataArr.count && !shouldHide) {
        [FLT_APP_WINDOW addSubview:self];
        CGFloat height = 0;
        for (TDD_ArtiInputSaveModel * saveModel in self.dataArr) {
          height +=  (20 * _scale + [NSString tdd_getHeightWithText:saveModel.value width:(IphoneWidth - _leftSpace * 2 - 24 * _scale) fontSize:[[UIFont systemFontOfSize:13] tdd_adaptHD]]);
            if (height >= 250 * _scale) {
                height = 250 * _scale;
                break;
            }
            
        }
        //float h = MIN(250 * _scale, self.dataArr.count * 50) ;
        BOOL showInTop = ((self.clickPoint.y + 45 * _scale + height) > IphoneHeight);
        float y = (showInTop ? (self.clickPoint.y - height - 25 * _scale) : (self.clickPoint.y + 45 * _scale));
        [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(y);
            make.size.mas_equalTo(CGSizeMake(IphoneWidth - _leftSpace * 2, height + 44 * _scale));
        }];
        [self layoutIfNeeded];
        [self.tableView reloadData];
    }else {
        [self remove];
    }
    
}

+ (NSInteger )historyRecordCount:(ArtiInputItemModel *)itemModel {
    NSArray *dataArr = [TDD_ArtiInputSaveModel findByCriteria:[NSString stringWithFormat:@"WHERE path = '%@' and mask = '%@'", TDD_ArtiGlobalModel.sharedArtiGlobalModel.CarName, itemModel.strMask]];
    return dataArr.count;
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify =@"cellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    [self configureCell:cell atIndexpath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexpath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
//    cell.fd_enforceFrameLayout = NO;
    TDD_ArtiInputSaveCellView *cellView = [cell.contentView viewWithTag:1000];
    @kWeakObj(self);
    TDD_ArtiInputSaveModel * saveModel = self.dataArr[indexPath.row];
    if (!cellView) {
        cellView = [[TDD_ArtiInputSaveCellView alloc] init];
        cellView.tag = 1000;
        cellView.deleteBlock = ^(NSInteger index) {
            @kStrongObj(self);
            TDD_ArtiInputSaveModel * deleteModel = self.dataArr[index];
            BOOL isSuccess =  [deleteModel deleteObject];
            [self setItemModel:self.itemModel shouldHide:(self.dataArr.count == 1)];
        };
        [cell.contentView addSubview:cellView];
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }

    cellView.saveModel = saveModel;
    cellView.index = indexPath.row;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    TDD_ArtiInputSaveCellView * cellView = [cell.contentView viewWithTag:1000];
    
    cellView.titleLab.textColor = [UIColor tdd_colorDiagTheme];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    TDD_ArtiInputSaveCellView * cellView = [cell.contentView viewWithTag:1000];
    
    cellView.titleLab.textColor = [UIColor tdd_title];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(TDD_ArtiInputSaveViewDidSelect:)]) {
        
        NSInteger index = indexPath.row;
        
        if (index >= self.dataArr.count) {
            return;
        }
        
        TDD_ArtiInputSaveModel * saveModel = self.dataArr[index];
        
        [self.delegate TDD_ArtiInputSaveViewDidSelect:saveModel.value];
    }
    
    [self remove];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44 * _scale;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIButton *clearAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearAllBtn setTitle:TDDLocalized.clear_all forState:UIControlStateNormal];
    [clearAllBtn setTitleColor:[UIColor tdd_colorDiagTheme] forState:UIControlStateNormal];
    clearAllBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    clearAllBtn.frame = CGRectMake(0, 0, IphoneWidth - _leftSpace * 2 * _scale, 44 * _scale);
    [clearAllBtn addTarget:self action:@selector(clearAll) forControlEvents:UIControlEventTouchUpInside];
    clearAllBtn.backgroundColor = [UIColor tdd_alertBg];
    return clearAllBtn;
}

- (void)clearAll {
    @kWeakObj(self);
    [TDD_HTipManage showBtnTipViewWithTitle:TDDLocalized.app_tip content:TDDLocalized.clear_all_history_tips buttonType:HTipBtnTwoType block:^(NSInteger btnTag) {
        @kStrongObj(self);
        if (btnTag == 1) {
            BOOL isSuccess =  [TDD_ArtiInputSaveModel deleteObjects:self.dataArr];
            if (isSuccess) {
                self.dataArr = @[];
            }
        }
        [self remove];
    }];
    
    
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    
    if (self.dataArr.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)remove
{
    if ([self.delegate respondsToSelector:@selector(tdd_artiInputRemoveView:)]){
        [self.delegate tdd_artiInputRemoveView:(self.dataArr.count == 0)];
    }
    [self removeFromSuperview];
}

@end
