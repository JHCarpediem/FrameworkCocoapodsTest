//
//  TDD_ArtiLiveDataChartSelectModel.h
//  AD200
//
//  Created by AppTD on 2022/9/15.
//

#import "TDD_ArtiModelBase.h"
#import "TDD_ArtiLiveDataMoreChartModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveDataChartSelectModel : TDD_ArtiModelBase
@property (nonatomic,strong) TDD_ArtiLiveDataMoreChartModel * liveDataMoreChartModel;
@property (nonatomic, strong) NSMutableArray * selectItmes; //选中的item
@end

NS_ASSUME_NONNULL_END
