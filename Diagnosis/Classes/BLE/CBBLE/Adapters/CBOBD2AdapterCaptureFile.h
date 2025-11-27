//
//  Copyright (c) diag. All rights reserved.
//

#import "CBOBD2AdapterELM327.h"

@class CBOBD2CaptureFile;

NS_ASSUME_NONNULL_BEGIN

@interface CBOBD2AdapterCaptureFile : CBOBD2AdapterELM327

+(nullable instancetype)adapterWithInputStream:(NSInputStream*)inputStream outputStream:(NSOutputStream*)outputStream NS_UNAVAILABLE;
-(nullable instancetype)initWithInputStream:(NSInputStream*)inputStream outputStream:(NSOutputStream*)outputStream NS_UNAVAILABLE;

+(nullable instancetype)adapterWithLogFile:(NSData*)logFile;
-(nullable instancetype)initWithLogFile:(NSData*)logFile;

+(nullable instancetype)adapterWithCaptureFile:(CBOBD2CaptureFile*)captureFile;
-(nullable instancetype)initWithCaptureFile:(CBOBD2CaptureFile*)captureFile;

@property(assign,nonatomic,readwrite) NSTimeInterval simulatedLatency;

@end

NS_ASSUME_NONNULL_END
