//
//  TDD_ArtiLiveDataView.h
//  AD200
//
//  Created by 何可人 on 2022/5/30.
//

#import "TDD_ArtiContentBaseView.h"
#import "TDD_ArtiLiveDataModel.h"
#import "TDD_ArtiFreezeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveDataView : TDD_ArtiContentBaseView
@property (nonatomic, strong) TDD_ArtiLiveDataModel * liveDataModel;
@property (nonatomic, strong) TDD_ArtiFreezeModel * freezeModel;
@property (nonatomic, strong) TDD_CarModel * carModel;
/// 是否是数据流播放
@property (nonatomic,assign) BOOL isPlay;

- (void)autoSaveVideo;
@end

NS_ASSUME_NONNULL_END
