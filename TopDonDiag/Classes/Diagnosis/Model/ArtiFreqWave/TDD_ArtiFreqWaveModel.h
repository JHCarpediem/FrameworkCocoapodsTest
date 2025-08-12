//
//  TDD_ArtiFreqWaveModel.h
//  AD200
//
//  Created by AppTD on 2023/2/15.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

// 频率检测波形示意图
//
// 此接口为非阻塞接口
//
// 1、波形有滚动效果
//
// 2、按“模式”设定，分为两类波形：ASK模式和FSK模式
//    “FSK”为“双尖顶”波形，“ASK”为“单尖顶”波形
//
// 3、波形X轴为时间，Y轴为高度
//
// 4、Y轴分为10横线（9行格），静态（低电平位置）时处于第3格（从底部数）正弦波小幅波动，
//    尖顶位置即波峰处于第7格顶部（第8横线）
//
// 5、“单尖顶”指一个尖顶（波峰），尖顶位置处于第7格顶部（第8横线）
//
// 6、“双尖顶”指连续两个尖顶（波峰）靠在一起，尖顶位置处于第7格顶部（第8横线），
//     两个尖顶之间有一个凹处，凹处位置处于第4个顶部（第5横线）
//
// 7、 锁匠程序检测到遥控频率模式属于“FSK”，将触发一次“双尖顶”波形（TriggerCrest）
//
// 8、 锁匠程序检测到遥控频率模式属于“ASK”，将触发一次“单尖顶”波形（TriggerCrest）
//
// 9、 界面左边显示帮助图片，界面右边显示波形图，模式和频率值显示在波形图下方
//
//

typedef enum
{
    TRIGGER_ONE_CREST = 1, // 触发一个“单尖顶”波形，即触发一个波峰
    TRIGGER_TWO_CREST = 2, // 触发一个“双尖顶”波形
}eCrestType;


@interface TDD_ArtiFreqWaveModel : TDD_ArtiModelBase

@property (nonatomic,strong) NSString *strModeValue; //模式
@property (nonatomic,strong) NSString *strFreqValue; //频率值
@property (nonatomic,strong) NSString *strIntensity; //信号强度
@property (nonatomic,assign) eCrestType Type;
@property (nonatomic,strong) NSString *strPicturePath; //显示的图片路径
@property (nonatomic,strong) NSString *strPictureTips; //图片显示的文本提示
@property (nonatomic,assign) uint16_t uAlignType; //文本提示显示在图片的哪个部位

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
+ (void)SetModeFrequencyWithId:(uint32_t)ID strModeValue:(NSString *)strModeValue strFreqValue:(NSString *)strFreqValue strIntensity:(NSString *)strIntensity;


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
+ (void)TriggerCrestWithId:(uint32_t)ID Type:(eCrestType)Type;


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
+ (BOOL)SetLeftLayoutPictureWithId:(uint32_t)ID strPicturePath:(NSString *)strPicturePath strPictureTips:(NSString *)strPictureTips uAlignType:(uint16_t)uAlignType;

@end

NS_ASSUME_NONNULL_END
