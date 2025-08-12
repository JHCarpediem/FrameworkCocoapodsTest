//
//  TDD_ArtiLiveDataSelectModel.h
//  AD200
//
//  Created by 何可人 on 2022/8/8.
//

#import "TDD_ArtiModelBase.h"
#import "TDD_ArtiLiveDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveDataSelectModel : TDD_ArtiModelBase
@property (nonatomic, strong) TDD_ArtiLiveDataModel * liveDataModel;
@property (nonatomic, strong) NSMutableArray * selectItmes; //选中的item
@property (nonatomic, assign, readonly) BOOL isSelectAll; //是否选择全部

@property (nonatomic, strong) NSMutableArray *showItems;

///  设置编辑按钮文字
- (void)setEditBtnTitle;

- (void)updateShowLiveData;

@end

NS_ASSUME_NONNULL_END
