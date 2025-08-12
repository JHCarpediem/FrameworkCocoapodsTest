//
//  TDD_ArtiModelBase.h
//  AD200
//
//  Created by 何可人 on 2022/4/16.
//

#import <Foundation/Foundation.h>
//#import "TDD_TranslatedModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    ArtiButtonStatus_ENABLE = 0, //DF_ST_BTN_ENABLE    按钮状态为可见并且可点击
    ArtiButtonStatus_DISABLE,    //DF_ST_BTN_DISABLE   按钮状态为可见但不可点击
    ArtiButtonStatus_UNVISIBLE   //DF_ST_BTN_UNVISIBLE 按钮状态为不可见，隐藏
}ArtiButtonStatus;

@interface TDD_ArtiButtonModel : NSObject
@property (nonatomic, assign) uint32_t uButtonId;//按钮编号 从0开始
@property (nonatomic, strong) NSString * strButtonText;//动作测试按钮文本
@property (nonatomic, assign) BOOL bIsEnable;//按钮是否可点击
@property (nonatomic, assign) ArtiButtonStatus uStatus;//自定义按钮的状态
@property (nonatomic, assign) BOOL bIsTemporaryNoEnable;//按钮是否为临时不可点击
@property (nonatomic, strong) NSString * strTranslatedButtonText;//翻译按钮文本
@property (nonatomic, assign) BOOL isTranslated; //是否已翻译
@property (nonatomic, strong) NSDictionary *params; // 向下一个view传递的参数
@property (nonatomic, assign) CGPoint clickPoint;
@property (nonatomic, assign) BOOL isLock;//是否加锁(过期软件)
@property (nonatomic, strong) NSString * uiTextIdentify;//UI测试的标记
@end

@interface TDD_ArtiModelBase : NSObject
@property (nonatomic, assign) int modID;
@property (nonatomic, strong) NSString * strTitle;//标题
@property (nonatomic, assign) uint32_t returnID;
@property (nonatomic, strong) TDD_ArtiButtonModel *lastClickButtonModel;//最后一次点击的按钮
@property (nonatomic, strong) NSMutableDictionary * objectDic;
@property (nonatomic, strong) NSCondition * condition;
@property (nonatomic, strong) NSMutableArray<TDD_ArtiButtonModel *> * buttonArr;//按钮数组
@property (nonatomic, strong) NSMutableArray<TDD_ArtiButtonModel *> * customButtonArr;//自定义按钮数组
@property (nonatomic, assign) BOOL isLock;//是否阻塞线程
@property (nonatomic, assign) BOOL isReloadButton; //是否刷新按钮
@property (nonatomic, assign) BOOL isShowOtherView; //是否显示其他页面
@property (nonatomic, assign) int scrollRow; //滑动位置
@property (nonatomic, assign) double scrollOffSet;
@property (nonatomic, assign) BOOL isTranslating; //是否正在翻译
@property (nonatomic, assign) BOOL translateSucc; //翻译是否成功
@property (nonatomic, strong) NSString * strTranslatedTitle;//已翻译标题
@property (nonatomic, assign) BOOL isTitleTranslated; //标题是否已翻译
@property (nonatomic, strong) NSMutableDictionary * translatedDic; //翻译缓存数据
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容
@property (nonatomic, assign) BOOL isSearch;    // 是否搜索
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, strong) NSMutableArray *filterArray;
@property (nonatomic, assign) BOOL isHideBottomView;///是否隐藏 bottomView

#pragma mark 注册方法
+ (void)registerMethod;

#pragma mark 初始化菜单显示控件，同时设置标题文本
/**********************************************************
*    功  能：初始化菜单显示控件，同时设置标题文本
*    参  数：strTitle 标题文本
*    返回值：true 初始化成功 false 初始化失败
**********************************************************/
+ (BOOL)InitTitleWithId:(uint32_t)ID strTitle:(NSString *)strTitle;

#pragma mark 显示菜单
/**********************************************************
*    功  能：显示菜单
*    参  数：无
*    返回值：uint32_t 组件界面按键返回值
*            选中菜单树区域，菜单项，返回
*            阻塞接口
**********************************************************/
+ (uint32_t)ShowWithId:(uint32_t)ID;

#pragma mark 创建对象
///创建对象
+ (void)Construct:(uint32_t)ID;

#pragma mark 销毁该对象
///销毁该对象
+ (void)Destruct:(uint32_t)ID;

#pragma mark 获取Model
///获取Model
+ (TDD_ArtiModelBase *)getModelWithID:(uint32_t)ID;

#pragma mark 添加动作测试按钮,添加完按钮默认可点击
+ (uint32_t)AddButtonExWithId:(uint32_t)ID strButtonText:(NSString *)strButtonText;

#pragma mark 删除自由按钮
+ (BOOL)DelButtonWithId:(uint32_t)ID uButtonId:(uint32_t)uButtonId;

#pragma mark 设置自定义按钮的状态
+ (void)SetButtonStatusWithId:(uint32_t)ID uIndex:(uint32_t)uIndex uStatus:(uint32_t)uStatus;

#pragma mark 设置指定的动作测试按钮文本
+ (void)SetButtonTextWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strButtonText:(NSString *)strButtonText;

#pragma mark 更新字典缓存model
+ (void)updateModel:(TDD_ArtiModelBase *)model;

#pragma mark 删除所有Model
///删除所有Model
+ (void)removeAllObjects;

#pragma mark 显示
- (uint32_t)show;

#pragma mark 底部按钮点击 - 返回是否允许回调
- (BOOL)ArtiButtonClick:(uint32_t)buttonID;

#pragma mark 等待时间后解锁
- (void)conditionSignalWithTime:(float)time;

#pragma mark 解锁
- (void)conditionSignal;

#pragma mark 点击退出按钮
- (void)backClick;

#pragma mark 机器翻译
- (void)machineTranslation;

#pragma mark 翻译完成
- (void)translationCompleted;
@end

NS_ASSUME_NONNULL_END
