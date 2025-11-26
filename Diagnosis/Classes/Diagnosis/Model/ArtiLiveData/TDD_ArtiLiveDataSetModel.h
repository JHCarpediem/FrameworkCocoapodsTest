//
//  TDD_ArtiLiveDataSetModel.h
//  AD200
//
//  Created by AppTD on 2022/8/10.
//

#import "TDD_ArtiModelBase.h"
#import "TDD_ArtiLiveDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiLiveUnitModel : NSObject
/// 0:车型默认单位、1:公制单位、2:英制单位
@property (nonatomic,assign) TDD_UnitConversionType type;
@property (nonatomic,copy) NSString *unit;
@property (nonatomic,copy) NSString *strMin;
@property (nonatomic,copy) NSString *strMax;
@end

@interface TDD_ArtiLiveDataSetModel : TDD_ArtiModelBase
@property (nonatomic,strong) TDD_ArtiLiveDataModel * liveDataModel;
@property (nonatomic,strong) TDD_ArtiLiveDataItemModel * itemModel;
@end

NS_ASSUME_NONNULL_END
