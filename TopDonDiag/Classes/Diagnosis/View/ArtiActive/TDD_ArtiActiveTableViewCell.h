//
//  TDD_ArtiActiveTableViewCell.h
//  AD200
//
//  Created by 何可人 on 2022/4/24.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiActiveModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiActiveTableViewCell : UITableViewCell
@property (nonatomic, strong) ArtiActiveItemModel * itemModel;
@property (nonatomic, strong) NSArray * heightArr;
@end

NS_ASSUME_NONNULL_END
