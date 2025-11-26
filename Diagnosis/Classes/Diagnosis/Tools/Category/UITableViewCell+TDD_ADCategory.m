//
//  UITableViewCell+TDD_ADCategory.m
//  AD200
//
//  Created by lecason on 2022/8/3.
//

#import "UITableViewCell+TDD_ADCategory.h"

@implementation UITableViewCell (ADCategory)

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass(self);
}

@end
