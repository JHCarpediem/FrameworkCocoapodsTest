//
//  TDD_HChartView.h
//  BTMobile Pro
//
//  Created by 何可人 on 2022/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum
{
    ///1条外y轴，没x轴
    ChartType_OneOutY = 0,
    ///2条外y轴，没x轴
    ChartType_TwoOutY,
    ///1条内y轴，没x轴
    ChartType_OneInY,
    ///2条内y轴，没x轴
    ChartType_TwoInY,
    ///没有y轴，有线，有x轴
    ChartType_NoY_Line,
    ///没有y轴，没有线，有x轴
    ChartType_NoY_NoLine
}ChartType;

typedef enum
{
    ///数据流页面
    ShowType_LiveData = 0,
    ///FreqWave页面
    ShowType_FreqWave,
    /// 组合图形页面
    showType_More,
}ShowType;

@interface TDD_HChartView : UIView
@property (nonatomic, strong) NSArray<NSArray *> * valueArr;
@property (nonatomic, assign) ChartType chartType;
@property (nonatomic, assign) NSTimeInterval startTime; // 开始日期
@property (nonatomic, strong) NSArray<UIColor *> * colorArr;
@property (nonatomic, assign) ShowType showType; //显示类型

- (void)setXMin:(NSTimeInterval)xMin XMax:(NSTimeInterval)XMax;

- (CGSize)getLeftAxisRequiredSize;

- (CGSize)getRightAxisRequiredSize;

- (CGFloat)getxAxisLabelHeight;

- (void)setExtraOffsetsWithLeft:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom;

- (instancetype)initWithShowType:(ShowType) showType;

@end

NS_ASSUME_NONNULL_END
