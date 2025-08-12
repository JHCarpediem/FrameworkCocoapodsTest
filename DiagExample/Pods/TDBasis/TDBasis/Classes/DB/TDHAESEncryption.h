//
//  HAESEncryption.h
//  BTMobile Pro
//
//  Created by 何可人 on 2021/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//首先声明一个宏定义
#define TDFileHashDefaultChunkSizeForReadingData 1024*8

@interface TDHAESEncryption : NSObject

+ (NSString *)td_AES128ParmEncryptWithContent:(NSString *)content;
+ (NSString *)td_AES128ParmDecryptWithContent:(NSString *)content;
+ (NSString *)td_AESLocalEncryptionWithContent:(NSString *)content;
+ (NSString *)td_hmacSHA256WithContent:(NSString *)content;
+ (NSString *)td_getmd5Str:(NSString *)str;
+ (NSString *)td_getBigFileMD5:(NSString *)path;
+ (NSString *)td_encryptAES:(NSString *)content key:(NSString *)key;
+ (NSString *)td_decryptAES:(NSString *)content key:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
