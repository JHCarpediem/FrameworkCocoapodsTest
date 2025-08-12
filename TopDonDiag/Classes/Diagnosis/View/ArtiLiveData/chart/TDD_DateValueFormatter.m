//
//  TDD_DateValueFormatter.m
//  BTMobile Pro
//
//  Created by 何可人 on 2021/10/21.
//

#import "TDD_DateValueFormatter.h"

@implementation TDD_DateValueFormatter

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    
    NSString * valueStr = @"";
    
    if ([axis isKindOfClass:[ChartXAxis class]]) {
        
//        NSString * format = @"mm:ss";
        
//        NSTimeInterval dayTime = 24 * 60 * 60;
//
//        NSTimeInterval time = self.startTime + value * dayTime;
        
//        valueStr = [NSDate tdd_getTimeStringWithInterval:value - self.startTime Format:format];
        
//        int valueInt = value - self.startTime;
        
        valueStr = [NSString stringWithFormat:@"%02d:%02d", (int)value / 60, (int)value % 60];
        
    }else if ([axis isKindOfClass:[ChartYAxis class]]){
        if (self.valueStrArr.count > 0) {
            
            int valueInt = (int)value - 1;
            
            if (valueInt < self.valueStrArr.count) {
                valueStr = self.valueStrArr[valueInt];
            }else {
                valueStr = @"";
            }
            
        }else {
            valueStr = [NSString stringWithFormat:@"%.02f", roundf(value * 100) / 100.0];
        }
        
    }
    
    return valueStr;
}

@end
