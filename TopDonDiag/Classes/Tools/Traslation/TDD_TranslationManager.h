//
//  TDD_TranslationManager.h
//  TopDonDiag
//
//  Created by lecason on 2023/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_TranslationManager : NSObject

/// 单例
+ (TDD_TranslationManager *)sharedManager;

/// 查询
/// - Parameters:
///   - words: 需要查询的字符数组所提供的文本段不能超过 128 个。
///   - target: 使用相应的 ISO-639 代码来指定目标语言
///   - completionHandler: 翻译完成回调
///
///   responseDict {
///    data =     {
///        translations =         (
///                        {
///                detectedSourceLanguage = en;
///                translatedText = "Hallo Welt";
///            },
///                        {
///                detectedSourceLanguage = en;
///                translatedText = "Mein Name ist Jeff";
///            }
///        );
///      };
///    }
///
///
- (void)queryWords:(NSArray *)words target:(NSString *)target completionHandler:(void (^)(NSArray * _Nonnull responseArray, NSError * _Nullable error, NSString * errorStr))completionHandler;

@end

NS_ASSUME_NONNULL_END
