//
//  TDD_ArtiCoilReaderModel.h
//  AD200
//
//  Created by AppTD on 2023/2/15.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

// 线圈检测示意图
//
// 1、线圈检测根据检测到和没有检测到，分为“有信号”和“无信号”两种

//非阻塞页面

typedef enum
{
    SIGNAL_IS_NOT_SET   = 0, // 无信号，即没有检测到线圈
    SIGNAL_IS_SET       = 1, // 有信号，即检测到线圈
}eSignalType;

@interface TDD_ArtiCoilReaderModel : TDD_ArtiModelBase

@property (nonatomic,assign) eSignalType eType;

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
+ (void)SetCoilSignalWithId:(uint32_t)ID eType:(eSignalType)eType;

@end

NS_ASSUME_NONNULL_END
