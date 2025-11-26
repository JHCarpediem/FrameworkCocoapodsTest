//
//  TDD_SetVinModel.h
//  Diagnosis
//
//  Created by Diag on 2025/10/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_SetVinModel : NSObject
///设置时间
@property (nonatomic, assign) NSTimeInterval setTime;
///VIN
@property (nonatomic, copy) NSString *vinStr;
///是否已经保存数据库
@property (nonatomic, assign) BOOL didSave;
@end

NS_ASSUME_NONNULL_END
