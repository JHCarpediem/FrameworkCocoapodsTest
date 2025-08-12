//
//  TDD_ArtiLiveDataSelectView.h
//  AD200
//
//  Created by 何可人 on 2022/8/8.
//

#import "TDD_ArtiContentBaseView.h"
#import "TDD_ArtiLiveDataSelectModel.h"
#import "TDD_ArtiLiveDataChartSelectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveDataSelectView : TDD_ArtiContentBaseView
@property (nonatomic, strong) TDD_ArtiLiveDataSelectModel * liveDataSelectModel;
@property (nonatomic, strong) TDD_ArtiLiveDataChartSelectModel * liveDataChartSelectModel;
@end

NS_ASSUME_NONNULL_END
