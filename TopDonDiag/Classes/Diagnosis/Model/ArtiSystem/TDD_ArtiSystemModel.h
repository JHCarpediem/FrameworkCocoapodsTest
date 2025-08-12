//
//  TDD_ArtiSystemModel.h
//  AD200
//
//  Created by 何可人 on 2022/5/25.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum
{
    SST_TYPE_DEFAULT = 0,   // 默认系统类型
    SST_TYPE_ADAS    = 1,   // ADAS系统扫描类型
}eSysScanType;

@interface ArtiSystemItemModel : NSObject
@property (nonatomic, assign) uint32_t uIndex; //索引
@property (nonatomic, strong) NSString * strItem; //系统项名称
@property (nonatomic, strong) NSString * strStatus; //状态 （正在初始化.../正在读码.../正在清码...）
@property (nonatomic, assign) uint32_t uResult; //结果 （不存在/有码/无码/未知）
@property (nonatomic, assign) uint32_t uAdasResult; //（存在ADAS/不存在ADAS）
@property (nonatomic, assign) uint32_t eType;//小车探系统扫描的系统类型分类 - 如果为DMM_INVALID，则不需要分类
@property (nonatomic, strong) NSString * strTranslatedItem;//系统项名称 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, strong) NSString * strTranslatedStatus;//状态 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, assign) BOOL isStrItemTranslated; //系统项名称是否已翻译
@property (nonatomic, assign) BOOL isStrStatusTranslated; //状态是否已翻译
@end

@protocol TDD_ArtiSystemModelDelegata <NSObject>

/**********************************************************
*    功  能：自动扫描
**********************************************************/
- (void)ArtiSystemSetAutoEnable:(TDD_ArtiButtonModel *)buttonModel;

@end

@interface TDD_ArtiSystemModel : TDD_ArtiModelBase
@property (nonatomic, weak) __nullable id<TDD_ArtiSystemModelDelegata> delegate;;
@property (nonatomic, strong) NSMutableArray<ArtiSystemItemModel *> * itemArr;
@property (nonatomic, assign) BOOL isClearButtonVisible; //是否显示一键清码按钮
@property (nonatomic, assign) BOOL isHelpButtonVisible; //是否显示帮助按钮
@property (nonatomic, assign) BOOL isScanButtonVisible; //是否显示扫描按钮
@property (nonatomic, assign) uint32_t scanStatus; //系统扫描状态,默认为-1
@property (nonatomic, assign) uint32_t clearStatus; //一键清码状态 - 开始清码即禁止所有点击，默认为-1
@property (nonatomic, assign) int32_t selectItem; //选中的项,默认为-1
@property (nonatomic, assign) BOOL bIsLock; //设置界面的阻塞状态
@property (nonatomic, assign) BOOL isShowActual; //是否显示实际项
@property (nonatomic, assign) BOOL isDisplayRefresh; //是否显示刷新效果
@property (nonatomic, assign) BOOL isStartScan; //是否开始扫码 - 完成扫描时跳回顶部
@property (nonatomic, assign) BOOL isStartClear; //是否开始清码 - 完成清码时跳回顶部
@property (nonatomic, assign) BOOL hadScan; //是否扫过码
@property (nonatomic, assign) BOOL isScrollToSelect; //是否滑动到选中行
@property (nonatomic, assign) BOOL isAutoScanEnable; // 是否自动扫描
@property (nonatomic, strong) NSMutableArray *selectArray;  // 记录选中Item
@property (nonatomic, assign) eSysScanType eType; // 扫描类型
@property (nonatomic, assign) NSInteger score; //记录算分分数

@property (nonatomic, assign) ArtiButtonStatus clearStartShowBtnStatus;//清码开始时显示按钮的按钮状态

// 清码进度
@property (nonatomic, assign) NSInteger clearStartDtcRowCount;//清码开始时有码的条数
@property (nonatomic, assign)NSInteger clearStartFinishRowCount;//清码开始后清过的条数

//一般情况下阻塞，扫码、清码时非阻塞且返回NOKEY
//开始扫描和开始清码为非阻塞、其他为阻塞

/*
    CArtiSystem 按钮包括如下：

    “帮助”
    “诊断报告”
    “一键扫描”/“暂停扫描”/“继续扫描”
    “一键清码”
    “后退”
    “显示全部”/“显示实际”

    按钮规则：
        1、“帮助”按钮，是否可用根据SetHelpButtonVisible接口决定，“帮助”按钮默认不可用

        2、进入CArtiSystem界面，“后退”和“一键扫描”可用，“诊断报告”、“一键清码”不可用

        3、“一键清码”按钮默认显示，状态为不可用，如果SetClearButtonVisible设置“一键清码”不显示
            即使存在故障码，也不显示
          
        4、点击“一键扫描”，“一键扫描”变为“暂停扫描”，其余按钮皆不可用，直至扫描完成或者暂停，
           扫描完成或者暂停由接口SetScanStatus()指定

        5、如果点击了“暂停扫描”，或者SetScanStatus接口指定为暂停，
           “暂停扫描”变成“继续扫描”可用，此时界面状态为暂停，
           “帮助”按钮和“后退”按钮可用，“诊断报告”按钮根据是否有系统，决定是否可用
           如果此时有故障码或者系统未知（DF_ENUM_UNKNOWN），“一键清码”应可用

        6、如果点击了“继续扫描”，“继续扫描”变为“暂停扫描”，其余按钮皆不可用，
           直至扫描完成或者暂停，扫描完成或者暂停由接口SetScanStatus()指定

        7、如果点击了“一键清码”，所有按钮皆不可用，直至清码完成，清码完成由SetClearStatus接口指定

        8、“一键清码”按钮是否可用，由是否存在故障码决定，如果此时正在“一键扫描”中，即使有故障码，按钮也不可用
           如果SetClearButtonVisible设置“一键清码”不显示，即使存在故障码，也不显示此按钮

        9、SetScanStatus()的实参是DF_SYS_SCAN_PAUSE，相当于点击了“暂停扫描”

        10、诊断代码在系统扫描完后，需调用SetScanStatus()，此时系统扫描已完成

        11、诊断代码在一键清码完后，需调用SetClearStatus()，一键清码已完成

        12、如果返回 DF_ID_SYS_START 表示点击了“一键扫描”
            诊断程序需立即调用SetScanStatus(DF_SYS_SCAN_START)通知实现
            一键扫描开始

           如果返回 DF_ID_SYS_STOP  表示点击了“暂停”
           诊断程序需立即调用SetScanStatus(DF_SYS_SCAN_PAUSE)通知实现
            暂停扫描

           如果返回 DF_ID_SYS_ERASE 表示点击了“一键清码”
           诊断程序需立即调用SetClearStatus(DF_SYS_CLEAR_START)通知实现
            一键清码开始
*/

/**********************************************************
*    功  能：添加系统项
*    参  数：strItem 系统项名称
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strItem:(NSString *)strItem;

/**********************************************************
*    功  能：获取指定系统项的文本串
*    参  数：uIndex 指定的系统项
*    返回值：string 指定系统项的文本串
**********************************************************/
+ (NSString *)GetItemWithId:(uint32_t)ID uIndex:(uint32_t)uIndex;

/**********************************************************
*    功  能：获取当前有故障码的系统项
*    参  数：无
*    返回值：有故障码的系统项，
*             即扫描结果为“DF_ENUM_DTCNUM”的系统集合
*
*     例如，当前系统列表中有5个系统，0,2,4系统编号有故障码，
*          则返回的vector大小为3,值分别是0,2,4
**********************************************************/
+ (NSArray *)GetDtcItemsWithId:(uint32_t)ID;

/**********************************************************
*    功  能：设置帮助按钮是否显示，帮助按钮默认不显示
*    参  数：bIsVisible=true   显示帮助按钮
*            bIsVisible=false 隐藏帮助按钮
*    返回值：无
**********************************************************/
+ (void)SetHelpButtonVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible;


/**********************************************************
*    功  能：强制设置一键清码按钮是否显示，一键清码按钮默认显示
*
*    参  数：bIsVisible=true   显示一键清码
*            bIsVisible=false  隐藏一键清码
*
*    返回值：无
*
*    注 意： 在没有调用此接口下，“一键清码”按钮默认显示
*            显示的条件是存在故障码
*
*            如果SetClearButtonVisible设置为true，是否显示由是
*            否存在故障码决定
*
*            如果SetClearButtonVisible设置为false，将强制不显示
*            即使存在故障码也不显示
*
**********************************************************/
+ (void)SetClearButtonVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible;


/**********************************************************
*    功  能：设置指定系统项的状态
*    参  数：uIndex 指定的系统项
*            strStatus 指定系统项的状态
*            （正在初始化.../正在读码.../正在清码...）
*    返回值：无
**********************************************************/
+ (void)SetItemStatusWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strStatus:(NSString *)strStatus;


/**********************************************************
*    功  能：设置指定系统项的扫描结果
*    参  数：uIndex 指定的系统项
*            uResult 指定系统项的最终结果
*            （不存在/有码/无码/未知）
*    返回值：无
**********************************************************/
+ (void)SetItemResultWithId:(uint32_t)ID uIndex:(uint32_t)uIndex uResult:(uint32_t)uResult;

/**********************************************************
*    功  能：设置扫描按键是否隐藏，控件默认显示
*    参  数：bIsHidden=true 按钮区隐藏
*            bIsHidden=false 按钮区显示
*    返回值：无
**********************************************************/
+ (void)SetButtonAreaHiddenWithId:(uint32_t)ID bIsHidden:(BOOL)bIsHidden;


/**********************************************************
*    功  能：设置系统扫描状态
*
*    参  数：uStatus
*                DF_SYS_SCAN_PAUSE,   暂停扫描
*                DF_SYS_SCAN_FINISH,  扫描结束
*
*    返回值：无
**********************************************************/
+ (void)SetScanStatusWithId:(uint32_t)ID uStatus:(uint32_t)uStatus;

/**********************************************************
*    功  能：设置一键清码状态
*
*    参  数：uStatus
*                DF_SYS_CLEAR_FINISH,   一键清码结束
*               DF_SYS_CLEAR_START,   一键清码开始
*
*    返回值：无
**********************************************************/
+ (void)SetClearStatusWithId:(uint32_t)ID uStatus:(uint32_t)uStatus;


/**********************************************************
*    功  能：显示系统控件
*    参  数：无
*    返回值：uint32_t 组件界面按键返回值
*        按键：一键扫描，一键清码，帮助，诊断报告，返回等
*
*     说明
*        如果返回 DF_ID_SYS_START 表示点击了“一键扫描”
*       诊断程序需立即调用SetScanStatus(DF_SYS_SCAN_START)通知实现
*        一键扫描开始
*
*       如果返回 DF_ID_SYS_STOP  表示点击了“暂停”
*       诊断程序需立即调用SetScanStatus(DF_SYS_SCAN_PAUSE)通知实现
*        暂停扫描
*
*       如果返回 DF_ID_SYS_ERASE 表示点击了“一键清码”
*       诊断程序需立即调用SetClearStatus(DF_SYS_CLEAR_START)通知实现
*        一键清码开始
**********************************************************/

#pragma mark - 获取不存在数据
- (NSArray *)GetNoDataItems;

#pragma mark - 获取有码数据
- (NSArray *)GetDtcItems;
@end

NS_ASSUME_NONNULL_END
