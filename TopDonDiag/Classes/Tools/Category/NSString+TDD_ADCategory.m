//
//  NSString+TDD_ADCategory.m
//  AD200
//
//  Created by yong liu on 2022/7/14.
//

#import "NSString+TDD_ADCategory.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (TDD_ADCategory)

#pragma mark -- 字符串是否为空
+ (BOOL)tdd_isEmpty:(NSString *)str{
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([str isKindOfClass:[NSNumber class]]) {
        str = [NSString stringWithFormat:@"%@",str];
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([str isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isNum:(NSString *)checkedNumString {
    
    NSArray * arr1 = [checkedNumString componentsSeparatedByString:@"-"];
    
    if (arr1.count > 2) {
        return NO;
    }
    
    checkedNumString = [checkedNumString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if (checkedNumString.length == 0) {
        return NO;
    }
    
    NSArray * arr = [checkedNumString componentsSeparatedByString:@"."];
    
    if (arr.count > 2) {
        return NO;
    }
    
    NSString * str = @"";
    
    for (int i = 0; i < arr.count; i ++) {
        str = [NSString stringWithFormat:@"%@%@", str, arr[i]];
    }
    
    checkedNumString = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

/// 返回自身或者默认的值
+ (NSString *)tdd_nullableString:(NSString *)string defaultString:(nonnull NSString *)defaultString {
    if ([string isKindOfClass:[NSString class]] && string != nil) {
        return string;
    }
    return defaultString;
}

- (NSString *)tdd_fileSize
{
    // 总大小
    unsigned long long size = 0;
    NSString *sizeText = @"0";
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];

    // 文件属性
    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
    // 如果这个文件或者文件夹不存在,或者路径不正确直接返回0;
    if (attrs == nil) return @"0";
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 如果是文件夹
        // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 累加文件大小
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;

           if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%@B", @(size)];
            }

        }
        return sizeText;
    } else { // 如果是文件
        size = attrs.fileSize;
         if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%@B", @(size)];
            }

        }
        return sizeText;
}

- (NSInteger)tdd_fileSizeCalculate
{
    // 总大小
    unsigned long long size = 0;
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 文件属性
    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
    // 如果这个文件或者文件夹不存在,或者路径不正确直接返回0;
    if (attrs == nil) return size;
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 如果是文件夹
        // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 累加文件大小
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        return size;
    } else { // 如果是文件
        size = attrs.fileSize;
    }
    return size;
}

///获取文字长度
+ (CGFloat)tdd_getWidthWithText:(NSString *)text height:(CGFloat)textHeight fontSize:(UIFont *)font{
   NSDictionary *dict = @{NSFontAttributeName:font};
   CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, textHeight) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
   //返回计算出的长
   return rect.size.width + 1;
}

///获取文字高度
+ (CGFloat)tdd_getHeightWithText:(NSString *)text width:(CGFloat)textWidth fontSize:(UIFont *)font{
   NSDictionary *dict = @{NSFontAttributeName:font};
//   CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil];
   //返回计算出的行高
   return rect.size.height + 1;
}

+ (CGFloat)tdd_calculateHeightForAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width {
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 context:nil];
    return ceil(rect.size.height + 1);
}

+ (BOOL)tdd_isNum:(NSString *)checkedNumString {
    //这种方式在 测试的iPhone8 15.0.2 系统的手机上有问题
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    formatter.numberStyle = NSNumberFormatterDecimalStyle; // 允许小数和负数
//    NSNumber *number = [formatter numberFromString:checkedNumString];
//    return (number != nil);
    
    NSArray * arr1 = [checkedNumString componentsSeparatedByString:@"-"];
    
    if (arr1.count > 2) {
        return NO;
    }
    
    checkedNumString = [checkedNumString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if (checkedNumString.length == 0) {
        return NO;
    }
    
    NSArray * arr = [checkedNumString componentsSeparatedByString:@"."];
    
    if (arr.count > 2) {
        return NO;
    }
    
    NSString * str = @"";
    
    for (int i = 0; i < arr.count; i ++) {
        str = [NSString stringWithFormat:@"%@%@", str, arr[i]];
    }
    
    checkedNumString = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

- (NSMutableAttributedString *)tdd_setHighlight:(NSString *)highlightText font: (UIFont *)font normalColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor {
    NSMutableAttributedString *res = [NSMutableAttributedString mutableAttributedStringWithLTRString:self attributes:@{NSForegroundColorAttributeName : normalColor,
                                                                                                              NSFontAttributeName : font}];;
    if ([NSString tdd_isEmpty:highlightText]) return res;
    
    NSRange range = [self rangeOfString:highlightText];
    
    [res addAttributes:@{NSForegroundColorAttributeName : highlightColor, NSFontAttributeName : [[UIFont systemFontOfSize:IS_IPad ? 24 : 18 weight:UIFontWeightSemibold] tdd_adaptHD]} range:range];
    return res;
}

//ASCII码0.5长度 中文1长度
- (CGFloat)tdd_MSLength
{
    CGFloat n = [self length];
    int l = 0;
    int a = 0;
    int b = 0;
    CGFloat wLen = 0;
    unichar c;
    for(int i = 0; i < n; i++){
        c = [self characterAtIndex:i];//按顺序取出单个字符
        if(isblank(c)){//判断字符串为空或为空格
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
        wLen = l+(CGFloat)((CGFloat)(a+b)/2.0);
        NSLog(@"wLen--%f",wLen);
        
    }
    if(a==0 && l==0)
    {
        return 0;//只有isblank
    }else{
        return wLen;//长度，中文占1，英文等能转ascii的占0.5
    }
}

#pragma mark  判斷郵箱是否合法
+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (NSString *)tdd_removeFileSpecialString {
    NSArray *specialCharArr = @[@"/",@" ",@"\\",@":",@"|",@"?",@"*",@"<",@">",@"\"", @",", @"(", @")", @"，", @"（", @"）"];
    NSString *fileName = self;
    for (NSString *string in specialCharArr) {
        fileName = [fileName stringByReplacingOccurrencesOfString:string withString:@""];
    }
    return fileName;
}

- (NSString *)tdd_removeContainSpaceFileSpecialString {
    NSArray *specialCharArr = @[@"/",@"\\",@":",@"|",@"?",@"*",@"<",@">",@"\""];
    NSString *fileName = self;
    for (NSString *string in specialCharArr) {
        fileName = [fileName stringByReplacingOccurrencesOfString:string withString:@""];
    }
    return fileName;
}
    
+ (NSString *)tdd_strFromInterger:(NSInteger )interger {
    return [NSString stringWithFormat:@"%ld",interger];
}

// 辅助方法：检查字符串是否为 "0"
BOOL isZero(NSString *str) {
    for (NSUInteger i = 0; i < str.length; i++) {
        if ([str characterAtIndex:i] != '0') {
            return NO;
        }
    }
    return YES;
}

// 辅助方法：大数除法，返回商和余数
NSString *divideByTwo(NSString *decimalString, int *remainder) {
    NSMutableString *result = [NSMutableString string];
    NSInteger carry = 0;
    
    for (NSUInteger i = 0; i < decimalString.length; i++) {
        NSInteger digit = ([decimalString characterAtIndex:i] - '0') + carry * 10;
        [result appendFormat:@"%ld", digit / 2];
        carry = digit % 2; // 余数，作为下一位的进位
    }
    
    // 移除商的前导零
    while (result.length > 1 && [result characterAtIndex:0] == '0') {
        [result deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    *remainder = (int)carry;
    return result;
}

// 将十进制字符串转换为二进制字符串
+ (NSArray *)tdd_convertDecimalToBinary:(NSString *)decimalString arrCount:(NSInteger)arrCount{
    //NSMutableString *binaryString = [NSMutableString string];
    NSString *currentDecimal = [decimalString copy];//
    NSMutableArray *binaryStrArr = @[].mutableCopy;
    while (!isZero(currentDecimal)) {
        int remainder = 0;
        currentDecimal = divideByTwo(currentDecimal, &remainder);
        //[binaryString insertString:(remainder == 0 ? @"0" : @"1") atIndex:0];
        [binaryStrArr addObject:(remainder == 0 ? @"0" : @"1")];
    }
    if (binaryStrArr.count < arrCount) {
        NSInteger count = arrCount - binaryStrArr.count;
        for (int i = 0; i < count; i++) {
            [binaryStrArr addObject:@"0"];
        }
    }
    return binaryStrArr;
    //return binaryString.length > 0 ? binaryString : @"0"; // 如果输入是 0，直接返回 "0"
}

//将二进制字符串数组[@"0",@"1"]转换成十进制字符串
+ (NSString *)tdd_converBinaryArrToDecimal:(NSArray *)binaryArr {
    //倒序
    binaryArr = [[binaryArr reverseObjectEnumerator] allObjects];
    
    // 将数组拼接成完整的二进制字符串
    NSString *binaryString = [binaryArr componentsJoinedByString:@""];
    
    // 将二进制字符串转换为十进制数
    NSUInteger decimalValue = strtoul([binaryString UTF8String], NULL, 2);
    
    // 转换为十进制字符串
    NSString *decimalString = [NSString stringWithFormat:@"%lu", (unsigned long)decimalValue];
    
    return decimalString;
}

+ (NSString *)tdd_removeWhiteSpaceFromPreOrSuff:(NSString *)originalStr {
    NSString *trimmedString = [originalStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return trimmedString;
}


+ (NSString *)tdd_setFirstCharLow:(NSString *)originalString {
    if (originalString.length > 0) {
        NSString *resultString = [[originalString substringToIndex:1] lowercaseString];
        if (originalString.length > 1) {
            resultString = [resultString stringByAppendingString:[originalString substringFromIndex:1]];
        }
        return resultString;
    } else {
        return originalString;
    }
}
@end
