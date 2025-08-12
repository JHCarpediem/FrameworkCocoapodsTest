//
//  TDD_ArtiReportGeneratorSelectTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportGeneratorSelectTableViewCell : UITableViewCell

@property (nonatomic, strong) TDD_CustomLabel *nameLabel;
@property (nonatomic, assign) BOOL isADAS;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, strong) UIImageView *arrow;

- (void)arrowImageRotate;


@end

NS_ASSUME_NONNULL_END
