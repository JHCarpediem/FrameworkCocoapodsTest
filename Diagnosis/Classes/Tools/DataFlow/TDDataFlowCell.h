//
//  TDDataFlowCell.h
//  AD200
//
//  Created by yong liu on 2022/8/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LocalDataFlowSelectDelegate <NSObject>

- (void)dataFlowSelect:(TDD_DataFlowModel *)model;

@end

static NSString * const TDDataFlowCellId = @"TDDataFlowCellId";

@interface TDDataFlowCell : UITableViewCell

@property (nonatomic, weak) id<LocalDataFlowSelectDelegate> delegate;

- (void)fillCellWithModel:(TDD_DataFlowModel *)model;

- (void)cellSelected:(BOOL)isSelect;

- (void)cellEditState:(BOOL)isEdit;

@end

NS_ASSUME_NONNULL_END
