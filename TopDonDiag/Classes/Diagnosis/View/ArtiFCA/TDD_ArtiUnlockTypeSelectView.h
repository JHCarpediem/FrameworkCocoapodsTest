//
//  TDD_ArtiUnlockTypeSelectView.h
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/12/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiUnlockTypeSelectView : UIView
@property (nonatomic, copy) void (^selectBlock)(NSInteger i);
@property (nonatomic, assign) NSInteger unlockType;
@end

NS_ASSUME_NONNULL_END
