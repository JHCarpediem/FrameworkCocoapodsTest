//
//  TDD_ArtiReportGeneratorMessageCell.h
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/11.
//

#import <UIKit/UIKit.h>
#import "TopdonDiagnosis/TopdonDiagnosis-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportGeneratorMessageCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic, strong) TDD_PlaceholderTextView *textView;
@property (nonatomic, copy) void(^didChangedText)(NSString* message);
@property (nonatomic, copy) void(^beginEditing)(void);

@end

NS_ASSUME_NONNULL_END
