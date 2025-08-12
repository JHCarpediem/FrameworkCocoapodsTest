//
//  NSMutableAttributedString+TDD_LTR.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/5/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (TDD_LTR)
+ (NSMutableAttributedString *)mutableAttributedStringWithLTR;

+ (NSMutableAttributedString *)mutableAttributedStringWithLTRString:(NSString *)string;

+ (NSMutableAttributedString *)mutableAttributedStringWithLTRString:(NSString *)string attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs;
@end

NS_ASSUME_NONNULL_END
