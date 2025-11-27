//
//  Copyright (c) diag. All rights reserved.
//
#import <Foundation/Foundation.h>

FOUNDATION_EXPORT double CBSupportAutomotiveVersionNumber;

FOUNDATION_EXPORT const unsigned char CBSupportAutomotiveVersionString[];

// automotive
#import "CBVIN.h"
#import "CBOBD2Adapter.h"
#import "CBOBD2AdapterELM327.h"
#import "CBOBD2AdapterCaptureFile.h"
#import "CBOBD2Command.h"
#import "CBOBD2Protocol.h"
#import "CBOBD2ProtocolISO15765_4.h"
#import "CBOBD2ProtocolISO14230_4.h"
#import "CBOBD2ProtocolSAEJ1850.h"
#import "CBOBD2ProtocolISO9141_2.h"
#import "CBOBD2PID.h"
#import "CBOBD2DTC.h"
#import "CBOBD2O2Sensor.h"
#import "CBOBD2MonitorResult.h"
#import "CBOBD2PerformanceTrackingResult.h"
#import "CBOBD2Mode6TestResult.h"
#import "CBOBD2CaptureFile.h"

// aux (should go into a seperate library)
#import "CBBTLESerialTransporter.h"
#import "CBBTLEReadCharacteristicStream.h"
#import "CBBTLEWriteCharacteristicStream.h"

NS_ASSUME_NONNULL_BEGIN

// global helpers
NSString* _Nullable LTStringLookupOrNil( NSString* key );
NSString* LTStringLookupWithPlaceholder( NSString* key, NSString* placeholder );
void MyNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);
NSString* LTDataToString( NSData* d );

NS_ASSUME_NONNULL_END

// global macros
#ifndef LOG
    #define LOG(args...) MyNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#endif

#ifndef UTF8_NARROW_NOBREAK_SPACE
    #define UTF8_NARROW_NOBREAK_SPACE @"\u202F"
#endif

#ifndef WARN
#define WARN LOG
#endif

#ifndef ERROR
#define ERROR LOG
#endif

