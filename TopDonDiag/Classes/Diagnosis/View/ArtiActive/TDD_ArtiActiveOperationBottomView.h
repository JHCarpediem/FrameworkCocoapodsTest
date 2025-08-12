//
//  TDD_ArtiActiveOperationBottomView.h
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/9/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiActiveOperationBottomView : UIView
@property (nonatomic, copy)void(^hideBlock)(void);
- (void)setTitleStr:(NSString *)titleStr contentStr:(NSString *)contentStr alignType:(uint16_t)alignType fontSize:(uint16_t)fontSize boldType:(uint16_t)boldType;
@end

NS_ASSUME_NONNULL_END
