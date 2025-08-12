//
//  TDD_TranslationManager.m
//  TopDonDiag
//
//  Created by lecason on 2023/8/25.
//

#include <CommonCrypto/CommonDigest.h>
#import "TDD_TranslationManager.h"

@implementation TDD_TranslationManager

+ (TDD_TranslationManager *)sharedManager
{
    static TDD_TranslationManager * manage = nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        manage = [[TDD_TranslationManager alloc] init];
    });
    return manage;
}

/// 拆分请求 按 Google 的限制，每次请求数组个数不能超过 128 个，每个jsonData 的大小不能超过 204800 bytes。每个 Item 长度不能超过 5000 个字符。
- (void)queryWords:(NSArray *)words target:(NSString *)target completionHandler:(void (^)(NSArray * _Nullable responseDict, NSError * _Nullable error, NSString * errorStr))completionHandler {
    

    // 总批次翻译的数组
    NSMutableArray *sectionArray = [self getTranslateSectionArray:words target:target];
    // 翻译后的数组
    NSMutableArray *translatedArray = [[NSMutableArray alloc] initWithCapacity:sectionArray.count];
    // 创建一个信号量，初始值为1
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    @kWeakObj(self)
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @kStrongObj(self)
        __block NSError *responseError;
        __block BOOL hadSuccess = false;
        __block NSInteger chartNumSum = 0;//翻译成功字符量
        __block NSString *errorMessageStr = @"错误信息:";
        for (int i = 0; i < sectionArray.count; i++) {
            NSLog(@">>> Start %d", i);
            NSArray *items = sectionArray[i];
            NSInteger chartNum = 0;
            for (NSString *str in items) {
                chartNum += [str tdd_MSLength] * 2;
            }
            
            if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(translateWords:toLangeageID:completion:)]) {
                
                [[TDD_DiagnosisManage sharedManage].manageDelegate translateWords:words toLangeageID:[TDD_HLanguage getServiceLanguageId] completion:^(NSURLResponse * _Nullable response, id  _Nullable responseObject, NSError * _Nullable error) {
                    NSLog(@">>> Done %d", i);
                    if (error) {
                        responseError = error;
                        errorMessageStr = [errorMessageStr stringByAppendingFormat:@"%d:%@\n",i,error];
                        NSLog(@">>> Error %@", error);
                    }else {
                        chartNumSum += chartNum;
                    }
                    
                    if (responseObject && responseObject[@"data"] && [responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                        [translatedArray addObjectsFromArray:responseObject[@"data"]];
                        hadSuccess = YES;
                    } else {
                        for (NSString *str in items) {
                            [translatedArray addObject:@{@"translatedText": @"", @"detectedSourceLanguage": @""}];
                        }
                    }
                    dispatch_semaphore_signal(semaphore);
                }];
            }else {
                [[TDD_TranslationManager sharedManager] privateQueryWords:items target: target completion:^(NSDictionary * _Nullable responseDict, NSError * _Nullable error) {
                    NSLog(@">>> Done %d", i);
                    if (error) {
                        responseError = error;
                        errorMessageStr = [errorMessageStr stringByAppendingFormat:@"%d:%@\n",i,error];
                        NSLog(@">>> Error %@", error);
                    }else {
                        chartNumSum += chartNum;
                    }
                    
                    if (responseDict && responseDict[@"data"] && [responseDict[@"data"][@"translations"] isKindOfClass:[NSArray class]]) {
                        [translatedArray addObjectsFromArray:responseDict[@"data"][@"translations"]];
                        hadSuccess = YES;
                    } else {
                        for (NSString *str in items) {
                            [translatedArray addObject:@{@"translatedText": @""}];
                        }
                    }
                    dispatch_semaphore_signal(semaphore);
                }];
            }
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@">>> Wait %d", i);
        }
        NSLog(@"%@", translatedArray);
        if (hadSuccess) {
            NSString *str = [TDD_UserdefaultManager getTranslateStartTime];
            if ([NSString tdd_isEmpty:str]) {
                str = [NSString stringWithFormat:@"%f",[NSDate tdd_getTimestampSince1970]];
                [[NSUserDefaults standardUserDefaults] setObject:str forKey:KTDDUDTranslateStartTime];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }

            NSInteger translateCount = [TDD_UserdefaultManager getTranslateCount];
            [TDD_UserdefaultManager setTranslateCount:translateCount + 1];
            
            NSInteger translateChartNum = [TDD_UserdefaultManager getTranslateChartNum];
            [TDD_UserdefaultManager setTranslateChartNum:translateChartNum + chartNumSum];
            
        }
        completionHandler(translatedArray, responseError,errorMessageStr);
    });
}

- (void)privateQueryWords:(NSArray *)words target:(NSString *)target completion:(void (^)(NSDictionary * _Nullable responseDict, NSError * _Nullable error))completionHandler {
    // 创建包含要发送的数据的字典
    NSDictionary *jsonDictionary = @{
                                     @"q": words,
                                     @"target": target
    };
    // 将字典转换为JSON数据
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:nil];
    // 创建URL对象
    NSURL *url = [NSURL URLWithString:@"https://translation.googleapis.com/language/translate/v2?key=AIzaSyAD2_G8TgZW6d75ESZTsG4vOZVxLdvINqQ"];
    // 创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    // 设置请求头
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"com.dingjiang.topscanapplication" forHTTPHeaderField:@"x-ios-bundle-identifier"];
    // 将JSON数据设置为请求的主体内容
    [request setHTTPBody:jsonData];
    // 创建NSURLSession对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 创建数据任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"请求错误: %@", error.localizedDescription);
            completionHandler(nil, error);
            return;
        }
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            completionHandler(dict, error);
            
            
        } else {
            completionHandler(nil, error);
            NSLog(@"未收到数据响应");
        }
    }];

    [task resume];
}

/// 总批次翻译的数组
- (NSMutableArray *)getTranslateSectionArray:(NSArray *)words target:(NSString *)target {
    // 要翻译成的语言
    NSString *targetLanguage = target;
    // 限制的大小
    NSUInteger maxBytesLimit = 204800;
    // 单个字符的长度大小
    NSUInteger maxWordLenght = 4500;
    // 单批翻译的数组
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    // 总批次翻译的数组
    NSMutableArray *sectionArray = [[NSMutableArray alloc] init];

    for (int i = 0; i < words.count; i++) {
        NSString *singleItem = words[i];
        NSData *singleJsonData = [NSJSONSerialization dataWithJSONObject:@{@"q": @[singleItem], @"target": targetLanguage } options:0 error:nil];
        
        // 单个数据已经超过限制最大值 不进行翻译 用空白符代码 @""
        if (singleJsonData.length > maxBytesLimit || singleItem.length > maxWordLenght) {
            [itemArray addObject:@""];
        } else {
            
            // 判断总翻译是否大于限制大小
            [itemArray addObject:singleItem];
            NSData *totalJsonData = [NSJSONSerialization dataWithJSONObject:@{@"q": itemArray, @"target": targetLanguage } options:0 error:nil];
            
            // 总数已经大于需要翻译的大小
            if (totalJsonData.length > maxBytesLimit || itemArray.count > 128) {
                [itemArray removeLastObject];
                [sectionArray addObject:[itemArray mutableCopy]];
                [itemArray removeAllObjects];
                
                // 回退上一个数据
                i--;
                continue;
            }
            
            // 如果已经是最后一个，加上最后的 Section
            if (i == words.count - 1 && itemArray.count > 0) {
                [sectionArray addObject:[itemArray mutableCopy]];
                [itemArray removeAllObjects];
            }
        }
    }
    return sectionArray;
}



- (NSString *)buildQueryWords:(NSArray *)words {
    if (words.count == 0) {
        return @"";
    }
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSString *word in words) {
        [result appendFormat:@"q=%@&", word];
    }
    if ([result hasSuffix:@"&"]) {
        result = [[result substringToIndex:[result length] - 1] mutableCopy] ;
    }
    return result;
}

- (NSString *)buildQuerySign:(NSArray *)words {
    if (words.count == 0) {
        return @"";
    }
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSString *word in words) {
        [result appendFormat:@"%@", word];
    }
    return result;
}

- (NSString*)sha256HashFor:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, (unsigned int)strlen(str), result);

    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSString *)truncate:(NSString *)q {
    NSUInteger len = q.length;
    if(len<=20) return q;
    return [NSString stringWithFormat:@"%@%ld%@", [q substringWithRange:NSMakeRange(0, 10)], len, [q substringWithRange:NSMakeRange(len-10, len-(len-10))]];
    // 启动任务
    //[task resume];

}

@end
