//
//  TDD_ArtiFreezeView.m
//  AD200
//
//  Created by 何可人 on 2022/5/6.
//

#import "TDD_ArtiFreezeView.h"

#import "TDD_ArtiFreezeCellView.h"

@interface TDD_ArtiFreezeView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation TDD_ArtiFreezeView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor tdd_line];
        
        [self creatTableView];
    }
    
    return self;
}

- (void)setFreezeModel:(TDD_ArtiFreezeModel *)freezeModel
{
    _freezeModel = nil;
    
    [self.tableView reloadData];
    
    [self.tableView layoutIfNeeded];
    
    _freezeModel = [freezeModel yy_modelCopy];
    
    [self.tableView reloadData];
}

- (void)creatTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
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
    tableView.estimatedRowHeight = 44;

    tableView.estimatedSectionFooterHeight = 0;

    tableView.estimatedSectionHeaderHeight = 44;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerIdentify"];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor tdd_line];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.freezeModel.groupArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify =@"cellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    [self configureCell:cell atIndexpath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexpath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor clearColor];
//    cell.fd_enforceFrameLayout = NO;
    
    TDD_ArtiFreezeCellView * cellView = [cell.contentView viewWithTag:1000];
    
    if (!cellView) {
        cellView = [[TDD_ArtiFreezeCellView alloc] init];
        cellView.tag = 1000;
        [cell.contentView addSubview:cellView];
        
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }

    NSInteger index = indexPath.row;
    
    if (index >= self.freezeModel.groupArr.count) {
        return;
    }
    
    TDD_ArtiFreezeItemModel * itemModel = self.freezeModel.groupArr[index];
    
    cellView.isShowTranslated = self.freezeModel.isShowTranslated;
    
    cellView.itemModel = itemModel;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [self reloadHeader];
    
    return header;
}

- (UITableViewHeaderFooterView *)reloadHeader{
    UITableViewHeaderFooterView *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerIdentify"];

    TDD_ArtiFreezeCellView * headView = [header.contentView viewWithTag:10000];

    if (!headView) {
        headView = [[TDD_ArtiFreezeCellView alloc] init];
        headView.backgroundColor = [UIColor tdd_listBackground];
        headView.tag = 10000;
        [header.contentView addSubview:headView];
        
        TDD_ArtiFreezeItemModel * itemModel = [[TDD_ArtiFreezeItemModel alloc] init];
        itemModel.strName = @"diagnosis_name";
        itemModel.strValue = @"diagnosis_value";
        itemModel.strUnit = @"diagnosis_unit";
        
        headView.itemModel = itemModel;
        
        [headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(header.contentView);
        }];
    }
    
    return header;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.01;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

@end

