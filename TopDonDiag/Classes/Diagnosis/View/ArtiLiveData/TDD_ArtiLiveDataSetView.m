//
//  TDD_ArtiLiveDataSetView.m
//  AD200
//
//  Created by AppTD on 2022/8/10.
//

#import "TDD_ArtiLiveDataSetView.h"

@interface TDD_ArtiLiveDataSetView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIView * contentView;
@property (nonatomic,strong) UIView * progressBackView; // 滑条
@property (nonatomic,strong) UIView * tapView; // 左滑块
@property (nonatomic,strong) UIView * tapView2; // 右滑块
@property (nonatomic,strong) TDD_CustomLabel * scopeValueLabel;
@property (nonatomic,assign) BOOL isScope; //是否有范围
@property (nonatomic,strong) TDD_CustomLabel * nameLabel; // 数据名称
@property (nonatomic,strong) UIControl * unitSelCol;// 数据单位切换
@property (nonatomic,strong) TDD_CustomLabel * unitLabel; // 数据单位
@property (nonatomic,strong) UIImageView * unitArrow; // 数据单位箭头
@property (nonatomic,strong) UIView *popView;//单位弹出背景
@property (nonatomic,strong) UITableView *tableView;//单位选择列表
@property (nonatomic,strong) NSMutableArray *unitArr;//单位数组
@property (nonatomic,assign) NSInteger selectUnitIndex;//选中单位数组的哪一个
@property (nonatomic,assign) CGFloat maxUnitTextWidth;//单位最长文本宽度
@property (nonatomic,strong) TDD_CustomLabel * unitCountSetLabel; // 单位设置范围
@property (nonatomic,strong) TDD_CustomLabel * unitCountMinLabel; // 单位最小值
@property (nonatomic,strong) TDD_CustomLabel * unitCountMaxLabel; // 单位最大值
@property (nonatomic,strong) UIView * showStyleBackView;
@property (nonatomic,strong) TDD_CustomLabel * showTypeLabel; // 表格 线形图等
@property (nonatomic,strong) UIButton * selectedBtn; // 选中的样式
@property (nonatomic,strong) UIImageView * selectedImageView; // 选中的样式图
@property (nonatomic,strong) TDD_CustomLabel * selectNumImageLabel;// 数字样式图的文本
@property (nonatomic,strong) UIView * helpBackView;//帮助背景
@property (nonatomic,strong) TDD_CustomLabel *helpLabel;//帮助;
@property (nonatomic,strong) TDD_ArtiLiveDataItemModel * currentItemModel; // 当前数据
@property (nonatomic,strong) UIButton * saveBtn; // 保存按钮
@property (nonatomic,assign) BOOL tapNotInMax;//滑块不在最大值
@property (nonatomic,assign) BOOL tapNotInMin;//滑块不在最小值
@property (nonatomic,assign) CGFloat maxProgress;
@property (nonatomic,assign) CGFloat minProgress;

@property (nonatomic, assign) CGSize legendImgSize;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, assign) CGFloat imgScale;
@property (nonatomic, assign) CGFloat bigFontSize;
@property (nonatomic, assign) CGFloat midFontSize;
@property (nonatomic, assign) CGFloat smallFontSize;
@end

@implementation TDD_ArtiLiveDataSetView

- (instancetype)init{
    self = [super init];

    if (self) {
        
        self.backgroundColor = [UIColor tdd_liveDataSetBackground];
    }
    
    return self;
}

- (void)setSetModel:(TDD_ArtiLiveDataSetModel *)setModel {
    _setModel = setModel;
    TDD_UnitConversionModel *metric = [TDD_UnitConversion diagUnitConversionWithUnit:setModel.itemModel.strUnit value:setModel.itemModel.strValue unitConversionType:TDD_UnitConversionType_Metric];
    TDD_UnitConversionModel *imperial = [TDD_UnitConversion diagUnitConversionWithUnit:setModel.itemModel.strUnit value:setModel.itemModel.strValue unitConversionType:TDD_UnitConversionType_Imperial];
    
    //公制单位
    if (![NSString tdd_isEmpty:metric.unit] && ![setModel.itemModel.strUnit isEqualToString:metric.unit]) {
        TDD_ArtiLiveUnitModel *model = [[TDD_ArtiLiveUnitModel alloc] init];
        model.type = TDD_UnitConversionType_Metric;
        model.unit = metric.unit;
        model.strMin = setModel.itemModel.strMetricMin;
        model.strMax = setModel.itemModel.strMetricMax;
        [self.unitArr addObject:model];
        self.currentItemModel.strMetricUnit = self.setModel.itemModel.strMetricUnit = metric.unit;
    }
    
    //英制单位
    if (![NSString tdd_isEmpty:imperial.unit] && ![setModel.itemModel.strUnit isEqualToString:imperial.unit]) {
        TDD_ArtiLiveUnitModel *model = [[TDD_ArtiLiveUnitModel alloc] init];
        model.type = TDD_UnitConversionType_Imperial;
        model.unit = imperial.unit;
        model.strMin = setModel.itemModel.strImperialMin;
        model.strMax = setModel.itemModel.strImperialMax;
        [self.unitArr addObject:model];
        self.currentItemModel.strImperialUnit = self.setModel.itemModel.strImperialUnit = imperial.unit;
    }
    
    //车型默认单位，仅有公制/英制单位时增加车型默认单位的切换
    if (self.unitArr.count >0 && self.unitArr.count < 2 && ![NSString tdd_isEmpty:setModel.itemModel.strUnit]) {
        TDD_ArtiLiveUnitModel *model = [[TDD_ArtiLiveUnitModel alloc] init];
        model.type = TDD_UnitConversionType_Car;
        model.unit = setModel.itemModel.strUnit;
        model.strMin = setModel.itemModel.strMin;
        model.strMax = setModel.itemModel.strMax;
        [self.unitArr insertObject:model atIndex:0];
    }
    
    if (_setModel.itemModel.originalUnitConversionType == TDD_UnitConversionType_None) {
        for (TDD_ArtiLiveUnitModel *model in self.unitArr) {
            if ([_setModel.itemModel.strChangeUnit isEqualToString:model.unit]) {
                _setModel.itemModel.originalUnitConversionType = model.type;
                break;
            }
        }
    }
    
    self.currentItemModel = setModel.itemModel.yy_modelCopy;
    
    if (setModel.itemModel.strChangeMin.length > 0 &&
        setModel.itemModel.strChangeMax.length > 0 &&
        [NSString tdd_isNum:setModel.itemModel.strChangeMin] &&
        [NSString tdd_isNum:setModel.itemModel.strChangeMax]) {
        
        double minValue = self.setModel.itemModel.strChangeMin.doubleValue;
        double maxValue = self.setModel.itemModel.strChangeMax.doubleValue;
        
        if (maxValue == minValue) {
            self.isScope = NO;
        } else {
            self.isScope = YES;
        }
    } else {
        self.isScope = NO;
    }
    
    [self drawUI];
    
    if (self.isScope) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            float width = self.progressBackView.frame.size.width;
            double minValue = self.setModel.itemModel.strChangeMin.doubleValue;
            double maxValue = self.setModel.itemModel.strChangeMax.doubleValue;
            
            if (maxValue == minValue) {
                return;
            }
            
            float offset = (self.setModel.itemModel.setStrMin.doubleValue - minValue) / (maxValue - minValue) * width;
            [self changeOffsetView:self.tapView offset:offset];
            
            float offset2 = (self.setModel.itemModel.setStrMax.doubleValue - minValue) / (maxValue - minValue) * width;
            if (offset2 - offset < self.tapView.frame.size.width) {
                offset2 = offset + self.tapView.frame.size.width;
            }
            [self changeOffsetView:self.tapView2 offset:offset2];
            
        });
    }
    
    self.unitLabel.text = self.setModel.itemModel.strChangeUnit; // 数据流单位
    self.nameLabel.text = self.setModel.itemModel.strName; // 数据流名称
    self.helpBackView.hidden = [NSString tdd_isEmpty:self.setModel.itemModel.strHelpText];
    self.helpLabel.text = self.setModel.itemModel.strHelpText;// 帮助
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(@(IphoneWidth));
        make.bottom.equalTo(self.helpBackView.hidden?self.showStyleBackView.mas_bottom:self.helpBackView.mas_bottom).offset(self.helpBackView.hidden?_topSpace * 2 :10);
    }];
    
    [self layoutIfNeeded];
}

#pragma mark 判断是否有设置变化
- (BOOL)checkNeedSavaLiveData {
    BOOL needSave = NO;
    if (self.setModel.itemModel.UIType != self.currentItemModel.UIType) {
        needSave = YES;
    }
    if (![self.setModel.itemModel.setStrMin isEqualToString:self.currentItemModel.setStrMin]) {
        needSave = YES;
    }
    if (![self.setModel.itemModel.setStrMax isEqualToString: self.currentItemModel.setStrMax]) {
        needSave = YES;
    }
    if (self.setModel.itemModel.unitConversionType != self.currentItemModel.unitConversionType) {
        needSave = YES;
    }
    self.currentItemModel.setHasChange = needSave;
    self.setModel.itemModel.setHasChange = needSave;
    
    [self refreshSaveBtnStatus:needSave];
    
    return needSave;
}

- (void)refreshSaveBtnStatus:(BOOL)needSave {
    if (self.saveBtn.userInteractionEnabled == needSave) {
        return;
    }
    
    if (needSave) {
        self.saveBtn.userInteractionEnabled = YES;
        [self.saveBtn setSelected:YES];
        self.saveBtn.backgroundColor = [UIColor tdd_colorDiagTheme];
    } else {
        self.saveBtn.userInteractionEnabled = false;
        [self.saveBtn setSelected:NO];
        self.saveBtn.backgroundColor = [[UIColor tdd_colorDiagTheme] colorWithAlphaComponent:0.5];
    }
}

#pragma mark 保存当前变化
- (void)saveLiveData {
    //修改单位
    if (self.setModel.itemModel.unitConversionType != self.currentItemModel.unitConversionType) {
        [self.setModel.itemModel.valueArr removeAllObjects];
        [self.setModel.itemModel.valueStrArr removeAllObjects];
        self.setModel.itemModel.unitConversionType = self.currentItemModel.unitConversionType;
        self.setModel.itemModel.strChangeMax = self.currentItemModel.strChangeMax;
        self.setModel.itemModel.strChangeMin = self.currentItemModel.strChangeMin;
        self.setModel.itemModel.strChangeUnit = self.currentItemModel.strChangeUnit;
    }
    self.setModel.itemModel.UIType = self.currentItemModel.UIType;
    self.setModel.itemModel.setStrMin = self.currentItemModel.setStrMin;
    self.setModel.itemModel.setStrMax = self.currentItemModel.setStrMax;
}

#pragma mark 展示样式点击
- (void)modelButtonClick:(UIButton *)modelButton {
    if (modelButton == self.selectedBtn) {
        return;
    }
    self.selectedBtn.backgroundColor = [UIColor tdd_keyboardItemDisableBackground];
    modelButton.backgroundColor = [UIColor tdd_colorDiagTheme];
    modelButton.selected = YES;
    self.selectedBtn.selected = NO;
    self.selectedBtn = modelButton;
    
    int tag = (int)modelButton.tag - 100;
    
//    if (self.setModel.itemModel.UIType != tag) {
//        self.setModel.itemModel.UIType = tag;
//    }
    
    if (self.currentItemModel.UIType != tag) {
        self.currentItemModel.UIType = tag;
    }
    
    [self checkNeedSavaLiveData]; // 更新数据
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtLiveSetChange object:self.currentItemModel userInfo:nil];

    
    NSArray *imageArr = @[[UIImage tdd_imageLiveDataSetNumLegend],[UIImage tdd_imageLiveDataSetNumChartLegend],[UIImage tdd_imageLiveDataSetDialLegend]];
    NSArray *styleArr = @[TDDLocalized.live_data_style_number,TDDLocalized.live_data_style_line_graph,TDDLocalized.live_data_style_dial];
    if (tag < 3) {
        CGSize firstSize = CGSizeMake(265 * _scale * _imgScale, 75 * _scale * _imgScale);
        self.selectedImageView.image = imageArr[tag];
        CGFloat firstTopSpace = 40 * _scale;
        CGFloat topSpace = 20 * _scale;
        self.showTypeLabel.text = styleArr[tag];
        self.selectNumImageLabel.hidden = (tag != 0);
        
        if (self.selectedImageView.superview) {
            [self.selectedImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(tag == 0 ? firstTopSpace : topSpace));
                make.centerX.equalTo(@0);
                make.size.mas_equalTo(tag == 0 ? firstSize : _legendImgSize);
            }];
        }

    }

}

#pragma mark pan平移手势事件
-(void)panView:(UIPanGestureRecognizer *)sender{
    
    CGPoint point = [sender translationInView:sender.view];
    CGFloat leftSpace = (IS_IPad ? 40 : 28) * _scale;
    float space = sender.view.center.x - leftSpace;
    if (space > 0 && space < 0.5) {
        space = 0;
    }
    
    CGFloat progressWidth = IphoneWidth - leftSpace;
    if (point.x >= 0 && progressWidth - sender.view.center.x < 0.5) {
        space = progressWidth;
    }
    float offset = space + point.x;
    HLog(@"panView:%f - offset:%f",point.x,offset);
    [self changeOffsetView:sender.view offset:offset];

    [sender setTranslation:CGPointZero inView:sender.view];

}

- (void)changeOffsetView:(UIView *)view offset:(float)offset
{
    //一直拖会让 view 不断缩小，所以留个 0.3 间距
    float max = self.tapView2.frame.origin.x - self.progressBackView.frame.origin.x - self.tapView.frame.size.width / 2 -  0.3;
    
    float min = 0;
    
    if (view == self.tapView2) {
        max = self.progressBackView.frame.size.width;
        
        min = self.tapView.center.x - self.progressBackView.frame.origin.x + self.tapView2.frame.size.width + 0.3;
    }
    
    if (offset > max) {
        offset = max;
    }else if (offset < min){
        offset = min;
    }
        
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.progressBackView.mas_left).offset(offset);
    }];
    
    double minValue = self.currentItemModel.strChangeMin.doubleValue;
    
    double maxValue = self.currentItemModel.strChangeMax.doubleValue;
    
    double value = minValue + (maxValue - minValue) * (offset / self.progressBackView.frame.size.width);
    HLog(@"changeOffsetView:%f - offset:%f",value,offset);
    if (view == self.tapView) {
        //最小值
        self.minProgress = (offset / self.progressBackView.frame.size.width);
        if (offset == min) {
            self.currentItemModel.setStrMin = self.currentItemModel.strChangeMin;
            self.tapNotInMin = false;
        } else {
            if (maxValue - minValue <= 10) {
                self.currentItemModel.setStrMin = [NSString stringWithFormat:@"%.2f", value];
            }else {
                self.currentItemModel.setStrMin = [NSString stringWithFormat:@"%.0f", value];
            }
            self.tapNotInMin = true;
        }

    }else {
        //最大值
        self.maxProgress = (offset / self.progressBackView.frame.size.width);
        if (offset == max) {
            self.currentItemModel.setStrMax = self.currentItemModel.strChangeMax;
            self.tapNotInMax = false;
        } else {
            if (maxValue - minValue <= 10) {
                self.currentItemModel.setStrMax = [NSString stringWithFormat:@"%.2f", value];
            }else {
                self.currentItemModel.setStrMax = [NSString stringWithFormat:@"%.0f", value];
            }
            self.tapNotInMax = true;
        }
    }

    [self updateScopeValueLabel];
}

#pragma mark 更新设置的范围
- (void)updateScopeValueLabel {
//    self.unitCountFromLabel.text = [NSString stringWithFormat:@"%@", self.setModel.itemModel.setStrMin];
//    self.unitCountEndLabel.text = [NSString stringWithFormat:@"%@", self.setModel.itemModel.setStrMax];
    
    [self checkNeedSavaLiveData];
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtLiveSetChange object:self.currentItemModel userInfo:nil];
    
    self.unitCountSetLabel.text = [NSString stringWithFormat:@"%@ - %@%@", self.currentItemModel.setStrMin ,self.currentItemModel.setStrMax, self.currentItemModel.strChangeUnit];
    
    self.unitCountMinLabel.text = [NSString stringWithFormat:@"%@%@", self.currentItemModel.strChangeMin, self.currentItemModel.strChangeUnit];
    self.unitCountMaxLabel.text = [NSString stringWithFormat:@"%@%@", self.currentItemModel.strChangeMax, self.currentItemModel.strChangeUnit];
}

#pragma mark 切换单位

/// 选择单位
- (void)selectUnit
{
    CGPoint point = [self.unitSelCol convertPoint:CGPointMake(0,0) toView:[UIApplication sharedApplication].windows.lastObject];
    CGFloat leftSpace = (IS_IPad ? 40 : 20) * _scale;
    if (point.y > IphoneHeight - point.y - 40) {
        self.tableView.frame = CGRectMake(IphoneWidth - leftSpace - _maxUnitTextWidth, point.y - 87, _maxUnitTextWidth, 83);
    } else {
        self.tableView.frame = CGRectMake(IphoneWidth - leftSpace - _maxUnitTextWidth, point.y + 47, _maxUnitTextWidth, 83);
    }
    [self.popView addSubview:self.tableView];
    [FLT_APP_WINDOW addSubview:self.popView];
    [self.unitArrow setImage:kImageNamed(@"up_arrow")];
}

- (void)popViewTap
{
    [self.popView removeFromSuperview];
    [self.unitArrow setImage:kImageNamed(@"down_arrow")];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.unitArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EngineRateCellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TDD_CustomLabel *label = [[TDD_CustomLabel alloc] initWithFrame:CGRectMake(20 * _scale, 0, _maxUnitTextWidth - 40 * _scale, 40)];
    TDD_ArtiLiveUnitModel *unitModel = self.unitArr[indexPath.row];
    label.text = unitModel.unit;
    label.textColor = [UIColor tdd_title];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    cell.backgroundColor = label.backgroundColor = [UIColor tdd_alertBg];
    [cell addSubview:label];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.popView removeFromSuperview];
    [self.unitArrow setImage:kImageNamed(@"down_arrow")];
    self.selectUnitIndex = indexPath.row;
    TDD_ArtiLiveUnitModel *unitModel = self.unitArr[indexPath.row];
    if (![self.unitLabel.text isEqualToString:unitModel.unit]) {
        
        self.unitLabel.text = unitModel.unit;
        self.currentItemModel.unitConversionType = (TDD_UnitConversionType)(indexPath.row + 1);
        
        //滑块不在最小值位置，计算滑动后的值在单位切换后的更改
        if (_tapNotInMin) {
            if (unitModel.strMax.floatValue - unitModel.strMin.floatValue <= 10) {
                self.currentItemModel.setStrMin = [NSString stringWithFormat:@"%.2f",unitModel.strMin.floatValue +  (unitModel.strMax.floatValue - unitModel.strMin.floatValue) * _minProgress];
            }else {
                self.currentItemModel.setStrMin = [NSString stringWithFormat:@"%.0f",unitModel.strMin.floatValue +  (unitModel.strMax.floatValue - unitModel.strMin.floatValue) * _minProgress];
            }

        }else {
            self.currentItemModel.setStrMin = unitModel.strMin;
        }
        
        //滑块不在最大值位置，计算滑动后的值在单位切换后的更改
        if (_tapNotInMax) {
            if (unitModel.strMax.floatValue - unitModel.strMin.floatValue <= 10) {
                self.currentItemModel.setStrMax = [NSString stringWithFormat:@"%.2f", unitModel.strMin.floatValue +  (unitModel.strMax.floatValue - unitModel.strMin.floatValue) * _maxProgress];
            }else {
                self.currentItemModel.setStrMax = [NSString stringWithFormat:@"%.0f", unitModel.strMin.floatValue +  (unitModel.strMax.floatValue - unitModel.strMin.floatValue) * _maxProgress];
            }

        }else {
            self.currentItemModel.setStrMax = unitModel.strMax;
        }
        
        //最大最小值根据单位切换修改
        self.currentItemModel.strChangeMin = unitModel.strMin;
        self.currentItemModel.strChangeMax = unitModel.strMax;
        self.currentItemModel.strChangeUnit = unitModel.unit;
        
        [self updateScopeValueLabel];
        [self checkNeedSavaLiveData];
    }

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}


#pragma mark 恢复按钮点击
- (void)restoreButtonClick {
    UIButton * button = [self viewWithTag:100];
    
    [self modelButtonClick:button];
    if (self.isScope) {
        [self changeOffsetView:self.tapView offset:0];
        
        [self changeOffsetView:self.tapView2 offset:self.progressBackView.frame.size.width];
    }

    for (int i = 0; i<self.unitArr.count; i++) {
        TDD_ArtiLiveUnitModel *model = self.unitArr[i];
        if (model.type == self.setModel.itemModel.originalUnitConversionType) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
            break;
        }
    }
    
    [self checkNeedSavaLiveData];
    
}

#pragma mark 保存按钮点击
- (void)saveButtonClick {
    [self saveLiveData];
    [self.setModel backClick];
}

#pragma mark UI绘制
- (void)drawUI {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    _scale = IS_IPad ? HD_Height : H_Height;
    _imgScale = IS_IPad ? 2 : 1;
    _legendImgSize = CGSizeMake(225 * _scale * _imgScale, 130 * _scale * _imgScale);
    CGSize firstSize = CGSizeMake(265 * _scale * _imgScale, 75 * _scale * _imgScale);
    CGFloat leftSpace = (IS_IPad ? 40 : 20) * _scale;
    CGFloat topSpace = (IS_IPad ? 15 : 12) * _scale;
    _topSpace = topSpace;
    _bigFontSize = (IS_IPad ? 18 : 14);
    _midFontSize = (IS_IPad ? 16 : 12);
    _smallFontSize = (IS_IPad ? 14 : 11);
    
    // 基础色
    UIColor *whiteColor = [UIColor whiteColor];
    UIColor *backColor = [UIColor tdd_inputHistoryCellBackground];
    UIColor *bluecolor = [UIColor tdd_colorDiagTheme];
    
    BOOL hadUnit = self.unitArr.count >=2;
    if (hadUnit) {
        //计算单位的最长宽度
        for (TDD_ArtiLiveUnitModel *model in self.unitArr) {
            CGFloat w =  [NSString tdd_getWidthWithText:model.unit height:CGFLOAT_MAX fontSize:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]];
            _maxUnitTextWidth = MAX(w + 40 * _scale, _maxUnitTextWidth);
        }
        _maxUnitTextWidth = MIN(IphoneWidth - leftSpace * 2, _maxUnitTextWidth);
    }
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = NO;
    scrollView.delaysContentTouches = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 创建contentView，添加到scrollView作为唯一子视图
    UIView * contentView = [[UIView alloc] init];
    [scrollView addSubview:contentView];
    self.contentView = contentView;
    
    // 自定义当前数据流的展示方式：
    TDD_CustomLabel * titleDesLabel = ({
        TDD_CustomLabel *label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:_midFontSize] tdd_adaptHD];
        label.textColor = [UIColor tdd_subTitle];
        label.text = TDDLocalized.live_data_control_title;
        label.numberOfLines = 0;
        label;
    });
    
    [contentView addSubview:titleDesLabel];
    [titleDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftSpace);
        make.top.mas_equalTo(topSpace);
    }];
    
    // 单位背景
    UIView *unitBackView = [[UIView alloc] init];
    unitBackView.backgroundColor = backColor;
    
    [contentView addSubview:unitBackView];
    [unitBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(titleDesLabel.mas_bottom).offset(topSpace);
    }];
    
    // 数据名称
    TDD_CustomLabel * unitTitleLabel = ({
        TDD_CustomLabel *label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:_bigFontSize] tdd_adaptHD];
        label.textColor = [UIColor tdd_subTitle];
        label.text =  TDDLocalized.live_data_unit_name_title;
        label.numberOfLines = 0;
        label;
    });
    
    // 数据名称 - 例如：车速
    [unitBackView addSubview:self.nameLabel];
    self.nameLabel.textColor = [UIColor tdd_title];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-leftSpace);
        make.top.mas_equalTo(topSpace);
        make.left.equalTo(unitBackView.mas_centerX).offset(5 * _scale);
    }];
    
    [unitBackView addSubview:unitTitleLabel];
    [unitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftSpace);
        make.top.mas_equalTo(topSpace);
        make.centerY.equalTo(self.nameLabel);
        make.right.equalTo(unitBackView.mas_centerX);
    }];
    

    
    // 线条
    UIView *unitLineView = [[UIView alloc] init];
    unitLineView.backgroundColor = [UIColor tdd_line];
    [unitBackView addSubview:unitLineView];
    [unitLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(topSpace);
        make.height.equalTo(@0.5);
    }];
    
    // 单位 - 例如：km/h

    [unitBackView addSubview:self.unitLabel];
    self.unitLabel.textColor = [UIColor tdd_title];
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-leftSpace - (hadUnit ? (8 + 14) * _scale : 0));
        make.top.equalTo(unitLineView.mas_bottom).offset(topSpace);
        make.bottom.equalTo(unitBackView.mas_bottom).offset(-topSpace);
        make.left.equalTo(unitBackView.mas_centerX).offset(5 * _scale);
    }];
    
    if (hadUnit) {
        [unitBackView addSubview:self.unitArrow];
        [self.unitArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-leftSpace);
            make.centerY.equalTo(self.unitLabel);
            make.size.mas_equalTo(CGSizeMake(14 * _scale, 14 * _scale));
        }];
        [unitBackView addSubview:self.unitSelCol];
        [_unitSelCol mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(unitLineView.mas_bottom);
            make.right.bottom.equalTo(unitBackView);
            make.left.equalTo(self.unitLabel);
        }];
    }

    // 单位
    TDD_CustomLabel * unitTitleDesLabel = ({
        TDD_CustomLabel *label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:_bigFontSize] tdd_adaptHD];
        label.textColor = [UIColor tdd_subTitle];
        label.text = TDDLocalized.diagnosis_unit;
        label;
    });
    
    [unitBackView addSubview:unitTitleDesLabel];
    [unitTitleDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftSpace);
        make.top.greaterThanOrEqualTo(unitLineView.mas_bottom).offset(topSpace);
        make.centerY.equalTo(self.unitLabel);
        make.right.equalTo(unitBackView.mas_centerX);
    }];
    

    // 滑块背景
    UIView *progressContentBackView = [[UIView alloc] init];
    progressContentBackView.backgroundColor = backColor;
    
    [contentView addSubview:progressContentBackView];
    [progressContentBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(unitBackView.mas_bottom).offset(topSpace);
    }];
    
    // 参考值范围
    TDD_CustomLabel * progressTitleLabel = ({
        TDD_CustomLabel *label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:_bigFontSize] tdd_adaptHD];
        label.textColor = [UIColor tdd_subTitle];
        label.text = TDDLocalized.live_data_reference_range;
        label;
    });
    
    [progressContentBackView addSubview:progressTitleLabel];
    [progressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftSpace);
        make.top.equalTo(progressContentBackView).offset(topSpace);
    }];
    
    // 线条
    UIView *progressLineView = [[UIView alloc] init];
    progressLineView.backgroundColor = [UIColor tdd_line];
    [progressContentBackView addSubview:progressLineView];
    [progressLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(progressTitleLabel.mas_bottom).offset(topSpace);
        make.height.equalTo(@0.5);
    }];
    
    //====范围值====
    if (self.isScope) {
        //拖动条背景
        UIView * progressBackView = [[UIView alloc] init];
        progressBackView.layer.cornerRadius = 2;
        progressBackView.backgroundColor = [UIColor tdd_line];
        [progressContentBackView addSubview:progressBackView];
        self.progressBackView = progressBackView;
        
        // 滚动条蓝色
        UIView * progressView = [[UIView alloc] init];
        progressView.layer.cornerRadius = 2;
        progressView.backgroundColor = bluecolor;
        [progressContentBackView addSubview:progressView];
        
        // 左滑块
        UIView * tapView = [[UIView alloc] init];
        tapView.backgroundColor = whiteColor;
        tapView.layer.cornerRadius = 2;
        [progressContentBackView addSubview:tapView];
        tapView.layer.shadowColor = [UIColor tdd_colorWithHex:0x000000 alpha:0.5].CGColor;
        tapView.layer.shadowOffset = CGSizeMake(0, 0);
        tapView.layer.shadowOpacity = 1;
        tapView.layer.cornerRadius = 4;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        [tapView addGestureRecognizer:pan];
        self.tapView = tapView;
        
        // 右滑块
        UIView * tapView2 = [[UIView alloc] init];
        tapView2.backgroundColor = whiteColor;
        tapView2.layer.cornerRadius = 2;
        tapView2.layer.shadowColor = [UIColor tdd_colorWithHex:0x000000 alpha:0.5].CGColor;
        tapView2.layer.shadowOffset = CGSizeMake(0, 0);
        tapView2.layer.shadowOpacity = 1;
        tapView2.layer.cornerRadius = 4;
        [progressContentBackView addSubview:tapView2];
        UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        [tapView2 addGestureRecognizer:pan2];
        self.tapView2 = tapView2;
        
        // 设置范围单位值
        [progressContentBackView addSubview:self.unitCountSetLabel];

        // 最小单位值
        [progressContentBackView addSubview:self.unitCountMinLabel];
        self.unitCountMinLabel.textColor = [UIColor tdd_color666666];
        
        // 最大单位值
        [progressContentBackView addSubview:self.unitCountMaxLabel];
        self.unitCountMaxLabel.textColor = [UIColor tdd_color666666];
        
        [progressBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(progressContentBackView).offset(IS_IPad ? leftSpace : 28 * _scale);
            make.right.equalTo(progressContentBackView).offset(IS_IPad ? -leftSpace : -28 * _scale);
            make.top.equalTo(progressLineView.mas_bottom).offset((IS_IPad ? 50 : 38) * _scale);
            make.height.mas_equalTo((IS_IPad ? 8 : 12) * _scale);
        }];
        
        [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(progressBackView);
            make.left.equalTo(tapView.mas_centerX);
            make.right.equalTo(tapView2.mas_centerX);
        }];
        CGSize tabSize = IS_IPad ? CGSizeMake(22 * _scale, 28 * _scale) : CGSizeMake(16 * _scale, 22 * _scale);
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(progressBackView);
            //make.centerX.greaterThanOrEqualTo(progressBackView.mas_left);
            make.right.lessThanOrEqualTo(tapView2.mas_left);
            make.centerX.equalTo(progressBackView.mas_left).offset(0);
            make.size.mas_equalTo(tabSize);
        }];
        
        [tapView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(progressBackView);
            //make.centerX.lessThanOrEqualTo(progressBackView.mas_right);
            make.left.greaterThanOrEqualTo(tapView.mas_right);
            make.centerX.equalTo(progressBackView.mas_left).offset(IphoneWidth - (IS_IPad ? leftSpace : 28 * _scale) * 2);

            make.size.mas_equalTo(tabSize);
        }];
        
        [self.unitCountSetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-leftSpace);
            make.centerY.equalTo(progressTitleLabel);
            make.left.equalTo(progressTitleLabel.mas_right).offset(10 * _scale);
        }];
        
        [self.unitCountMinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftSpace);
            make.top.equalTo(progressBackView.mas_bottom).offset(topSpace);
        }];
        
        [self.unitCountMaxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-leftSpace);
            make.top.equalTo(progressBackView.mas_bottom).offset(topSpace);
            make.bottom.equalTo(progressContentBackView).offset(-topSpace);
        }];
    }
    
    // 展示方式背景
    UIView *showBackView = [[UIView alloc] init];
    showBackView.backgroundColor = backColor;
    
    [contentView addSubview:showBackView];

    
    // 展示方式
    TDD_CustomLabel * showTitleLabel = ({
        TDD_CustomLabel *label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:_bigFontSize] tdd_adaptHD];
        label.textColor = [UIColor tdd_subTitle];
        label.text = TDDLocalized.live_data_display;
        label;
    });
    
    [showBackView addSubview:showTitleLabel];
    [showTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftSpace);
        make.top.equalTo(@0);
        make.height.mas_equalTo(45.5 * _scale);
    }];
    
    // 数字 表格 线形图
    [showBackView addSubview:self.showTypeLabel];
    [self.showTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-leftSpace);
        make.top.equalTo(@0);
        make.height.mas_equalTo(45.5 * _scale);
    }];
    
    // 线条
    UIView *showLineView = [[UIView alloc] init];
    showLineView.backgroundColor = [UIColor tdd_line];
    [showBackView addSubview:showLineView];
    [showLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(showTitleLabel.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    
    // 按钮切换下面图片随着切换 - 背景
    UIView *showStyleBackView = [[UIView alloc] init];
    showStyleBackView.backgroundColor = [UIColor tdd_liveDataSetRangeBackground];
    showStyleBackView.layer.cornerRadius = 5;
    [showBackView addSubview:showStyleBackView];
    self.showStyleBackView = showStyleBackView;
    [showStyleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showBackView).offset(leftSpace);
        make.centerX.equalTo(showBackView);
        make.top.equalTo(showLineView.mas_bottom).offset((IS_IPad ? 80 : 65) * _scale);
    }];
    
    // 按钮切换下面图片随着切换 - 图片
    [showStyleBackView addSubview:self.selectedImageView];
    [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showStyleBackView).offset(40 * _scale);
        make.centerX.equalTo(@0);
        make.size.mas_equalTo(firstSize);
    }];
    
    [showStyleBackView addSubview:self.selectNumImageLabel];
    [self.selectNumImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectedImageView).offset(10 * _scale);
        make.top.equalTo(self.selectedImageView).offset(topSpace);
        
    }];
    
    // 图例
    TDD_CustomLabel * showStyleLabel = ({
        TDD_CustomLabel *label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:_midFontSize] tdd_adaptHD];
        label.textColor = [UIColor tdd_liveDataLegendColor];
        label.text = TDDLocalized.live_date_legend;
        label;
    });
    
    [showStyleBackView addSubview:showStyleLabel];
    [showStyleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(showStyleBackView).offset(-topSpace);
        make.centerX.equalTo(@0);
        make.top.equalTo(_selectedImageView.mas_bottom).offset(topSpace);
    }];
    
    
    // 三个切换按钮
    NSArray * imageArr = @[[UIImage tdd_imageDiagLiveDataSetSelectText],[UIImage tdd_imageDiagLiveDataSetSelectChart],[UIImage tdd_imageDiagLiveDataSetSelectDial]];
    NSArray * imageSeletedArr = @[[UIImage tdd_imageDiagLiveDataSetSelectTextHL],[UIImage tdd_imageDiagLiveDataSetSelectChartHL],[UIImage tdd_imageDiagLiveDataSetSelectDialHL]];
    CGFloat btnLeftSpace = (IS_IPad ? 40 : 15) * _scale;
    CGFloat btnMidSpace = (IS_IPad ? 30 : 22) * _scale;
    for (int i = 0; i < imageArr.count; i ++) {
        UIButton * modelButton = ({
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 100 + i;
            btn.backgroundColor = [UIColor tdd_keyboardItemDisableBackground];
            btn.layer.cornerRadius = 4;
            [btn addTarget:self action:@selector(modelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:imageSeletedArr[i] forState:UIControlStateNormal];
            
            btn;
        });
        
        CGFloat btnWidth = (IphoneWidth - btnLeftSpace * 2 - btnMidSpace * 2)/3.0;
        [showBackView addSubview:modelButton];
        [modelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(btnLeftSpace + i * (btnWidth + btnMidSpace)));
            make.top.equalTo(showLineView.mas_bottom).offset(topSpace);
            make.width.equalTo(@(btnWidth));
            make.height.mas_equalTo((IS_IPad ? 50 : 40) * _scale);
        }];
        
        if (![NSString tdd_isNum:self.setModel.itemModel.strChangeValue]) {
            
            if (i > 0) {
                modelButton.enabled = NO;
                [modelButton setImage:imageArr[i] forState:UIControlStateNormal];
            }
            
        }else {
            if (i == 2 && !self.isScope) {
                modelButton.enabled = NO;
                [modelButton setImage:imageArr[i] forState:UIControlStateNormal];
            }
        }
        
        if (i == self.setModel.itemModel.UIType) {
            [self modelButtonClick:modelButton];
        }
    }
    
    [showBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        if (self.isScope) {
            make.top.equalTo(progressContentBackView.mas_bottom).offset(topSpace);
        } else {
            make.top.equalTo(unitBackView.mas_bottom).offset(topSpace);
        }
        make.bottom.equalTo(showStyleBackView.mas_bottom).offset(topSpace);
//        make.height.mas_greaterThanOrEqualTo(318 * _scale);
    }];
    
    // 帮助
    [contentView addSubview:self.helpBackView];
    UIView *helpTipView = [UIView new];
    helpTipView.backgroundColor = [UIColor tdd_colorDiagTheme];
    [self.helpBackView addSubview:helpTipView];
    
    TDD_CustomLabel * helpTipLabel = [[TDD_CustomLabel alloc] init];
    helpTipLabel.font = [UIFont systemFontOfSize:14];
    helpTipLabel.textColor = [UIColor tdd_title];
    helpTipLabel.text = TDDLocalized.diagnosis_help;
    [self.helpBackView addSubview:helpTipLabel];
    [self.helpBackView addSubview:self.helpLabel];
    
    [self.helpBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(showBackView.mas_bottom).offset(10);
    }];
    [helpTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * _scale);
        make.top.equalTo(self.helpBackView).offset(16.5 * _scale);
        make.size.mas_equalTo(CGSizeMake(4 * _scale, 14 * _scale));
    }];
    [helpTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(helpTipView.mas_right).offset(8 * _scale);
        make.centerY.equalTo(helpTipView);
    }];
    [self.helpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(helpTipLabel.mas_bottom).offset(10 * _scale);
        make.left.mas_equalTo(20 * _scale);
        make.centerX.equalTo(self.helpBackView);
        make.bottom.equalTo(self.helpBackView).offset(-20 * _scale);
    }];

    //====恢复默认值====
    UIView *restoreButtonBackView = [[UIView alloc] init];
    restoreButtonBackView.backgroundColor = [UIColor tdd_alertBg];
    [self addSubview:restoreButtonBackView];
    [restoreButtonBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        //make.height.equalTo(@(108 + iPhoneX_D));
    }];
    
    // 保存按钮
    UIButton * saveButton = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = true;
        [btn addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:TDDLocalized.person_save forState:UIControlStateNormal];
        btn.titleLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 24 : 16] tdd_adaptHD];
        [btn setTitleColor:[whiteColor colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
        [btn setTitleColor:whiteColor forState:UIControlStateSelected];
        btn.backgroundColor = [bluecolor colorWithAlphaComponent:0.5];
        [btn setSelected:NO];
        btn.userInteractionEnabled = false;
        btn;
    });
    [restoreButtonBackView addSubview:saveButton];
    self.saveBtn = saveButton;
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topSpace);
        make.left.mas_equalTo(leftSpace);
        make.right.mas_equalTo(-leftSpace);
        make.height.mas_equalTo((IS_IPad ? 70 : 44) * _scale);
    }];
    
    // 恢复默认值按钮
    UIButton * restoreButton = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(restoreButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:TDDLocalized.live_data_restore forState:UIControlStateNormal];
        btn.titleLabel.font = [[UIFont systemFontOfSize:_bigFontSize weight:UIFontWeightMedium] tdd_adaptHD];
        [btn setTitleColor:[UIColor tdd_reportCodeTitleTextColor] forState:UIControlStateNormal];
        btn;
    });
    [restoreButtonBackView addSubview:restoreButton];
    
    [restoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(saveButton.mas_bottom).offset(15);
        make.centerX.equalTo(saveButton);
        make.height.equalTo(@30);
        make.bottom.equalTo(@(-15));
    }];
    
    //===== scrollView布局确认

    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.equalTo(restoreButtonBackView.mas_top).offset(0);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(@(IphoneWidth));
        make.bottom.equalTo(self.helpBackView.mas_bottom).offset(10);
    }];
}


- (TDD_CustomLabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[TDD_CustomLabel alloc] init];
        _nameLabel.font = [[UIFont systemFontOfSize:_bigFontSize weight:UIFontWeightMedium] tdd_adaptHD];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _nameLabel;
}

- (TDD_CustomLabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[TDD_CustomLabel alloc] init];
        _unitLabel.font = [[UIFont systemFontOfSize:_bigFontSize weight:UIFontWeightMedium] tdd_adaptHD];
        _unitLabel.numberOfLines = 0;
        _unitLabel.textAlignment = NSTextAlignmentRight;
    }
    return _unitLabel;
}

- (UIImageView *)unitArrow {
    if (!_unitArrow) {
        _unitArrow = [[UIImageView alloc] initWithImage:kImageNamed(@"down_arrow")];
    }
    return _unitArrow;
}

- (UIControl *)unitSelCol {
    if (!_unitSelCol) {
        _unitSelCol = [[UIControl alloc] init];
        [_unitSelCol addTarget:self action:@selector(selectUnit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unitSelCol;
}

- (TDD_CustomLabel *)unitCountSetLabel {
    if (!_unitCountSetLabel) {
        _unitCountSetLabel = [[TDD_CustomLabel alloc] init];
        _unitCountSetLabel.font = [[UIFont boldSystemFontOfSize:_bigFontSize] tdd_adaptHD];
        _unitCountSetLabel.textAlignment = NSTextAlignmentRight;
        _unitCountSetLabel.textColor = [UIColor tdd_liveDataSetRangeColor];
    }
    return _unitCountSetLabel;
}

- (TDD_CustomLabel *)unitCountMinLabel {
    if (!_unitCountMinLabel) {
        _unitCountMinLabel = [[TDD_CustomLabel alloc] init];
        _unitCountMinLabel.font = [[UIFont systemFontOfSize:_smallFontSize] tdd_adaptHD];
        _unitCountMinLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _unitCountMinLabel;
}

- (TDD_CustomLabel *)unitCountMaxLabel {
    if (!_unitCountMaxLabel) {
        _unitCountMaxLabel = [[TDD_CustomLabel alloc] init];
        _unitCountMaxLabel.font = [[UIFont systemFontOfSize:_smallFontSize] tdd_adaptHD];
        _unitCountMaxLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _unitCountMaxLabel;
}

- (TDD_CustomLabel *)showTypeLabel {
    if (!_showTypeLabel) {
        _showTypeLabel = [[TDD_CustomLabel alloc] init];
        _showTypeLabel.font = [[UIFont systemFontOfSize:_bigFontSize weight:UIFontWeightMedium] tdd_adaptHD];
        _showTypeLabel.textColor = [UIColor tdd_title];
    }
    return _showTypeLabel;
}

- (UIImageView *)selectedImageView {
    if (!_selectedImageView) {
        _selectedImageView = [[UIImageView alloc] init];
    }
    return  _selectedImageView;
}

- (TDD_CustomLabel *)selectNumImageLabel {
    if (!_selectNumImageLabel) {
        _selectNumImageLabel = [[TDD_CustomLabel alloc] init];
        _selectNumImageLabel.font = [[UIFont systemFontOfSize:_smallFontSize] tdd_adaptHD];
        _selectNumImageLabel.textColor = [UIColor tdd_title];
        _selectNumImageLabel.text = TDDLocalized.engine_speed;
    }
    return _selectNumImageLabel;
}

- (UIView *)helpBackView {
    if (!_helpBackView) {
        _helpBackView = [[UIView alloc] init];
        _helpBackView.backgroundColor = [UIColor tdd_inputHistoryCellBackground];
    }
    return _helpBackView;
}

- (TDD_CustomLabel *)helpLabel {
    if (!_helpLabel) {
        _helpLabel = [[TDD_CustomLabel alloc] init];
        _helpLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        _helpLabel.textColor = [UIColor tdd_title];
        _helpLabel.numberOfLines = 0;
    }
    return _helpLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 130, 80) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor tdd_alertBg];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 40;
    }
    return _tableView;
}

- (UIView *)popView {
    if (!_popView) {
        _popView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight)];
        _popView.backgroundColor = [UIColor tdd_colorWithHex:0x000000 alpha:0.08];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popViewTap)];
        tap.delegate = self;
        [_popView addGestureRecognizer:tap];
    }
    return _popView;
}

- (NSMutableArray *)unitArr {
    if (!_unitArr) {
        _unitArr = [[NSMutableArray alloc] init];
    }
    return _unitArr;
}

- (void)dealloc
{
    HLog(@"%s", __func__);
}

@end
