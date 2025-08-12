//
//  TDD_VehInfoModel.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/5/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_VehInfoModel : NSObject
@property (nonatomic, assign) NSTimeInterval setTime;//设置时间
@property (nonatomic, copy) NSString *vehInfo;//设置路径
@property (nonatomic, assign) BOOL didSave;//是否已经保存数据库

@end

NS_ASSUME_NONNULL_END
