//
//  TDD_ArtiCoilReaderModel.m
//  AD200
//
//  Created by AppTD on 2023/2/15.
//

#import "TDD_ArtiCoilReaderModel.h"

#if useCarsFramework
#import <CarsFramework/RegCoilReader.hpp>
#else
#import "RegCoilReader.hpp"
#endif

#import "TDD_CTools.h"

@implementation TDD_ArtiCoilReaderModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);
    CRegCoilReader::Construct(StdCoilReaderConstruct);
    CRegCoilReader::Destruct(StdCoilReaderDestruct);
    CRegCoilReader::InitTitle(StdCoilReaderInitTitle);
    CRegCoilReader::SetCoilSignal(SetCoilSignal);
    CRegCoilReader::Show(StdCoilReaderShow);
}

void StdCoilReaderConstruct(uint32_t id)
{
    [TDD_ArtiCoilReaderModel Construct:id];
}

void StdCoilReaderDestruct(uint32_t id)
{
    [TDD_ArtiCoilReaderModel Destruct:id];
}

bool StdCoilReaderInitTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiCoilReaderModel InitTitleWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle]];
}

uint32_t StdCoilReaderShow(uint32_t id)
{
    return [TDD_ArtiCoilReaderModel ShowWithId:id];
}

void SetCoilSignal(uint32_t id, uint32_t type)
{
    [TDD_ArtiCoilReaderModel SetCoilSignalWithId:id eType:(eSignalType)type];
}

/*******************************************************************
*    功  能：设置线圈检测的状态，检测到还是未检测到线圈
*
*    参  数：eType    状态类型，例如，SIGNAL_IS_NOT_SET，没有检测到线圈
*                             例如，SIGNAL_IS_SET，检测到线圈
*
*    返回值：无
*
*    说 明： 如果没有调用此接口，默认为 SIGNAL_IS_NOT_SET，即没有检测到线圈
****************************************************************************/
+ (void)SetCoilSignalWithId:(uint32_t)ID eType:(eSignalType)eType
{
    HLog(@"%@ - 设置线圈检测的状态 - ID:%d - eSignalType:%d", [self class], ID, eType);
    
    TDD_ArtiCoilReaderModel * model = (TDD_ArtiCoilReaderModel *)[self getModelWithID:ID];
    
    model.eType = eType;
}

@end
