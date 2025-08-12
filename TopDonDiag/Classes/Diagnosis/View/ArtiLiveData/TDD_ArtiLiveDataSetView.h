//
//  TDD_ArtiLiveDataSetView.h
//  AD200
//
//  Created by AppTD on 2022/8/10.
//

#import "TDD_ArtiContentBaseView.h"
#import "TDD_ArtiLiveDataSetModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveDataSetView : TDD_ArtiContentBaseView
@property (nonatomic, strong) TDD_ArtiLiveDataSetModel * setModel;

/// 判断是否有设置变化
- (BOOL)checkNeedSavaLiveData;

/// 保存当前变化
- (void)saveLiveData;
@end

NS_ASSUME_NONNULL_END
