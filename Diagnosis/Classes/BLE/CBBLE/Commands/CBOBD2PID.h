//
//  Copyright (c) diag. All rights reserved.
//

#import "CBSupportAutomotive.h"

NS_ASSUME_NONNULL_BEGIN

@class CBOBD2DTC;
@class CBOBD2MonitorResult;
@class CBOBD2PerformanceTrackingResult;
@class CBOBD2Mode6TestResult;

typedef enum : NSUInteger {
    LTIgnitionTypeUnknown,
    LTIgnitionTypeSpark,
    LTIgnitionTypeCompression,
} LTIgnitionType;

#pragma mark -
#pragma mark PID Base class

@interface CBOBD2PID : CBOBD2Command

+(instancetype)pidForMode1; // mode 1
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC*)freezeFrameDTC; // mode 2, freeze frame w/ ECU selection
+(instancetype)pid; // mode 3-n

@property(assign,nonatomic,readonly) NSInteger freezeFrame; // NSNotFound, if not applicable
@property(strong,nonatomic,readonly) NSString* selectedECU; // nil, if not applicable

@end

#pragma mark -
#pragma mark Helper class to check for individual PID support

@interface CBOBD2PID_TEST_SUPPORTED_COMMANDS : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;
+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrame:(NSUInteger)freezeFrame NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;

+(instancetype)pidForMode:(NSUInteger)mode part:(NSUInteger)part;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC part:(NSUInteger)part;

-(NSArray<NSNumber*>*)supportBytes;

@end

@interface CBOBD2PIDDB : NSObject

+(instancetype)dbForMode:(NSUInteger)mode;
+(instancetype)dbForFreezeFrameDTC:(CBOBD2DTC*)freezeFrameDTC;

-(void)populateUsingAdapter:(CBOBD2Adapter*)adapter updateHandler:(void (^)(void))updateBlock completionHandler:(void (^)(void))completionBlock;
-(BOOL)supportsPID:(CBOBD2PID*)pid;

@end

#pragma mark -
#pragma mark Some abstract classes to simplify

@interface CBOBD2PIDSingleByteTemperature : CBOBD2PID
@end

@interface CBOBD2PIDDoubleByteTemperature : CBOBD2PID
@end

@interface CBOBD2PIDSingleBytePercent : CBOBD2PID
@end

@interface CBOBD2PIDStoredDTC : CBOBD2PID

@property(nonatomic,readonly) NSArray<CBOBD2DTC*>* troubleCodes;

@end

@interface CBOBD2PIDComponentMonitoring : CBOBD2PID

@property(nonatomic,readonly) NSArray<CBOBD2MonitorResult*>* monitorResults;
@property(nonatomic,readonly) LTIgnitionType ignitionType;

@end

@interface CBOBD2PID_OXYGEN_SENSORS_INFO_1 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;
+(instancetype)pidForSensor:(NSUInteger)sensor mode:(NSUInteger)mode;
+(instancetype)pidForSensor:(NSUInteger)sensor inFreezeFrame:(NSUInteger)frame;

@property(nonatomic,readonly) double voltage;
@property(nonatomic,readonly) double shortTermFuelTrim;

@end

@interface CBOBD2PID_OXYGEN_SENSORS_INFO_2 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;
+(instancetype)pidForSensor:(NSUInteger)sensor mode:(NSUInteger)mode;
+(instancetype)pidForSensor:(NSUInteger)sensor inFreezeFrame:(NSUInteger)frame;

@property(nonatomic,readonly) double fuelAirEquivalenceRatio;
@property(nonatomic,readonly) double voltage;

@end

@interface CBOBD2PID_OXYGEN_SENSORS_INFO_3 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;
+(instancetype)pidForSensor:(NSUInteger)sensor mode:(NSUInteger)mode;
+(instancetype)pidForSensor:(NSUInteger)sensor inFreezeFrame:(NSUInteger)frame;

@property(nonatomic,readonly) double fuelAirEquivalenceRatio;
@property(nonatomic,readonly) double current;

@end

@interface CBOBD2PIDPerformanceTracking : CBOBD2PID

+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;

@property(nonatomic,readonly) NSArray<CBOBD2PerformanceTrackingResult*>* counters;

@end

#pragma mark -
#pragma mark Mode 01 & Mode 02

@interface CBOBD2PID_SUPPORTED_COMMANDS1_00 : CBOBD2PID

@property(nonatomic,readonly) NSArray<NSString*>* connectedECUs;

@end

@interface CBOBD2PID_MONITOR_STATUS_THIS_DRIVE_CYCLE_41 : CBOBD2PIDComponentMonitoring
@end

@interface CBOBD2PID_MONITOR_STATUS_SINCE_DTC_CLEARED_01 : CBOBD2PIDComponentMonitoring

+(instancetype)pidForFreezeFrame:(NSUInteger)freezeFrame NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;

@property(nonatomic,readonly) BOOL motorIndicationLampOn;
@property(nonatomic,readonly) NSUInteger totalNumberOfStoredDTCs;
@property(nonatomic,readonly) NSDictionary<NSString*,NSNumber*>* numberOfStoredDTCsByECU;
@property(nonatomic,readonly) LTIgnitionType ignitionType;

@end

@interface CBOBD2PID_DTC_CAUSING_FREEZE_FRAME_02 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;
+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrame:(NSUInteger)freezeFrame; // mode 2, no ECU selection

@property(nonatomic,readonly) NSArray<CBOBD2DTC*>* troubleCodes;

@end

@interface CBOBD2PID_FUEL_SYSTEM_STATUS_03 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ENGINE_LOAD_04 : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_COOLANT_TEMP_05 : CBOBD2PIDSingleByteTemperature

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_SHORT_TERM_FUEL_TRIM_1_06 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_LONG_TERM_FUEL_TRIM_1_07 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_SHORT_TERM_FUEL_TRIM_2_08 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_LONG_TERM_FUEL_TRIM_2_09 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_FUEL_PRESSURE_0A : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_INTAKE_MAP_0B : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ENGINE_RPM_0C : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_VEHICLE_SPEED_0D : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_TIMING_ADVANCE_0E : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_INTAKE_TEMP_0F : CBOBD2PIDSingleByteTemperature

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_MAF_FLOW_10 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_THROTTLE_11 : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_SECONDARY_AIR_STATUS_12 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_OXYGEN_SENSORS_PRESENT_2_BANKS_13 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@property(nonatomic,readonly) NSArray<NSNumber*>* sensors;

@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_1_SENSOR_0_14 : CBOBD2PID_OXYGEN_SENSORS_INFO_1
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_1_SENSOR_1_15 : CBOBD2PID_OXYGEN_SENSORS_INFO_1
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_1_SENSOR_2_16 : CBOBD2PID_OXYGEN_SENSORS_INFO_1
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_1_SENSOR_3_17 : CBOBD2PID_OXYGEN_SENSORS_INFO_1
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_1_SENSOR_4_18 : CBOBD2PID_OXYGEN_SENSORS_INFO_1
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_1_SENSOR_5_19 : CBOBD2PID_OXYGEN_SENSORS_INFO_1
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_1_SENSOR_6_1A : CBOBD2PID_OXYGEN_SENSORS_INFO_1
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_1_SENSOR_7_1B : CBOBD2PID_OXYGEN_SENSORS_INFO_1
@end

@interface CBOBD2PID_OBD_STANDARDS_1C : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_OXYGEN_SENSORS_PRESENT_4_BANKS_1D : CBOBD2PID_OXYGEN_SENSORS_PRESENT_2_BANKS_13

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_AUX_INPUT_1E : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_RUNTIME_1F : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_DISTANCE_WITH_MIL_21 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_FUEL_RAIL_PRESSURE_22 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_FUEL_RAIL_GAUGE_PRESSURE_23 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_2_SENSOR_0_24 : CBOBD2PID_OXYGEN_SENSORS_INFO_2
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_2_SENSOR_1_25 : CBOBD2PID_OXYGEN_SENSORS_INFO_2
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_2_SENSOR_2_26 : CBOBD2PID_OXYGEN_SENSORS_INFO_2
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_2_SENSOR_3_27 : CBOBD2PID_OXYGEN_SENSORS_INFO_2
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_2_SENSOR_4_28 : CBOBD2PID_OXYGEN_SENSORS_INFO_2
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_2_SENSOR_5_29 : CBOBD2PID_OXYGEN_SENSORS_INFO_2
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_2_SENSOR_6_2A : CBOBD2PID_OXYGEN_SENSORS_INFO_2
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_2_SENSOR_7_2B : CBOBD2PID_OXYGEN_SENSORS_INFO_2
@end

@interface CBOBD2PID_COMMANDED_EGR_2C : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_EGR_ERROR_2D : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_COMMANDED_EVAPORATIVE_PURGE_2E : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_FUEL_TANK_LEVEL_2F : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_WARMUPS_SINCE_DTC_CLEARED_30 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_DISTANCE_SINCE_DTC_CLEARED_31 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_EVAP_SYS_VAPOR_PRESSURE_32 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ABSOLUTE_BAROMETRIC_PRESSURE_33 : CBOBD2PID
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_3_SENSOR_0_34 : CBOBD2PID_OXYGEN_SENSORS_INFO_3
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_3_SENSOR_1_35 : CBOBD2PID_OXYGEN_SENSORS_INFO_3
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_3_SENSOR_2_36 : CBOBD2PID_OXYGEN_SENSORS_INFO_3
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_3_SENSOR_3_37 : CBOBD2PID_OXYGEN_SENSORS_INFO_3
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_3_SENSOR_4_38 : CBOBD2PID_OXYGEN_SENSORS_INFO_3
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_3_SENSOR_5_39 : CBOBD2PID_OXYGEN_SENSORS_INFO_3
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_3_SENSOR_6_3A : CBOBD2PID_OXYGEN_SENSORS_INFO_3
@end

@interface CBOBD2PID_OXYGEN_SENSOR_INFO_3_SENSOR_7_3B : CBOBD2PID_OXYGEN_SENSORS_INFO_3
@end

@interface CBOBD2PID_CATALYST_TEMP_B1S1_3C : CBOBD2PIDDoubleByteTemperature

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_CATALYST_TEMP_B2S1_3D : CBOBD2PIDDoubleByteTemperature

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_CATALYST_TEMP_B1S2_3E : CBOBD2PIDDoubleByteTemperature

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_CATALYST_TEMP_B2S2_3F : CBOBD2PIDDoubleByteTemperature

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_CONTROL_MODULE_VOLTAGE_42 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ABSOLUTE_ENGINE_LOAD_43 : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_AIR_FUEL_EQUIV_RATIO_44 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_RELATIVE_THROTTLE_POS_45 : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_AMBIENT_TEMP_46 : CBOBD2PIDSingleByteTemperature

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ABSOLUTE_THROTTLE_POS_B_47 : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ABSOLUTE_THROTTLE_POS_C_48 : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ACC_PEDAL_POS_D_49 : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ACC_PEDAL_POS_E_4A : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ACC_PEDAL_POS_F_4B : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_COMMANDED_THROTTLE_ACTUATOR_4C : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_TIME_WITH_MIL_4D : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_TIME_SINCE_DTC_CLEARED_4E : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_MAX_VALUE_FUEL_AIR_EQUIVALENCE_RATIO_4F : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_MAX_VALUE_OXYGEN_SENSOR_VOLTAGE_4F : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_MAX_VALUE_OXYGEN_SENSOR_CURRENT_4F : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_MAX_VALUE_INTAKE_MAP_4F : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_MAX_VALUE_MAF_AIR_FLOW_RATE_50 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_FUEL_TYPE_51 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ETHANOL_FUEL_52 : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ABSOLUTE_EVAP_SYSTEM_VAPOR_PRESSURE_53 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_EVAP_SYSTEM_VAPOR_PRESSURE_54 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_FUEL_RAIL_ABSOLUTE_PRESSURE_59 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_RELATIVE_ACCELERATOR_PEDAL_POSITION_5A : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_HYBRID_BATTERY_PERCENTAGE_5B : CBOBD2PIDSingleBytePercent

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ENGINE_OIL_TEMP_5C : CBOBD2PIDSingleByteTemperature

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_FUEL_INJECTION_TIMING_5D : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ENGINE_FUEL_RATE_5E : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_SUPPORTED_EMISSION_REQUIREMENTS_5F : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ENGINE_TORQUE_DEMANDED_61 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ENGINE_TORQUE_PERCENTAGE_62 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

@interface CBOBD2PID_ENGINE_REF_TORQUE_63 : CBOBD2PID

+(instancetype)pid NS_UNAVAILABLE;

@end

#pragma mark -
#pragma mark Mode 03 – Show stored Diagnostic Trouble Codes

@interface CBOBD2PID_STORED_DTC_03 : CBOBD2PIDStoredDTC

+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;

@end

#pragma mark -
#pragma mark Mode 04 – Clear Diagnostic Trouble Codes and stored values

@interface CBOBD2PID_CLEAR_STORED_DTC_04 : CBOBD2PID

+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;

@end

#pragma mark -
#pragma mark Mode 05 – Oxygen Sensor Component Monitoring (not for CAN)

@interface CBOBD2PID_SUPPORTED_PIDS_MODE_5_0500 : CBOBD2PID

+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;

@end

#pragma mark -
#pragma mark Mode 06 – Test Results Component Monitoring

@interface CBOBD2PID_MODE_6_TEST_RESULTS_06 : CBOBD2PID

+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;
+(instancetype)pid NS_UNAVAILABLE;

+(instancetype)pidForMid:(NSUInteger)mid;

@property(nonatomic,readonly) NSArray<CBOBD2Mode6TestResult*>* testResults;

@end

#pragma mark -
#pragma mark Mode 07 – Pending Diagnostic Trouble Codes

@interface CBOBD2PID_PENDING_DTC_07 : CBOBD2PIDStoredDTC

+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;

@end

#pragma mark -
#pragma mark Mode 08 – Interactive Test

#pragma mark -
#pragma mark Mode 09 – Vehicle Information

@interface CBOBD2PID_VIN_CODE_0902 : CBOBD2PID

+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;

@end

@interface CBOBD2PID_CALIBRATION_ID_0904 : CBOBD2PID

+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;

@end

@interface CBOBD2PID_CALIBRATION_VERIFICATION_0906 : CBOBD2PID

+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;

@end

@interface CBOBD2PID_SPARK_IGNITION_PERFORMANCE_TRACKING_0908 : CBOBD2PIDPerformanceTracking
@end

@interface CBOBD2PID_ECU_NAME_090A : CBOBD2PID

+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;

-(NSDictionary<NSString*,NSString*>*)recognizedECUs;

@end

@interface CBOBD2PID_COMPRESSION_IGNITION_PERFORMANCE_TRACKING_090B : CBOBD2PIDPerformanceTracking
@end

#pragma mark -
#pragma mark Mode 0A – Permanent DTC

@interface CBOBD2PID_PERMANENT_DTC_0A : CBOBD2PIDStoredDTC

+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC *)freezeFrameDTC NS_UNAVAILABLE;

@end

#pragma mark -
#pragma mark Mode 10 – Start Diagnostic Session

#pragma mark -
#pragma mark Mode 11 – ECU Reset

#pragma mark -
#pragma mark Mode 12 – Read Freeze Frame Data

#pragma mark -
#pragma mark Mode 13 – Read Diagnostic Trouble Codes

#pragma mark -
#pragma mark Mode 14 – Clear Diagnostic Information

#pragma mark -
#pragma mark Mode 17 – Read Status Of Diagnostic Trouble Codes

#pragma mark -
#pragma mark Mode 18 – Read Diagnostic Trouble Codes By Status

#pragma mark -
#pragma mark Mode 1A – Read ECU Id

#pragma mark -
#pragma mark Mode 20 – Stop Diagnostic Session

#pragma mark -
#pragma mark Mode 21 – Read Data By Local Id

#pragma mark -
#pragma mark Mode 22 – Read Data By Common Id

#pragma mark -
#pragma mark Mode 23 – Read Memory By Address

#pragma mark -
#pragma mark Mode 25 – Stop Repeated Data Transmission

#pragma mark -
#pragma mark Mode 26 – Set Data Rates

#pragma mark -
#pragma mark Mode 27 – Security Access

#pragma mark -
#pragma mark Mode 2C – Dynamically Define Local Id

#pragma mark -
#pragma mark Mode 2E – Write Data By Common Id

#pragma mark -
#pragma mark Mode 2F – Input Output Control By Common Id

#pragma mark -
#pragma mark Mode 30 – Input Output Control By Local Id

#pragma mark -
#pragma mark Mode 31 – Start Routine By Local ID

#pragma mark -
#pragma mark Mode 32 – Stop Routine By Local ID

#pragma mark -
#pragma mark Mode 33 – Request Routine Results By Local Id

#pragma mark -
#pragma mark Mode 34 – Request Download

#pragma mark -
#pragma mark Mode 35 – Request Upload

#pragma mark -
#pragma mark Mode 36 – Transfer data

#pragma mark -
#pragma mark Mode 37 – Request transfer exit

#pragma mark -
#pragma mark Mode 38 – Start Routine By Address

#pragma mark -
#pragma mark Mode 39 – Stop Routine By Address

#pragma mark -
#pragma mark Mode 3A – Request Routine Results By Address

#pragma mark -
#pragma mark Mode 3B – Write Data By Local Id

#pragma mark -
#pragma mark Mode 3D – Write Memory By Address

#pragma mark -
#pragma mark Mode 3E – Tester Present

@interface CBOBD2PID_TESTER_PRESENT_3E : CBOBD2PID

+(instancetype)pidForMode1 NS_UNAVAILABLE;
+(instancetype)pidForFreezeFrameDTC:(CBOBD2DTC*)freezeFrameDTC NS_UNAVAILABLE;

@end

#pragma mark -
#pragma mark Mode 81 – Start Communication

#pragma mark -
#pragma mark Mode 82 – Stop Communication

#pragma mark -
#pragma mark Mode 83 – Access Timing Parameters

#pragma mark -
#pragma mark Mode 85 – Start Programming


NS_ASSUME_NONNULL_END
