//
//  TDD_ArtiLiveDataHDMoreChartView.h
//  TopdonDiagnosis
//
//  Created by lk_ios2023002 on 2024/2/22.
//

#import <TopdonDiagnosis/TopdonDiagnosis.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveDataHDMoreSelectItemView : UIView
@property (nonatomic, strong)UIColor *color;
@property (nonatomic, strong)TDD_ArtiLiveDataItemModel *itemModel;
@end

@interface TDD_ArtiLiveDataHDMoreChartView : TDD_ArtiContentBaseView
@property (nonatomic,strong) TDD_ArtiLiveDataMoreChartModel *model;
@end

NS_ASSUME_NONNULL_END
