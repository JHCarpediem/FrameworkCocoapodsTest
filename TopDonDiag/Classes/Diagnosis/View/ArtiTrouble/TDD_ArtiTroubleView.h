//
//  TDD_ArtiTroubleView.h
//  AD200
//
//  Created by 何可人 on 2022/5/9.
//

#import "TDD_ArtiContentBaseView.h"
#import "TDD_ArtiTroubleModel.h"
#import "TDD_ArtiPopupModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiTroubleView : TDD_ArtiContentBaseView
@property (nonatomic, strong) TDD_ArtiTroubleModel * troubleModel;
@property (nonatomic, strong) TDD_ArtiPopupModel * popupModel;
@end

NS_ASSUME_NONNULL_END
