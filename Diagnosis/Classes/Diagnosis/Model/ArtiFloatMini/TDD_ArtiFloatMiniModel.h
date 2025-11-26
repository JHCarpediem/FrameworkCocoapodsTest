//
//  TDD_ArtiFloatMiniModel.h
//  Alamofire
//
//  Created by zhouxiong on 2024/8/15.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiFloatMiniModel : TDD_ArtiModelBase
@property (nonatomic, assign) BOOL showTimer;           //时钟
@property (nonatomic, strong) NSString *strContent;     //内容
@property (nonatomic, assign) int ID;                   //ID
@property (nonatomic, assign) BOOL hidden;              //是否隐藏

+ (void)registerMethod;


@end

NS_ASSUME_NONNULL_END
