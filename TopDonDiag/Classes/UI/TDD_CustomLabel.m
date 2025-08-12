//
//  TDD_CustomLabel.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/5/15.
//

#import "TDD_CustomLabel.h"

@implementation TDD_CustomLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft; // 强制左对齐
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft; // 强制左对齐
    }
    return self;
}

@end
