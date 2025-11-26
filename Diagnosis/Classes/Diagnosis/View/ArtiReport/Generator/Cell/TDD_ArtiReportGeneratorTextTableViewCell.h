//
//  TDD_ArtiReportGeneratorTextTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportGeneratorTextTableViewCell : UITableViewCell <UITextFieldDelegate>

//@property (nonatomic, strong) TDD_CustomLabel *nameLabel;
@property (nonatomic, strong) TDD_CustomTextField *inputTextField;
@property (nonatomic, copy) void(^didChangedText)(NSString*);

@end

NS_ASSUME_NONNULL_END
