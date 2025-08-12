//
//  NSData+TDD_ADCategory.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/12/12.
//

#import "NSData+TDD_ADCategory.h"

@implementation NSData (TDD_ADCategory)
+ (NSString *)convertBase64ToHex:(NSString *)base64String {
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    
    const unsigned char *bytes = [data bytes];
    NSMutableString *hexString = [NSMutableString new];
    
    for (int i = 0; i < [data length]; i++) {
        [hexString appendFormat:@"%02x", bytes[i]];
    }
    
    return hexString;
}

@end
