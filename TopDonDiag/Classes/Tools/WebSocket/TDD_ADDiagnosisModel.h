//
//  TDD_ADDiagnosisModel.h
//  AD200
//
//  Created by fench on 2023/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TDD_ADDiagnosisModel;

/// WebSocket 算法数据模型 服务器Response
@interface ADDiagnosisWSResponse : NSObject

@property(nonatomic, copy) NSString* msg;

@property(nonatomic, assign) BOOL success;

@property(nonatomic, assign) NSInteger code;

@property(nonatomic, assign) NSInteger type;

@property(nonatomic, strong) TDD_ADDiagnosisModel* data;

- (instancetype)initWithJSON: (id)json;

+ (instancetype)modelWithJSON: (id)json;

@end


@interface TDD_ADDiagnosisModel : NSObject

/// sn 码
@property(nonatomic, copy) NSString* sn;

/// 算法结果数据
@property(nonatomic, copy) NSString* resultData;

/// 结果长度
@property(nonatomic, assign) NSInteger resultDataLen;

/// uuid
@property(nonatomic, copy) NSString* uuid;

@end


NS_ASSUME_NONNULL_END
