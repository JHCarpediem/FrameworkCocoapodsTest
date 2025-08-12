//
//  TDD_ArtiListView.m
//  AD200
//
//  Created by 何可人 on 2022/5/12.
//

#import "TDD_ArtiListView.h"
#import "TDD_ArtiListCellView.h"
#import "TDD_ButtonTableView.h"
#import "TDD_StdCommModel.h"
#import "TDD_ListTableViewCell.h"
//#import "UITableView+FDTemplateLayoutCell.h"
#import "TDD_ArtiListTableHeaderView.h"
#import "TDD_ArtiListTableFooterView.h"
#import "TDD_ArtiActiveFloatingView.h"
#import "TDD_ArtiActiveOperationBottomView.h"
typedef void(^GetHeightCacheFuncBlock)(void);

@interface TDD_ArtiListView ()<UITableViewDelegate,UITableViewDataSource,TDD_ArtiListCellViewDelegate,TDD_ArtiActiveFloatingViewDelegate>
@property (nonatomic, assign) BOOL isScroll;
@property (nonatomic, strong) TDD_ButtonTableView * tableView;
@property (nonatomic, strong) TDD_ArtiListTableHeaderView *tableHeadView;
@property (nonatomic, strong) TDD_ArtiListTableFooterView *tableFootView;
@property (nonatomic, strong) TDD_ArtiActiveOperationBottomView *bottomView;
@property (nonatomic, strong) TDD_ArtiActiveFloatingView *bottomBtn;
@property (nonatomic, strong) NSMutableArray * cellArr;
@property (nonatomic, strong) NSMutableDictionary * cellHightDic;
@property (nonatomic, assign) CGFloat maxTextViewHeight;
@property (nonatomic, assign) CGFloat scale;
@end

@implementation TDD_ArtiListView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
        CGFloat bottomHeight = (IS_IPad ? 100 : 58) * _scale;
        self.backgroundColor = UIColor.tdd_viewControllerBackground;
        _maxTextViewHeight = (IphoneHeight - NavigationHeight - (bottomHeight + iPhoneX_D))/3;

        [self creatTableView];
    }
    
    return self;
}

- (void)setListModel:(TDD_ArtiListModel *)listModel
{
    BOOL isScroll = NO;
    
    if (_listModel != listModel || listModel.scrollToIndex != -1) {
        isScroll = YES;
    }
    _listModel = listModel;
    //顶部提示
    [_tableHeadView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        if (([NSString tdd_isEmpty:listModel.strTopTips] && [NSString tdd_isEmpty:listModel.strTitleTopTips])){
            make.height.mas_equalTo(0);
        }
    }];
    [self.tableHeadView setListModel:listModel];


    //底部提示
    if ([NSString tdd_isEmpty:listModel.strBottomTips]) {
        //_tableFootView.hidden = YES;

        _bottomBtn.hidden = YES;
        _bottomView.hidden = YES;
    }else {
        //_tableFootView.hidden = NO;
        [_bottomView setTitleStr:@"" contentStr:listModel.strBottomTips alignType:DT_LEFT fontSize:2 boldType:0];
        _bottomBtn.hidden = NO;
//        _bottomView.hidden = NO;
    }

    //[self.tableFootView setListModel:listModel];
    
    if (isScroll) {
        if (_listModel.scrollToIndex == -1) {
            _listModel.scrollToIndex = 0;
        }
        if (_listModel.itemArr.count > _listModel.scrollToIndex) {
            if (self.tableView.visibleCells.count > 0) {
                
                if (_listModel.scrollRowType == SCREEN_TYPE_FIRST_ROW){
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_listModel.scrollToIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:_listModel.scrollRowType!=0];
                }else {
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_listModel.scrollToIndex inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:_listModel.scrollRowType!=0];
                }
                _listModel.scrollToIndex = -1;
            }
        }
        
    }
    [self.tableView layoutIfNeeded];
    [self.tableView reloadData];
    if (!listModel.bIsBlock) {
        [listModel conditionSignalWithTime:0.1];
    }
}

- (void)creatTableView{
    [self addSubview:self.tableHeadView];
    [_tableHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(0);
    }];
    //[self addSubview:self.tableFootView];
//    [_tableFootView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.left.right.equalTo(self);
//    }];
    
    TDD_ButtonTableView *tableView = [[TDD_ButtonTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.clearColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
    if (@available(iOS 15.0, *)) {
        //iOS 15 去掉新增的默认顶部间距
        tableView.sectionHeaderTopPadding = 0;
    } else {
        
    }
    
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.tableHeadView.mas_bottom);
    }];
    
    //设行高为自动计算
    tableView.rowHeight = UITableViewAutomaticDimension;
    //预计行高
    tableView.estimatedRowHeight = 47 * _scale;
    
    tableView.estimatedSectionFooterHeight = 0;

    tableView.estimatedSectionHeaderHeight = 47 * _scale;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerIdentify"];
    
    [self addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor tdd_line];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    [self addSubview:self.bottomBtn];
}

#pragma mark - TDD_ArtiActiveFloatingViewDelegate
- (void)floatingViewDidClickView {
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomBtn.alpha = 0;
        self.bottomView.alpha = 1;
        self.bottomView.hidden = NO;
        [self bringSubviewToFront:self.bottomView];
    }];
    
}

- (void)hideBottomView {
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomBtn.alpha = 1;
        self.bottomView.alpha = 0;
        
    }];
    
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    long row = self.listModel.itemArr.count;
    
    if (self.listModel.isLockFirstRow) {
        return row - 1;
    }
    
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identify = [NSString stringWithFormat:@"Cell%d%d", (int)[indexPath section], (int)[indexPath row]];//以indexPath来唯一确定
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];

    if (!cell) {
        if (self.cellArr.count < 30) {
            cell = [[TDD_ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
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
//    cell.fd_enforceFrameLayout = NO;
//    cell.contentView.clipsToBounds = YES;
    TDD_ArtiListCellView * cellView = [cell.contentView viewWithTag:1000];

    if (!cellView) {
        cellView = [[TDD_ArtiListCellView alloc] init];
        cellView.tag = 1000;
        cellView.delegate = self;
        [cell.contentView addSubview:cellView];
        
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    
    NSInteger index = indexPath.row;
    //首行锁定
    if (self.listModel.isLockFirstRow) {
        index = index + 1;
    }

    if (index >= self.listModel.itemArr.count) {
        return;
    }

    ArtiListItemModel * itemModel = self.listModel.itemArr[index];

    cellView.listViewType = self.listModel.listViewType;

    cellView.vctColWidth = self.listModel.vctColWidth;

    cellView.isShowImage = self.listModel.isShowImage;

    cellView.uColImageIndex = self.listModel.uColImageIndex;

    if (index < self.listModel.vctImagePathArr.count) {
        cellView.imageUrlStr = self.listModel.vctImagePathArr[index];
    }else {
        cellView.imageUrlStr = @"";
    }

    cellView.itemModel = itemModel;
    
    NSInteger row = itemModel.index;
    if (self.listModel.selectedRow == row && row >= 0) {
        CGFloat height = [[self.cellHightDic objectForKey:[NSString stringWithFormat:@"%ld_%ld",(long)indexPath.section, (long)indexPath.row]] floatValue];
        if (height == 0) {
            height = 47 * _scale;
        }
        
        cell.backgroundColor = [UIColor tdd_colorDiagListSelectColor:CGSizeMake(IphoneWidth, height + 50)];//高了没事，短了会有割裂感

    }else{
        if (itemModel.isGroup && ![NSString tdd_isEmpty:itemModel.strGroupName]) {
            cell.backgroundColor = [UIColor tdd_cellBackground];
        } else {
            cell.backgroundColor = [UIColor clearColor];
        }
    }

    BOOL isSelect = NO;

    if ([self.listModel.boxSelectSet containsObject:@(row)]) {
        
        isSelect = YES;
        
        if (row < 0)
        {
            isSelect = NO;
        }
    }

    [cellView changeSelectButtonWithIsSelect:isSelect];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.cellHightDic setObject:@(cell.frame.size.height) forKey:[NSString stringWithFormat:@"%ld_%ld",(long)indexPath.section, (long)indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [[self.cellHightDic objectForKey:[NSString stringWithFormat:@"%ld_%ld",(long)indexPath.section, (long)indexPath.row]] floatValue];
    
    if (height == 0) {
        return 47 * _scale;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerIdentify"];
    if (@available(iOS 14.0, *)) {
        //去掉自带的毛玻璃效果
        header.backgroundConfiguration = UIBackgroundConfiguration.clearConfiguration;
    } else {
               // Fallback on earlier versions
    }
    header.contentView.backgroundColor = [UIColor tdd_listBackground];
    
    [self configureHeader:header atSection:section];
    if (self.listModel.isLockFirstRow || self.listModel.isShowHeader) {
        return header;
    }
    return UIView.new;
}

- (void)configureHeader:(UITableViewHeaderFooterView *)header atSection:(NSInteger)section
{
    TDD_ArtiListCellView * headView = [header.contentView viewWithTag:2000];
    TDD_ArtiListCellView * cellView = [header.contentView viewWithTag:2001];
    
    if (!headView) {
        headView = [[TDD_ArtiListCellView alloc] init];
        headView.isHeader = YES;
        headView.backgroundColor = _listModel.isShowHeader ? [UIColor tdd_reportMilesNormalBackground] : [UIColor tdd_listBackground];
        headView.tag = 2000;
        [header.contentView addSubview:headView];
        
        cellView = [[TDD_ArtiListCellView alloc] init];
        cellView.delegate = self;
        cellView.tag = 2001;
        cellView.hidden = YES;
        [header.contentView addSubview:cellView];
        
        [headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(header.contentView);
        }];
        
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(header.contentView);
        }];
    }
    
    
    
    ArtiListItemModel * itemModel = [[ArtiListItemModel alloc] init];
    
    itemModel.vctItems = self.listModel.vctHeadNames.mutableCopy;
    itemModel.strGroupName = self.listModel.strTopTips;
    headView.listViewType = self.listModel.listViewType;
    
    headView.vctColWidth = self.listModel.vctColWidth;
    headView.itemModel = itemModel;
    
    if (self.listModel.isLockFirstRow && self.listModel.itemArr.count > 0) {
        ArtiListItemModel * itemModel2 = self.listModel.itemArr.firstObject;

        cellView.listViewType = self.listModel.listViewType;

        cellView.vctColWidth = self.listModel.vctColWidth;
        cellView.model = self.listModel;
        cellView.itemModel = itemModel2;
        
        if (self.listModel.selectedRow == 0) {
            CGFloat height = MIN(UITableViewAutomaticDimension, 47 * _scale);
            cellView.backgroundColor = [UIColor tdd_colorDiagListSelectColor:CGSizeMake(IphoneWidth, height)];
        }else if (itemModel2.bIsHighLight) {
            if (itemModel2.eHighLighColorType == 0){
                CGFloat height = MIN(UITableViewAutomaticDimension, 47 * _scale);
                cellView.backgroundColor = [UIColor tdd_colorDiagHightLightColor:CGSizeMake(IphoneWidth, height)];
            }else {
                cellView.backgroundColor = [UIColor tdd_listBackground];
            }

        }else {
            cellView.backgroundColor = [UIColor tdd_keyboardItemDisableTitle];
        }
        BOOL isSelect = NO;
        
        if ([self.listModel.boxSelectSet containsObject:@(0)]) {
            isSelect = YES;
        }
        
        [cellView changeSelectButtonWithIsSelect:isSelect];
    }
    
    if (self.listModel.isLockFirstRow) {
        cellView.hidden = NO;
        
        BOOL isShow = NO;
        
        if (self.listModel.isShowHeader) {
            isShow = YES;
        }
        
        [headView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(header.contentView);
            
            if (!isShow) {
                make.height.mas_equalTo(0);
            }
        }];
        
        [cellView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headView.mas_bottom);
            make.left.right.bottom.equalTo(header.contentView);
        }];
    }else {
        cellView.hidden = YES;
        
        [headView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(header.contentView);
        }];
        
        [cellView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(header.contentView);
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    BOOL isShow = NO;
    
    if (self.listModel.isLockFirstRow || self.listModel.isShowHeader) {
        isShow = YES;
    }
 
    if (isShow) {
        return MIN(UITableViewAutomaticDimension, 47 * _scale);
    }

    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isScroll = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    if (!decelerate) {
        self.isScroll = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.isScroll = NO;
}

#pragma mark - CellView代理
- (void)TDD_ArtiListCellViewUnderButtonClick:(TDD_ArtiListCellView *)cellView
{
    if (self.listModel.listViewType == 0 && self.listModel.listSelectType == ITEM_SELECT_DISABLED){
        HLog(@"设置不可选中");
        return;
    }
    int row = (int)cellView.itemModel.index;
    if (row < 0){
        HLog(@"非item,选择无效");
        return;
    }
    if (self.listModel.isLockFirstRow && row == 0){
        HLog(@"首行锁定,点击无效");
        return;
    }
    if (cellView.itemModel >= 0){
        
        self.listModel.selectedRow = row;
        
        self.listModel.returnID = row;
        
        [self TDD_ArtiListCellViewSelectButtonClick:cellView];
        
        [self.tableView reloadData];
    }
}

- (void)TDD_ArtiListCellViewSelectButtonClick:(TDD_ArtiListCellView *)cellView
{
    //int row = (int)[self.listModel.itemArr indexOfObject:cellView.itemModel];
    int row = (int)cellView.itemModel.index;
    if (row < 0){
        HLog(@"非item,选择无效");
        return;
    }
    NSLog(@"按钮点击：%d", row);
    self.listModel.selectedRow = row;
    self.listModel.returnID = row;
    if ([self.listModel.boxSelectSet containsObject:@(row)]) {
        //移除选择
        [self.listModel.boxSelectSet removeObject:@(row)];
    }else {
        //添加选择
        if (self.listModel.listViewType == ITEM_WITH_CHECKBOX_SINGLE) {
            //互斥选择
            [self.listModel.boxSelectSet removeAllObjects];
        }
        [self.listModel.boxSelectSet addObject:@(row)];
    }
    
    [self.tableView reloadData];
    [self.listModel conditionSignalWithTime:0.1];
}

- (TDD_ArtiListTableHeaderView *)tableHeadView {
    if (!_tableHeadView) {
        _tableHeadView = [[TDD_ArtiListTableHeaderView alloc] initWithFrame:CGRectZero];
    }
    return _tableHeadView;
}

- (TDD_ArtiListTableFooterView *)tableFootView {
    if (!_tableFootView) {
        _tableFootView = [[TDD_ArtiListTableFooterView alloc] initWithFrame:CGRectZero];
        @kWeakObj(self)
        _tableFootView.hideBlock = ^{
            @kStrongObj(self)
            [self hideBottomView];
        };

    }
    return _tableFootView;
    
}

- (TDD_ArtiActiveOperationBottomView *)bottomView {
    if (!_bottomView){
        _bottomView = [[TDD_ArtiActiveOperationBottomView alloc] init];
        _bottomView.alpha = 1;
        @kWeakObj(self)
        _bottomView.hideBlock = ^{
            @kStrongObj(self)
            [self hideBottomView];
        };
        _bottomView.alpha = 0;
    }
    return _bottomView;
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

- (TDD_ArtiActiveFloatingView *)bottomBtn {
    if (!_bottomBtn){
        CGFloat width = isKindOfTopVCI ? 50 * _scale : 80 * _scale;
        CGFloat bottomHeight = (IS_IPad ? 100 : 58) * _scale;
        _bottomBtn = [[TDD_ArtiActiveFloatingView alloc] initWithFrame:CGRectMake(10, (IphoneHeight - (bottomHeight + iPhoneX_D) - 14 - NavigationHeight - width), width, width) delegate:self];
        _bottomBtn.hidden = YES;
        _tableFootView.alpha = 0;
    }
    return _bottomBtn;;
}

- (void)dealloc
{
    HLog(@"%@ -- dealloc", [self class]);
}

@end
