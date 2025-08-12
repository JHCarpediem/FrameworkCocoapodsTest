//
//  TDD_HChartModel.h
//  BTMobile Pro
//
//  Created by 何可人 on 2021/10/21.
//

#import "TDD_JKDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_HChartModel : TDD_JKDBModel
//@property (nonatomic, assign) long time;
@property (nonatomic, assign) double time;
@property (nonatomic, assign) float value;
@property (nonatomic, strong) NSString * valueStr;
@property (nonatomic, strong) NSMutableArray * valueStrArr; //非数字数据，使用数组存储
@end

NS_ASSUME_NONNULL_END
