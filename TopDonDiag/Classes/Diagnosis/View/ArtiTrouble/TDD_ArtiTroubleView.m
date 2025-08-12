//
//  TDD_ArtiTroubleView.m
//  AD200
//
//  Created by 何可人 on 2022/5/9.
//

#import "TDD_ArtiTroubleView.h"
#import "TDD_ArtiTroubleCellView.h"
#import "TDD_ButtonTableView.h"
#import "TDD_ArtiTroubleAIGuildView.h"
@interface TDD_ArtiTroubleView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource,TDD_ArtiTroubleCellViewDelegate>
@property (nonatomic, strong) TDD_ButtonTableView * tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat itemWidth;
@end

@implementation TDD_ArtiTroubleView
- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor tdd_troubleBackground];
        _scale = IS_IPad ? HD_Height : H_Height;
        _leftSpace = (IS_IPad ? 25 : 15) * _scale;
        _topSpace = (IS_IPad ? 20 : 10 ) * _scale;
        _lineSpace = (IS_IPad ? 10 : 5 ) * _scale;
        _itemHeight = (IS_IPad ? 184 : 165) * _scale;
        _itemWidth = (IS_IPad ? (IphoneWidth - _leftSpace * 2 - _lineSpace)/2 : (IphoneWidth - _leftSpace * 2));
        //[self creatTableView];
        [self createCollectionView];
    }
    
    return self;
}

- (void)setTroubleModel:(TDD_ArtiTroubleModel *)troubleModel
{
    _troubleModel = troubleModel;
    [self.collectionView reloadData];
    //[self.tableView reloadData];
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

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(_itemWidth, _itemHeight);//每一个cell的大小
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
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"troubleCellId"];
    
}

#pragma mark - UICollectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.troubleModel.itemArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"troubleCellId" forIndexPath:indexPath];
    [self configureCollectionCell:cell atIndexpath:indexPath];
    return cell;
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

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.troubleModel.itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify =@"cellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    [self configureCell:cell atIndexpath:indexPath];
    
    return cell;
}

- (void)configureCollectionCell:(UICollectionViewCell *)cell atIndexpath:(NSIndexPath *)indexPath{
    
    TDD_ArtiTroubleCellView * cellView = [cell.contentView viewWithTag:1000];
    
    if (!cellView) {
        cellView = [[TDD_ArtiTroubleCellView alloc] init];
        cellView.tag = 1000;
        cellView.delegate = self;
        [cell.contentView addSubview:cellView];
        
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
 
    NSInteger index = indexPath.item;
    
    if (index >= self.troubleModel.itemArr.count) {
        return;
    }
    
    TDD_ArtiTroubleItemModel * itemModel = self.troubleModel.itemArr[index];
    
    cellView.isShowTranslated = self.troubleModel.isShowTranslated;
    
    cellView.itemModel = itemModel;
    
    //AI 引导
    if ((([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany) || ([TDD_DiagnosisManage sharedManage].functionConfigMask & 1) || ([TDD_DiagnosisTools softWareIsCarPalSeries])) && indexPath.row == 0) {
        BOOL isShowGuild = [[NSUserDefaults standardUserDefaults] boolForKey:TDDDidShowTroubleGuild];
        if (!isShowGuild) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [cellView showGuildView];
                });
                
            });
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexpath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor clearColor];
//    cell.fd_enforceFrameLayout = NO;
    
    TDD_ArtiTroubleCellView * cellView = [cell.contentView viewWithTag:1000];
    
    if (!cellView) {
        cellView = [[TDD_ArtiTroubleCellView alloc] init];
        cellView.tag = 1000;
        cellView.delegate = self;
        [cell.contentView addSubview:cellView];
        
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
 
    NSInteger index = indexPath.row;
    
    if (index >= self.troubleModel.itemArr.count) {
        return;
    }
    
    TDD_ArtiTroubleItemModel * itemModel = self.troubleModel.itemArr[index];
    
    cellView.isShowTranslated = self.troubleModel.isShowTranslated;
    
    cellView.itemModel = itemModel;
    
        //AI 引导(目前只有德国定制)
        if ((([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany) || ([TDD_DiagnosisManage sharedManage].functionConfigMask & 1) || ([TDD_DiagnosisTools softWareIsCarPalSeries])) && indexPath.row == 0) {

            BOOL isShowGuild = [[NSUserDefaults standardUserDefaults] boolForKey:TDDDidShowTroubleGuild];
            if (!isShowGuild) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [cellView showGuildView];
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

- (void)ArtiTroubleCellButtonClick:(UIButton *)button
{
    UICollectionViewCell * cell = (UICollectionViewCell *)button.superview;
    
    while (![cell isKindOfClass:[UICollectionViewCell class]]) {
        cell = (UICollectionViewCell *)cell.superview;
        if (cell == nil) {
            return;
        }
    }
    
    if (button.tag == 203) {
        NSIndexPath * indexPath = [self.collectionView indexPathForCell:cell];
        
        self.troubleModel.returnID = (uint32_t)indexPath.row;
        
        [self.troubleModel conditionSignal];
    }else if (button.tag == 204) {
        NSIndexPath * indexPath = [self.collectionView indexPathForCell:cell];
        if ([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany || [TDD_DiagnosisManage sharedManage].functionConfigMask & 1) {
            if (![TDD_DiagnosisManage sharedManage].carModel.supportProfessionalTrouble) {
                //德国定制版本并且车型不支持专业版故障码直接前往 AI
                if ([self.troubleModel.delegate respondsToSelector:@selector(ArtiTroubleGotoAI:itemIndex:)]) {
                    [self.troubleModel.delegate ArtiTroubleGotoAI:self.troubleModel itemIndex:indexPath.row];
                    HLog(@"点击故障码 - 直接前往 AI");
                    return;
                }
            }
        }
        
//        if (isatty(STDOUT_FILENO) != 0) {
//            if ([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany) {
//                TDD_ArtiTroubleRepairInfoModle * infoModel = [[TDD_ArtiTroubleRepairInfoModle alloc] init];
//                if (self.troubleModel.itemArr.count > indexPath.row) {
//                    TDD_ArtiTroubleItemModel *item = self.troubleModel.itemArr[indexPath.row];
//                    infoModel.RIT_TROUBLE_DESC = item.strTroubleDesc;
//                }
//
//                switch (indexPath.row) {
//                    case 0:
//                        {
//                            infoModel.RIT_DTC_CODE = @"B0003";
//                            infoModel.RIT_VEHICLE_BRAND = @"CHEVROLET";
//                            infoModel.RIT_VEHICLE_YEAR = @"2023";
//                            infoModel.RIT_VEHICLE_MODEL = @"CT5";
//                        }
//                        break;
//                    case 1:
//                        {
//                            infoModel.RIT_DTC_CODE = @"P0300";
//                            infoModel.RIT_VEHICLE_BRAND = @"TOYOTA";
//                        }
//                        break;
//
//                    default:
//                        break;
//                }
//                [self.troubleModel.delegate ArtiTroubleSetRepairManualInfo:infoModel];
//            }
//        }
        
        //支持专业版故障码
        self.troubleModel.returnID = 0x40000000 + (uint32_t)indexPath.row;
        self.troubleModel.repairInfoIndex = indexPath.row;
        HLog(@"点击故障码 - 等待车型接口");
        [self.troubleModel conditionSignal];
        
    }
    
}

//- (void)ArtiTroubleCellMoreButtonClick:(TDD_ArtiTroubleCellView *)cellView
//{
//    UITableViewCell * cell = (UITableViewCell *)cellView;
//    
//    while (![cell isKindOfClass:[UITableViewCell class]]) {
//        cell = (UITableViewCell *)cell.superview;
//        if (cell == nil) {
//            HLog(@"ArtiTroubleCellMoreButtonClick cell为空");
//            return;
//        }
//    }
//    
//    cellView.itemModel.isShowMore = YES;
//    
//    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
//    
//    if (indexPath) {
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    }
//}

- (void)ArtiTroubleCellLockClick:(TDD_ArtiTroubleCellView *)cellView {
    [TDD_DiagnosisTools showSoftExpiredToBuyAlert:nil];
    
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    
    if (_troubleModel.itemArr.count > 0) {
        [self.collectionView scrollsToTop];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"VCdealloc" object:[self class]];
}

@end
