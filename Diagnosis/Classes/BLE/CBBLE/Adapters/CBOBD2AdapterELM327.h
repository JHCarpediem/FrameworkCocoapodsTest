//
//  Copyright (c) diag. All rights reserved.
//

#import "CBOBD2Adapter.h"

#import "CBOBD2Command.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBOBD2AdapterELM327 : CBOBD2Adapter

+(NSString*)identifyWithResponseToResetCommand:(NSString*)response;

@end

@interface CBOBD2CommandELM327_IDENTIFY : CBOBD2Command

+(instancetype)command;

@end

@interface CBOBD2CommandELM327_READ_VOLTAGE : CBOBD2Command

+(instancetype)command;

@end

@interface CBOBD2CommandELM327_IGNITION_STATUS : CBOBD2Command

+(instancetype)command;

@end

@interface CBOBD2CommandELM327_TRY_PROTOCOL : CBOBD2Command

+(instancetype)commandForAutoProtocol:(OBD2VehicleProtocol)protocol;
+(instancetype)commandForProtocol:(OBD2VehicleProtocol)protocol;

@end

@interface CBOBD2CommandELM327_SET_PROTOCOL : CBOBD2Command

+(instancetype)commandForAutoProtocol:(OBD2VehicleProtocol)protocol;
+(instancetype)commandForProtocol:(OBD2VehicleProtocol)protocol;

@end

@interface CBOBD2CommandELM327_DESCRIBE_PROTOCOL : CBOBD2Command

+(instancetype)command;

@end

@interface CBOBD2CommandELM327_DESCRIBE_PROTOCOL_NUMERIC : CBOBD2Command

+(instancetype)command;

@end

NS_ASSUME_NONNULL_END
