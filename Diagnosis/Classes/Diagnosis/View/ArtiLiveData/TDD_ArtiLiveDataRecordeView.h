//
//  TDD_ArtiLiveDataRecordeView.h
//  AD200
//
//  Created by AppTD on 2022/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^StopBlock)(void);
typedef void (^RecordCompleteBlock)(NSString * _Nullable text, BOOL isOK,BOOL isBack);
@interface TDD_ArtiLiveDataRecordeView : UIView
@property (nonatomic,copy) RecordCompleteBlock completeBlock;
@property (nonatomic,copy) StopBlock stopBlock;
- (void)unInit;
- (void)autoStopVideo;
@end

NS_ASSUME_NONNULL_END
