//
//  HAESEncryption.m
//  BTMobile Pro
//
//  Created by 何可人 on 2021/4/6.
//

#import "TDHAESEncryption.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import "TDGTMBase64.h"

NSString *const Kkey = @"thanks,lenkor123";

NSString *const Localkey = @"hkr123hkr123,^&*";
size_t const kKeySize = kCCKeySizeAES256;
@implementation TDHAESEncryption

/**
    @code
 CCCrypt(kCCDecrypt,  //kCCDecrypt是解密，kCCEncrypt是加密
 kCCAlgorithmAES128,   //算法 ase128
 kCCOptionPKCS7Padding | kCCOptionECBMode,   //填充模式，比如使用ase128算法，要求数据最小长度是128bit，当数据没达到长度是的填充数据策略
 keyPtr, //密钥
 kCCBlockSizeAES128,  //密钥大小
 NULL,   //偏移量
 [self bytes], dataLength,   //数据和数据长度
 buffer, bufferSize,  &numBytesDecrypted);  返回数据
    @endcode
*/
+ (NSString *)td_AES128ParmEncryptWithContent:(NSString *)content
{
    NSData *originData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryData = [self td_AES128ParmEncryptWithContent:originData Key:Kkey iv:Kkey];
    NSString *base64string = [encryData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return base64string;
}

+ (NSString *)td_AES128ParmDecryptWithContent:(NSString *)content
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *resultData = [self td_AES128ParmDecryptWithContent:data Key:Kkey iv:Kkey];
    NSString *reusltString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    return reusltString;
}

+ (NSString *)td_AESLocalEncryptionWithContent:(NSString *)content
{
    NSData *originData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryData = [self td_AES128ParmEncryptWithContent:originData Key:Localkey iv:Localkey];
    NSString *base64string = [encryData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return base64string;
}

+ (NSData *)td_AES128ParmEncryptWithContent:(NSData *)content Key:(NSString *)key iv:(NSString *)iv
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];

    
    NSUInteger dataLength = [content length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr, kCCBlockSizeAES128,
                                          ivPtr,
                                          [content bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

+ (NSString *)td_encryptAES:(NSString *)content key:(NSString *)key{
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = contentData.length;
    // 为结束符'\\0' +1
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionECBMode,  // 系统默认使用 CBC，使用 PKCS7Padding
                                          keyPtr,
                                          kKeySize,
                                          nil,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        // 对加密后的数据 base64 编码
        return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    free(encryptedBytes);
    return nil;
}

+ (NSString *)td_decryptAES:(NSString *)content key:(NSString *)key{
    //NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *contentData = [TDGTMBase64 td_decodeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger dataLength = contentData.length;
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t decryptSize = dataLength + kKeySize;
    void *decryptedBytes = malloc(decryptSize);
    size_t actualOutSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kKeySize,
                                          nil,
                                          contentData.bytes,
                                          dataLength,
                                          decryptedBytes,
                                          decryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    free(decryptedBytes);
    return nil;
}

+ (NSData *)td_AES128ParmDecryptWithContent:(NSData *)content Key:(NSString *)key iv:(NSString *)iv
{
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [content length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr, kCCBlockSizeAES128,
                                          ivPtr,
                                          [content bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

/**
 *  加密方式,MAC算法: HmacSHA256
 *
 *  @param content 要加密的文本
 *
 *  @return 加密后的字符串
 */
+ (NSString *)td_hmacSHA256WithContent:(NSString *)content
{
    NSString * secret = @"htopdong2021";
    const char *cKey  = [secret cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [content cStringUsingEncoding:NSUTF8StringEncoding];// 有可能有中文 所以用NSUTF8StringEncoding -> NSASCIIStringEncoding
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSMutableString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    for (int i = 0; i < HMACData.length; ++i){
        [HMAC appendFormat:@"%02x", buffer[i]];
    }
    
    return HMAC;
}

+ (NSString *)td_getmd5Str:(NSString *)str
{
    //传入参数,转化成char
    const char *cStr = [str UTF8String];
    //开辟一个16字节的空间
    unsigned char result[16];
    /*
     extern unsigned char * CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把str字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了md这个空间中
     */
    CC_MD5(cStr, (unsigned)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ];
}

+ (NSString *)td_getBigFileMD5:(NSString *)path {
    long long size = [self sizeAtPath:path];
    
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)path, TDFileHashDefaultChunkSizeForReadingData, size);
}

//文件的大小(字节)
+ (unsigned long long)sizeAtPath:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,
                                       size_t chunkSizeForReadingData, long long fileSize) {
    
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) goto done;
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = TDFileHashDefaultChunkSizeForReadingData;
    }
    
    long totaLen = 0; //累计写入大小
    int md5Size = 32; //MD5大小
    
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                  (UInt8 *)buffer,
                                                  (CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        
        totaLen = totaLen + readBytesCount;
        long residualSize = fileSize - totaLen; //剩余大小
        if (residualSize <= md5Size) {
            readBytesCount = readBytesCount - (32 - residualSize);
        }
        
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
        
        if (residualSize <= md5Size) {
            hasMoreData = false;
            break; //跳出
        }
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault,
                                       (const char *)hash,
                                       kCFStringEncodingUTF8);
    
done:
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}

@end
