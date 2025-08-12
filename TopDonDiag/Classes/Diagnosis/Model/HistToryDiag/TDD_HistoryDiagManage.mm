//
//  TDD_HistoryDiagManage.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/9/23.
//

#import "TDD_HistoryDiagManage.h"
#import "TDD_CTools.h"
@implementation TDD_HistoryDiagManage
+ (TDD_HistoryDtcNodeExModel *)dtcNodeExModelWith:(stDtcNodeEx )nodeEx {
    TDD_HistoryDtcNodeExModel *model = [[TDD_HistoryDtcNodeExModel alloc] init];
    model.nodeCode = [TDD_CTools CStrToNSString:nodeEx.strCode];
    model.nodeDescription = [TDD_CTools CStrToNSString:nodeEx.strDescription];
    model.nodeStatus = [TDD_CTools CStrToNSString:nodeEx.strStatus];
    model.status = nodeEx.uStatus;
    
    return model;
}
+ (TDD_HistoryDtcItemModel *)dtcItemWith:(stDtcReportItemEx )itemEx {
    TDD_HistoryDtcItemModel *model = [[TDD_HistoryDtcItemModel alloc] init];
    model.itemID = [TDD_CTools CStrToNSString:itemEx.strID];
    model.itemName = [TDD_CTools CStrToNSString:itemEx.strName];
    NSMutableArray *nsArray = [NSMutableArray array];
    for (int j = 0; j < itemEx.vctNode.size(); j++) {
        stDtcNodeEx ex = itemEx.vctNode[j];
        TDD_HistoryDtcNodeExModel *exModel = [[TDD_HistoryDtcNodeExModel alloc] init];
        exModel.nodeCode = [TDD_CTools CStrToNSString:ex.strCode];
        exModel.nodeDescription = [TDD_CTools CStrToNSString:ex.strDescription];
        exModel.nodeStatus = [TDD_CTools CStrToNSString:ex.strStatus];
        exModel.status = ex.uStatus;
        [nsArray addObject:exModel];
    }
    model.vctNodeArr = nsArray;
    
    return model;
}
@end
