//
//  JKDataBase.h
//  JKBaseModel
//
//  Created by zx_04 on 15/6/24.
//
//  github:https://github.com/Joker-King/JKDBModel

#import <Foundation/Foundation.h>

@class FMDatabaseQueue;
@interface TDDBHelper : NSObject

@property (nonatomic, retain, readonly) FMDatabaseQueue *dbQueue;
@property (nonatomic, copy) NSString* defaultDBDir;

+ (TDDBHelper *)shareInstance;

+ (NSString *)dbPath;

- (BOOL)changeDBWithDirectoryName:(NSString *)directoryName groupID: (NSString *)groupID;

- (FMDatabaseQueue *)groupQueueWithGroupID:(NSString *)groupID;

@end
