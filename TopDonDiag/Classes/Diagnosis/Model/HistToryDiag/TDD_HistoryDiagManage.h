//
//  TDD_HistoryDiagManage.h
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/9/23.
//

#import <Foundation/Foundation.h>
#import "TDD_HistoryDiagModel.h"

#if useCarsFramework
#include <CarsFramework/HStdOtherMaco.h>
#else
#include "HStdOtherMaco.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TDD_HistoryDiagManage : NSObject
+ (TDD_HistoryDtcNodeExModel *)dtcNodeExModelWith:(stDtcNodeEx )nodeEx;
+ (TDD_HistoryDtcItemModel *)dtcItemWith:(stDtcReportItemEx )itemEx;
@end

NS_ASSUME_NONNULL_END
