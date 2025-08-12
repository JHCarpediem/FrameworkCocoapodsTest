//
//  TDD_CustomTextField.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/5/15.
//

#import "TDD_CustomTextField.h"

@implementation TDD_CustomTextField
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft; // 强制左对齐
        self.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft; // 强制左对齐
        self.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
    }
    return self;
}

@end
