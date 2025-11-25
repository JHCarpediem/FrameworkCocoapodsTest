//
//  TDD_ArtiNastfModel.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/8/19.
//

#import "TDD_ArtiNastfModel.h"
//#if useCarsFramework
//#import <CarsFramework/RegNastf.hpp>
//#else
//#import "RegNastf.hpp"
//#endif

#import "TDD_CTools.h"
@implementation TDD_ArtiNastfModel
#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);
    // 6.10 没有界面逻辑先注释
//    CRegNastf::Construct(ArtiNastfConstruct);
//    CRegNastf::Destruct(ArtiNastfDestruct);
//    CRegNastf::InitTitle(ArtiNastfInitTitle);
//    CRegNastf::GetNeedShow(ArtiNastfGetNeedShow);
//    CRegNastf::Show(ArtiNastfShow);
}

void ArtiNastfConstruct(uint32_t id)
{
    [TDD_ArtiNastfModel Construct:id];
}

void ArtiNastfDestruct(uint32_t id)
{
    [TDD_ArtiNastfModel Destruct:id];
}

uint32_t ArtiNastfInitTitle(uint32_t id, const std::string& strTitle)
{
    NSString * Title = [TDD_CTools CStrToNSString:strTitle];
    
    [TDD_ArtiNastfModel InitTitleWithId:id strTitle:Title];
    return DF_APP_CURRENT_NOT_SUPPORT_FUNCTION;
}

uint32_t ArtiNastfGetNeedShow(uint32_t id, uint32_t functionsType)
{
    return [TDD_ArtiNastfModel getNeedShowWithId:id functionsType:functionsType];
}

uint32_t ArtiNastfShow(uint32_t id)
{
    return [TDD_ArtiNastfModel ShowWithId:id];
}

+ (uint32_t)getNeedShowWithId:(uint32_t)ID functionsType:(uint32_t)functionsType
{
    HLog(@"%@ - getNeedShowWithId - ID : %d -  functionsType ：%d", [self class], ID, functionsType);
    TDD_ArtiNastfModel * model = (TDD_ArtiNastfModel *)[self getModelWithID:ID];
    model.functionsType = (eNastfFuncType)functionsType;
    //JH:return eNastfReturnType
    return DF_APP_CURRENT_NOT_SUPPORT_FUNCTION;
}
@end
