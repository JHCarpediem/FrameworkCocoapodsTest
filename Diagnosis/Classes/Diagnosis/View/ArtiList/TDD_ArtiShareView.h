//
//  TDD_ArtiShareView.h
//  Diagnosis
//
//  Created by zhouxiong on 2024/8/16.
//

#import <Diagnosis/Diagnosis.h>
#import "TDD_ArtiListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiShareView : TDD_TipBaseView

- (instancetype)initWithFrame:(CGRect)frame model:(TDD_ArtiListModel *)model;

@end

NS_ASSUME_NONNULL_END
