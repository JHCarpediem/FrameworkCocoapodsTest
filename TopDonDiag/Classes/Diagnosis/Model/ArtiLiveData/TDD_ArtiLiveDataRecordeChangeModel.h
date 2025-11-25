//
//  TDD_ArtiLiveDataRecordeChangeModel.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/10/21.
//

#import <TopdonDiagnosis/TopdonDiagnosis.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveDataRecordeChangeModel : TDD_JKDBModel
@property (nonatomic, copy) NSString *createTime; //创建时间
///TDD_ArtiLiveDataRecordeModel的 PK
@property (nonatomic, assign)   int recordModelPK;
///LiveDataitem 的 index
@property (nonatomic, assign)   int itemIndex;
///数据流值
@property (nonatomic, strong) NSString * strValue;
/// 开始时间
@property (nonatomic, assign) NSInteger startTime;
///图表时间
@property (nonatomic, assign) double chartTime;
///数据流单位
@property (nonatomic, strong) NSString * strUnit;
///数据流名称
@property (nonatomic, strong) NSString * strName;
///数据流最小参考值
@property (nonatomic, strong) NSString * strMin;
///数据流最大参考值
@property (nonatomic, strong) NSString * strMax;

@end

NS_ASSUME_NONNULL_END
