//
//  TDDataFlowViewController.m
//  AD200
//
//  Created by yong liu on 2022/8/24.
//

#import "TDDataFlowViewController.h"
#import "TDDataFlowCell.h"
#import "TDLiveDataPlayViewController.h"
#import "TDD_ArtiLiveDataRecordeSaveModel.h"
#import "TDD_DataFlowModel.h"
#import "TDD_ArtiLiveDataRecordeModel.h"

@interface TDDataFlowViewController ()<UITableViewDelegate, UITableViewDataSource, LocalDataFlowSelectDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *allBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *editBtn;

@end

@implementation TDDataFlowViewController

- (void)dealloc {
    [TDD_DiagnosisManage switchDBType:TDD_DATA_BASE_TYPE_DEFAULT];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedArray = [NSMutableArray array];
    // 取数据流本地缓存数据
    [self getData];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.allBtn];
    [self.bottomView addSubview:self.deleteBtn];
    self.bottomView.hidden = YES;
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColor.tdd_colorF5F5F5;
    [self.view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.naviView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.naviView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(10);

        make.height.equalTo(@(kSafeBottomHeight + 70));
        
    }];
    
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(10);
        make.top.equalTo(self.bottomView).offset(10);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allBtn);
        make.right.equalTo(self.bottomView).offset(-20);
        make.width.mas_greaterThanOrEqualTo(100);
    }];
}

- (void)getData
{
    
    //清除旧版无效数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int pageSize = 300;
        while (1) {
            @autoreleasepool {
                NSArray * saveArr = [TDD_ArtiLiveDataRecordeSaveModel findByCriteria:[NSString stringWithFormat:@"where isTemporaryData = 1 LIMIT (0), %d",  pageSize]];
                
                [TDD_ArtiLiveDataRecordeSaveModel deleteObjects:saveArr];
                
                if (saveArr.count < 300) {
                    break;
                }
                //清除新版无效数据
                [TDD_ArtiLiveDataRecordeModel deleteObjectsByCriteria:@"WHERE createTime NOT IN (SELECT createTime FROM DataFlowModel)"];
                [TDD_ArtiLiveDataRecordeChangeModel deleteObjectsByCriteria:@"WHERE createTime NOT IN (SELECT createTime FROM DataFlowModel)"];
            }
        }
        

        [TDD_DiagnosisManage switchDBType:TDD_DATA_BASE_TYPE_DEFAULT];
        NSArray * localArr = [TDD_DataFlowModel findByCriteria:[NSString stringWithFormat:@"where sn = '110238C4F13562'"]];
        for (TDD_DataFlowModel *model in localArr) {
            model.dbType = TDD_DATA_BASE_TYPE_DEFAULT;
        }

        NSMutableArray *dataArray = [NSMutableArray arrayWithArray:localArr];

        self.dataArray = [dataArray sortedArrayUsingComparator:^NSComparisonResult(TDD_ArtiLiveDataRecordeSaveModel *obj1, TDD_ArtiLiveDataRecordeSaveModel *obj2) {
            return [obj2.createTime compare:obj1.createTime options:NSNumericSearch];
        }].mutableCopy;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
    });
    
    
}

- (void)setupNavigation
{
    self.naviView.title = @"数据流";
//    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.editBtn setImage:kImageNamed(@"navi_edit_select") forState:UIControlStateNormal];
//    [self.editBtn setImage:nil forState:UIControlStateSelected];
//    [self.editBtn setTitle:@"取消" forState:UIControlStateSelected];
//    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [self.editBtn setTitleColor:UIColor.tdd_color333333 forState:UIControlStateSelected];
//    
//    [self.editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.naviView addSubview:self.editBtn];
//    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.naviView).offset(-15);
//        make.centerY.equalTo(self.naviView.titleLabel);
////        make.width.height.equalTo(@23);
//    }];
}

// 编辑
- (void)editBtnClick
{
    self.editBtn.selected = !self.editBtn.selected;
    self.bottomView.hidden = !self.editBtn.selected;
    UIImage *normalImg = self.editBtn.selected ? nil : kImageNamed(@"navi_edit_select");
    [self.editBtn setImage:normalImg forState:UIControlStateNormal];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(self.editBtn.selected ? -60 - kSafeBottomHeight : 0);
        
    }];
    [self.tableView reloadData];
    [self setBottomBtnStatus];
    
    if (self.editBtn.selected) {
        [self.bottomView addShadowViewWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.08] offset:CGSizeMake(0, 2) opacity:1 radius:8 tag:1999];
    } else {
        [self.bottomView removeShadowView:1999];
    }
}

#pragma mark -- 全选/取消全选
- (void)allBtnClick
{
    if (self.dataArray.count == 0) {
        return;
    }
    if (self.dataArray.count == self.selectedArray.count) {
        [self.selectedArray removeAllObjects];
    } else {
        [self.selectedArray removeAllObjects];
        [self.selectedArray addObjectsFromArray:self.dataArray];
    }
    [self setBottomBtnStatus];
    [self.tableView reloadData];
}

- (void)deleteBtnClick {
    if (self.selectedArray.count == 0) {
        return;
    }
    // 删除弹窗
    @kWeakObj(self)
    [TDD_HTipManage showBtnTipViewWithTitle:TDDLocalized.app_tip buttonType:HTipBtnTwoType block:^(NSInteger btnTag) {
        if (btnTag == 1) {
            @kStrongObj(self)
            [TDD_HTipManage showNewLoadingViewWithTitle:@""];
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                for (NSInteger i = 0; i < self.selectedArray.count; i++) {
                    TDD_DataFlowModel *model = self.selectedArray[i];
                    [TDD_DiagnosisManage switchDBType:model.dbType];
                    // 删除本地数据
                    [TDD_ArtiLiveDataRecordeSaveModel deleteObjectsByCriteria:[NSString stringWithFormat:@"WHERE createTime = '%@'", model.createTime]];
                    
                    [TDD_DataFlowModel deleteObjectsByCriteria:[NSString stringWithFormat:@"WHERE createTime = '%@'", model.createTime]];
                    
                    [TDD_ArtiLiveDataRecordeModel deleteObjectsByCriteria:[NSString stringWithFormat:@"WHERE createTime = '%@'", model.createTime]];
                    
                    [TDD_ArtiLiveDataRecordeChangeModel deleteObjectsByCriteria:[NSString stringWithFormat:@"WHERE createTime = '%@'", model.createTime]];
                }
                // 删除完数据重置当前选中数据库类型
                [TDD_DiagnosisManage switchDBType:TDD_DATA_BASE_TYPE_DEFAULT];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [TDD_HTipManage deallocView];
                    
                    [self.selectedArray removeAllObjects];
                    [self editBtnClick];
                    
                    [self getData];
                });
            });
        }
    }];

}

#pragma mark -- 设置底部按钮状态
- (void)setBottomBtnStatus {
    
    if (self.dataArray.count == self.selectedArray.count && self.dataArray.count != 0) {
        self.allBtn.selected = YES;
    } else {
        self.allBtn.selected = NO;
    }
    
    self.deleteBtn.enabled = self.selectedArray.count != 0;
    [self.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%@)",  @(self.selectedArray.count)] forState:UIControlStateNormal];
}

#pragma mark -- LocalDataFlowSelectDelegate
- (void)dataFlowSelect:(TDD_DataFlowModel *)model
{
    BOOL flag = NO;
    for (NSInteger i = 0; i < self.selectedArray.count; i++) {
        TDD_DataFlowModel *selectModel = self.selectedArray[i];
        if ([model.createTime isEqualToString:selectModel.createTime]) {
            [self.selectedArray removeObject:selectModel];
            flag = YES;
            break;
        }
    }
    
    if (!flag) {
        [self.selectedArray addObject:model];
    }
    
    [self setBottomBtnStatus];
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDDataFlowCell *cell = [tableView dequeueReusableCellWithIdentifier:TDDataFlowCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row >= self.dataArray.count) {
        return cell;
    }
    [cell fillCellWithModel:self.dataArray[indexPath.row]];
    [cell cellSelected:[self.selectedArray containsObject:self.dataArray[indexPath.row]]];
    [cell cellEditState:self.editBtn.selected];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = 0;
    if (self.editBtn.selected) {
        width = 40 * H_Height;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, width, 0, 15)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, width, 0, 15)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int index = (int)indexPath.row;
    
    if (index > self.dataArray.count) {
        NSLog(@"数组越界");
        return;
    }
    
    if (self.editBtn.selected) {
        [self dataFlowSelect:self.dataArray[index]];
        return;
    }
    
    TDLiveDataPlayViewController * vc = [[TDLiveDataPlayViewController alloc] init];
    vc.model = self.dataArray[index];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载UI
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorColor = [UIColor colorF5F5F5];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
        [_tableView registerClass:[TDDataFlowCell class] forCellReuseIdentifier:TDDataFlowCellId];
        _tableView.rowHeight = 60;
    }
    return _tableView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [_bottomView tdd_addCornerRadius:10];
    }
    return _bottomView;
}

- (UIButton *)allBtn {
    if (!_allBtn) {
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allBtn setTitle:TDDLocalized.report_select_all forState:UIControlStateNormal];
        [_allBtn setTitle:TDDLocalized.live_data_cancel_all forState:UIControlStateSelected];
        [_allBtn setImage:kImageNamed(@"check_box_normal") forState:UIControlStateNormal];
        [_allBtn setImage:kImageNamed(@"check_box_selected") forState:UIControlStateSelected];
        [_allBtn setTitleColor:[UIColor tdd_color333333] forState:UIControlStateNormal];
        _allBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _allBtn.titleLabel.font = kSystemFont(15);
        [_allBtn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%@)",  @0] forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor tdd_title] forState:UIControlStateDisabled];
        [_deleteBtn setTitleColor:[UIColor tdd_colorDiagTheme] forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = kSystemFont(15);
        _deleteBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [_deleteBtn tdd_addCornerRadius:3];
        _deleteBtn.enabled = NO;
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}


@end
