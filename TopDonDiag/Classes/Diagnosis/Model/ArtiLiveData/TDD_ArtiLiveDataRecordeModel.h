//
//  TDD_ArtiLiveDataRecordeModel.h
//  AD200
//
//  Created by AppTD on 2022/8/27.
//

#import "TDD_JKDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveDataRecordeModel : TDD_JKDBModel
@property (nonatomic, copy) NSString *createTime; //创建时间
@property (nonatomic, copy) NSString *recordChangeDictStr;// record 过程中修改过的 model 的属性的 keyValue
@property (nonatomic, copy) NSString *recordChangeItemDictStr;// record 过程中修改过的 model  的 itemModel 数据
@end

NS_ASSUME_NONNULL_END
