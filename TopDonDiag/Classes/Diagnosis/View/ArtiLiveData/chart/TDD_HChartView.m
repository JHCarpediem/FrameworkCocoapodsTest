//
//  TDD_HChartView.m
//  BTMobile Pro
//
//  Created by 何可人 on 2022/3/4.
//

#import "TDD_HChartView.h"
#import <TopdonDiagnosis/TopdonDiagnosis-Swift.h>
#import "TopdonDiagnosis-Bridging-Header.h"
#import "TDD_HChartModel.h"
#import "TDD_DateValueFormatter.h"

@interface TDD_HChartView ()<ChartViewDelegate>
@property (nonatomic, strong) LineChartView *lineChartView;
@property (nonatomic, strong) ChartDataEntry * selectEntry; //选中的点
@end

@implementation TDD_HChartView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatChart];
    }
    return self;
}

- (instancetype)initWithShowType:(ShowType)showType
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.showType = showType;
        [self creatChart];
    }
    return self;
}

- (void)setShowType:(ShowType)showType
{
    _showType = showType;
    
    if (self.showType == ShowType_FreqWave) {
        ChartXAxis * xAxis = self.lineChartView.xAxis;
        ChartYAxis * leftAxis = self.lineChartView.leftAxis;
        xAxis.drawLabelsEnabled = NO;
        leftAxis.drawLabelsEnabled = NO;
    }
}

- (void)setValueArr:(NSArray *)valueArr{
    _valueArr = valueArr;
    
    TDD_DateValueFormatter * xForm = (TDD_DateValueFormatter *)self.lineChartView.xAxis.valueFormatter;
    
    xForm.startTime = self.startTime;
    
    LineChartDataSet *set1 = (LineChartDataSet *)self.lineChartView.data.dataSets[0];
    [set1 clear];
    
    LineChartDataSet *set2 = (LineChartDataSet *)self.lineChartView.data.dataSets[1];
    [set2 clear];
    
//    if (self.type == 1) {
//        for (int i = 0; i < valueArr.count; i ++) {
//            NSArray * arr = valueArr[i];
//
//            NSMutableArray * dataArr = [[NSMutableArray alloc] init];
//
//            for (int j = 0; j < arr.count; j ++) {
//                TDD_HChartModel * model = arr[j];
//
//                ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:model.time y:model.value];
//
//                [dataArr addObject:entry];
//            }
//
//            if (dataArr.count == 0) {
//                return;
//            }
//
//            LineChartDataSet *set = nil;
//            if (self.lineChartView.data.dataSets.count > i) {
//                set = (LineChartDataSet *)self.lineChartView.data.dataSets[i];
//                [set replaceEntries:dataArr];
//            }
//        }
//    }else{
    for (int j = 0; j < valueArr.count; j ++) {
        
        if (j > 1) {
            break;
        }
        
        NSArray * arr = valueArr[j];
        
        NSMutableArray * dataArr = [[NSMutableArray alloc] init];
        
        int startTime = 0;
        
        int endTime = 0;
        
        for (int i = 0; i < arr.count; i ++) {
            
            TDD_HChartModel * model = arr[i];
            
            if ([model isKindOfClass:[NSDictionary class]]) {
                model = [TDD_HChartModel yy_modelWithDictionary:(NSDictionary *)model];
            }
            
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:model.time y:model.value];
            
            [dataArr addObject:entry];
            
            if (i == 0) {
                startTime = model.time;
            }
            
            if (i == arr.count - 1) {
                
                if (model.valueStrArr.count > 0) {
                    if (j == 0) {
                        self.lineChartView.leftAxis.labelCount = model.valueStrArr.count + 2;
                        TDD_DateValueFormatter * leftForm = (TDD_DateValueFormatter *)self.lineChartView.leftAxis.valueFormatter;
                        leftForm.valueStrArr = model.valueStrArr;
                    }else {
                        self.lineChartView.rightAxis.labelCount = model.valueStrArr.count + 2;
                        TDD_DateValueFormatter * rightForm = (TDD_DateValueFormatter *)self.lineChartView.rightAxis.valueFormatter;
                        
                        rightForm.valueStrArr = model.valueStrArr;
                    }
                    
                }else {
                    self.lineChartView.leftAxis.labelCount = 5;
                    
                    self.lineChartView.rightAxis.labelCount = 5;
                    
                    if (self.showType == ShowType_FreqWave) {
                        self.lineChartView.leftAxis.labelCount = 10;
                        
                        self.lineChartView.rightAxis.labelCount = 6;
                        
                        self.lineChartView.xAxis.granularity = 1;
                    }
                    
                    self.lineChartView.leftAxis.granularityEnabled = YES;//设置重复的值不显示
                    
                    self.lineChartView.leftAxis.forceLabelsEnabled = YES; //强制轴数量
                    
                    self.lineChartView.rightAxis.granularityEnabled = YES;//设置重复的值不显示
                    
                    self.lineChartView.rightAxis.forceLabelsEnabled = YES; //强制轴数量
                    
                    TDD_DateValueFormatter * leftForm = (TDD_DateValueFormatter *)self.lineChartView.leftAxis.valueFormatter;
                    
                    leftForm.valueStrArr = @[].mutableCopy;
                    
                    TDD_DateValueFormatter * rightForm = (TDD_DateValueFormatter *)self.lineChartView.rightAxis.valueFormatter;
                    
                    rightForm.valueStrArr = @[].mutableCopy;
                }
                
                endTime = model.time;
                
                if (self.showType == ShowType_FreqWave) {
                    if (endTime - startTime > 6) {
                        [self setXMin:endTime - 6 XMax:endTime];
                    }else {
                        [self setXMin:startTime XMax:startTime + 6];
                    }
                }else {
                    if (endTime - startTime > 30) {
                        [self setXMin:endTime - 29 XMax:endTime + 1];
                    }else {
                        [self setXMin:startTime XMax:startTime + 30];
                    }
                }
                
            }
            
        }
        
        if (dataArr.count == 0) {
            return;
        }
        
        LineChartDataSet *set = nil;
        if (self.lineChartView.data.dataSets.count > j) {
            set = (LineChartDataSet *)self.lineChartView.data.dataSets[j];
            [set replaceEntries:dataArr];
        }
    }
    
        
//    }
    
    [self updata];
}

- (void)setXMin:(NSTimeInterval)xMin XMax:(NSTimeInterval)XMax{
    self.lineChartView.xAxis.axisMinimum = xMin;
    
    self.lineChartView.xAxis.axisMaximum = XMax;
    
    [self updata];
}

#pragma mark 创建图表
- (void)creatChart{
//    LineChartView *lineChartView = [[LineChartView alloc] initWithFrame:CGRectMake(0, 15 * H_Height, self.bounds.size.width, self.bounds.size.height - 15 * H_Height)];
    LineChartView *lineChartView = [[LineChartView alloc] init];
    lineChartView.delegate = self;
//    lineChartView.viewPortHandler.chartWidth = 100;
//    lineChartView.minOffset = 40;
//    [lineChartView setViewPortOffsetsWithLeft:100 top:0 right:0 bottom:0];
//    [lineChartView.viewPortHandler setChartDimensWithWidth:100 height:100];
    [self addSubview:lineChartView];
    
    [lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.lineChartView = lineChartView;
    lineChartView.dragEnabled = NO;
    //禁止双击缩放 有需要可以设置为YES
//    [lineChartView setExtraOffsetsWithLeft:50 top:0 right:5 bottom:0];
//    lineChartView.minOffset = 10;
    lineChartView.doubleTapToZoomEnabled = NO;
    
    lineChartView.scaleYEnabled = NO;//取消Y轴缩放
    lineChartView.scaleXEnabled = NO;//取消x轴缩放
    
    //表框以及表内线条的颜色以及隐藏设置 根据自己需要调整
    
    lineChartView.gridBackgroundColor = [UIColor clearColor];
    
    lineChartView.borderColor = [UIColor clearColor];
    
    lineChartView.drawGridBackgroundEnabled = NO;
    
    lineChartView.drawBordersEnabled = NO;
    
    lineChartView.noDataText = TDDLocalized.home_no_data_tips;
    
    lineChartView.noDataTextColor = [UIColor tdd_subTitle];
    
//    lineChartView.setVisibleXRangeMaximum = 10;
    
    //    lineChartView.description = @"XXX";//该表格的描述名称
    //
//        lineChartView.descriptionTextColor = [UIColor whiteColor];//描述字体颜色
    
    lineChartView.legend.enabled = NO;//是否显示折线的名称以及对应颜色 多条折线时必须开启 否则无法分辨
    
//    lineChartView.legend.textColor = [UIColor whiteColor];//折线名称字体颜色
//    lineChartView.autoScaleMinMaxEnabled = YES;
    lineChartView.dragEnabled = YES;//启用拖拽
    lineChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    lineChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
//    lineChartView.maxVisibleCount = 6;//设置能够显示的数据数量
    //设置动画时间
    
    //设置纵轴坐标显示在左边而非右边
    
    ChartYAxis * rightAxis = lineChartView.rightAxis;
    rightAxis.enabled = NO;
    rightAxis.axisLineColor = [UIColor tdd_color666666];
//    rightAxis.drawLimitLinesBehindDataEnabled = YES; //网格线放前面
//    rightAxis.drawGridLinesBehindDataEnabled = NO;
//    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.labelTextColor = [UIColor tdd_subTitle];
    rightAxis.labelFont = [[UIFont systemFontOfSize:10] tdd_adaptHD];
    rightAxis.valueFormatter = [TDD_DateValueFormatter new];
    rightAxis.gridColor = [UIColor clearColor];
    rightAxis.labelCount = 5;//轴应该有标签条目的数量
    rightAxis.granularity = 1;//间隔
    rightAxis.decimals = 2;
    rightAxis.granularityEnabled = YES;//设置重复的值不显示
    rightAxis.forceLabelsEnabled = YES; //强制轴数量
    
    ChartYAxis * leftAxis = lineChartView.leftAxis;
//    leftAxis.drawLimitLinesBehindDataEnabled = YES; //网格线放前面
//    leftAxis.drawGridLinesBehindDataEnabled = NO;
//    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.axisLineColor = [UIColor tdd_color666666];
    leftAxis.labelTextColor = [UIColor tdd_subTitle];
    leftAxis.drawGridLinesBehindDataEnabled = NO;
    leftAxis.labelFont = [[UIFont systemFontOfSize:10] tdd_adaptHD];
    leftAxis.valueFormatter = [TDD_DateValueFormatter new];
    leftAxis.gridColor = [UIColor tdd_colorWithHex:0xE9E9E9];
    leftAxis.gridLineDashLengths = @[@(1),@(1)];
    leftAxis.labelCount = 5;//轴应该有标签条目的数量
    leftAxis.granularity = 1;//间隔
    leftAxis.decimals = 2;
    leftAxis.granularityEnabled = YES;//设置重复的值不显示
    leftAxis.forceLabelsEnabled = YES; //强制轴数量
    
    //设置横轴坐标显示在下方 默认显示是在顶部
    ChartXAxis * xAxis = lineChartView.xAxis;
    xAxis.axisLineColor = [UIColor tdd_color666666];
    xAxis.gridColor = [UIColor tdd_colorWithHex:0xE9E9E9];
    xAxis.gridLineDashLengths = @[@(1),@(1)];
    xAxis.drawGridLinesBehindDataEnabled = NO;
    xAxis.drawGridLinesEnabled = YES;
//    xAxis.drawAxisLineEnabled = NO;
//    xAxis.labelRotationAngle = -45; //倾斜角度
    xAxis.labelPosition = XAxisLabelPositionBottom;
//    xAxis.centerAxisLabelsEnabled = YES;//x标签居中
    xAxis.labelCount = 7;
//    xAxis.decimals = 2;
//    xAxis.avoidFirstLastClippingEnabled = YES;  //避免文字显示不全 这个属性很重要
//    xAxis.forceLabelsEnabled = YES; //强制x轴数量
    xAxis.granularity = isKindOfTopVCI ? 10 : 5;//间隔
    xAxis.granularityEnabled = YES;//设置重复的值不显示
    xAxis.labelTextColor = [UIColor tdd_subTitle];
    xAxis.labelFont = [[UIFont systemFontOfSize:10] tdd_adaptHD];
    xAxis.valueFormatter = [TDD_DateValueFormatter new];
    
    NSLog(@"创建线条");
    NSMutableArray *sets = [NSMutableArray array];

    LineChartDataSet * set = [self creatDataSetWithYValues:@[] color:[UIColor tdd_blue]];
    
    [sets addObject:set];
    
    LineChartDataSet * set2 = [self creatDataSetWithYValues:@[] color:[UIColor tdd_blue]];
    set2.axisDependency = AxisDependencyRight;
    [sets addObject:set2];
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:sets];
    
    self.lineChartView.data = data;
    
//    self.lineChartView.leftAxis.axisMinimum = 0;
}

#pragma mark 创建线条
- (LineChartDataSet *)creatDataSetWithYValues:(NSArray *)yValues color:(UIColor *)color{
    //创建LineChartDataSet对象
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithEntries:yValues label:@""];
    //这里模式可以用来设置线条的类型：比如折线，平滑曲线等
    set.mode = LineChartModeHorizontalBezier;
    //辅助线 默认是有辅助线的(也就是十字线)，如果不需要可以设置
    set.drawHorizontalHighlightIndicatorEnabled = NO;
//    set1.drawVerticalHighlightIndicatorEnabled = NO;
    
    set.drawValuesEnabled = NO;//不显示文字
    set.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
    set.highlightColor = color;// 十字线颜色
    set.highlightLineDashLengths = @[@(2),@(2)];
    set.highlightLineWidth = 1;
    set.drawCirclesEnabled = YES;//是否绘制拐点
//    set.drawCirclesEnabled = NO;//是否绘制拐点
    set.cubicIntensity = 0.2;// 曲线弧度
    set.circleRadius = 1.0f;//拐点半径
    set.drawCircleHoleEnabled = NO;//是否绘制中间的空心
    set.circleHoleRadius = 4.0f;//空心的半径
    set.circleHoleColor = [UIColor whiteColor];//空心的颜色
//    set.circleColors = @[[UIColor colorWithRed:0.114 green:0.812 blue:1.000 alpha:1.000]];
    set.circleColors = @[color];
    // 设置渐变效果
    [set setColor:color];//折线颜色
    if (self.showType != showType_More) {
        
        set.drawFilledEnabled = YES;//是否填充颜色
        NSArray *gradientColors = @[(id)color.CGColor,
                                    (id)[color colorWithAlphaComponent:0].CGColor];
        CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        set.fillAlpha = 1;//透明度
        set.fill = [ChartFill fillWithLinearGradient:gradientRef angle:-90.0f];//赋值填充颜色对象
        CGGradientRelease(gradientRef);//释放gradientRef
        
    }
    return set;
}

#pragma mark 更新数据
- (void)updata{
//    LineChartDataSet *set = nil;
//    if (self.lineChartView.data.dataSets.count > 0) {
//        set = (LineChartDataSet *)self.lineChartView.data.dataSets[0];
//        [set replaceEntries:self.values];
//    }
    
//    self.lineChartView.leftAxis.axisMinimum = 5;
//
//    self.lineChartView.leftAxis.axisMaximum = 18;
    
//    //y轴高度自适应
//    if (self.lineChartView.data.dataSets.count > 0) {
//        LineChartDataSet *set = nil;
//        set = (LineChartDataSet *)self.lineChartView.data.dataSets[0];
//
//        double yDifference = set.yMax - set.yMin;
//
//        if (yDifference < 0.6) {
//            yDifference = 0.6;
//        }
//
//        if (yDifference > 0) {
//            double yAdd = yDifference / 4.0;
//
//            self.lineChartView.leftAxis.axisMaximum = set.yMax + yAdd;
//
//            double min = set.yMin - yAdd;
//
//            if (min < 0) {
//                min = 0;
//            }
//
//            self.lineChartView.leftAxis.axisMinimum = min;
//        }
//    }
    
//    self.lineChartView.rightAxis.axisMinimum = 0;
//
//    self.lineChartView.rightAxis.axisMaximum = 6;
    
//
//    self.lineChartView.xAxis.axisMinimum = 0;
//
//    self.lineChartView.xAxis.axisMaximum = 5;

    if (self.showType == ShowType_FreqWave) {
        self.lineChartView.leftAxis.axisMinimum = 0;
        
        self.lineChartView.leftAxis.axisMaximum = 9;
    }
    
    //通知data去更新
    [self.lineChartView.lineData notifyDataChanged];
    //通知图表去更新
    [self.lineChartView notifyDataSetChanged];
}

- (void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    
}

- (void)setChartType:(ChartType)chartType{
    _chartType = chartType;
    
    ChartYAxis * leftAxis = self.lineChartView.leftAxis;
    ChartYAxis * rightAxis = self.lineChartView.rightAxis;
    ChartXAxis * xAxis = self.lineChartView.xAxis;
    
    xAxis.enabled = NO;
    leftAxis.gridColor = [UIColor clearColor];
    leftAxis.maxWidth = 0;
    
    //折线颜色
    LineChartDataSet * set1 = (LineChartDataSet *)self.lineChartView.data.dataSets[0];
//    [set1 clear];
    LineChartDataSet * set2 = (LineChartDataSet *)self.lineChartView.data.dataSets[1];
//    [set2 clear];
    
    UIColor * color1 = [UIColor tdd_colorDiagTheme];
    UIColor * color2 = [UIColor tdd_colorDiagTheme];
    
    if (self.colorArr.count > 0) {
        color1 = self.colorArr[0];
    }
    
    if (self.colorArr.count > 1) {
        color2 = self.colorArr[1];
    }
        
    switch (chartType) {
        case ChartType_OneOutY:
        {
            leftAxis.enabled = YES;
            rightAxis.enabled = NO;
            leftAxis.labelTextColor = self.colorArr[0];
            rightAxis.labelTextColor = self.colorArr[1];
            leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
            rightAxis.labelPosition = YAxisLabelPositionOutsideChart;
            [set1 setColor:[UIColor clearColor]];
            set1.circleColors = @[[UIColor clearColor]];
            [set2 setColor:[UIColor clearColor]];
            set2.circleColors = @[[UIColor clearColor]];
        }
            break;
        case ChartType_TwoOutY:
        {
            leftAxis.enabled = YES;
            rightAxis.enabled = YES;
            leftAxis.labelTextColor = self.colorArr[0];
            rightAxis.labelTextColor = self.colorArr[1];
            leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
            rightAxis.labelPosition = YAxisLabelPositionOutsideChart;
            [set1 setColor:[UIColor clearColor]];
            set1.circleColors = @[[UIColor clearColor]];
            [set2 setColor:[UIColor clearColor]];
            set2.circleColors = @[[UIColor clearColor]];
        }
            break;
        case ChartType_OneInY:
        {
            leftAxis.enabled = YES;
            rightAxis.enabled = NO;
            
            leftAxis.labelTextColor = self.colorArr[2];
            rightAxis.labelTextColor = self.colorArr[3];
            
            leftAxis.axisLineColor = [UIColor clearColor];
            rightAxis.axisLineColor = [UIColor clearColor];
            
            leftAxis.labelPosition = YAxisLabelPositionInsideChart;
            rightAxis.labelPosition = YAxisLabelPositionInsideChart;
            
            [set1 setColor:[UIColor clearColor]];
            set1.circleColors = @[[UIColor clearColor]];
            [set2 setColor:[UIColor clearColor]];
            set2.circleColors = @[[UIColor clearColor]];
        }
            break;
        case ChartType_TwoInY:
        {
            leftAxis.enabled = YES;
            rightAxis.enabled = YES;
            
            leftAxis.labelTextColor = self.colorArr[2];
            rightAxis.labelTextColor = self.colorArr[3];
            
            leftAxis.axisLineColor = [UIColor clearColor];
            rightAxis.axisLineColor = [UIColor clearColor];
            
            leftAxis.labelPosition = YAxisLabelPositionInsideChart;
            rightAxis.labelPosition = YAxisLabelPositionInsideChart;
            
            [set1 setColor:[UIColor clearColor]];
            set1.circleColors = @[[UIColor clearColor]];
            [set2 setColor:[UIColor clearColor]];
            set2.circleColors = @[[UIColor clearColor]];
        }
            break;
        case ChartType_NoY_Line:
        {
            leftAxis.enabled = YES;
            rightAxis.enabled = NO;
            xAxis.enabled = YES;
            leftAxis.maxWidth = 0.0001;
            leftAxis.axisLineColor = [UIColor clearColor];
            leftAxis.labelTextColor = [UIColor clearColor];
            leftAxis.gridColor = [UIColor tdd_colorWithHex:0xE9E9E9];
            [set1 setColor:color1];
            set1.circleColors = @[color1];
            [set2 setColor:color2];
            set2.circleColors = @[color2];
        }
            break;
        case ChartType_NoY_NoLine:
        {
            leftAxis.enabled = NO;
            rightAxis.enabled = NO;
            xAxis.enabled = YES;
            xAxis.axisLineColor = [UIColor clearColor];
            xAxis.gridColor = [UIColor clearColor];
            xAxis.labelTextColor = [UIColor clearColor];
            [set1 setColor:color1];
            set1.circleColors = @[color1];
            [set2 setColor:color2];
            set2.circleColors = @[color2];
        }
            break;
            
        default:
            break;
    }
    
    
    
//    LineChartDataSet *set = nil;
//
//    if (chartType == 1){
//        self.lineChartView.rightAxis.enabled = YES;
//        if (self.lineChartView.data.dataSets.count > 0) {
//            set = (LineChartDataSet *)self.lineChartView.data.dataSets[0];
//            [set setColor:[UIColor tdd_mainColor]];//折线颜色
//            set.highlightColor = [UIColor tdd_mainColor];// 十字线颜色
//            set.circleColors = @[[UIColor tdd_mainColor]];
//        }
//    }else{
//        self.lineChartView.rightAxis.enabled = NO;
//        if (self.lineChartView.data.dataSets.count > 1) {
//            set = (LineChartDataSet *)self.lineChartView.data.dataSets[1];
//            [set clear];
//            set = (LineChartDataSet *)self.lineChartView.data.dataSets[0];
//            [set setColor:[UIColor tdd_mainColor]];//折线颜色
//            set.highlightColor = [UIColor tdd_mainColor];// 十字线颜色
//            set.circleColors = @[[UIColor tdd_mainColor]];
//        }
//    }
    
    //通知data去更新
    [self.lineChartView.lineData notifyDataChanged];
    //通知图表去更新
    [self.lineChartView notifyDataSetChanged];
}

- (CGSize)getLeftAxisRequiredSize
{
    ChartYAxis * leftAxis = self.lineChartView.leftAxis;
    
    return leftAxis.requiredSize;
}

- (CGSize)getRightAxisRequiredSize
{
    ChartYAxis * rightAxis = self.lineChartView.rightAxis;
    
    return rightAxis.requiredSize;
}

- (CGFloat)getxAxisLabelHeight
{
    ChartXAxis * xAxis = self.lineChartView.xAxis;
    
    return xAxis.labelHeight;
}

- (void)setExtraOffsetsWithLeft:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom
{
    [self.lineChartView setExtraOffsetsWithLeft:left top:top right:right bottom:bottom];
}

- (NSArray *)colorArr
{
    if (!_colorArr) {
        _colorArr = [TDD_DiagBridge chart4Colors];
    }
    
    return _colorArr;
}

- (void)dealloc{
    NSLog(@"chart -- dealloc");
}

@end
