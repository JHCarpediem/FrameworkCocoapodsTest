//
//  JKDataBase.h
//  JKBaseModel
//
//  Created by zx_04 on 15/6/24.
//
//  github:https://github.com/Joker-King/JKDBModel

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "TDD_Enums.h"
@interface TDD_JKDBHelper : NSObject

@property (nonatomic, retain, readonly) FMDatabaseQueue *dbQueue;
@property (nonatomic, assign) TDD_DBType dbType;
@property (nonatomic, strong) NSString *groupID;
+ (TDD_JKDBHelper *)shareInstance;

+ (NSString *)dbPath;
- (FMDatabaseQueue *)groupQueueWithGroupID:(NSString *)groupID;
- (BOOL)changeDBWithDirectoryName:(NSString *)directoryName groupID:(NSString *)groupID;
+ (NSString *)dbPathWithDirectoryName:(NSString *)directoryName groupID:(NSString *)groupID;
@end
