//
//  JKDataBase.m
//  JKBaseModel
//
//  Created by zx_04 on 15/6/24.
//
// github:https://github.com/Joker-King/JKDBModel

#import <objc/runtime.h>

#import "TDD_JKDBHelper.h"
#import "TDD_JKDBModel.h"

@interface TDD_JKDBHelper ()

@property (nonatomic, retain) FMDatabaseQueue *dbQueue;
@property (nonatomic, retain) FMDatabaseQueue *groupQueue;

@end

@implementation TDD_JKDBHelper

static TDD_JKDBHelper *_instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _instance;
}

+ (NSString *)dbPathWithDirectoryName:(NSString *)directoryName groupID:(NSString *)groupID
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *docsdir = documentPath;
    NSFileManager *filemanage = [NSFileManager defaultManager];
    if (groupID && groupID.length) {
        docsdir = [[[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:groupID] path];
    } else {
        if (directoryName == nil || directoryName.length == 0) {
            docsdir = [docsdir stringByAppendingPathComponent:@"JKBD"];
        } else {
            docsdir = [docsdir stringByAppendingPathComponent:directoryName];
        }
    }
    BOOL isDir;
    BOOL exit = [filemanage fileExistsAtPath:docsdir isDirectory:&isDir];
    NSError * error;
    if (!exit || !isDir) {
        [filemanage createDirectoryAtPath:docsdir withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) { // groupID 有问题，keychain 没有创建 权限， 直接创建本地数据库
            NSLog(@"数据库创建--- groupId: %@ - error: %@ - 目录：%@", groupID, error, @"JKBD");
            if (directoryName == nil || directoryName.length == 0) {
                docsdir = [documentPath stringByAppendingPathComponent:@"JKBD"];
            } else {
                docsdir = [documentPath stringByAppendingPathComponent:directoryName];
            }
            if (![filemanage fileExistsAtPath:docsdir]) {
                NSError *tempError;
                [filemanage createDirectoryAtPath:docsdir withIntermediateDirectories:YES attributes:nil error:&tempError];
                if (tempError) {
                    NSLog(@"创建沙盒数据库失败 -path: %@ - error: %@", docsdir, error);
                }
            }
        }
    }
    NSString *dbpath = [docsdir stringByAppendingPathComponent:@"jkdb.sqlite"];
    return dbpath;
}

+ (NSString *)dbPath
{
    return [self dbPathWithDirectoryName:nil groupID:(_instance.dbType == TDD_DATA_BASE_TYPE_DEFAULT ? @"" : _instance.groupID)];
}

- (FMDatabaseQueue *)groupQueueWithGroupID:(NSString *)groupID {
    if (_groupQueue == nil) {
        _groupQueue = [[FMDatabaseQueue alloc] initWithPath:[self.class dbPathWithDirectoryName:nil groupID:groupID]];
    }
    return _groupQueue;
}

- (FMDatabaseQueue *)dbQueue
{
    if (self.dbType == TDD_DATA_BASE_TYPE_GROUP) {
        return [self groupQueueWithGroupID:self.groupID];
    }
    if (_dbQueue == nil) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[self.class dbPathWithDirectoryName:nil groupID:nil]];
    }
    return _dbQueue;
}

- (BOOL)changeDBWithDirectoryName:(NSString *)directoryName groupID:(NSString *)groupID
{
    if ([NSString tdd_isEmpty:groupID]) {
        if (_instance.dbQueue) {
            _instance.dbQueue = nil;
        }
        _instance.dbQueue = [[FMDatabaseQueue alloc] initWithPath:[TDD_JKDBHelper dbPathWithDirectoryName:directoryName groupID:groupID]];
    }else {
        if (_instance.groupQueue) {
            _instance.groupQueue = nil;
        }
        _instance.groupQueue = [[FMDatabaseQueue alloc] initWithPath:[TDD_JKDBHelper dbPathWithDirectoryName:directoryName groupID:groupID]];
    }

    
    int numClasses;
    Class *classes = NULL;
    numClasses = objc_getClassList(NULL,0);
    
    if (numClasses >0 )
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            if (class_getSuperclass(classes[i]) == [TDD_JKDBModel class]){
                id class = classes[i];
                [class performSelector:@selector(createTable) withObject:nil];
            }
        }
        free(classes);
    }
    
    return YES;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [TDD_JKDBHelper shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [TDD_JKDBHelper shareInstance];
}

#if ! __has_feature(objc_arc)
- (oneway void)release
{
    
}

- (id)autorelease
{
    return _instance;
}

- (NSUInteger)retainCount
{
    return 1;
}
#endif

@end
