//
//  TDD_DateValueFormatter.h
//  BTMobile Pro
//
//  Created by Diag on 2021/10/21.
//

#import <Foundation/Foundation.h>
#import <Diagnosis/Diagnosis-Swift.h>
#import "Diagnosis-Bridging-Header.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_DateValueFormatter : NSObject <IChartAxisValueFormatter>
@property (nonatomic, assign) NSTimeInterval startTime; // 开始日期
@property (nonatomic, strong) NSMutableArray * valueStrArr; //非数字数据，使用数组存储
@end

NS_ASSUME_NONNULL_END
