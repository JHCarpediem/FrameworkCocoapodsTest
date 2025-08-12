//
//  TDD_ArtiActiveView.m
//  AD200
//
//  Created by 何可人 on 2022/4/22.
//

#import "TDD_ArtiActiveView.h"
#import "TDD_ArtiActiveCellView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "TDD_ArtiActiveTableViewCell.h"

#import "TDD_ArtiActiveOperationTopView.h"
#import "TDD_ArtiActiveOperationBottomView.h"
#import "TDD_ArtiActiveFloatingView.h"
@interface TDD_ArtiActiveView ()<UITableViewDelegate,UITableViewDataSource,TDD_ArtiActiveModelDelegata,TDD_ArtiActiveFloatingViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * cellArr;
@property (nonatomic, assign) BOOL isScroll;
@property (nonatomic, strong) NSMutableDictionary * cellHightDic;
@property (nonatomic, strong) TDD_ArtiActiveOperationTopView *topView;
@property (nonatomic, strong) TDD_ArtiActiveOperationBottomView *bottomView;
@property (nonatomic, strong) TDD_ArtiActiveFloatingView *bottomBtn;
@property (nonatomic, assign) CGFloat scale;
@end

@implementation TDD_ArtiActiveView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = UIColor.tdd_viewControllerBackground;
        _scale = IS_IPad ? HD_Height : H_Height;
        [self createUI];
    }
    
    return self;
}

- (void)createUI{
    
    [self addSubview:self.topView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];

    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.clearColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
//    //设行高为自动计算
    tableView.rowHeight = UITableViewAutomaticDimension;
    //预计行高
    tableView.estimatedRowHeight = IS_IPad ? 62 * _scale : 50 * _scale;
    
    tableView.estimatedSectionHeaderHeight = IS_IPad ? 62 * _scale : 50 * _scale ;
    
    tableView.estimatedSectionFooterHeight = 1;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerIdentify"];
    
    [self addSubview:self.bottomBtn];
    
    [self addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
    }];
}

- (void)setActiveModel:(TDD_ArtiActiveModel *)activeModel{
   
    _activeModel = activeModel;
    
    activeModel.delegate = self;
    ///顶部操作提示
    if (![NSString tdd_isEmpty:activeModel.strOperationTopTips] || ![NSString tdd_isEmpty:activeModel.strTitleTopTips]){
        [_topView setTitleStr:activeModel.strTitleTopTips contentStr:activeModel.strOperationTopTips alignType:activeModel.uTitleTopAlignType fontSize:activeModel.eTitleTopFontSize boldType:activeModel.eTitleTopBoldType];

        _topView.hidden = NO;
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topView.mas_bottom).offset(16);
            make.left.right.bottom.equalTo(self);
        }];

    }else {
        if (!_topView.hidden){
            [_topView setTitleStr:activeModel.strTitleTopTips contentStr:activeModel.strOperationTopTips alignType:activeModel.uTitleTopAlignType fontSize:activeModel.eTitleTopFontSize boldType:activeModel.eTitleTopBoldType];
            _topView.hidden = YES;
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
    }
    //尾部操作提示
    if (![NSString tdd_isEmpty:activeModel.strOperationBottomTips] || ![NSString tdd_isEmpty:activeModel.strTitleBottomTips]){
        [_bottomView setTitleStr:activeModel.strTitleBottomTips contentStr:activeModel.strOperationBottomTips alignType:activeModel.uTitleBottomAlignType fontSize:activeModel.eTitleBottomFontSize boldType:activeModel.eTitleBottomBoldType];
        _bottomBtn.hidden = NO;
        _bottomView.hidden = NO;
    }else {
        [_bottomView setTitleStr:activeModel.strTitleBottomTips contentStr:activeModel.strOperationBottomTips alignType:activeModel.uTitleBottomAlignType fontSize:activeModel.eTitleBottomFontSize boldType:activeModel.eTitleBottomBoldType];
        _bottomBtn.hidden = YES;
        _bottomView.hidden = YES;
    }
    
    
    [self.tableView reloadData];
    
    [activeModel conditionSignalWithTime:0.1];
}

- (NSArray *)getCacheHeightWithArtiActiveItemModel:(ArtiActiveItemModel *)itemModel{

    CGFloat height1 = [NSString tdd_getHeightWithText:itemModel.strItem width:IphoneWidth / 2.0 - 100 * _scale fontSize:[[UIFont systemFontOfSize:26] tdd_adaptHD]];
    CGFloat height2 = [NSString tdd_getHeightWithText:itemModel.strValue width:IphoneWidth / 4.0 fontSize:[[UIFont systemFontOfSize:26] tdd_adaptHD]];
    CGFloat height3 = [NSString tdd_getHeightWithText:itemModel.strUnit width:IphoneWidth / 4.0 fontSize:[[UIFont systemFontOfSize:26] tdd_adaptHD]];
    
    return @[@(height1),@(height2),@(height3)];
}


#pragma mark - TDD_ArtiActiveModel delegate
- (NSArray *)TDD_ArtiActiveModelGetUpdateItems
{
 
    if (self.activeModel.itemArr.count == 0) {
        return @[];
    }
    
    __block NSArray * indexPaths;
    
    if ([NSThread isMainThread]) {
        [self.tableView layoutIfNeeded];

        indexPaths = [self.tableView indexPathsForVisibleRows];
    }else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView layoutIfNeeded];

            indexPaths = [self.tableView indexPathsForVisibleRows];
        });
    }
    
    NSMutableArray * mArr = [[NSMutableArray alloc] init];
    
    if (self.activeModel.SetLockFirstRow) {
        ArtiActiveItemModel * model = self.activeModel.itemArr.firstObject;
        if (!model.bIsLocked) {
            [mArr addObject:@(0)];
        }
    }
    
    for (NSIndexPath * indexPath in indexPaths) {
        int row = (int)indexPath.row;
        
        if (self.activeModel.SetLockFirstRow) {
            row ++;
        }
        
        if (row < self.activeModel.itemArr.count) {
            ArtiActiveItemModel * model = self.activeModel.itemArr[row];
            
            if (!model.bIsLocked) {
                [mArr addObject:@(row)];
            }
        }
    }
    
    return mArr;
  
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    NSMutableArray * arr = self.activeModel.itemArr;
//
//    return arr.count;
    
    long row = self.activeModel.itemArr.count;
    
    if (self.activeModel.SetLockFirstRow) {
        return row - 1;
    }
    
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identify = [NSString stringWithFormat:@"Cell%d%d", (int)[indexPath section], (int)[indexPath row]];//以indexPath来唯一确定
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];

    if (!cell) {
        if (self.cellArr.count < 40) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            [self.cellArr addObject:cell];
        }else{
            cell = self.cellArr[indexPath.row % 40];
        }
    }
    
    [self configureCell:cell atIndexpath:indexPath];

    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexpath:(NSIndexPath *)indexPath{
    TDD_ArtiActiveCellView * cellView = [cell.contentView viewWithTag:1000];
    
    if (!cellView) {
        cellView = [[TDD_ArtiActiveCellView alloc] init];
        cellView.tag = 1000;
        [cell.contentView addSubview:cellView];
        
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    
    NSInteger index = indexPath.row;
    
    if (self.activeModel.SetLockFirstRow) {
        index ++;
    }
    
    NSArray * arr = self.activeModel.itemArr;
    
    if (index >= arr.count) {
        return;
    }
    
    cellView.itemModel = arr[index];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.cellHightDic setObject:@(cell.frame.size.height) forKey:[NSString stringWithFormat:@"%ld_%ld",(long)indexPath.section, (long)indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [[self.cellHightDic objectForKey:[NSString stringWithFormat:@"%ld_%ld",(long)indexPath.section, (long)indexPath.row]] floatValue];
    
    if (height == 0) {
        return IS_IPad ? 62 * _scale : 50 * _scale;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [self reloadHeader];
    
    return header;
}

- (UITableViewHeaderFooterView *)reloadHeader{
    UITableViewHeaderFooterView *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerIdentify"];

    TDD_ArtiActiveCellView * headView = [header.contentView viewWithTag:10000];
    
    TDD_ArtiActiveCellView * cellView = [header.contentView viewWithTag:10001];

    if (!headView) {
        headView = [[TDD_ArtiActiveCellView alloc] init];
        headView.tag = 10000;
        headView.isHeader = YES;
        [header.contentView addSubview:headView];
        
        cellView = [[TDD_ArtiActiveCellView alloc] init];
        cellView.tag = 10001;
        [header.contentView addSubview:cellView];
        
    }
    
    headView.itemModel = self.activeModel.headModel;
    
    if (self.activeModel.SetLockFirstRow) {
        cellView.hidden = NO;
        
        NSArray * arr = self.activeModel.itemArr;

        if (arr.count != 0) {
            ArtiActiveItemModel * itemModel = arr[0];
            
            cellView.itemModel = itemModel;
        }
    }else{
        cellView.hidden = YES;
    }
    
    BOOL isShow = NO;
    
    NSArray * arr = @[headView.itemModel.strItem,headView.itemModel.strUnit,headView.itemModel.strValue];
    
    for (NSString * str in arr) {
        if (str.length > 0) {
            isShow = YES;
            break;
        }
    }
    
    if (self.activeModel.SetLockFirstRow) {
        cellView.hidden = NO;
        
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
            if (!isShow) {
                make.left.right.top.equalTo(header.contentView);
                make.height.mas_equalTo(0);
            }else {
                make.edges.equalTo(header.contentView);
            }
        }];

        
        [cellView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(header.contentView);
        }];
    }
    header.backgroundColor = UIColor.clearColor;
    header.contentView.backgroundColor = UIColor.clearColor;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    BOOL isShow = NO;
    
    NSArray * arr;
    
    if (self.activeModel) {
        arr = @[self.activeModel.headModel.strItem,self.activeModel.headModel.strUnit,self.activeModel.headModel.strValue];
    }
    
    for (NSString * str in arr) {
        if (str.length > 0) {
            isShow = YES;
            break;
        }
    }
    
    if (!isShow) {
        return 0;
    }else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, 1)];
    footView.backgroundColor = UIColor.tdd_line;
    return footView;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //高刷时，不灵敏
}

- (void)headerTipButton{
    [TDD_HTipManage showBtnTipViewWithTitle:self.activeModel.strOperationTopTips buttonType:HTipBtnOneType block:^(NSInteger btnTag) {
        
    }];
}

#pragma mark - Lazy

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

- (TDD_ArtiActiveOperationTopView *)topView {
    if (!_topView){
        _topView = [[TDD_ArtiActiveOperationTopView alloc] init];
        _topView.hidden = YES;
    }
    return _topView;
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
    }
    return _bottomView;
}

- (TDD_ArtiActiveFloatingView *)bottomBtn {
    if (!_bottomBtn){

        CGFloat  sizeW = isKindOfTopVCI ? 50 * _scale : 80 * _scale;

        CGFloat bottomHeight = (IS_IPad ? 100 : 58) * _scale;
        _bottomBtn = [[TDD_ArtiActiveFloatingView alloc] initWithFrame:CGRectMake(10, (IphoneHeight - (bottomHeight + iPhoneX_D) - 14 - NavigationHeight - sizeW), sizeW, sizeW) delegate:self];
        _bottomBtn.hidden = YES;
        _bottomBtn.alpha = 0;
    }
    return _bottomBtn;;
}

@end
