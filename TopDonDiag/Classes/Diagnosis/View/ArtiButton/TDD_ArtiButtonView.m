//
//  TDD_ArtiButtonView.m
//  AD200
//
//  Created by 何可人 on 2022/4/27.
//

#import "TDD_ArtiButtonView.h"
#import "TDD_ArtiButtonCellView.h"
#import "TDD_ButtonTableView.h"

@interface TDD_ArtiButtonView ()<UITableViewDelegate,UITableViewDataSource,TDD_ArtiButtonCellViewDelegate>
@property (nonatomic, strong) TDD_ButtonTableView * tableView;
@property (nonatomic, strong) UIStackView * stackView;
@property (nonatomic, strong) NSArray<TDD_ArtiButtonModel *> * buttonArr;//按钮数组
@property (nonatomic, strong) NSMutableArray * cellArr;
@property (nonatomic, assign) CGFloat btnWidth;
@property (nonatomic, assign) CGFloat spaceWidth;
@end

@implementation TDD_ArtiButtonView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        CGFloat scale = IS_IPad ? HD_Height : H_Height;
        _btnWidth = (IS_IPad ? 160 : 100) * scale;
        _spaceWidth = (IS_IPad ? 20 : 10) * scale;
        // gradient
//        CAGradientLayer *gl = [CAGradientLayer layer];
//        gl.frame = CGRectMake(0,0,IphoneWidth,59 * H_Height + iPhoneX_D);
//        gl.startPoint = CGPointMake(0.5, 0);
//        gl.endPoint = CGPointMake(0.5, 1);
//        gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:242/255.0 green:248/255.0 blue:253/255.0 alpha:1.0].CGColor];
//        gl.locations = @[@(0), @(1.0f)];
//        gl.cornerRadius = 10 * H_Height;
        
        
        //[self.layer addSublayer:gl];
    }
    
    return self;
}

- (void)setModel:(TDD_ArtiModelBase *)model
{
    _model = model;
    
    if (!model.isReloadButton) {
         return;
    }else {
        //刷新一次即可
        model.isReloadButton = NO;
    }
    
    HLog(@"刷新底部按钮");
    
    NSMutableArray *allButtonArr = [NSMutableArray new];
    [allButtonArr addObjectsFromArray:model.customButtonArr];
    [allButtonArr addObjectsFromArray:model.buttonArr];
    self.buttonArr = allButtonArr;
}


- (void)setButtonArr:(NSArray<TDD_ArtiButtonModel *> *)buttonArr{
    //Carpal 进车中退到后台，在后台完成进车。再打开前台。tableView 的 frame 可能为 0
    if (!self.tableView || self.tableView.frame.size.width == 0 || self.tableView.frame.size.height == 0) {
        [self creatTableView];
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uStatus <= 1"];
    
    NSArray *filterArray = [buttonArr filteredArrayUsingPredicate:predicate];
    
    _buttonArr = filterArray;
    
    float buttonWidth = _btnWidth + _spaceWidth;
    
    float width = _buttonArr.count * buttonWidth;
    
    if (width < self.bounds.size.width) {
        width = self.bounds.size.width - width;
        if (self.tableView.contentInset.top != width) {
            self.tableView.contentInset = UIEdgeInsetsMake(width, 0, 0, 0);
        }
    }else{
        if (self.tableView.contentInset.top != 0) {
            self.tableView.contentInset = UIEdgeInsetsMake(_spaceWidth, 0, 0, 0);
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)creatTableView{
    if (self.tableView && self.tableView.superview) {
        [self.tableView removeFromSuperview];
    }
    TDD_ButtonTableView *tableView = [[TDD_ButtonTableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.width) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
    [tableView setTransform:CGAffineTransformMakeRotation(-M_PI*0.5)];
    tableView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerClass:[TDD_ArtiButtonCellView class] forCellReuseIdentifier:@"cellIdentify"];
    
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.buttonArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identify = [NSString stringWithFormat:@"Cell%d%d", (int)[indexPath section], (int)[indexPath row]];//以indexPath来唯一确定
    TDD_ArtiButtonCellView *cell = [tableView dequeueReusableCellWithIdentifier:identify];

    if (!cell) {
        if (self.cellArr.count < 30) {
            cell = [[TDD_ArtiButtonCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            [self.cellArr addObject:cell];
        }else{
            cell = self.cellArr[indexPath.row % 30];
        }
    }

    
    if (indexPath.row >= self.buttonArr.count) {
        return cell;
    }
    
    TDD_ArtiButtonModel * model = self.buttonArr[indexPath.row];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.buttonArr.count) {
        return 0;
    }
    
    TDD_ArtiButtonModel * model = self.buttonArr[indexPath.row];
    
    if (model.uStatus == ArtiButtonStatus_UNVISIBLE) {
        return 0;
    }
    
    return _btnWidth + _spaceWidth;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return UIView.new;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10 * H_Height;
//}


- (void)ArtiButtonCellButtonClick:(UIButton *)Button cell:(nonnull TDD_ArtiButtonCellView *)cell
{
    TDD_ArtiButtonModel * model = cell.model;
    
    CGPoint cellCenter = cell.center;
    // 将 cell 的中心点转换到 window 坐标系
    CGPoint cellCenterInWindow = [cell convertPoint:cellCenter toView:FLT_APP_WINDOW];
    model.clickPoint = cellCenterInWindow;
    //过期加锁软件不适用报告置灰逻辑
    if (model.uButtonId == DF_ID_REPORT && ![TDD_DiagnosisTools isLimitedTrialFuction]) {
        //报告按钮
        model.uStatus = ArtiButtonStatus_DISABLE;
        model.bIsTemporaryNoEnable = YES;
        [self.tableView reloadData];
    }
    
    if ([self.delegate respondsToSelector:@selector(ArtiButtonClick:)]) {
        [self.delegate ArtiButtonClick:model];
    }
}


//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//
//}

@end
