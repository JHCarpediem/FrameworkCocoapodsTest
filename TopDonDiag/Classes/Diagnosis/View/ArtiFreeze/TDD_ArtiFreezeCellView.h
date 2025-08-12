//
//  TDD_ArtiFreezeCellView.h
//  AD200
//
//  Created by 何可人 on 2022/5/6.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiFreezeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiFreezeCellView : UIView
@property (nonatomic, strong) TDD_ArtiFreezeItemModel * itemModel;
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容
@end

NS_ASSUME_NONNULL_END
