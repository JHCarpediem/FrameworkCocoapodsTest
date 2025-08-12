//
//  TDD_CarModel.m
//  DiagnosisSDK
//
//  Created by 何可人 on 2022/6/1.
//

#import "TDD_CarModel.h"
@implementation TDD_MaskModel

@end
@implementation TDD_CarModel


- (NSString *)calculateFileSize
{
    NSString *filePath = [NSString stringWithFormat:@"%@", self.path];
    return filePath.tdd_fileSize;
}

- (NSString *)description {
    // 初始化一个字典
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    // 得到当前classs的所有属性
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        // 循环并用kvc得到每个属性的值
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name] ? : nil;  // 默认值为nil字符串
        if (value) {
            [dictionary setObject:value forKey:name];
        }
    }
    // 释放
    free(properties);
    // return
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class], self, dictionary];
}

@end
