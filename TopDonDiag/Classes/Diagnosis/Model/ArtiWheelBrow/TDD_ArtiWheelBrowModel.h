//
//  TDD_ArtiWheelBrowModel.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/17.
//

#import <TopdonDiagnosis/TopdonDiagnosis.h>
#import "TDD_ArtiModelBase.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiWheelBrowItemModel : NSObject
@property (nonatomic, assign)BOOL showWarn;
@property (nonatomic, assign)float value;
@end
@interface TDD_ArtiWheelBrowModel : TDD_ArtiModelBase
@property (nonatomic, assign) ePosType posType; //列表类型
@property (nonatomic, strong) NSString *strTips;//提示
@property (nonatomic, strong) NSString *warningTips;//输入框文本
@property (nonatomic, assign) NSInteger warningType;//警告类型(1 前轮差值、2 后轮差值、3 前后轮差值)
@property (nonatomic, strong) TDD_ArtiWheelBrowItemModel *lfBrowModel; //左前轮
@property (nonatomic, strong) TDD_ArtiWheelBrowItemModel *rfBrowModel; //右前轮
@property (nonatomic, strong) TDD_ArtiWheelBrowItemModel *lrBrowModel; //左后轮
@property (nonatomic, strong) TDD_ArtiWheelBrowItemModel *rrBrowModel; //右后轮
@property (nonatomic, assign) BOOL showWarning;

- (void)reloadButtonView;
- (void)handleDifference;
@end

NS_ASSUME_NONNULL_END
