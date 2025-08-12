//
//  TDD_ArtiMiniMsgBoxModel.h
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/7/18.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiMiniMsgBoxModel : TDD_ArtiModelBase
@property (nonatomic, strong) NSString * strContent; //消息框内容文本
@property (nonatomic, assign) uint32_t uButtonType; //消息框按钮类型
@property (nonatomic, assign) uint32_t uAlignType; //消息框文本对齐方式
@property (nonatomic, assign) BOOL isBusyVisible; //消息框忙状态是否显示
@property (nonatomic, assign) BOOL bIsBlock; //设置界面的阻塞状态
@property (nonatomic, strong) NSMutableArray<TDD_ArtiButtonModel *> * customButtonArr;//按钮数组
/**********************************************************
*    功  能：初始化消息框
*    参  数：strTitle 消息框标题文本
*            strContent 消息框内容文本
*            uButtonType 消息框按钮类型
*            uAlignType 消息框文本对齐方式
*    返回值：true 初始化成功 false 初始化失败
*
*    注：
*     uButtonType值可以如下：
*            DF_MB_NOBUTTON             //  无按钮的非阻塞消息框
*            DF_MB_YES                  //  Yes 按钮的阻塞消息框
*            DF_MB_NO                   //  No 按钮的阻塞消息框
*            DF_MB_YESNO                //  Yes/No 按钮的阻塞消息框
*            DF_MB_OK                   //  OK 按钮的阻塞消息框
*            DF_MB_CANCEL               //  Cancel 按钮的阻塞消息框
*            DF_MB_OKCANCEL             //  OK/Cancel 按钮的阻塞消息框
*            DF_MB_FREE | DF_MB_BLOCK   //  自由按钮的阻塞消息框
*
**********************************************************/
  
+ (uint32_t)artiShowMiniMsgBoxWithStrTitle:(NSString *)strTitle strContent:(NSString *)strContent uButton:(uint32_t)uButton uAlignType:(uint32_t)uAlignType;

+ (BOOL)InitMsgBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle strContent:(NSString *)strContent uButtonType:(uint32_t)uButtonType uAlignType:(uint32_t)uAlignType;

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
*    功  能：设置消息框忙状态是否显示
*    参  数：bIsVisible = true; 显示消息框忙状态，如沙漏或者其他
*            bIsVisible = false; 不显示显示消息框忙状态
*    返回值：无
**********************************************************/
+ (void)SetBusyVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible;

@end

NS_ASSUME_NONNULL_END
