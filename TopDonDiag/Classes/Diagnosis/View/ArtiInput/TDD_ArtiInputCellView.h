//
//  TDD_ArtiInputCellView.h
//  AD200
//
//  Created by 何可人 on 2022/5/10.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiInputModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiInputCellView : UIView
@property (nonatomic, strong) ArtiInputItemModel * itemModel;
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容

@property (nonatomic, copy) void (^heightDidChange)();

@end

NS_ASSUME_NONNULL_END
