//
//  TDD_HTipInputView.h
//  AD200
//
//  Created by AppTD on 2022/8/30.
//

#import "TDD_TipBaseView.h"
#import "TDD_CustomTextField.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^CompleteBlock)(NSString * _Nullable text, BOOL isOK);

@interface TDD_HTipInputView : TDD_TipBaseView

@property (nonatomic,strong) TDD_CustomTextField * inputTextField;

@property (nonatomic,assign) BOOL showClearBtn;

- (instancetype)initWithTitle:(NSString *)title delayDismiss:(BOOL )delayDismiss completeBlock:(CompleteBlock)completeBlock;

- (instancetype)initWithTitle:(NSString *)title completeBlock:(CompleteBlock)completeBlock;

- (instancetype)initWithTitle:(NSString *)title
                 delayDismiss:(BOOL )delayDismiss
                 defaultValue:(NSString *)defaultValue completeBlock:(CompleteBlock)completeBlock;

@end

NS_ASSUME_NONNULL_END
