//
//  TDD_ArtiLiveDataMoreChartModel.h
//  AD200
//
//  Created by AppTD on 2022/9/8.
//

#import "TDD_ArtiModelBase.h"
#import "TDD_ArtiLiveDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveDataMoreChartModel : TDD_ArtiModelBase
@property (nonatomic,strong) TDD_ArtiLiveDataModel * liveDataModel;
@property (nonatomic, strong) NSMutableArray * selectItmes; //选中的item
@end

NS_ASSUME_NONNULL_END
