//
//  TDD_UnitConversion.h
//  AD200
//
//  Created by AppTD on 2022/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum
{
    TDD_UnitConversionType_None               = 0,    // 无
    TDD_UnitConversionType_Metric             = 1,    // 公里制
    TDD_UnitConversionType_Imperial           = 2,     // 英里制
    TDD_UnitConversionType_Car                = 3,     // 车型默认
}TDD_UnitConversionType;

@interface TDD_UnitConversionModel : NSObject
@property (nonatomic,strong) NSString *unit; //单位
@property (nonatomic,strong) NSString *value; //值
@end

@interface TDD_UnitConversion : NSObject
@property (nonatomic,assign) TDD_UnitConversionType unitConversionType;
@property (nonatomic,strong) NSDictionary *unitDic; //单位字典
@property (nonatomic,strong) NSDictionary *coefficientDic; //系数字典
//公制
@property (nonatomic,strong) NSDictionary *metricUnitDic;
@property (nonatomic,strong) NSDictionary *metricCoefficientDic;
//英制
@property (nonatomic,strong) NSDictionary *imperialUnitDic;
@property (nonatomic,strong) NSDictionary *imperialCoefficientDic;

+ (TDD_UnitConversion *)sharedUnit;

#pragma mark 解析公英制文件
+ (void)analysisUnitFile:(NSString *)unit;

#pragma mark 公英制转换
+ (TDD_UnitConversionModel *)diagUnitConversionWithUnit:(NSString *)unit value:(NSString *)valueStr;
+ (TDD_UnitConversionModel *)diagUnitConversionWithUnit:(NSString *)unit value:(NSString *)valueStr unitConversionType:(TDD_UnitConversionType )unitConversionType;
@end

NS_ASSUME_NONNULL_END
