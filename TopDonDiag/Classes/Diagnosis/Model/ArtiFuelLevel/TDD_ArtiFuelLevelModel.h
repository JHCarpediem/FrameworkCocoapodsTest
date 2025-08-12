//
//  TDD_ArtiFuelLevelModel.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/17.
//

#import <TopdonDiagnosis/TopdonDiagnosis.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiFuelLevelModel : TDD_ArtiModelBase
@property (nonatomic, assign) ePosType posType; //列表类型
@property (nonatomic, strong) NSString *strTips;//提示
@property (nonatomic, assign) uint32_t oliValue;
@property (nonatomic, assign) BOOL showWarning;
@property (nonatomic, strong) NSString *warningTips;
@end

NS_ASSUME_NONNULL_END
