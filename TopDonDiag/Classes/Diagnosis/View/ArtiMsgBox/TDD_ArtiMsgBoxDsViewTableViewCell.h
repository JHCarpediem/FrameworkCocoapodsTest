//
//  TDD_ArtiMsgBoxDsViewTableViewCell.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/28.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiLiveDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiMsgBoxDsViewTableViewCell : UITableViewCell
@property (nonatomic,strong)TDD_ArtiLiveDataItemModel *itemModel;
@property (nonatomic,assign)BOOL isShowTranslated;
@end

NS_ASSUME_NONNULL_END
