//
//  TDD_ArtiInputSaveView.h
//  AD200
//
//  Created by 何可人 on 2022/5/12.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiInputModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol TDD_ArtiInputSaveViewDelegate <NSObject>

- (void)TDD_ArtiInputSaveViewDidSelect:(NSString *)textStr;
- (void)tdd_artiInputRemoveView:(BOOL )isEmpty;
@end

@interface TDD_ArtiInputSaveView : UIView
@property (nonatomic, weak) id<TDD_ArtiInputSaveViewDelegate> delegate;
@property (nonatomic, strong) ArtiInputItemModel * itemModel;
@property (nonatomic, assign) CGPoint clickPoint;

+ (NSInteger )historyRecordCount:(ArtiInputItemModel *)itemModel;
@end

NS_ASSUME_NONNULL_END
