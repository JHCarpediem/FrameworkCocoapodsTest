//
//  Copyright (c) diag. All rights reserved.
//

#import "CBOBD2PerformanceTrackingResult.h"

#import "CBSupportAutomotive.h"

@implementation CBOBD2PerformanceTrackingResult

+(instancetype)resultWithMnemonic:(NSString*)mnemonic count:(NSUInteger)count
{
    CBOBD2PerformanceTrackingResult* obj = [[self alloc] init];
    obj->_mnemonic = mnemonic;
    obj->_count = count;
    return obj;
}

-(NSString*)formattedMnemonic
{
    NSString* key = [NSString stringWithFormat:@"OBD2_PERFORMANCE_TRACKING_%@", _mnemonic];
    return LTStringLookupWithPlaceholder( key, _mnemonic );
}

@end
