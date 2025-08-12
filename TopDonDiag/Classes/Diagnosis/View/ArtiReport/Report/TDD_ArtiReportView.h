//
//  TDD_ArtiReportView.h
//  AD200
//
//  Created by 何可人 on 2022/5/6.
//

#import "TDD_ArtiContentBaseView.h"
#import "TDD_ArtiReportModel.h"
#import "TDD_ArtiReportHistoryJKDBModel.h"




NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportView : TDD_ArtiContentBaseView

@property (nonatomic, strong) TDD_ArtiReportModel * reportModel;

- (void)setReportModel:(TDD_ArtiReportModel *)reportModel showLiveData:(nullable NSArray *)showItems;

- (void)setDbModel:(TDD_ArtiReportHistoryJKDBModel *)dbModel dbType:(TDD_DBType)dbType;

@end

NS_ASSUME_NONNULL_END
