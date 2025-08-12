//
//  TDD_ChooseCarViewController.m
//  AD200
//
//  Created by 何可人 on 2022/4/16.
//

#ifdef __OBJC__
#import "TDD_ChooseCarViewController.h"
#import "TDD_DiagnosisViewController.h"
#import "TDD_ArtiMenuCellView.h"
#import "TDD_CarModel.h"
#import "TDD_DiagnosisTools.h"
#endif

#import "TDD_RightbuttonView.h"
@import TDBasis;
@import TDUIProvider;
@interface TDD_ChooseCarViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, TDD_HTipBtnViewDelegate,DiagnosisVCDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, strong) TDD_RightbuttonView *rightView;
@property (nonatomic, strong) TDD_CarModel * carModel;
@property (nonatomic, assign) CGFloat scale;
@end

@implementation TDD_ChooseCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _scale = IS_IPad ? HD_Height : H_Height;
    self.view.backgroundColor = [UIColor tdd_colorDiagNormalGradient:TDD_GradientStyleUpleftToLowright withFrame:self.view.bounds.size];
    
    self.titleStr = TDDLocalized.select_vehicle;
    self.naviView.naviType = kNaviTypeWhite;

    [self creatUI];
    
    [self getData];
   
    [self navbutton]; // tang 加
}

- (void)navbutton{

    self.rightView = [[TDD_RightbuttonView alloc]init];
    [self.naviView addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.naviView.mas_right).offset(-15 * _scale);
        make.centerY.equalTo(self.naviView.mas_centerY).offset(StatusBarHeight / 2);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(44);
    }];
    

}

- (void)getData
{
    self.dataArr = [TDD_DiagnosisTools searchAllDirectory];
    
    self.dataArr = [self.dataArr sortedArrayUsingComparator:^NSComparisonResult(TDD_CarModel * obj1, TDD_CarModel * obj2) {
        return [obj1.strVehicle compare:obj2.strVehicle]; // 升序
    }];
    
    [self.collectionView reloadData];
}

- (void)creatUI{
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(StatusBarHeight + 44);
        make.height.mas_equalTo(40 * _scale);
    }];
    
    UIButton * topBtn = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [[UIFont systemFontOfSize:20] tdd_adaptHD];
//        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"全部" forState:UIControlStateNormal];
        [btn setTitleColor:RgbColor(40, 102, 177, 1) forState:UIControlStateNormal];
        btn;
    });
    [self.view addSubview:topBtn];
    
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(StatusBarHeight + 44);
        make.height.mas_equalTo(40 * _scale);
        make.width.mas_equalTo(120 * _scale);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = RgbColor(221, 221, 221, 1);
    [self.view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(topBtn.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((IphoneWidth - 2) / 5.0, 255 * _scale);//每一个cell的大小
    layout.sectionInset = UIEdgeInsetsMake(0 * _scale, 0 * _scale, 0 * _scale, 0 * _scale);//四周的边距
    //设置最小边距
    layout.minimumLineSpacing = 0;
    
    //创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 22 * _scale, IphoneWidth, 170 * _scale) collectionViewLayout:layout];
    collectionView.backgroundColor = UIColor.clearColor;
    collectionView.delegate=self;
    collectionView.dataSource=self;
    collectionView.bounces = NO;
    collectionView.delaysContentTouches = NO;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(lineView.mas_bottom);
    }];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];

    TDD_ArtiMenuCellView * cellView = [cell.contentView viewWithTag:100];
    
    if (!cellView) {
        cellView = [[TDD_ArtiMenuCellView alloc] init];
        cellView.itemHeight = 255 * _scale;
        cellView.tag = 100;
        [cell.contentView addSubview:cellView];
        
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        
        CALayer *bottomLineLayer = [[CALayer alloc] init];
        bottomLineLayer.frame = CGRectMake(0, cell.bounds.size.height - 1, cell.bounds.size.width, 1);
        bottomLineLayer.backgroundColor = RgbColor(221, 221, 221, 1).CGColor;
        [cell.contentView.layer addSublayer:bottomLineLayer];
        
        CALayer *rightLineLayer = [[CALayer alloc] init];
        rightLineLayer.frame = CGRectMake(cell.bounds.size.width - 1, 0, 1, cell.bounds.size.height);
        rightLineLayer.backgroundColor = RgbColor(221, 221, 221, 1).CGColor;
        [cell.contentView.layer addSublayer:rightLineLayer];
    }
    
    if (indexPath.row >= self.dataArr.count) {
        return cell;
    }
    
    TDD_CarModel * carModel = self.dataArr[indexPath.row];
    
    ArtiMenuItemModel * itemModel = cellView.itemModel;
    
    if (!itemModel) {
        itemModel = [[ArtiMenuItemModel alloc] init];
    }
    
    itemModel.strItem = carModel.strVehicle;
    
    cellView.itemModel = itemModel;
    
    return cell;
}

//布局确定每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((IphoneWidth) / 5.0, 255 * _scale);
}

//返回每个section内左右两个Item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//返回每个section内上下两个Item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

// 高亮时调用
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor tdd_colorDiagTheme];
}

// 高亮结束调用
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row >= self.dataArr.count) {
        return;
    }
    
    TDD_CarModel * carModel = self.dataArr[indexPath.row];
    
    self.carModel = carModel;
    
    NSString *tipStr = [NSString stringWithFormat:@"%@\n资源库:%@\n静态库:%@", carModel.strVehicle, carModel.strVersion, carModel.strStaticLibraryVersion];
    @kWeakObj(self);
    [LMSAlertController showDefaultWithTitle:tipStr content:nil image:nil confirmAction:^(LMSAlertAction * _Nonnull confirmAction) {
        @kStrongObj(self);
        if ([carModel.strVehicle isEqualToString:@"DEMO"]) {
            [TDD_ArtiGlobalModel sharedArtiGlobalModel].softCode = @"AD200_CarSW_DEMO_iOS";
        }else {
            [TDD_ArtiGlobalModel sharedArtiGlobalModel].softCode = [NSString stringWithFormat:@"AD200_CarSW_%@_iOS",carModel.strVehicle];
        }

        [TDD_DiagnosisManage enterDiagViewControllerWithCarModel:self.carModel entryType:self.diagEntryType menuMask:DMM_ALL_SYSTEM_SUPPORT delegate:self.delegate];
    }];
    
}

#pragma mark -- DiagnosisVCDelegate
- (void)finishDiag:(TDD_DiagnosisViewController *)diagVC {
    [self backClick];
}

- (void)artiModelDelegate:(nonnull TDD_ArtiModelBase *)artiModel eventType:(TDD_ArtiModelEventType)eventType param:(nullable NSDictionary *)param diagVC:(nonnull UIViewController *)diagVC {
    if ([self.delegate respondsToSelector:@selector(artiModelDelegate:eventType:param:diagVC:)]) {
        [self.delegate artiModelDelegate:artiModel eventType:eventType param:param diagVC:diagVC completeHandle:nil];
    }
}


- (void)handleOtherEvent:(TDD_DiagOtherEventType)eventType model:(nonnull TDD_ArtiModelBase *)artiModel param:(nullable NSDictionary *)param diagVC:(nonnull UIViewController *)diagVC {
    if ([self.delegate respondsToSelector:@selector(handleOtherEvent:model:param:diagVC:)]){
        [self.delegate handleOtherEvent:eventType model:artiModel param:param diagVC:diagVC];
    }
}

- (void)artiModelDelegate:(nonnull TDD_ArtiModelBase *)artiModel eventType:(TDD_ArtiModelEventType)eventType param:(nullable NSDictionary *)param diagVC:(nonnull UIViewController *)diagVC completeHandle:(nullable void (^)(id _Nonnull))complete {
    if ([self.delegate respondsToSelector:@selector(artiModelDelegate:eventType:param:diagVC:completeHandle:)]) {
        [self.delegate artiModelDelegate:artiModel eventType:eventType param:param diagVC:diagVC completeHandle:complete];
    }
}



@end
