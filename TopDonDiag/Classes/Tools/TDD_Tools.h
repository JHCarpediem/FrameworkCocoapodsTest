//
//  TDD_Tools.h
//  TDDiag
//
//  Created by lk_ios2023002 on 2023/6/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define kSoundCoilReaderSet @"coilReaderSet.wav"
#define kSoundArtiStop @"artiStop.mp3"

@interface TDD_Tools : NSObject
+ (UIImage *)tdd_imageNamed:(NSString *)imageName;

+ (int )troubleCodeLevelWithVehicle:(NSString *)vehicle statusStr:(NSString *)statusStr;

+ (NSString *)readVehicleEventNameFromID:(NSString *)eventID;

+ (NSString *)readVehicleEventNameFromType:(NSString *)type;

+ (void)bleLog:(NSString *)message file:(NSString *)file func:(NSString *)func line:(NSInteger)line;

+ (void)diagLog:(NSString *)message file:(NSString *)file func:(NSString *)func line:(NSInteger)line;

@end

NS_ASSUME_NONNULL_END
