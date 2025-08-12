//
//  HKeychainTool.h
//  BTMobile Pro
//
//  Created by 何可人 on 2021/5/12.
//

#import <Foundation/Foundation.h>



@interface TDHKeychainTool : NSObject

/**
 *  储存字符串到🔑钥匙串
 *
 *  @param sValue 对应的Value
 *  @param sKey   对应的Key
 */
+ (void)td_saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;


/**
 *  从🔑钥匙串获取字符串
 *
 *  @param sKey 对应的Key
 *
 *  @return 返回储存的Value
 */
+ (NSString *)td_readKeychainValue:(NSString *)sKey;


/**
 *  从🔑钥匙串删除字符串
 *
 *  @param sKey 对应的Key
 */
+ (void)td_deleteKeychainValue:(NSString *)sKey;
@end


