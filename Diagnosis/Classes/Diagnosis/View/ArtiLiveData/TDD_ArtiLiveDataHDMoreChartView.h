//
//  TDD_ArtiLiveDataHDMoreChartView.h
//  Diagnosis
//
//  Created by diag on 2024/2/22.
//

#import <Diagnosis/Diagnosis.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveDataHDMoreSelectItemView : UIView
@property (nonatomic, strong)UIColor *color;
@property (nonatomic, strong)TDD_ArtiLiveDataItemModel *itemModel;
@property (nonatomic, assign)BOOL isLast;
@end

@interface TDD_ArtiLiveDataHDMoreChartView : TDD_ArtiContentBaseView
@property (nonatomic,strong) TDD_ArtiLiveDataMoreChartModel *model;
@end

NS_ASSUME_NONNULL_END
