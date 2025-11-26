//
//  TDD_ArtiKeyboardView.h
//  AD200
//
//  Created by AppTD on 2022/10/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSInteger,ArtiKeyboardType) {
    ArtiKeyboard0 = 0,
    ArtiKeyboardA,//A键盘
    ArtiKeyboardB,//B键盘
    ArtiKeyboardF,//F键盘
    ArtiKeyboardV,//V键盘
    ArtiKeyboardT,//#键盘
};
@interface TDD_ArtiKeyboardView : UIView
@property (nonatomic,assign)ArtiKeyboardType type;
- (instancetype)initWithType:(ArtiKeyboardType)type;
@property(nonatomic,copy) void(^enterBlock)(void);
@property(nonatomic,copy) void(^deleteBlock)(void);
@property(nonatomic,copy) void(^insertBlock)(NSString *text);
@end

NS_ASSUME_NONNULL_END
