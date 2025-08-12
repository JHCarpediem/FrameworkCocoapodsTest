//
//  TDD_ArtiListView.h
//  AD200
//
//  Created by 何可人 on 2022/5/12.
//

#import "TDD_ArtiContentBaseView.h"
#import "TDD_ArtiListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiListView : TDD_ArtiContentBaseView
@property (nonatomic, strong) TDD_ArtiListModel * listModel;
@end

NS_ASSUME_NONNULL_END
