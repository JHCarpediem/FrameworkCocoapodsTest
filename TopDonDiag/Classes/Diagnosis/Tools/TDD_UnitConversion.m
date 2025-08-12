//
//  TDD_UnitConversion.m
//  AD200
//
//  Created by AppTD on 2022/12/21.
//

#import "TDD_UnitConversion.h"

@implementation TDD_UnitConversion

+ (TDD_UnitConversion *)sharedUnit
{
    static TDD_UnitConversion * unitConversion = nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        unitConversion = [[TDD_UnitConversion alloc] init];
    });
    return unitConversion;
}

#pragma mark 解析公英制文件
+ (void)analysisUnitFile:(NSString *)unit
{
    [TDD_UnitConversion analysisUnitFile:unit isReset:YES];
    
}


/// 解析公英制文件
/// - Parameters:
///   - unit: 公制/英制
///   - isReset: 解析完是否设置到全局使用
+ (void)analysisUnitFile:(NSString *)unit isReset:(BOOL )isReset {
    __block NSString *diagnosticUnit = unit;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (diagnosticUnit.length == 0) {
            diagnosticUnit = @"metric";
        }
        TDD_UnitConversionType *type;
        if ([diagnosticUnit isEqualToString:@"metric"]) {
            type = TDD_UnitConversionType_Metric;
        } else if ([diagnosticUnit isEqualToString:@"imperial"]) {
            type = TDD_UnitConversionType_Imperial;
        }
        if (isReset) {
            [self sharedUnit].unitConversionType = type;
        }

        
        
        // 获取文件路径
        NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:[NSString stringWithFormat:@"TopdonDiagnosis.bundle/%@", diagnosticUnit] ofType:@"json"];
        // 将文件数据化
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        // 对数据进行JSON格式化并返回字典形式
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSMutableDictionary * unitDic = [[NSMutableDictionary alloc] init];
        
        NSMutableDictionary * coefficientDic = [[NSMutableDictionary alloc] init];
        
        for (NSDictionary * dic in arr) {
            [unitDic setValue:dic[@"转换后单位"] forKey:dic[@"转换前单位"]];
            [coefficientDic setValue:dic[@"计算因子"] forKey:dic[@"转换前单位"]];
        }
        
        if (type == TDD_UnitConversionType_Metric) {
            [self sharedUnit].metricUnitDic = unitDic;
            [self sharedUnit].metricCoefficientDic = coefficientDic;
            //把另一个单位解析出来
            if ([self sharedUnit].imperialUnitDic.count == 0) {
                [TDD_UnitConversion analysisUnitFile:@"imperial" isReset:false];
            }
            

        }else {
            [self sharedUnit].imperialUnitDic = unitDic;
            [self sharedUnit].imperialCoefficientDic = coefficientDic;
            //把另一个单位解析出来
            if ([self sharedUnit].metricUnitDic.count == 0) {
                [TDD_UnitConversion analysisUnitFile:@"metric" isReset:false];
            }
            
        }
        if (isReset) {
            [self sharedUnit].unitDic = unitDic;
            [self sharedUnit].coefficientDic = coefficientDic;
        }

    });
    
    
}

#pragma mark 公英制转换
+ (TDD_UnitConversionModel *)diagUnitConversionWithUnit:(NSString *)unit value:(NSString *)valueStr
{
    return [TDD_UnitConversion diagUnitConversionWithUnit:unit value:valueStr unitConversionType:TDD_UnitConversionType_None];
}

+ (TDD_UnitConversionModel *)diagUnitConversionWithUnit:(NSString *)unit value:(NSString *)valueStr unitConversionType:(TDD_UnitConversionType )unitConversionType {
    NSString *valueStrTemp = valueStr;
    if ([valueStrTemp hasPrefix:@"+"]){
        valueStrTemp = [valueStrTemp stringByReplacingOccurrencesOfString:@"+" withString:@"" options:1 range:NSMakeRange(0, 1)];
    }
    BOOL isNum = [NSString tdd_isNum:valueStrTemp]; //是否为数字
    if (unit.length == 0) {
        
        double value = 0;
        value = valueStrTemp.doubleValue;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.numberStyle = NSNumberFormatterNoStyle;
        formatter.maximumFractionDigits = 3;
        formatter.minimumIntegerDigits = 1;
        [formatter setDecimalSeparator:@"."];
        NSString *string = [formatter stringFromNumber:@(value)];
        
        TDD_UnitConversionModel * model = [[TDD_UnitConversionModel alloc] init];
        model.unit = unit;
        if (isNum){
            model.value = string;
        }else {
            model.value = valueStr;
        }

        return model;
    }
    
    TDD_UnitConversionType type = unitConversionType;
    //未指定公英制使用通用设置的公英制
    if (type == TDD_UnitConversionType_None) {
        type = [self sharedUnit].unitConversionType;
    }
    
    double value = 0;
    
    if (isNum) {
        value = valueStrTemp.doubleValue;
    }
    
    NSString *convertedUnit = unit;
    
    // 温度单位的转换
    if (type == TDD_UnitConversionType_Metric) {
        //公里制
        if ([unit isEqualToString:@"deg.F"] || [unit isEqualToString:@"°F"]) {
            //华氏度(℉) (℃)=（(℉)-32）÷1.8
            value = (value - 32.0) / 1.8;
            convertedUnit = @"°C";
        }else if ([unit isEqualToString:@"K"]) {
            //开氏度(K) [°C] = [K] − 273.15
            value = value - 273.15;
            convertedUnit = @"°C";
        }else if ([unit isEqualToString:@"deg.C"]) {
            convertedUnit = @"°C";
        }
    }else {
        //英里制
        if ([unit isEqualToString:@"deg.C"] || [unit isEqualToString:@"°C"]) {
            //摄氏度(℃) (℉)=32+(℃)×1.8
            value = 32 + value * 1.8;
            convertedUnit = @"°F";
        }else if ([unit isEqualToString:@"K"]) {
            //开氏度(K) (℉)=32+([K] − 273.15)×1.8
            value = 32 + (value - 273.15) * 1.8;
            convertedUnit = @"°F";
        }else if ([unit isEqualToString:@"deg.F"]) {
            convertedUnit = @"°F";
        }
    }
    
    // 非温度单位的转换//
    NSDictionary *unitDict = (type == TDD_UnitConversionType_Metric) ? [self sharedUnit].metricUnitDic : [self sharedUnit].imperialUnitDic;
    NSDictionary *coefficientDic = (type == TDD_UnitConversionType_Metric) ? [self sharedUnit].metricCoefficientDic: [self sharedUnit].imperialCoefficientDic;
    if ([unit isEqualToString:convertedUnit]) {
        if ([unitDict.allKeys containsObject:unit]) {
            
            double coefficient = [coefficientDic[unit] doubleValue];
            
            if (coefficient > 0) { // 二次容错 温度单位在文档中的计算因子为-1 小于-1的为温度单位 在上面的判断中已经计算过一次了
                convertedUnit = unitDict[unit];
                
                value = value * coefficient;
            }else {
                NSLog(@"错误：转换前单位：%@，转换因子：%f", unit, coefficient);
            }
        }
    }
    
    TDD_UnitConversionModel * model = [[TDD_UnitConversionModel alloc] init];
    model.unit = convertedUnit;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    formatter.maximumFractionDigits = 5;
    formatter.minimumIntegerDigits = 1;
    [formatter setDecimalSeparator:@"."];
    NSString *string = [formatter stringFromNumber:@(value)];
    if (isNum) {
        model.value = string;
    }else {
        model.value = valueStr;
    }
//    model.value = [NSString stringWithFormat:@"%.2f", value];
//    model.value = [NSString stringWithFormat:@"%@",@(model.value.doubleValue)];
    return model;
    
}

@end


@implementation TDD_UnitConversionModel

@end
