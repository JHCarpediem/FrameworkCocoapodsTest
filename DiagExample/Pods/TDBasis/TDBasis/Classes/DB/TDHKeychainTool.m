//
//  HKeychainTool.m
//  BTMobile Pro
//
//  Created by 何可人 on 2021/5/12.
//

#import "TDHKeychainTool.h"
#import <Security/Security.h>

@implementation TDHKeychainTool
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service{
    
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,
            (id)kSecClass,service,
            (id)kSecAttrService,service,
            (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,
            (id)kSecAttrAccessible,
            nil];
}

+ (void)td_saveKeychainValue:(NSString *)sValue key:(NSString *)sKey{
    NSMutableDictionary * keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:sValue] forKey:(id)kSecValueData];
    
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (NSString *)td_readKeychainValue:(NSString *)sKey
{
    NSString *ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = (NSString *)[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
//            TDNSLog(@"Unarchive of %@ failed: %@", sKey, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    
    return ret;
}

+ (void)td_deleteKeychainValue:(NSString *)sKey {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    
    SecItemDelete(( CFDictionaryRef)keychainQuery);
}
@end
