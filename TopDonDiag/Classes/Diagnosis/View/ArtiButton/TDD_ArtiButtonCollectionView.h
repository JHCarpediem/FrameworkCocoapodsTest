//
//  TDD_ArtiButtonCollectionView.h
//  AD200
//
//  Created by AI Assistant on 2024/12/19.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@class TDD_ArtiButtonCollectionCellView;

@protocol TDD_ArtiButtonCollectionViewDelegate <NSObject>

- (void)ArtiButtonClick:(TDD_ArtiButtonModel *)model;

@end

@interface TDD_ArtiButtonCollectionView : UIView
@property (nonatomic, weak) id<TDD_ArtiButtonCollectionViewDelegate> delegate;
@property (nonatomic, strong) TDD_ArtiModelBase * model;
@end

NS_ASSUME_NONNULL_END 
