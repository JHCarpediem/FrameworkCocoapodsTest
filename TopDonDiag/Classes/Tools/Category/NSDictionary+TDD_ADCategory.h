//
//  NSDictionary+TDD_ADCategory.h
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (TDD_ADCategory)
- (id)tdd_objectForTreeStyleKey:(NSString*)key;     //format the key to string separated by "/", eg. key/subkey

- (BOOL)tdd_getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (NSInteger)tdd_getIntValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (time_t)tdd_getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;
- (long long)tdd_getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (NSString *)tdd_getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (double)tdd_getDoubleValueForKey:(NSString *)key defaultValue:(double)defaultValue;
- (NSDate *)tdd_getDateValueForKey:(NSString *)key defaultValue:(NSDate *)defaultValue;
- (NSArray *)tdd_getArrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSString*)tdd_kp_description;
+ (id)tdd_changeType:(id)myObj;
@end

NS_ASSUME_NONNULL_END
