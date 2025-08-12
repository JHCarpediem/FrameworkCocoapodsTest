//
//  NSString+TDD_ADCategory.h
//  AD200
//
//  Created by yong liu on 2022/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TDD_ADCategory)


/** 字符串是否为空 */
+ (BOOL)tdd_isEmpty:(NSString *)str;

#pragma mark 字符串是否是数字
+ (BOOL)tdd_isNum:(NSString *)checkedNumString;

/// 计算文件大小
- (NSString *)tdd_fileSize;

/// 计算文件大小
- (NSInteger)tdd_fileSizeCalculate;

/// 返回自身或者默认的值
+ (NSString *)tdd_nullableString:(NSString *)string defaultString:(nonnull NSString *)defaultString;

/**
 获取文字长度
 */
+ (CGFloat)tdd_getWidthWithText:(NSString *)text height:(CGFloat)textHeight fontSize:(UIFont *)font;

///获取文字高度
+ (CGFloat)tdd_getHeightWithText:(NSString *)text width:(CGFloat)textWidth fontSize:(UIFont *)font;

+ (CGFloat)tdd_calculateHeightForAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width;

- (NSMutableAttributedString *)tdd_setHighlight:(NSString *)highlightText font: (UIFont *)font normalColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor;

//ASCII码0.5长度 其他1长度
- (CGFloat)tdd_MSLength;

#pragma mark  判斷郵箱是否合法
+ (BOOL)isValidateEmail:(NSString *)email;
//去除文件名特殊字符
- (NSString *)tdd_removeFileSpecialString;

//去除文件名特殊字符保留空格
- (NSString *)tdd_removeContainSpaceFileSpecialString;

+ (NSString *)tdd_strFromInterger:(NSInteger )interger;

//将十进制字符串转换为二进制字符串数组
+ (NSArray *)tdd_convertDecimalToBinary:(NSString *)decimalString arrCount:(NSInteger)arrCount;

//将二进制字符串数组[@"0",@"1"]转换成十进制字符串
+ (NSString *)tdd_converBinaryArrToDecimal:(NSArray *)binaryArr;

//去掉前后空格
+ (NSString *)tdd_removeWhiteSpaceFromPreOrSuff:(NSString *)originalStr;

//第一个字符设置为小写
+ (NSString *)tdd_setFirstCharLow:(NSString *)originalString;

@end

NS_ASSUME_NONNULL_END
