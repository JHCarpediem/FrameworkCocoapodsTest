//
//  TDD_ArtiFreqWaveModel.m
//  AD200
//
//  Created by AppTD on 2023/2/15.
//

#import "TDD_ArtiFreqWaveModel.h"

#if useCarsFramework
#import <CarsFramework/RegFreqWave.hpp>
#else
#import "RegFreqWave.hpp"
#endif

#import "TDD_CTools.h"

@implementation TDD_ArtiFreqWaveModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);
    
    CRegFreqWave::Construct(StdFreqWaveConstruct);
    CRegFreqWave::Destruct(StdFreqWaveDestruct);
    CRegFreqWave::InitTitle(StdFreqWaveInitTitle);
    CRegFreqWave::Show(StdFreqWaveShow);
    CRegFreqWave::SetModeFrequency(StdFreqWaveSetModeFrequency);
    CRegFreqWave::TriggerCrest(StdFreqWaveTriggerCrest);
    CRegFreqWave::SetLeftLayoutPicture(StdFreqWaveSetLeftLayoutPicture);
}

void StdFreqWaveConstruct(uint32_t id)
{
    [TDD_ArtiFreqWaveModel Construct:id];
}

void StdFreqWaveDestruct(uint32_t id)
{
    [TDD_ArtiFreqWaveModel Destruct:id];
}

bool StdFreqWaveInitTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiFreqWaveModel InitTitleWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle]];
}

uint32_t StdFreqWaveShow(uint32_t id)
{
    return [TDD_ArtiFreqWaveModel ShowWithId:id];
}

void StdFreqWaveSetModeFrequency(uint32_t id, const std::string& strModeValue, const std::string& strFreqValue, const std::string& strIntensity)
{
    [TDD_ArtiFreqWaveModel SetModeFrequencyWithId:id strModeValue:[TDD_CTools CStrToNSString:strModeValue] strFreqValue:[TDD_CTools CStrToNSString:strFreqValue] strIntensity:[TDD_CTools CStrToNSString:strIntensity]];
}

void StdFreqWaveTriggerCrest(uint32_t id, uint32_t Type)
{
    [TDD_ArtiFreqWaveModel TriggerCrestWithId:id Type:(eCrestType)Type];
}

bool StdFreqWaveSetLeftLayoutPicture(uint32_t id, const std::string& strPicturePath, const std::string& strPictureTips, uint16_t uAlignType)
{
    return [TDD_ArtiFreqWaveModel SetLeftLayoutPictureWithId:id strPicturePath:[TDD_CTools CStrToNSString:strPicturePath] strPictureTips:[TDD_CTools CStrToNSString:strPictureTips] uAlignType:uAlignType];
}

/*******************************************************************
*    功  能：设置频率检测的模式和频率值
*
*    参  数：strModeValue    模式，"ASK"或者"FSK"
*            strFreqValue    频率值，例如"868.75MHz"
*            strIntensity   信号强度，例如"-32dbm"
*
*    返回值：无
*
*    说 明：
****************************************************************************/
+ (void)SetModeFrequencyWithId:(uint32_t)ID strModeValue:(NSString *)strModeValue strFreqValue:(NSString *)strFreqValue strIntensity:(NSString *)strIntensity
{
    HLog(@"%@ - 设置频率检测的模式和频率值 - ID:%d - strModeValue:%@ - strFreqValue:%@ - strIntensity:%@", [self class], ID, strModeValue, strFreqValue, strIntensity);
    
    TDD_ArtiFreqWaveModel * model = (TDD_ArtiFreqWaveModel *)[self getModelWithID:ID];
    
    model.strModeValue = strModeValue;
    model.strFreqValue = strFreqValue;
    model.strIntensity = strIntensity;
}

/*******************************************************************
*    功  能：触发一次尖顶（波峰）类型的波形
*
*    参  数：Type    TRIGGER_ONE_CREST = 1        触发一个“单尖顶”波形
*                   TRIGGER_TWO_CREST = 2        触发一个“双尖顶”波形
*
*    返回值：无
*
*    说 明： 连续的TriggerCrest调用之间不能太快，否则没有尖顶波形的效果
*
****************************************************************************/
+ (void)TriggerCrestWithId:(uint32_t)ID Type:(eCrestType)Type
{
    HLog(@"%@ - 触发一次尖顶（波峰）类型的波形 - ID:%d - eCrestType:%d", [self class], ID, Type);
    
    TDD_ArtiFreqWaveModel * model = (TDD_ArtiFreqWaveModel *)[self getModelWithID:ID];
    
    model.Type = Type;
}


/***************************************************************************
*    功  能：在波形左边增加一个图片，波形半屏靠右显示，增加的图片半屏靠左显示
*
*    参  数：strPicturePath 指定显示的图片路径
*                           如果strPicturePath指定图片路径串为非法路径（空串
*                           或文件不存在），返回失败
*
*            strPictureTips 图片显示的文本提示
*
*            uAlignType     文本提示显示在图片的哪个部位
*                           DT_RIGHT_TOP，文本提示显示在图片的右上角
*                           DT_LEFT_TOP， 文本提示显示在图片的左上角
*
*    返回值：无
*
*    注  意：如果没有调用此接口，或者此接口调用返回了false，波形图将全屏显示
*
*    使用场景：频率检测
*
***************************************************************************/
+ (BOOL)SetLeftLayoutPictureWithId:(uint32_t)ID strPicturePath:(NSString *)strPicturePath strPictureTips:(NSString *)strPictureTips uAlignType:(uint16_t)uAlignType
{
    HLog(@"%@ - 在波形左边增加一个图片 - ID:%d - strPicturePath:%@ - strPictureTips:%@ - uAlignType:%d", [self class], ID, strPicturePath, strPictureTips, uAlignType);
    
    TDD_ArtiFreqWaveModel * model = (TDD_ArtiFreqWaveModel *)[self getModelWithID:ID];
    
    strPicturePath = [strPicturePath stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    model.strPicturePath = strPicturePath;
    model.strPictureTips = strPictureTips;
    model.uAlignType = uAlignType;
    
    return YES;
}


@end
