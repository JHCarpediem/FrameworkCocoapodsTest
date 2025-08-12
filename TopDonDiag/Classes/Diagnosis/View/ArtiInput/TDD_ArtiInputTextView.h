//
//  TDD_ArtiInputTextView.h
//  AD200
//
//  Created by 何可人 on 2022/5/10.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiInputModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol TDD_ArtiInputTextViewDelegate <NSObject>

- (void)TDD_ArtiInputTextViewButtonClick:(NSString *)textStr;

@end

@interface TDD_ArtiInputTextView : UIView
@property (nonatomic, weak) id<TDD_ArtiInputTextViewDelegate> delegate;
@property (nonatomic, strong) ArtiInputItemModel * itemModel;
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容
@end

NS_ASSUME_NONNULL_END
