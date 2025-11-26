//
//  TDD_ArtiActiveView.h
//  AD200
//
//  Created by Diag on 2022/4/22.
//

#import "TDD_ArtiContentBaseView.h"

#import "TDD_ArtiActiveModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiActiveView : TDD_ArtiContentBaseView

@property (nonatomic, strong) TDD_ArtiActiveModel * activeModel;

@end

NS_ASSUME_NONNULL_END
