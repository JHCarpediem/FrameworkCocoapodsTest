//
//  TDD_ArtiButtonCollectionView.m
//  AD200
//
//  Created by AI Assistant on 2024/12/19.
//

#import "TDD_ArtiButtonCollectionView.h"
#import "TDD_ArtiButtonCollectionCellView.h"
#import "TDD_ButtonCollectionView.h"

@interface TDD_ArtiButtonCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TDD_ArtiButtonCollectionCellViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) TDD_ButtonCollectionView *collectionView;
@property (nonatomic, strong) NSArray<TDD_ArtiButtonModel *> *buttonArr;
@property (nonatomic, strong) NSMutableArray *cellArr;
@property (nonatomic, assign) CGFloat btnWidth;
@property (nonatomic, assign) CGFloat btnHeight;
@property (nonatomic, assign) CGFloat spaceWidth;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) int noReuseCount;


@end

@implementation TDD_ArtiButtonCollectionView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        CGFloat scale = IS_IPad ? HD_Height : H_Height;
        _scale = scale;
        
        _btnWidth = (IS_IPad ? 160 : 100) * scale;
        _btnHeight = (IS_IPad ? 50: 35) * scale;
        _spaceWidth = (IS_IPad ? 20 : 10) * scale;
        _noReuseCount = 10;
    }
    
    return self;
}

- (void)setModel:(TDD_ArtiModelBase *)model {
    _model = model;
    
    if (!model.isReloadButton) {
        return;
    } else {
        // 刷新一次即可
        model.isReloadButton = NO;
    }
    
    HLog(@"刷新底部按钮");
    
    NSMutableArray *allButtonArr = [NSMutableArray new];
    [allButtonArr addObjectsFromArray:model.customButtonArr];
    [allButtonArr addObjectsFromArray:model.buttonArr];
    self.buttonArr = allButtonArr;
}

- (void)setButtonArr:(NSArray<TDD_ArtiButtonModel *> *)buttonArr {
    //Carpal 进车中退到后台，在后台完成进车。再打开前台。tableView 的 frame 可能为 0
    if (!self.collectionView || self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0) {
        [self createCollectionView];
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uStatus <= 1"];
    NSArray *filterArray = [buttonArr filteredArrayUsingPredicate:predicate];
    
    _buttonArr = filterArray;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = _spaceWidth;
    layout.minimumLineSpacing = _spaceWidth;
    // 不设置固定的 sectionInset，让 delegate 方法动态控制
    layout.sectionInset = UIEdgeInsetsZero;
    
    TDD_ButtonCollectionView *collectionView = [[TDD_ButtonCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.delaysContentTouches = NO;
    
    int section = 0;
    for (int row = 0; row < _noReuseCount; row++) {
        NSString *identify = [NSString stringWithFormat:@"Cell%d%d", (int)section, (int)row];//以indexPath来唯一确定
        [collectionView registerClass:[TDD_ArtiButtonCollectionCellView class] forCellWithReuseIdentifier:identify];
    }
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 更新 collectionView 的 frame
    self.collectionView.frame = self.bounds;
    
    // 强制刷新布局，确保 inset 在屏幕旋转时能正确更新
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.buttonArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString *identify = [NSString stringWithFormat:@"Cell%d%d", (int)[indexPath section], (int)[indexPath row]];//以indexPath来唯一确定
    TDD_ArtiButtonCollectionCellView *cell = nil;
    if ([indexPath row] < _noReuseCount) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    } else {
        cell = self.cellArr[indexPath.row % _noReuseCount];
    }
    
    if (!cell) {
        cell = [[TDD_ArtiButtonCollectionCellView alloc] initWithFrame:CGRectZero];
        HLog(@"不应该来到这里 TDD_ArtiButtonCollectionCellView alloc");
    }
    
    if (indexPath.item >= self.buttonArr.count) {
        return cell;
    }
    
    TDD_ArtiButtonModel *model = self.buttonArr[indexPath.item];
    
    cell.delegate = self;
    cell.isShowTranslated = self.model.isShowTranslated;
    cell.model = model;
    
    if ([TDD_DiagnosisTools isDebug]) {
        if (![NSString tdd_isEmpty:model.uiTextIdentify]) {
            cell.btn.accessibilityIdentifier = model.uiTextIdentify;
        }
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item >= self.buttonArr.count) {
        return CGSizeZero;
    }
    
    TDD_ArtiButtonModel *model = self.buttonArr[indexPath.item];
    
    if (model.uStatus == ArtiButtonStatus_UNVISIBLE) {
        return CGSizeZero;
    }
    
    return CGSizeMake(_btnWidth, _btnHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // 计算所有按钮的总宽度
    CGFloat totalButtonWidth = self.buttonArr.count * _btnWidth + (self.buttonArr.count - 1) * _spaceWidth;
    
    // 如果按钮总宽度小于容器宽度，则从右边开始布局
    if (totalButtonWidth < collectionView.bounds.size.width) {
        CGFloat leftInset = collectionView.bounds.size.width - totalButtonWidth - _spaceWidth;
        return UIEdgeInsetsMake(0, leftInset, 0, _spaceWidth);
    } else {
        return UIEdgeInsetsMake(0, _spaceWidth, 0, _spaceWidth);
    }
}

#pragma mark - UIScrollViewDelegate
/*
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 开始拖动时，禁用按钮点击
    for (TDD_ArtiButtonCollectionCellView *cell in self.collectionView.visibleCells) {
        cell.btn.userInteractionEnabled = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        // 拖动结束时，重新启用按钮点击
        for (TDD_ArtiButtonCollectionCellView *cell in self.collectionView.visibleCells) {
            cell.btn.userInteractionEnabled = YES;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 减速结束时，重新启用按钮点击
    for (TDD_ArtiButtonCollectionCellView *cell in self.collectionView.visibleCells) {
        cell.btn.userInteractionEnabled = YES;
    }
}
*/

#pragma mark - TDD_ArtiButtonCellViewDelegate

- (void)ArtiButtonCollectionCellButtonClick:(UIButton *)Button cell:(TDD_ArtiButtonCollectionCellView *)cell {
    TDD_ArtiButtonModel *model = cell.model;
    
    CGPoint cellCenter = cell.center;
    // 将 cell 的中心点转换到 window 坐标系
    CGPoint cellCenterInWindow = [cell convertPoint:cellCenter toView:FLT_APP_WINDOW];
    model.clickPoint = cellCenterInWindow;
    
    // 过期加锁软件不适用报告置灰逻辑
    if (model.uButtonId == DF_ID_REPORT && ![TDD_DiagnosisTools isLimitedTrialFuction]) {
        // 报告按钮
        model.uStatus = ArtiButtonStatus_DISABLE;
        model.bIsTemporaryNoEnable = YES;
        [self.collectionView reloadData];
    }
    
    if ([self.delegate respondsToSelector:@selector(ArtiButtonClick:)]) {
        [self.delegate ArtiButtonClick:model];
    }
}

@end 
