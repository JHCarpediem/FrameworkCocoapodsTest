//
//  TDD_ArtiLiveDataRecordeSaveModel.h
//  AD200
//
//  Created by AppTD on 2022/9/19.
//

#import "TDD_JKDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveDataRecordeSaveModel : TDD_JKDBModel

@property (nonatomic, copy) NSString *createTime; //创建时间

@property (nonatomic, copy) NSString *strData; //数据 - TDD_ArtiLiveDataModel Json

@property (nonatomic, assign) BOOL isTemporaryData; //是否是临时数据

@end

NS_ASSUME_NONNULL_END
