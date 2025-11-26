//
//  TDD_RepairSelectView.h
//  AD200
//
//  Created by yong liu on 2022/7/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_RepairSelectView : UIView

@property (nonatomic, copy) void(^didSelectIndex)(int);

@property (nonatomic, assign) BOOL isADAS;
@property (nonatomic, assign) NSInteger selectIndex;

- (instancetype)initWithTableViewRect:(CGRect)rect;
- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
