//
//  NSAttributedString+TDD_LTR.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/5/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (TDD_LTR)
+ (NSAttributedString *)attributedStringWithLTRString:(NSString *)string;

+ (NSAttributedString *)attributedStringWithLTRString:(NSString *)string attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs;
@end

NS_ASSUME_NONNULL_END
