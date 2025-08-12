//
//  TDD_ArtiMsgBoxGroupViewTableViewCell.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/16.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiMsgBoxGroupModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiMsgBoxGroupViewTableViewCell : UITableViewCell
@property (nonatomic, strong)TDD_ArtiMsgBoxGroupItemModel *itemModel;
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容
+ (NSString *)reuseIdentifier;
@end

NS_ASSUME_NONNULL_END
