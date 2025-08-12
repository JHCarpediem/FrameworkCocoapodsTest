//
//  TDD_ArtiMenuView.h
//  AD200
//
//  Created by tangjilin on 2022/7/28.
//

#import "TDD_ArtiContentBaseView.h"
#import "TDD_ArtiMenuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiMenuView : TDD_ArtiContentBaseView

@property (nonatomic, strong) TDD_ArtiMenuModel *menuModel;

- (void)updateMenuViewWithModel:(TDD_ArtiMenuModel *)menuModel searchKeyDict:(NSMutableDictionary *)searchKeyDict;

@end

NS_ASSUME_NONNULL_END
