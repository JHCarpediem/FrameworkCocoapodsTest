//
//  TDD_ArtiReportGeneratorModel.h
//  AD200
//
//  Created by lecason on 2022/8/8.
//

#import "TDD_ArtiModelBase.h"
#import "TDD_ArtiReportModel.h"
#import "TDD_CarModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TDD_ArtiReportGeneratorModelDelegata <NSObject>

/**********************************************************
*    功  能：设置维修指南所需要的信息
**********************************************************/
- (void)ArtiUploadDiagReport:(TDD_ArtiReportModel *)model param:(NSDictionary *)json completeHandle: (nullable void(^)(id result))complete;

@end

@interface TDD_ArtiReportGeneratorModel : TDD_ArtiModelBase 

@property (nonatomic, strong) TDD_ArtiReportModel *reportModel;

@property (nonatomic, weak) __nullable id<TDD_ArtiReportGeneratorModelDelegata> delegate;
@end

NS_ASSUME_NONNULL_END
