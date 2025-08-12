

#import "TDD_ArtiMenuView.h"
#import "TDD_ArtiMenuCellView.h"
#import "TDD_EmptyView.h"

@interface TDD_ArtiMenuView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TDD_EmptyView * emptyView;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) CGFloat sumWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@end

@implementation TDD_ArtiMenuView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
        _leftSpace = (IS_IPad ? 40 : 15) * _scale;
        _topSpace = (IS_IPad ? 30 : 15 ) * _scale;
        _lineSpace = (IS_IPad ? 20 : 10 ) * _scale;
        _itemCount = IS_IPad ? 4 : 2;
        _sumWidth = IphoneWidth - _leftSpace * 2 - _lineSpace * (_itemCount - 1);
        _itemHeight = _sumWidth / _itemCount - 1;
        [self creatCollectionView];
    }
    
    return self;
}

- (void)updateMenuViewWithModel:(TDD_ArtiMenuModel *)menuModel searchKeyDict:(nonnull NSMutableDictionary *)searchKeyDict {
    
    [TDD_HTipManage deallocView];
    NSString *searchKey = @"";
    if ([searchKeyDict.allKeys containsObject:@(menuModel.modID)]) {
        searchKey = searchKeyDict[@(menuModel.modID)];
    }
    if (![menuModel.searchKey isEqualToString:searchKey]) {
        [searchKeyDict setObject:menuModel.searchKey forKey:@(menuModel.modID)];
        [self filterItemWithModel:menuModel];
    } else {
        if (searchKey.length == 0) {
            [self filterItemWithModel:menuModel];
        }
    }
    
    if (_menuModel.modID != menuModel.modID) {
        _menuModel = menuModel;
        [self.collectionView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView layoutIfNeeded];
            // 滚动到当前选中的item
            NSInteger index = -1;
            for (NSInteger i = 0; i < menuModel.filterArray.count; i++) {
                ArtiMenuItemModel *itemModel = menuModel.filterArray[i];
                if (itemModel.uIndex == menuModel.selectIndex) {
                    index = i;
                }
            }
            if (index >= 0) {
                NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:MIN(itemsCount - 1, index) inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            }else {
                [self.collectionView setContentOffset:CGPointMake(0, 0)];
            }
        });
    } else {
        _menuModel = menuModel;
        [self.collectionView reloadData];
    }
    self.emptyView.hidden = self.menuModel.filterArray.count > 0;

}

- (void)filterItemWithModel:(TDD_ArtiMenuModel *)menuModel {
    
    [menuModel.filterArray removeAllObjects];
    if (menuModel.searchKey.length > 0) {
        //搜索关键词不为空
        for (NSInteger i = 0; i < menuModel.itemArr.count; i++) {
            ArtiMenuItemModel *itemModel = menuModel.itemArr[i];
            NSString *filterKey = @"";
            if (menuModel.isShowTranslated) {
                filterKey = itemModel.strTranslatedItem;
            }else {
                filterKey = itemModel.strItem;
            }
            
            if (itemModel.strIconPath.length > 0) {
                //有图片
                if (menuModel.isShowTranslated) {
                    filterKey = itemModel.strTranslatedShortName;
                } else {
                    filterKey = itemModel.strShortName;
                }
            }
            if ([filterKey.lowercaseString containsString:menuModel.searchKey.lowercaseString]) {
                [menuModel.filterArray addObject:itemModel];
            }
        }
    } else {
        //搜索关键词为空显示全部数据
        menuModel.filterArray = [NSMutableArray arrayWithArray:menuModel.itemArr];
    }
}

- (void)creatCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(_itemHeight, _itemHeight);//每一个cell的大小
//    layout.sectionInset = UIEdgeInsetsMake(0 * _scale, 0 * _scale, 0 * _scale, 0 * _scale);//四周的边距
    layout.sectionInset = UIEdgeInsetsMake(_topSpace, _leftSpace, _topSpace, _leftSpace);
    //设置最小边距
    layout.minimumLineSpacing = 0;
    
    //创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 22 * _scale, IphoneWidth, 170 * _scale) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor tdd_collectionViewBG];
    collectionView.delegate=self;
    collectionView.dataSource=self;
    collectionView.bounces = NO;
    collectionView.delaysContentTouches = NO;
    if ([TDD_DiagnosisTools isDebug]) {
        collectionView.accessibilityIdentifier = @"diagMenuCollectionView";

    }
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    [self addSubview:self.emptyView];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.menuModel.filterArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    TDD_ArtiMenuCellView * cellView = [cell.contentView viewWithTag:100];
    if (!cellView) {
        cellView = [[TDD_ArtiMenuCellView alloc] init];
        cellView.tag = 100;
        cellView.itemHeight = _itemHeight;
        [cell.contentView addSubview:cellView];
        
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        cell.backgroundColor = [UIColor tdd_menuCellBackground:CGSizeMake(_sumWidth, 0.5 * _sumWidth)];
        cellView.layer.cornerRadius = 5;
        
        cellView.layer.shadowColor = [UIColor blackColor].CGColor;
        cellView.layer.shadowOpacity = 0.1f;
        cellView.layer.shadowRadius = 5.f;
        cellView.layer.shadowOffset = CGSizeMake(0, 0);

    }
    
    if (indexPath.row >= self.menuModel.filterArray.count) {
        return cell;
    }
    
    ArtiMenuItemModel * itemModel = self.menuModel.filterArray[indexPath.row];
    
    cellView.isShowTranslated = self.menuModel.isShowTranslated;
    
    cellView.itemModel = itemModel;
    if ([TDD_DiagnosisTools isDebug]) {
        if ([itemModel.strItem isEqualToString:@"自动选择车型"]) {
            cell.accessibilityIdentifier = @"diagAutoChooseCarCell";
        }
        if ([itemModel.strItem isEqualToString:@"手动选择车型"]) {
            cell.accessibilityIdentifier = @"diagHandleChooseCarCell";
        }
        if ([itemModel.strItem isEqualToString:@"帕拉丁(Xterra)"]) {
            cell.accessibilityIdentifier = @"diagMenuSelectCarModel";
        }
        if ([itemModel.strItem isEqualToString:@"2000"]) {
            cell.accessibilityIdentifier = @"diagMenuSelectCarYear";
        }
        if ([itemModel.strItem isEqualToString:@"2000"]) {
            cell.accessibilityIdentifier = @"diagMenuSelectCarYear";
        }
        if ([itemModel.strItem isEqualToString:@"自动扫描"]) {
            cell.accessibilityIdentifier = @"diagMenuAutoScan";
        }
    }

    if (itemModel.uStatus == DF_ST_MENU_DISABLE) {
        //不可点击
        [cellView setingTitelLabelColor:[UIColor tdd_titleDisable]];
    }else if ([self.menuModel.selectArray containsObject:@(itemModel.uIndex)]) {
        [cellView setingTitelLabelColor:[UIColor tdd_colorDiagTheme]];
    } else {
        [cellView setingTitelLabelColor:[UIColor tdd_title]];
    }
    cell.backgroundColor = [UIColor tdd_menuCellBackground:CGSizeMake(_sumWidth, 0.5 * _sumWidth)];
    return cell;
}

//布局确定每个Item 的大小  // tangjilin 改
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake((IphoneWidth) / 5.0, 255 * _scale);
//    if (self.menuModel.itemArr.count > 0) {
//        ArtiMenuItemModel *model = [self.menuModel.itemArr firstObject];
//        if (![NSString tdd_isEmpty:model.strIconPath]) {
//            itemHeight = 190 * _scale;
//        }
//    }
    return CGSizeMake(_itemHeight, _itemHeight);
}

//返回每个section内左右两个Item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return _lineSpace;
}

//返回每个section内上下两个Item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return _lineSpace;
}

// 高亮时调用
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];

    //TDD_ArtiMenuCellView * cellView = [cell.contentView viewWithTag:100];
    cell.backgroundColor = [UIColor tdd_menuCellHightlightBackground:CGSizeMake(_sumWidth, 0.5 * _sumWidth)];
}

// 高亮结束调用
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    //TDD_ArtiMenuCellView * cellView = [cell.contentView viewWithTag:100];
    
    cell.backgroundColor = [UIColor tdd_menuCellBackground:CGSizeMake(_sumWidth, 0.5 * _sumWidth)];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= self.menuModel.filterArray.count) {
        return;
    }
    
    ArtiMenuItemModel *itemModel = self.menuModel.filterArray[indexPath.row];
    if (itemModel.uStatus != DF_ST_MENU_DISABLE) {
        self.menuModel.selectIndex = itemModel.uIndex;
        
        if (![self.menuModel.selectArray containsObject:@(itemModel.uIndex)]) {
            [self.menuModel.selectArray addObject:@(itemModel.uIndex)];
            [TDD_ArtiModelBase updateModel:self.menuModel];
        }
    }
    
    //非正常状态
    if (itemModel.uStatus != DF_ST_MENU_NORMAL) {
        //软件过期
        if (itemModel.uStatus == DF_ST_MENU_EXPIR) {
            @kWeakObj(self);
            [TDD_DiagnosisTools showSoftExpiredToBuyAlert:^{
                //DEMO 上锁后点击确定继续往下执行
                @kStrongObj(self);
                if ([TDD_DiagnosisTools isDEMO]) {
                    [TDD_HTipManage showNewLoadingViewWithTitle:@""];
                    self.menuModel.returnID = itemModel.uIndex;
                    
                    [self.menuModel conditionSignal];
                }
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self.menuModel userInfo:nil];
            });
        }
        
        return;
    }
    
    //[TDD_HTipManage showLoadingView];
    [TDD_HTipManage showNewLoadingViewWithTitle:@""];
    self.menuModel.returnID = itemModel.uIndex;
    
    [self.menuModel conditionSignal];
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

