//
//  NSAttributedString+TDD_LTR.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/5/16.
//

#import "NSAttributedString+TDD_LTR.h"

@implementation NSAttributedString (TDD_LTR)
+ (NSAttributedString *)attributedStringWithLTRString:(NSString *)string {
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc]initWithString:string];
    
    // 强制设置 LTR
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    [mutableAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mutableAttributedString.length)];
    
    return [mutableAttributedString copy]; // 返回不可变副本
}

+ (NSAttributedString *)attributedStringWithLTRString:(NSString *)string attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs {
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:attrs];
    
    // 强制设置 LTR
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    [mutableAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mutableAttributedString.length)];
    
    return [mutableAttributedString copy]; // 返回不可变副本
    
}
@end
