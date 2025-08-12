//
//  TDD_ArtiMsgBoxModel.h
//  AD200
//
//  Created by 何可人 on 2022/5/20.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    SpecialViewType_None = 0,        //默认
    SpecialViewType_AdasStep = 1,    //AdasStep

}specialViewType;

@interface TDD_ArtiMsgBoxModel : TDD_ArtiModelBase
@property (nonatomic, strong) NSString * strContent; //消息框内容文本
@property (nonatomic, assign) uint32_t uButtonType; //消息框按钮类型
@property (nonatomic, assign) uint32_t uAlignType; //消息框文本对齐方式
@property (nonatomic, assign) uint32_t uTestType; //部件测试类型
@property (nonatomic, assign) uint32_t uRpm;//       uRpm为转速
@property (nonatomic, assign) uint32_t uCountDown;// uCountDown 倒计时参数
@property (nonatomic, assign) int32_t iTimer; //定时器，单位ms
@property (nonatomic, assign) BOOL isBusyVisible; //消息框忙状态是否显示
@property (nonatomic, assign) BOOL isProcessBarVisible; //进度条是否显示
@property (nonatomic, assign) uint32_t iCurPercent; //当前进度
@property (nonatomic, assign) uint32_t iTotalPercent; //总进度
@property (nonatomic, assign) BOOL bIsBlock; //设置界面的阻塞状态

// 小车探项目UI需求，App根据指定的消息类型，绘制指定UI
// uType 是消息类型
//      MBT_ERROR_DEFAULT        = 0    默认类型，即App不会做任何效果
//      MBT_ERROR_ENTER_SYS_COMM = 1    进系统失败
//      MBT_ERROR_EXEC_FUNC_COMM = 2    功能执行失败
//
@property (nonatomic, assign) uint32_t uType; // 小车探项目UI需求，App根据指定的消息类型，绘制指定UI
@property (nonatomic, assign) uint32_t adasStep; // adas step
@property (nonatomic, assign) uint32_t specialViewType;

@property (nonatomic, strong) NSString * strTranslatedContent;//消息框内容文本 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, assign) BOOL isStrContentTranslated; //消息框内容文本是否已翻译
@property (nonatomic, strong) NSMutableArray *liveDataItems;
/*
    消息框分为4种类型
    1、 固定按钮的阻塞消息框；
    2、 固定按钮的非阻塞消息框；
    3、 自由添加按钮的阻塞消息框；
    4、 自由添加按钮的非阻塞消息框。

    消息框按钮在底部，从右向左排列；无按钮的非阻塞消息框有沙漏（即是转圈效果）。
*/

/**
 #define DT_TOP                      0x00000000
 #define DT_LEFT                     0x00000000
 #define DT_CENTER                   0x00000001
 #define DT_RIGHT                    0x00000002
 #define DT_BOTTOM                   0x00000008
 */


/**********************************************************
*    功  能：初始化消息框
*    参  数：strTitle 消息框标题文本
*            strContent 消息框内容文本
*            uButtonType 消息框按钮类型
*            uAlignType 消息框文本对齐方式
*            iTimer 定时器，单位ms
*            注：iTimer只对单按钮消息框或者无按钮消息框有效
*    返回值：true 初始化成功 false 初始化失败
*
     当 uButton 指定为 固定按钮时可：
                 DF_MB_NOBUTTON              无按钮的非阻塞消息框
                 DF_MB_YES                   Yes 按钮的阻塞消息框
                 DF_MB_NO                    No 按钮的阻塞消息框
                 DF_MB_YESNO                 Yes/No 按钮的阻塞消息框
                 DF_MB_OK                    OK 按钮的阻塞消息框
                 DF_MB_CANCEL                Cancel 按钮的阻塞消息框
                 DF_MB_OKCANCEL              OK/Cancel 按钮的阻塞消息框
                 DF_MB_NEXTEXIT              Next/Exit 按钮的阻塞消息框

     全局消息框函数artiShowMsgBox无自由按钮的模式(会显示忙状态)

 注意：当 uButton 指定为 DF_MB_NOBUTTON 时，artiShowMsgBox是
       会显示消息框忙状态，有忙的属性（即转圈圈效果）

 注意：当 uButton 指定为 DF_MB_NOBUTTON 时，artiShowMsgBox是
       会显示消息框忙状态，有忙的属性（即转圈圈效果）
*
**********************************************************/
+ (uint32_t)artiShowMsgBoxWithStrTitle:(NSString *)strTitle strContent:(NSString *)strContent uButton:(uint32_t)uButton uAlignType:(uint32_t)uAlignType iTimer:(int32_t)iTimer;

+ (BOOL)InitMsgBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle strContent:(NSString *)strContent uButtonType:(uint32_t)uButtonType uAlignType:(uint32_t)uAlignType iTimer:(int32_t)iTimer;


/**********************************************************
*    功  能：使用与小车探项目的部件测试UI
*    参  数：strTitle 消息框标题文本
*            strContent 消息框内容文本
*            uButtonType 消息框按钮类型
*            uTestType 是部件测试类型
*
*    注：
 // 使用与小车探项目的部件测试UI
 // uTestType 是部件测试类型 DF_TYPE_THROTTLE_CARBON
**********************************************************/
+ (uint32_t)artiShowMsgBoxActTestWithStrTitle:(NSString *)strTitle strContent:(NSString *)strContent uButton:(uint32_t)uButton uTestType:(uint32_t)uTestType uRpm:(uint32_t)uRpm uCountDown:(uint32_t)uCountDown;


/**********************************************************
*    功  能：设置消息框标题
*    参  数：strTitle 消息框标题
*    返回值：无
**********************************************************/
+ (void)SetTitleWithId:(uint32_t)ID strTitle:(NSString *)strTitle;

/**********************************************************
*    功  能：设置消息框文本内容
*    参  数：strContent 消息框内容
*    返回值：无
**********************************************************/
+ (void)SetContentWithId:(uint32_t)ID strContent:(NSString *)strContent;


/**********************************************************
*    功  能：设置消息框按钮类型
*    参  数：uButtonTyp 按钮类型
*    返回值：无
**********************************************************/
+ (void)SetButtonTypeWithId:(uint32_t)ID uButtonType:(uint32_t)uButtonType;


/**********************************************************
*    功  能：设置消息框内容对齐方式
*    参  数：uAlignType 对齐方式
*    返回值：无
**********************************************************/
+ (void)SetAlignTypeWithId:(uint32_t)ID uAlignType:(uint32_t)uAlignType;

/**********************************************************
*    功  能：设置定时器
*    参  数：定时器时间，单位ms
*    返回值：无
**********************************************************/
+ (void)SetTimerWithId:(uint32_t)ID iTimer:(int32_t)iTimer;

/**********************************************************
*    功  能：设置消息框忙状态是否显示
*    参  数：bIsVisible = true; 显示消息框忙状态，如沙漏或者其他
*            bIsVisible = false; 不显示显示消息框忙状态
*    返回值：无
**********************************************************/
+ (void)SetBusyVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible;

/**********************************************************
*    功  能：设置进度条是否显示
*    参  数：bIsVisible = true;   显示进度条
*            bIsVisible = false; 不显示进度条
*    返回值：无
**********************************************************/
+ (void)SetProcessBarVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible;

/**********************************************************
*    功  能：设置进度条的进度
*    参  数：iCurPercent，   当前进度
*            iTotalPercent，总进度
*    返回值：无
**********************************************************/
+ (void)SetProgressBarPercentWithId:(uint32_t)ID iCurPercent:(int32_t)iCurPercent iTotalPercent:(int32_t)iTotalPercent;

@end

NS_ASSUME_NONNULL_END
