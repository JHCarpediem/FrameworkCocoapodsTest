//
//  TDD_ADASManage.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/31.
//

#import <Foundation/Foundation.h>
#import "TDD_ArtiWheelBrowModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ADASManage : NSObject
@property (nonatomic,strong)TDD_ArtiWheelBrowModel *wheelBrowModel;
@property (nonatomic,assign)NSInteger oliValue;
+ (TDD_ADASManage *)shared;
@end

NS_ASSUME_NONNULL_END
