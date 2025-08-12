//
//  TDD_ArtiInputSaveModel.h
//  AD200
//
//  Created by 何可人 on 2022/5/12.
//

#import "TDD_JKDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiInputSaveModel : TDD_JKDBModel
@property (nonatomic, strong) NSString * path;//路径
@property (nonatomic, strong) NSString * mask;//掩码
@property (nonatomic, strong) NSString * value;//值
@end

NS_ASSUME_NONNULL_END
