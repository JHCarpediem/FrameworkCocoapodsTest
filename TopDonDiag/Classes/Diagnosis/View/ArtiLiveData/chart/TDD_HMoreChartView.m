//
//  TDD_HMoreChartView.m
//  AD200
//
//  Created by hkr on 2022/9/14.
//

#import "TDD_HMoreChartView.h"
#import "TDD_HChartView.h"

@interface TDD_HMoreChartView ()
@property (nonatomic,strong) TDD_HChartView * showDataChartView1;
@property (nonatomic,strong) TDD_HChartView * showDataChartView2;
@property (nonatomic,strong) TDD_HChartView * OutYChartView;
@property (nonatomic,strong) TDD_HChartView * InYChartView;
@property (nonatomic,strong) NSArray * colorArr;
@end

@implementation TDD_HMoreChartView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setValueArr:(NSArray<NSArray *> *)valueArr
{
    _valueArr = valueArr;
    
    int nub = (int)valueArr.count;
    
    if (nub < 3) {
        
        _showDataChartView2.hidden = YES;
        _InYChartView.hidden = YES;
        
        self.showDataChartView1.valueArr = valueArr;
        self.OutYChartView.valueArr = valueArr;
        
        if (nub <= 1) {
            self.OutYChartView.chartType = ChartType_OneOutY;
            
            [self.showDataChartView1 setExtraOffsetsWithLeft:[self.OutYChartView getLeftAxisRequiredSize].width top:0 right:0 bottom:0];
        }else {
            self.OutYChartView.chartType = ChartType_TwoOutY;
            
            [self.showDataChartView1 setExtraOffsetsWithLeft:[self.OutYChartView getLeftAxisRequiredSize].width top:0 right:[self.OutYChartView getRightAxisRequiredSize].width bottom:0];
        }
        
        [self.OutYChartView setExtraOffsetsWithLeft:0 top:0 right:0 bottom:[self.showDataChartView1 getxAxisLabelHeight] + 4];
        
    }else {
        
        NSMutableArray * newValueArr = valueArr.mutableCopy;
        
        self.showDataChartView1.valueArr = [valueArr subarrayWithRange:NSMakeRange(0, 2)];
        self.OutYChartView.valueArr = [valueArr subarrayWithRange:NSMakeRange(0, 2)];
        
        [newValueArr removeObjectsInRange:NSMakeRange(0, 2)];
        
        self.showDataChartView2.valueArr = newValueArr;
        self.InYChartView.valueArr = newValueArr;
        
        _showDataChartView2.hidden = NO;
        _InYChartView.hidden = NO;
        
        self.OutYChartView.chartType = ChartType_TwoOutY;
        
        if (nub <= 3) {
            
            self.InYChartView.chartType = ChartType_OneInY;
            
            [self.showDataChartView1 setExtraOffsetsWithLeft:[self.OutYChartView getLeftAxisRequiredSize].width + [self.InYChartView getLeftAxisRequiredSize].width top:0 right:[self.OutYChartView getRightAxisRequiredSize].width bottom:0];
            
            [self.showDataChartView2 setExtraOffsetsWithLeft:[self.OutYChartView getLeftAxisRequiredSize].width + [self.InYChartView getLeftAxisRequiredSize].width top:0 right:[self.OutYChartView getRightAxisRequiredSize].width bottom:0];
        }else {
            
            self.InYChartView.chartType = ChartType_TwoInY;
            
            [self.showDataChartView1 setExtraOffsetsWithLeft:[self.OutYChartView getLeftAxisRequiredSize].width + [self.InYChartView getLeftAxisRequiredSize].width top:0 right:[self.OutYChartView getRightAxisRequiredSize].width + [self.InYChartView getRightAxisRequiredSize].width bottom:0];
            
            [self.showDataChartView2 setExtraOffsetsWithLeft:[self.OutYChartView getLeftAxisRequiredSize].width + [self.InYChartView getLeftAxisRequiredSize].width top:0 right:[self.OutYChartView getRightAxisRequiredSize].width + [self.InYChartView getRightAxisRequiredSize].width bottom:0];
        }
        
        [self.OutYChartView setExtraOffsetsWithLeft:0 top:0 right:0 bottom:[self.showDataChartView1 getxAxisLabelHeight] + 4];
        
        [self.InYChartView setExtraOffsetsWithLeft:[self.OutYChartView getLeftAxisRequiredSize].width top:0 right:[self.OutYChartView getRightAxisRequiredSize].width bottom:[self.showDataChartView1 getxAxisLabelHeight] + 4];
    }
}

- (TDD_HChartView *)showDataChartView1
{
    if (!_showDataChartView1) {
        _showDataChartView1 = [[TDD_HChartView alloc] initWithShowType:showType_More];
        _showDataChartView1.colorArr = @[self.colorArr[0],self.colorArr[1]];
        _showDataChartView1.chartType = ChartType_NoY_Line;
        [self addSubview:_showDataChartView1];
        
        [_showDataChartView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    
    return _showDataChartView1;
}

- (TDD_HChartView *)showDataChartView2
{
    if (!_showDataChartView2) {
        _showDataChartView2 = [[TDD_HChartView alloc] initWithShowType:showType_More];
        _showDataChartView2.colorArr = @[self.colorArr[2],self.colorArr[3]];
        _showDataChartView2.chartType = ChartType_NoY_NoLine;
        [self addSubview:_showDataChartView2];
        
        [_showDataChartView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    
    return _showDataChartView2;
}

- (TDD_HChartView *)OutYChartView
{
    if (!_OutYChartView) {
        _OutYChartView = [[TDD_HChartView alloc] initWithShowType:showType_More];
        _OutYChartView.chartType = ChartType_OneOutY;
        [self addSubview:_OutYChartView];
        
        [_OutYChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    
    return _OutYChartView;
}

- (TDD_HChartView *)InYChartView
{
    if (!_InYChartView) {
        _InYChartView = [[TDD_HChartView alloc] initWithShowType:showType_More];
        _InYChartView.chartType = ChartType_OneInY;
        [self addSubview:_InYChartView];
        
        [_InYChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    
    return _InYChartView;
}

- (NSArray *)colorArr
{
    if (!_colorArr) {
        _colorArr = [TDD_DiagBridge chart4Colors];
    }
    
    return _colorArr;
}
@end
