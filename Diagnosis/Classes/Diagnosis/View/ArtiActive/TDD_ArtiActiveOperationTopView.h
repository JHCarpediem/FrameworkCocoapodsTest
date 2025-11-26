//
//  TDD_ArtiActiveOperationTopView.h
//  Diag
//
//  Created by diag on 2023/9/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiActiveOperationTopView : UIView

- (void)setTitleStr:(NSString *)titleStr contentStr:(NSString *)contentStr alignType:(uint16_t)alignType fontSize:(uint16_t)fontSize boldType:(uint16_t)boldType;
@end

NS_ASSUME_NONNULL_END
