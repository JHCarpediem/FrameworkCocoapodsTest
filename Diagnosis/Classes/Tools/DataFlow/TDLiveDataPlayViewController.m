//
//  TDLiveDataPlayViewController.m
//  AD200
//
//  Created by App on 2022/9/1.
//

#import "TDLiveDataPlayViewController.h"
#import "TDD_ArtiLiveDataView.h"
#import "TDD_ArtiLiveDataRecordeSaveModel.h"
#import "TDD_ArtiLiveDataRecordeChangeModel.h"
#define GetDataNub 50

@interface TDLiveDataPlayViewController ()
@property (nonatomic,strong) TDD_ArtiLiveDataView * liveDataView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSTimer *timer; //定时器
@property (nonatomic,assign) int playNub; //播放到第几个
@property (nonatomic,assign) BOOL isPlay; //是否播放
@property (nonatomic,strong) UILabel * playTipLabel;
@property (nonatomic,strong) UIView * progressView;//进度条
@property (nonatomic,strong) UIView * progressBackView;//进度条背景
@property (nonatomic,strong) UIImageView * progressThumbView;
@property (nonatomic,strong) UIButton * playButton;
@property (nonatomic,strong) UIButton * playLeftButton;
@property (nonatomic,strong) UIButton * playRightButton;
@property (nonatomic,assign) double playSpeed;//播放速度
@property (nonatomic,strong) UILabel * playTimeLabel;
@property (nonatomic,assign) int playTotal;
@property (nonatomic,assign) int dataNub;//数据获取的次数
@property (nonatomic,strong) TDD_ArtiLiveDataModel *liveDataModel;
@property (nonatomic,strong) TDD_ArtiLiveDataModel *firstLiveDataModel;
@property (nonatomic,assign) BOOL isNewData;
@property (nonatomic,assign) long startTimeDiffer;//startTime 与现在时间的差值
@property (nonatomic,assign) int playType;//0自动播放、1 逐帧播放
@property (nonatomic,assign) CGFloat scale;
@property (nonatomic,assign) BOOL isDraging;
@property (nonatomic,assign) CGFloat dataVersion;
@end

@implementation TDLiveDataPlayViewController
{
    BOOL _isGetingData;
}

- (void)dealloc {
    // 退出页面还原数据库
    [TDD_DiagnosisManage switchDBType:TDD_DATA_BASE_TYPE_DEFAULT];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self stopTimer];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor tdd_colorF5F5F5];
    _scale =  H_Height;
    _dataVersion = [self.model.dataVersion stringByReplacingOccurrencesOfString:@"V" withString:@""].floatValue;
    _isNewData = _dataVersion >= 2.00;
    
    self.playSpeed = 1;
    
    self.titleStr = @"数据流播放";
    
    [TDD_HTipManage showNewLoadingViewWithTitle:@""];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [TDD_HTipManage deallocView];
            
            [self creatUI];
            
            if (self.dataArr.count > 0) {
                if (self.liveDataModel) {
                    self.liveDataView.liveDataModel = self.liveDataModel;
                }else if(!self.isNewData) {
                    self.liveDataView.liveDataModel = self.dataArr[0];
                }
                
                [self play];
            }
        });
    });
}

- (void)getData
{
    
    if (!self.playTotal) {
        [TDD_DiagnosisManage switchDBType:self.model.dbType];
        if (_isNewData) {
            self.playTotal = [TDD_ArtiLiveDataRecordeModel findCountByCriteria:[NSString stringWithFormat:@"where createTime = '%@'", self.model.createTime]];
        }else {
            self.playTotal = [TDD_ArtiLiveDataRecordeSaveModel findCountByCriteria:[NSString stringWithFormat:@"where createTime = '%@'", self.model.createTime]];
        }
    }
    
    if (self.dataNub * 100 > self.playTotal) {
        return;
    }
    if (_isNewData) {
        if (!_liveDataModel) {
            _liveDataModel = [TDD_ArtiLiveDataModel yy_modelWithJSON: _model.firstStrData];
            //重置开始时间为当前时间
            NSTimeInterval nowTime = [NSDate tdd_getTimestampSince1970];
            _startTimeDiffer = nowTime - _liveDataModel.startTime;
            _liveDataModel.startTime = nowTime;

            //item 由 Dict 转 model
            NSMutableArray *items = _liveDataModel.showItems;
            //当前app 的公英制
            TDD_UnitConversionType type = TDD_UnitConversionType_Metric;

            [items enumerateObjectsUsingBlock:^(TDD_ArtiLiveDataItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TDD_ArtiLiveDataItemModel *model;
                if (![obj isKindOfClass:[TDD_ArtiLiveDataItemModel class]]) {
                    model = [TDD_ArtiLiveDataItemModel yy_modelWithJSON:obj];
                    //model 初始化时设置的 unit、min、max 都会把用户设置的setMax 和 setMin 给修改掉,所以需要保存一下
                    
                    if ([obj isKindOfClass: [NSDictionary class]]) {
                        NSDictionary *objDict = (NSDictionary *)obj;
                        NSNumber *unitConversionType = objDict[@"unitConversionType"];
                        NSNumber * originalUnitConversionType = objDict[@"originalUnitConversionType"];
                        NSString *setStrMax = objDict[@"setStrMax"];
                        NSString *setStrMin = objDict[@"setStrMin"];

                        //是否需要转换公英制
                        BOOL shouldConversion = false;
                        if (unitConversionType.intValue == 0) {
                            //没有修改单个 Item 的单位
                            if (originalUnitConversionType.intValue != type && _dataVersion == 3.00) {
                                shouldConversion = true;
                            }
                            
                        }
                        if (shouldConversion) {
                            
                            if (type == TDD_UnitConversionType_Metric) {
                                model.setStrMax = ((model.maxProgress == 0 || model.maxProgress == 1) ? model.strMetricMax : [NSString stringWithFormat:@"%.2f",model.strMetricMin.doubleValue +  (model.strMetricMax.doubleValue - model.strMetricMin.doubleValue) * model.maxProgress]);
                                
                                model.setStrMin = ((model.minProgress == 0 || model.minProgress == 1) ? model.strMetricMin : [NSString stringWithFormat:@"%.2f",model.strMetricMin.doubleValue +  (model.strMetricMax.doubleValue - model.strMetricMin.doubleValue) * model.minProgress]);
                            }else {
                                model.setStrMax = ((model.maxProgress == 0 || model.maxProgress == 1) ? model.strImperialMax : [NSString stringWithFormat:@"%.2f",model.strImperialMin.doubleValue +  (model.strImperialMax.doubleValue - model.strImperialMin.doubleValue) * model.maxProgress]);
                                
                                model.setStrMin = ((model.minProgress == 0 || model.minProgress == 1) ? model.strImperialMin : [NSString stringWithFormat:@"%.2f",model.strImperialMin.doubleValue +  (model.strImperialMax.doubleValue - model.strImperialMin.doubleValue) * model.minProgress]);
                            }

                        }else {
                            model.setStrMax = setStrMax;
                            model.setStrMin = setStrMin;
                        }

                    }

                    [items replaceObjectAtIndex:idx withObject:model];
                }else {
                    *stop = YES;
                }
                
            }];
            _firstLiveDataModel = _liveDataModel.mutableCopy;
        }

        NSArray *saveArr = [TDD_ArtiLiveDataRecordeModel findByCriteria:[NSString stringWithFormat:@"where createTime = '%@' limit %d,100", self.model.createTime, self.dataNub * 100]];

        //TDD_ArtiLiveDataModel 替换修改的属性
        for (TDD_ArtiLiveDataRecordeModel *model in saveArr) {
            if(model && [model isKindOfClass:[TDD_ArtiLiveDataRecordeModel class]]){
                [self.dataArr addObject:model];
            }else {
                NSLog(@"V2.00数据流本地数据有误:%@",model);
            }
        }
        
    }else {
        NSArray * saveArr = [TDD_ArtiLiveDataRecordeSaveModel findByCriteria:[NSString stringWithFormat:@"where createTime = '%@' limit %d,100", self.model.createTime, self.dataNub * 100]];
        NSMutableDictionary *preValueDic = [self preparePreviousValueDictory];
        for (TDD_ArtiLiveDataRecordeSaveModel * saveModel in saveArr) {
            TDD_ArtiLiveDataModel * model = [TDD_ArtiLiveDataModel yy_modelWithJSON: saveModel.strData];
            [self fillPreviousValueArrInModel:model witDic:preValueDic];
            //model不能为nil
            if(model && [model isKindOfClass:[TDD_ArtiLiveDataModel class]]){
                [self.dataArr addObject:model];
            }else {
                NSLog(@"数据流本地数据有误:%@",saveModel.strData);
            }
            
        }
    }

    
    self.dataNub ++;
}

- (NSString *)converStr:(double )value
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    formatter.maximumFractionDigits = 5;
    formatter.minimumIntegerDigits = 1;
    [formatter setDecimalSeparator:@"."];
    NSString *string = [formatter stringFromNumber:@(value)];
    return string;
}

- (NSMutableArray<TDD_ArtiLiveDataItemModel *> *)showItemsFromModel:(TDD_ArtiLiveDataModel *)liveDataModel {
    if (liveDataModel.searchItems.count == 0) {
        return liveDataModel.selectItmes;
    }
    return liveDataModel.searchItems;
}

#pragma mark ----- 初版数据
- (NSMutableDictionary *)preparePreviousValueDictory
{
    NSMutableDictionary *preValueDic = [[NSMutableDictionary alloc] init];
    
    if (self.dataArr.count == 0) {
        return preValueDic;
    }
    TDD_ArtiLiveDataModel * model = _isNewData?_liveDataModel:self.dataArr.lastObject;
    NSArray *items = model.showItems;
    for (int i = 0; i < items.count; i++) {
        TDD_ArtiLiveDataItemModel *currentItemModel = items[i];
        if ([currentItemModel isKindOfClass:[NSDictionary class]]) {
            currentItemModel = [TDD_ArtiLiveDataItemModel yy_modelWithDictionary:(NSDictionary *)currentItemModel];
        }
        
        NSString *indexKey = [NSString stringWithFormat:@"%d", currentItemModel.index];
        
        if (currentItemModel.valueArr.count > 400) {
            NSMutableArray *subArr = [[NSMutableArray alloc] initWithArray:currentItemModel.valueArr];
            [subArr removeObjectsInRange: NSMakeRange(0, 100)];
            currentItemModel.valueArr = subArr;
        }
        
        preValueDic[indexKey] = currentItemModel.valueArr;
    }
    
    return preValueDic;
}

- (void)fillPreviousValueArrInModel:(TDD_ArtiLiveDataModel *)model witDic:(NSMutableDictionary *)preValueDic
{
    NSMutableArray *items = model.showItems;
    for (int i = 0; i < items.count; i++) {
        TDD_ArtiLiveDataItemModel *currentItemModel = items[i];
        if ([currentItemModel isKindOfClass:[NSDictionary class]]) {
            currentItemModel = [TDD_ArtiLiveDataItemModel yy_modelWithDictionary:(NSDictionary *)currentItemModel];
        }
        
        NSMutableArray *preValueArr;
        NSString *indexKey = [NSString stringWithFormat:@"%d", currentItemModel.index];
        if (preValueDic[indexKey] != nil) {
            preValueArr = [[NSMutableArray alloc] initWithArray: preValueDic[indexKey]];
        }else {
            preValueArr = [[NSMutableArray alloc] init];
        }
        
        NSMutableArray *valueMArr = [NSMutableArray arrayWithArray:currentItemModel.valueArr];
        if (valueMArr.count > 0) {
            if (valueMArr.count > 1) {
                [valueMArr removeLastObject];
            }
            [preValueArr addObject:valueMArr.lastObject];
            
        }
        
        preValueDic[indexKey] = preValueArr;
        NSLog(@"fillPreviousValueArrInModel:%ld",preValueArr.count);
        currentItemModel.valueArr = [preValueArr copy];
        items[i] = currentItemModel;
    }
}

- (void)creatUI
{
    UIView * blackView = [[UIView alloc] init];
    blackView.layer.backgroundColor = [UIColor tdd_colorWithHex:0x000000 alpha:0.8].CGColor;
    [self.view addSubview:blackView];
    
    UIButton * playButton = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];

        [btn setImage:kImageNamed(@"liveData_play") forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(5 * _scale, 5 * _scale, 5 * _scale, 5 * _scale)];

        btn;
    });
    [blackView addSubview:playButton];
    self.playButton = playButton;
    
    UIView * progressTapView = [[UIView alloc] init];
    [blackView addSubview:progressTapView];
    if (_dataVersion == 3.00) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleProgressTap:)];
        [progressTapView addGestureRecognizer:tap];
    }
    
    UIView * progressBackView = [[UIView alloc] init];
    progressBackView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    progressBackView.layer.cornerRadius = 2 * _scale;


    [progressTapView addSubview:progressBackView];
    self.progressBackView = progressBackView;
    
    UIView * progressView = [[UIView alloc] init];
    progressView.layer.backgroundColor = [UIColor tdd_colorDiagTheme].CGColor;
    progressView.layer.cornerRadius = 2 * _scale;
    [progressBackView addSubview:progressView];
    self.progressView = progressView;

    if (_dataVersion == 3.00) {
        // 添加滑块
        UIImageView *progressThumbView = [[UIImageView alloc] initWithImage:kImageNamed(@"liveData_play_normal_point")];
        progressThumbView.userInteractionEnabled = true;
        [blackView addSubview:progressThumbView];

        // 初始位置
        [progressThumbView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(progressBackView);
            make.centerX.equalTo(self.progressView.mas_right);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];

        // 拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleThumbPan:)];
        [progressThumbView addGestureRecognizer:pan];

        // 保存引用
        self->_progressThumbView = progressThumbView;
    }
    
    UIButton * playLeftButton = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(playLeftButtonClick) forControlEvents:UIControlEventTouchUpInside];

        [btn setImage:kImageNamed(@"liveData_play_left") forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(5 * _scale, 5 * _scale, 5 * _scale, 5 * _scale)];

        btn.enabled = false;
        btn;
    });
    [blackView addSubview:playLeftButton];
    self.playLeftButton = playLeftButton;
    
    UIButton * playRightButton = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(playRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setImage:kImageNamed(@"liveData_play_right") forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(5 * _scale, 5 * _scale, 5 * _scale, 5 * _scale)];

        btn;
    });
    [blackView addSubview:playRightButton];
    self.playRightButton = playRightButton;
    
    //切换播放模式
    UIButton *playTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playTypeBtn.backgroundColor = [UIColor tdd_color666666];
    [playTypeBtn tdd_addCornerRadius:4];
    [playTypeBtn addTarget:self action:@selector(changePlayType) forControlEvents:UIControlEventTouchUpInside];
    [blackView addSubview:playTypeBtn];
    
    UIImageView *changeImageView = [[UIImageView alloc] initWithImage:kImageNamed(@"liveData_change")];
    [blackView addSubview:changeImageView];
    
    UILabel * playTipLabel = ({
        UILabel * label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = UIColor.whiteColor;
        label.numberOfLines = 0;
        label.text = @"自动回放";
        label;
    });
    self.playTipLabel = playTipLabel;
    [playTypeBtn addSubview:playTipLabel];
    
    UILabel * playTimeLabel = ({
        UILabel * label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = UIColor.whiteColor;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"X1";//[NSString stringWithFormat:@"%@  1/%d", Localized.frame_play, self.playTotal];
        label;
    });
    [blackView addSubview:playTimeLabel];
    self.playTimeLabel = playTimeLabel;
    
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.height.mas_equalTo(101 + kSafeBottomHeight);
        
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [playTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blackView).offset(12);
        make.left.equalTo(blackView).offset(20);
        make.height.mas_equalTo(24);
    }];
    
    [changeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(playTypeBtn);
        make.left.equalTo(playTypeBtn).offset(10);

    }];
    
    [playTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(playTypeBtn).offset(4);
        make.left.equalTo(changeImageView.mas_right).offset(5);
        make.centerY.equalTo(playTypeBtn);
        make.right.equalTo(playTypeBtn.mas_right).offset(-10);
    }];
    
    [playTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(playTypeBtn);
        make.right.equalTo(blackView).inset(20);
    }];
    
    [progressTapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playTypeBtn.mas_bottom).offset(2);
        make.left.right.equalTo(blackView).inset(20);
        make.height.mas_equalTo(16);
    }];
    
    [progressBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playTypeBtn.mas_bottom).offset(8);
        make.left.right.equalTo(blackView).inset(20);
        make.height.mas_equalTo(4);
    }];
    
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(progressBackView);
        make.width.mas_equalTo(0);
    }];
    
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(progressTapView.mas_bottom).offset(6);
        make.centerX.equalTo(blackView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    
    [playLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playButton);
        make.right.equalTo(playButton.mas_left).offset(-32);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [playRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playButton);
        make.left.equalTo(playButton.mas_right).offset(32);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    
    [self.liveDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.naviView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(blackView.mas_top);
    }];
}

#pragma mark ---- 3.00 增加滑动 ------
- (void)handleThumbPan:(UIPanGestureRecognizer *)pan {
    _isDraging = true;
    UIImageView *thumb = (UIImageView *)pan.view;
    UIView *backView = thumb.superview;
    CGPoint translation = [pan locationInView:backView];

    // 当前x位置
    CGFloat leftMargin = 20;
    CGFloat rightMargin = 20;

    CGFloat minX = leftMargin;
    CGFloat maxX = backView.bounds.size.width - rightMargin - thumb.bounds.size.width;
    CGFloat newX = translation.x - thumb.bounds.size.width;

    // 限制滑块范围
    newX = MAX(minX, MIN(newX, maxX));

    // 计算进度（相对有效滑动区域）
    CGFloat progress = (newX - minX) / (maxX - minX);
    progress = fmin(fmax(progress, 0), 1.0);

    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.progressBackView.bounds.size.width * progress);
    }];
    
    [backView layoutIfNeeded];

    // 计算当前播放帧
    int newIndex = (int)(progress * (self.playTotal - 1));
    if (newIndex < 0) newIndex = 0;
    if (newIndex >= self.playTotal) newIndex = self.playTotal - 1;

    // 拖动时更新显示
    self.playNub = newIndex;
    if (_playType == 0) {
        self.playTimeLabel.text = [NSString stringWithFormat:@"X%.0f", self.playSpeed];
    } else {
        self.playTimeLabel.text = [NSString stringWithFormat:@"%d/%d", MAX(newIndex+1, 1), (int)self.playTotal];
    }

    if (pan.state == UIGestureRecognizerStateEnded ||
        pan.state == UIGestureRecognizerStateCancelled) {

        [TDD_HTipManage showNewLoadingViewWithTitle:@""];
        [thumb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        [thumb setImage:kImageNamed(@"liveData_play_normal_point")];
        if (_playType == 1) {
            if (newIndex >= (_playTotal - 1)) {
                _playLeftButton.enabled = true;
                _playRightButton.enabled = false;
            }else if (newIndex <= 1){
                _playLeftButton.enabled = false;
                _playRightButton.enabled = true;
            }else {
                _playLeftButton.enabled = _playRightButton.enabled = true;
            }
        }

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self getDataWith:newIndex];
        });

    }else {
        [thumb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        [thumb setImage:kImageNamed(@"liveData_play_drag_point")];
    }

    // 清除平移量（防止连续累积）
    [pan setTranslation:CGPointZero inView:backView];
}

#pragma mark ---- 点击进度条跳转 ----
- (void)handleProgressTap:(UITapGestureRecognizer *)tap {
    _isDraging = true;
    UIView *backView = tap.view; // 即 progressBackView
    CGPoint location = [tap locationInView:backView];

    CGFloat leftMargin = 20;
    CGFloat rightMargin = 20;
    CGFloat thumbWidth = self->_progressThumbView.bounds.size.width;

    CGFloat minX = leftMargin;
    CGFloat maxX = backView.bounds.size.width - rightMargin - thumbWidth;

    // 点击的 X 限制在有效范围
    CGFloat tapX = location.x - thumbWidth * 0.5;
    tapX = MAX(minX, MIN(tapX, maxX));

    // 计算进度
    CGFloat progress = (tapX - minX) / (maxX - minX);
    progress = fmin(fmax(progress, 0), 1.0);

    // 更新进度条宽度
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.progressBackView.bounds.size.width * progress);
    }];
    [self.progressBackView layoutIfNeeded];

    // 计算对应帧索引
    int newIndex = (int)(progress * (self.playTotal - 1));
    newIndex = MAX(0, MIN(newIndex, (int)self.playTotal - 1));
    self.playNub = newIndex;

    // 更新文字显示
    if (_playType == 0) {
        self.playTimeLabel.text = [NSString stringWithFormat:@"X%.0f", self.playSpeed];
    } else {
        self.playTimeLabel.text = [NSString stringWithFormat:@"%d/%d", newIndex + 1, (int)self.playTotal];
    }

    // 异步加载数据
    [TDD_HTipManage showNewLoadingViewWithTitle:@""];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getDataWith:newIndex];
    });
}

- (void)getDataWith:(NSInteger )index {
    HLog(@"in betweenAB - 0");
    NSInteger offset = index;   // 第 X 条
    NSString *createTime = self.model.createTime;
    NSString *criteria = [NSString stringWithFormat:
        @"WHERE createTime = '%@' "
         "ORDER BY pk ASC "
         "LIMIT 1 OFFSET %ld",
         createTime, (long)offset];
    
    NSArray *results = [TDD_ArtiLiveDataRecordeModel findByCriteria:criteria];
    
    TDD_ArtiLiveDataRecordeModel *model;
    if (results.count > 0) {
        model = results.firstObject;
        CGFloat chartTimeA = model.chartTime.floatValue;
        CGFloat chartTimeB = MAX(chartTimeA - 25, 0);
        HLog(@"in betweenAB - 1");
        NSString *criteriaB = [NSString stringWithFormat:
            @"WHERE createTime = '%@' AND chartTime<=%.6f ORDER BY pk ASC LIMIT 1",
             createTime, chartTimeB];
        TDD_ArtiLiveDataRecordeModel *modelB = [TDD_ArtiLiveDataRecordeModel findFirstByCriteria:criteriaB];
        int pkB = 0;
        if (modelB) {
            pkB = modelB.pk;
        }
        
        NSString *criteriaa = [NSString stringWithFormat:
            @"WHERE createTime='%@' AND pk BETWEEN %d AND %d ORDER BY pk ASC",
            createTime,
            MAX(pkB - 100, 0),   // 向前扩 100
            model.pk + 100        // 向后扩 100
        ];

        // 一次性取出完整数据
        NSArray<TDD_ArtiLiveDataRecordeModel *> *combined =
            [TDD_ArtiLiveDataRecordeModel findByCriteria:criteriaa];

        // 内存中手动分段
        NSMutableArray *beforeB = [NSMutableArray array];
        NSMutableArray *betweenAB = [NSMutableArray array];
        NSMutableArray *afterA = [NSMutableArray array];

        for (TDD_ArtiLiveDataRecordeModel *record in combined) {
            if (record.pk < pkB) {
                [beforeB addObject:record];
            } else if (record.pk <= model.pk) {
                [betweenAB addObject:record];
            } else {
                [afterA addObject:record];
            }
        }
        
        NSMutableArray *mutableCombined = [NSMutableArray array];
        [mutableCombined addObjectsFromArray:beforeB];
        [mutableCombined addObjectsFromArray:betweenAB];
        [mutableCombined addObjectsFromArray:afterA];
        self.dataArr = mutableCombined;
        TDD_ArtiLiveDataModel *firstLiveDataModel = _firstLiveDataModel.mutableCopy;
        
        HLog(@"in betweenAB - 2");
        // 建立 index -> itemModel 的映射表
        NSMutableDictionary<NSNumber *, TDD_ArtiLiveDataItemModel *> *itemMap = [NSMutableDictionary dictionaryWithCapacity:_liveDataModel.showItems.count];
        for (TDD_ArtiLiveDataItemModel *item in firstLiveDataModel.showItems) {
            if (![item.valueArr isKindOfClass:[NSMutableArray class]]) {
                item.valueArr = [NSMutableArray arrayWithArray:item.valueArr];
            }
            itemMap[@(item.index)] = item;
        }

        HLog(@"in betweenAB - 3");
        TDD_ArtiLiveDataRecordeModel *firstModel = [betweenAB firstObject];
        TDD_ArtiLiveDataRecordeModel *lastModel = [betweenAB lastObject];
        int minPK = firstModel.pk;
        int maxPK = lastModel.pk;

        NSString *criteria = [NSString stringWithFormat:
                              @"WHERE recordModelPK BETWEEN %d AND %d", minPK, maxPK];
        NSArray<TDD_ArtiLiveDataRecordeChangeModel *> *allChanges =
            [TDD_ArtiLiveDataRecordeChangeModel findByCriteria:criteria];
        
        HLog(@"in betweenAB - 4");
        
        for (TDD_ArtiLiveDataRecordeChangeModel *change in allChanges) {
            TDD_ArtiLiveDataItemModel *itemModel = itemMap[@(change.itemIndex)];
            if (!itemModel) continue;

            itemModel.chartTime = change.chartTime;
            itemModel.startTime = change.startTime;
            itemModel.isTempe = NO;
            itemModel.isPlay = YES;
            BOOL shouldAddChart = false;
            if (![NSString tdd_isEmpty:change.strValue]) {
                itemModel.strValue = change.strValue;
                shouldAddChart = (itemModel.UIType == 1);
            }
            if (![NSString tdd_isEmpty:change.strUnit]) {
                itemModel.strUnit = change.strUnit;
                shouldAddChart = (itemModel.UIType == 1);
            }
            if (![NSString tdd_isEmpty:change.strName]) {
                itemModel.strName = change.strName;
            }
            if (![NSString tdd_isEmpty:change.strMin]) {
                itemModel.strMin = change.strMin;
            }
            if (![NSString tdd_isEmpty:change.strMax]) {
                itemModel.strMax = change.strMax;
            }
            if (shouldAddChart) {
                TDD_HChartModel * chartModel = [[TDD_HChartModel alloc] init];
                chartModel.valueStr = change.strValue;
                chartModel.time = change.chartTime;
                [itemModel.valueArr addObject:chartModel];
                if (itemModel.valueArr.count > 1000) {
                    [itemModel.valueArr removeObjectsInRange:NSMakeRange(0, itemModel.valueArr.count - 1000)];
                }
            }
        }
        HLog(@"in betweenAB - 5");

        _liveDataModel = firstLiveDataModel;
        dispatch_async(dispatch_get_main_queue(), ^{
            [TDD_HTipManage deallocView];
            self.liveDataView.liveDataModel = firstLiveDataModel;
            self->_isDraging = false;
        });

        NSLog(@"SQL");
    } else {
        NSLog(@"没找到符合条件的数据");
    }
    
}

- (void)play
{
    if (self.dataArr.count == 0) {
        return;
    }
    
    self.isPlay = !self.isPlay;
    
    if (self.isPlay) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if (self.playNub >= self.playTotal - 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [TDD_HTipManage showNewLoadingViewWithTitle:@""];
                });
                self.playNub = 0;
                self.dataNub = 0;
                [self.dataArr removeAllObjects];
                if (self.isNewData) {
                    //还原回初始数据
                    self.liveDataModel = nil;
                }
                [self getData];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [TDD_HTipManage deallocView];
                [self timerMethod:true];
                [self stratPlay];
            });
        });
        
    }else {
        [self stopPlay];
    }
}

- (void)playLeftButtonClick
{
    self.playRightButton.enabled = true;
    if (_playType == 0) {
        if (self.playSpeed == 1) {
            return;
        }
        self.playSpeed = self.playSpeed - 1;
        self.playLeftButton.enabled = (self.playSpeed > 1);
        self.playTimeLabel.text = [NSString stringWithFormat:@"X%.0f",self.playSpeed];
        if (!self.isPlay) {
            return;
        }
    
        [self stopTimer];
        
        [self startTimer];
    }else {
        self.playLeftButton.enabled = (_playNub > 1);
        [self forwardFrame];
        
    }
    
}

- (void)playRightButtonClick
{
    self.playLeftButton.enabled = true;
    if (_playType == 0) {
        if (self.playSpeed == 4) {
            return;
        }
        self.playSpeed = self.playSpeed + 1;
        self.playRightButton.enabled = (self.playSpeed < 4);
        
        self.playTimeLabel.text = [NSString stringWithFormat:@"X%.0f",self.playSpeed];
        if (!self.isPlay) {
            return;
        }

        [self stopTimer];
        
        [self startTimer];
    }else {
        self.playRightButton.enabled = (_playNub < _playTotal - 2);
        [self nextFrame];
        
    }
    
}

- (void)stratPlay
{
    self.isPlay = YES;

    [self.playButton setImage:kImageNamed(@"liveData_stop") forState:UIControlStateNormal];

    
    [self startTimer];
}

- (void)stopPlay
{
    self.isPlay = NO;

    [self.playButton setImage:kImageNamed(@"liveData_play") forState:UIControlStateNormal];

    
    [self stopTimer];
}

- (void)changePlayType{
    _playType = !_playType;

    if (_playType == 0) {
        [self stratPlay];
        self.playButton.hidden = NO;
        self.playTipLabel.text = @"自动回放";

        [self.playLeftButton setImage:kImageNamed(@"liveData_play_left") forState:UIControlStateNormal];
        [self.playRightButton setImage:kImageNamed(@"liveData_play_right") forState:UIControlStateNormal];
        [self.playLeftButton setImage:kImageNamed(@"liveData_play_left_disable") forState:UIControlStateDisabled];
        [self.playRightButton setImage:kImageNamed(@"liveData_play_right_disable") forState:UIControlStateDisabled];

        self.playLeftButton.enabled = (self.playSpeed > 1);
        self.playRightButton.enabled = (self.playSpeed < 4);
        self.playTimeLabel.text = [NSString stringWithFormat:@"X%.0f",self.playSpeed];
    }else {
        [self stopPlay];
        self.playButton.hidden = YES;
        self.playTipLabel.text = @"帧回放";

        [self.playLeftButton setImage:kImageNamed(@"liveData_frame_left") forState:UIControlStateNormal];
        [self.playRightButton setImage:kImageNamed(@"liveData_frame_right") forState:UIControlStateNormal];
        [self.playLeftButton setImage:kImageNamed(@"liveData_frame_left_disable") forState:UIControlStateDisabled];
        [self.playRightButton setImage:kImageNamed(@"liveData_frame_right_disable") forState:UIControlStateDisabled];


        self.playLeftButton.enabled = (_playNub >= 1);
        self.playRightButton.enabled = (_playNub < _playTotal - 1);
        self.playTimeLabel.text = [NSString stringWithFormat:@"%d/%d", MAX(self.playNub+1, 1), (int)self.playTotal];
    }
    
}

- (void)forwardFrame {
    if (_playNub < 1) {
        return;
    }
    if (self.isNewData) {
        [self timerMethod:false];
    }else {
        [self timerMethod:false];
    }
}

- (void)nextFrame {

    if (_playNub >= _playTotal - 1) {
        return;
    }
    [self timerMethod:true];
    
}

- (void)playFrame:(BOOL)isNext {
    if (_dataVersion == 2.00) {
        //TDD_ArtiLiveDataModel 替换修改的属性
        TDD_ArtiLiveDataRecordeModel *recordModel = self.dataArr[MIN(self.dataArr.count-1, self.playNub)];

        NSData *data = [recordModel.recordChangeItemDictStr dataUsingEncoding:NSUTF8StringEncoding];
        
        // 对数据进行JSON格式化并返回字典形式
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data?:NSData.new options:NSJSONReadingMutableLeaves error:nil];
        if (dict.count) {

            NSMutableArray *items = _liveDataModel.showItems;

            for (NSUInteger i = 0; i < items.count; i++) {
                TDD_ArtiLiveDataItemModel *itemModel = items[i];
                if (![itemModel isKindOfClass:[TDD_ArtiLiveDataItemModel class]]) {
                    itemModel = [TDD_ArtiLiveDataItemModel yy_modelWithJSON:itemModel];
                }
                
                NSString *indexStr = [NSString stringWithFormat:@"%d", itemModel.index];
                id changeData = dict[indexStr];
                if (!changeData || [changeData isKindOfClass:[NSNull class]]) continue;
                
                itemModel.isTempe = NO;
                itemModel.isPlay = YES;
                itemModel.startTime = _liveDataModel.startTime;
                
                NSDictionary *itemDict = nil;
                if ([changeData isKindOfClass:[NSDictionary class]]) {
                    itemDict = changeData;
                } else if ([changeData isKindOfClass:[NSString class]]) {
                    NSData *itemData = [(NSString *)changeData dataUsingEncoding:NSUTF8StringEncoding];
                    if (itemData.length > 0) {
                        itemDict = [NSJSONSerialization JSONObjectWithData:itemData options:0 error:nil];
                    }
                }
                
                NSDictionary *recordChangeDict = itemDict[@"recordChangeDict"];
                if (![recordChangeDict isKindOfClass:[NSDictionary class]]) continue;
                
                NSNumber *chartTime = recordChangeDict[@"chartTime"];
                if (chartTime.doubleValue > 0) {
                    itemModel.chartTime = chartTime.doubleValue;
                }
                
                [recordChangeDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
                    if (![key isEqualToString:@"chartTime"] && value && value != [NSNull null]) {
                        [itemModel setValue:value forKey:key];
                    }
                }];
            }
        }
    }else if (_dataVersion == 3.00) {
        TDD_ArtiLiveDataRecordeModel *recordModel = self.dataArr[MIN(self.dataArr.count-1, self.playNub)];
        NSString *criteria = [NSString stringWithFormat:
                              @"WHERE recordModelPK = %d", recordModel.pk];
        NSArray<TDD_ArtiLiveDataRecordeChangeModel *> *allChanges =
            [TDD_ArtiLiveDataRecordeChangeModel findByCriteria:criteria];
        NSMutableArray *items = _liveDataModel.showItems;

        for (TDD_ArtiLiveDataItemModel *itemModel in items) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"time <= 100"];
            NSArray *filteredArray = [itemModel.valueArr filteredArrayUsingPredicate:predicate];
            [itemModel.valueArr removeAllObjects];
            [itemModel.valueArr addObjectsFromArray:filteredArray];
            for (TDD_ArtiLiveDataRecordeChangeModel *change in allChanges) {
                if (change.itemIndex == itemModel.index) {
                    itemModel.chartTime = change.chartTime;
                    itemModel.startTime = change.startTime;
                    itemModel.isTempe = NO;
                    itemModel.isPlay = YES;
                    BOOL shouldAddChart = false;
                    if (![NSString tdd_isEmpty:change.strValue]) {
                        itemModel.strValue = change.strValue;
                        shouldAddChart = (itemModel.UIType == 1);
                    }
                    if (![NSString tdd_isEmpty:change.strUnit]) {
                        itemModel.strUnit = change.strUnit;
                        shouldAddChart = (itemModel.UIType == 1);
                    }
                    if (![NSString tdd_isEmpty:change.strName]) {
                        itemModel.strName = change.strName;
                    }
                    if (![NSString tdd_isEmpty:change.strMin]) {
                        itemModel.strMin = change.strMin;
                    }
                    if (![NSString tdd_isEmpty:change.strMax]) {
                        itemModel.strMax = change.strMax;
                    }
                    if (shouldAddChart) {
                        if (isNext) {
                            
                            TDD_HChartModel * chartModel = [[TDD_HChartModel alloc] init];
                            chartModel.valueStr = change.strValue;
                            chartModel.time = change.chartTime;

                            if (chartModel.time < 100) {
                                [itemModel.valueArr addObject:chartModel];
                                if (itemModel.valueArr.count > 1000) {
                                    [itemModel.valueArr removeObjectsInRange:NSMakeRange(0, itemModel.valueArr.count - 1000)];
                                }

                            }

                        }else {
                            [itemModel.valueArr removeLastObject];
                        }

                    }
                    break;
                }else {
                    continue;
                }
            }
        }
    }

}

- (void)timerMethod:(BOOL)isNext
{
    if (!self->_isDraging) {
        if (isNext) {
            self.playNub ++;
        }else {
            self.playNub --;
        }
        
        if (self.dataArr.count - self.playNub <= 50 && !_isGetingData) {
            _isGetingData = YES;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [self getData];
                self->_isGetingData = NO;
            });
        }
        
        if (self.playNub > self.playTotal - 1) {
            self.playNub = self.playTotal - 1;
        }
        if (self.playNub < 0) {
            self.playNub = 0;
        }
        
        if (!self.dataArr || self.dataArr.count == 0) {
            [self stopPlay];
            return;
        }
        

        TDD_ArtiLiveDataModel * liveDataModel;
        if (self.isNewData) {
            [self playFrame:isNext];
            liveDataModel = self->_liveDataModel;
        }else {
            liveDataModel = self.dataArr[MIN(self.dataArr.count-1, self.playNub)];
            liveDataModel.isSearch = YES;
        }

        self.liveDataView.liveDataModel = liveDataModel;
        double progress = self.playNub / (double)(self.playTotal - 1);
        
        if (self.playTotal <= 1) {
            progress = 1;
        }
        
        if (self->_playType == 0) {
            self.playTimeLabel.text = [NSString stringWithFormat:@"X%.0f",self.playSpeed];
        }else{
            self.playTimeLabel.text = [NSString stringWithFormat:@"%d/%d", MAX(self.playNub+1, 1), (int)self.playTotal];
        }
        
        [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.progressView.superview.frame.size.width * progress);
        }];
        
        [self.progressView layoutIfNeeded];
        
        if (self.playNub >= self.playTotal - 1) {
            if (self.isPlay) {
                [self stopPlay];
            }
        }
    }


}

- (void)startTimer
{
    if (!self.timer) {
        @kWeakObj(self);
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 / self.playSpeed repeats:YES block:^(NSTimer * _Nonnull timer) {
            @kStrongObj(self);
            if (self.isDraging) {
                return;
            }
            [self timerMethod:true];
        }];
        
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (TDD_ArtiLiveDataView *)liveDataView
{
    if (!_liveDataView) {
        _liveDataView = [[TDD_ArtiLiveDataView alloc] init];
        _liveDataView.isPlay = YES;
    }
    [self.view addSubview:_liveDataView];
    return _liveDataView;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    
    return _dataArr;
}

@end
