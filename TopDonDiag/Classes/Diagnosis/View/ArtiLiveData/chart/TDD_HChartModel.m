//
//  TDD_HChartModel.m
//  BTMobile Pro
//
//  Created by 何可人 on 2021/10/21.
//

#import "TDD_HChartModel.h"

@implementation TDD_HChartModel

- (void)setValueStr:(NSString *)valueStr
{
    _valueStr = valueStr;
    
    if ([NSString tdd_isNum:valueStr]) {
        self.value = valueStr.floatValue;
    }else {
        int nub = (int)[self.valueStrArr indexOfObject:valueStr] + 1;
        
        self.value = nub;
    }
}

//##下面代码你只需要更换下model的类型，可直接复用。（在使用的地方需要导入   #import <objc/message.h>）
-(id)copyWithZone:(NSZone *)zone{
    id objCopy = [[TDD_HChartModel allocWithZone:zone] init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([TDD_HChartModel class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:propertyName];
        if (value&&([value isKindOfClass:[NSMutableArray class]]||[value isKindOfClass:[NSArray class]])) {
            id valueCopy  = [[NSArray alloc]initWithArray:value copyItems:YES];
            [objCopy setValue:valueCopy forKey:propertyName];
        }else if (value) {
            [objCopy setValue:[value copy] forKey:propertyName];
        }
    }
    free(properties);
    return objCopy;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    id objCopy = [[[self class] allocWithZone:zone] init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:propertyName];
        if (value&&([value isKindOfClass:[NSMutableArray class]]||[value isKindOfClass:[NSArray class]])) {
            id valueCopy  = [[NSMutableArray alloc]initWithArray:value copyItems:YES];
            [objCopy setValue:valueCopy forKey:propertyName];
        }else if(value){
            [objCopy setValue:[value copy] forKey:propertyName];
        }
    }
    free(properties);
    return objCopy;
}

- (NSMutableArray *)valueStrArr {
    if (!_valueStrArr){
        _valueStrArr = [NSMutableArray array];
    }
    return _valueStrArr;
}
@end
