//
//  TDD_ArtiLiveDataSelectView.m
//  AD200
//
//  Created by 何可人 on 2022/8/8.
//

#import "TDD_ArtiLiveDataSelectView.h"
#import "TDD_EmptyView.h"

@interface TDD_ArtiLiveDataSelectView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) TDD_EmptyView * emptyView;

@property (nonatomic, strong) NSMutableArray * cellArr;

@property (nonatomic, strong) NSMutableArray * selectItmes; //选中的item

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation TDD_ArtiLiveDataSelectView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = UIColor.tdd_viewControllerBackground;

        [self creatUI];
    }
    
    return self;
}

- (void)setLiveDataSelectModel:(TDD_ArtiLiveDataSelectModel *)liveDataSelectModel
{
    _liveDataSelectModel = liveDataSelectModel;
    
    [_liveDataSelectModel updateShowLiveData];
    
    self.selectItmes = [NSMutableArray arrayWithArray:_liveDataSelectModel.selectItmes];
    
    [self.liveDataSelectModel setEditBtnTitle];
    
    [self.tableView reloadData];
    
    self.emptyView.hidden = self.liveDataSelectModel.showItems.count > 0;

}

- (void)setLiveDataChartSelectModel:(TDD_ArtiLiveDataChartSelectModel *)liveDataChartSelectModel
{
    _liveDataChartSelectModel = liveDataChartSelectModel;
    
    self.selectItmes = nil;
    
    [self.tableView reloadData];
    
    self.emptyView.hidden = self.liveDataChartSelectModel.liveDataMoreChartModel.liveDataModel.selectItmes.count > 0;

}

- (void)creatUI{
    
     // 1.0 横竖屏切换来不及取到正确的宽高
     // _scale = IS_IPad ? HD_Height : H_Height;
    _scale = 1.0;
    _cellHeight = (IS_IPad ? 62 : 60) * _scale;
    _leftSpace = (IS_IPad ? 40 : 14) * _scale;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    tableView.backgroundColor = UIColor.clearColor;
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
    tableView.estimatedRowHeight = _cellHeight;

    tableView.estimatedSectionFooterHeight = 0;

    tableView.estimatedSectionHeaderHeight = 0;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerIdentify"];
    
    if (![TDD_DiagnosisTools softWareIsCarPal]) {
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor tdd_line];
        [self addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(1);
        }];
    }

    [self addSubview:self.emptyView];

}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.liveDataSelectModel) {
        return self.liveDataSelectModel.showItems.count;
    }else {
        return self.liveDataChartSelectModel.liveDataMoreChartModel.liveDataModel.selectItmes.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *identify =@"cellIdentify";
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    NSString *identify = [NSString stringWithFormat:@"Cell%d%d", (int)[indexPath section], (int)[indexPath row]];//以indexPath来唯一确定
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];

    if (!cell) {
        if (self.cellArr.count < 30) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            [self.cellArr addObject:cell];
        }else{
            cell = self.cellArr[indexPath.row % 30];
        }
    }
    
    
    [self configureCell:cell atIndexpath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexpath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    TDD_CustomLabel * titleLabel = [cell.contentView viewWithTag:1000];
    UIButton * selectButton = [cell.contentView viewWithTag:1001];
    
    if (!titleLabel) {
        titleLabel = [[TDD_CustomLabel alloc] init];
        titleLabel.tag = 1000;
        titleLabel.textColor = [UIColor tdd_title];
        titleLabel.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        titleLabel.numberOfLines = 0;
        [cell.contentView addSubview:titleLabel];
        
        selectButton = ({
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 1001;
            btn.frame = CGRectMake(0, 0, 42 * _scale, 42 * _scale);
            [btn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:kImageNamed(@"test_result_cell_select") forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(10 * _scale, 10 * _scale, 10 * _scale, 10 * _scale)];
            btn;
        });
        [cell.contentView addSubview:selectButton];
        
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor tdd_line];
        [cell.contentView addSubview:lineView];
        
        [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(_leftSpace);
            make.centerY.equalTo(cell.contentView);
            make.size.mas_equalTo(CGSizeMake(42 * _scale, 42 * _scale));
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).offset(16 * _scale);
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView).offset(-_leftSpace);
            make.left.equalTo(selectButton.mas_right).offset(3 * _scale);
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(cell.contentView);
            make.height.mas_equalTo(1);
        }];
    }
    
    int row = (int)indexPath.row;
    
    NSMutableArray * selectItmes;
    
    if (self.liveDataSelectModel) {
        selectItmes = self.liveDataSelectModel.showItems;
    }else {
        selectItmes = self.liveDataChartSelectModel.liveDataMoreChartModel.liveDataModel.selectItmes;
    }
    
    if (row >= selectItmes.count) {
        return;
    }
    
    TDD_ArtiLiveDataItemModel * itemModel = selectItmes[row];
    
    titleLabel.text = itemModel.strName;
    
    selectButton.enabled = YES;
    
    [selectButton setImage:kImageNamed(@"test_result_cell_select") forState:UIControlStateNormal];
    [self.selectItmes enumerateObjectsUsingBlock:^(TDD_ArtiLiveDataItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.index == itemModel.index) {
            [selectButton setImage:[UIImage tdd_imageCheckDidSelect] forState:UIControlStateNormal];
            *stop = YES;
        }
    }];
    
//    if ([self.selectItmes containsObject:itemModel]) {
//        [selectButton setImage:[UIImage tdd_imageCheckDidSelect] forState:UIControlStateNormal];
//    }else {
//        [selectButton setImage:kImageNamed(@"test_result_cell_select") forState:UIControlStateNormal];
//    }
    
    if (self.liveDataChartSelectModel && ![NSString tdd_isNum:itemModel.strChangeValue]) {
        selectButton.enabled = NO;
        [selectButton setImage:[UIImage tdd_imageDiagCellSelectNO] forState:UIControlStateNormal];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self changeSelectButtonState:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerIdentify"];

    header.contentView.backgroundColor = [UIColor tdd_liveDataSegmentationBackground];
    
    TDD_CustomLabel * titleLabel = [header.contentView viewWithTag:100];
    
    if (!titleLabel) {
        titleLabel= ({
            TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
            label.tag = 100;
            label.font = [[UIFont systemFontOfSize:13] tdd_adaptHD];
            label.textColor = [UIColor tdd_title];
            label.numberOfLines = 0;
            label.text = TDDLocalized.liveData_chart_tip;
            label.textAlignment = NSTextAlignmentLeft;
            label;
        });
        [header.contentView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(header.contentView);
        }];
    }
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.liveDataSelectModel) {
        return 0.01;
    }else {
        return _cellHeight;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)selectButtonClick:(UIButton *)button
{
    UITableViewCell * cell = (UITableViewCell *)button.superview;
    
    while (![cell isKindOfClass:[UITableViewCell class]]) {
        cell = (UITableViewCell *)cell.superview;
        if (cell == nil) {
            return;
        }
    }
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    [self changeSelectButtonState:indexPath];
}

- (void)changeSelectButtonState:(NSIndexPath *)indexPath
{
    NSMutableArray * selectItmes;
    
    if (self.liveDataSelectModel) {
        selectItmes = self.liveDataSelectModel.showItems;
    }else {
        selectItmes = self.liveDataChartSelectModel.liveDataMoreChartModel.liveDataModel.selectItmes;
    }
    
    int row = (int)indexPath.row;
    
    if (row >= selectItmes.count) {
        return;
    }
    
    TDD_ArtiLiveDataItemModel * itemModel = selectItmes[row];
    
    if (self.liveDataChartSelectModel) {
        if (![NSString tdd_isNum:itemModel.strChangeValue]) {
            return;
        }
        
        if ([self.selectItmes containsObject:itemModel]) {
            [self.selectItmes removeObject:itemModel];
        }else {
            if (self.selectItmes.count >= 4) {
                NSString * tipStr = TDDLocalized.most_select;
                tipStr = [tipStr stringByReplacingOccurrencesOfString:@"$" withString:@"4"];
                [TDD_HTipManage showBottomTipViewWithTitle:tipStr];
            }else {
                [self.selectItmes addObject:itemModel];
            }
        }
    }else {
        
        __block BOOL isContain = NO;
        [self.selectItmes enumerateObjectsUsingBlock:^(TDD_ArtiLiveDataItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.index == itemModel.index) {
                [self.selectItmes removeObject:obj];
                isContain = YES;
                *stop = YES;
            }
        }];
        
        if (!isContain) {
            [self.selectItmes addObject:itemModel];
        }
        self.liveDataSelectModel.selectItmes = [NSMutableArray arrayWithArray:self.selectItmes];
//        self.liveDataSelectModel.liveDataModel.recordSelectItmes = [NSMutableArray arrayWithArray:self.selectItmes];
    }
    
    if (self.liveDataSelectModel) {
        [self.liveDataSelectModel show];
    }else {
        [self.liveDataChartSelectModel show];
    }
}

- (NSMutableArray *)cellArr
{
    if (!_cellArr) {
        _cellArr = [[NSMutableArray alloc] init];
    }
    
    return _cellArr;
}

- (NSMutableArray *)selectItmes
{
    if (!_selectItmes) {
        if (self.liveDataSelectModel) {
            _selectItmes = [NSMutableArray array];
        }else {
            _selectItmes = self.liveDataChartSelectModel.selectItmes;
        }
    }

    return _selectItmes;
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
    HLog(@"%s", __func__);
}

@end
