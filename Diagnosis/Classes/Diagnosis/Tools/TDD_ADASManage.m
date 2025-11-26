//
//  TDD_ADASManage.m
//  Diagnosis
//
//  Created by Diag on 2024/5/31.
//

#import "TDD_ADASManage.h"

@implementation TDD_ADASManage
+ (TDD_ADASManage *)shared {
    
    static TDD_ADASManage * adasManage = nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        adasManage = [[TDD_ADASManage alloc] init];
    });
    return adasManage;
}
@end
