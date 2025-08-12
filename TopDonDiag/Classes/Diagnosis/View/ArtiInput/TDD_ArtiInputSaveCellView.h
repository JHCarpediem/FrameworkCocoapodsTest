//
//  TDD_ArtiInputSaveCellVIew.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/7/28.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiInputSaveModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiInputSaveCellView : UIView
@property (nonatomic, copy) void(^deleteBlock)(NSInteger index);
@property (nonatomic, strong) TDD_ArtiInputSaveModel *saveModel;
@property (nonatomic, strong) TDD_CustomLabel *titleLab;
@property (nonatomic, assign) NSInteger index;
@end

NS_ASSUME_NONNULL_END
