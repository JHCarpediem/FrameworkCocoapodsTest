//
//  TDD_ArtiPopupView.h
//  TopDonDiag
//
//  Created by fench on 2023/8/29.
//
#import "TDD_ArtiContentBaseView.h"
#import "TDD_ArtiPopupModel.h"
#import "TDD_ArtiTroubleModel.h"
NS_ASSUME_NONNULL_BEGIN



@interface TDD_ArtiPopupView : TDD_ArtiContentBaseView

@property (nonatomic, strong) TDD_ArtiPopupModel * popupModel;

@property (nonatomic, strong) TDD_ArtiTroubleModel * troubleModel;
@end

NS_ASSUME_NONNULL_END
