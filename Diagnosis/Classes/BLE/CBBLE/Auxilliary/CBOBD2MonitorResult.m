//
//  Copyright (c) diag. All rights reserved.
//

#import "CBOBD2MonitorResult.h"

#import "CBSupportAutomotive.h"

@implementation CBOBD2MonitorResult
{
    NSString* _name;
    OBD2MonitorTestResult _result;
}

+(instancetype)resultWithTestName:(NSString*)name result:(OBD2MonitorTestResult)result
{
    CBOBD2MonitorResult* obj = [[self alloc] init];
    obj->_name = name;
    obj->_result = result;
    return obj;
}

-(NSString*)formattedName
{
    return LTStringLookupWithPlaceholder( _name, _name );
}

-(NSString*)formattedResult
{
    static NSString* const states[] = {
        @"OBD2_MONITOR_RESULT_UNAVAILABLE",
        @"OBD2_MONITOR_RESULT_PASSED",
        @"OBD2_MONITOR_RESULT_FAILED",
    };
    
    return LTStringLookupWithPlaceholder( states[_result], states[_result] );
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"<OBD2MonitorResult: %p %@=%@>", self, self.formattedName, self.formattedResult];
}

@end
