//
//  NSMutableAttributedString+TDD_LTR.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/5/16.
//

#import "NSMutableAttributedString+TDD_LTR.h"

@implementation NSMutableAttributedString (TDD_LTR)
+ (NSMutableAttributedString *)mutableAttributedStringWithLTR {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    // 强制设置 LTR
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;
    
}
+ (NSMutableAttributedString *)mutableAttributedStringWithLTRString:(NSString *)string {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    // 强制设置 LTR
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;
}

+ (NSMutableAttributedString *)mutableAttributedStringWithLTRString:(NSString *)string attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:attrs];
    // 强制设置 LTR
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;
}
@end
