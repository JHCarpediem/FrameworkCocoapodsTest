//
//  ObjcHelper.h
//  Pods-TopdonLog_Example
//
//  Created by xinwenliu on 2024/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static inline NSException * _Nullable tryBlock(void(^_Nonnull tryBlock)(void)) {
    @try {
        tryBlock();
    }
    @catch (NSException *exception) {
        return exception;
    }
    return nil;
}

@interface ObjcHelper : NSObject

@end

NS_ASSUME_NONNULL_END
