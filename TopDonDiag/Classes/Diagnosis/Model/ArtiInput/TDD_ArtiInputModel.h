//
//  TDD_ArtiInputModel.h
//  AD200
//
//  Created by 何可人 on 2022/5/10.
//

#import "TDD_ArtiModelBase.h"

#define DF_ID_QR     (0x60010011)
#define DF_ID_PASTE  (0x60010013)
NS_ASSUME_NONNULL_BEGIN
typedef enum
{
    Arti_ControlType_InputBox = 0,
    Arti_ControlType_ComboBox
}ControlType;
@interface ArtiInputItemModel : NSObject
@property (nonatomic, strong) NSString * strTips;//提示文本
@property (nonatomic, strong) NSString * strMask;//输入掩码
@property (nonatomic, strong) NSString * strDefault;//默认值
@property (nonatomic, strong) NSString * strText;//输入值
@property (nonatomic, strong) NSArray<NSString *> * vctValue;//选择值
@property (nonatomic, assign) BOOL isDropDownBox; //是否是下拉框

@property (nonatomic, strong) NSString * strTranslatedTips;//提示文本 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, assign) BOOL isStrTipsTranslated; //提示文本是否已翻译

/// 校验字符
- (NSString *)filterTextMatch:(NSString *)text;
- (BOOL)shouldTurnToUppercase;
@end

@interface TDD_ArtiInputModel : TDD_ArtiModelBase

@property (nonatomic, strong) NSMutableArray<ArtiInputItemModel *> * itemArr;

/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900输入框控件接口定义
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
*    输入框掩码说明：掩码决定了需要输入的内容和输入长度
*        *：表示可输入任意可显示字符
         0：表示可输入0~9之间的字符
         F：表示可输入0~9，A~F之间的用来表示16进制的字符
         #：表示可输入0~9，+，-，*，/字符
         V：表示可输入0~9，A~Z之间除了I，O，Q外的其他所有可出现在VIN码中的字符
         A：表示可输入A~Z之间的大写字母
         B：表示可输入0~9之间的字符和A~Z之间的大写字母


    输入框为用户提供输入的界面，存在以下情况
    1、 单输入框，确定、取消按钮，另加自由添加按钮，阻塞界面；
    2、 多输入框，确定、取消按钮，另加自由添加按钮，阻塞界面；
    3、 输入框应具备输入记忆功能；
    4、 输入框涉及键盘问题，请根据掩码和按钮组合键盘；
    5、 输入框采用上下滑动


* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/

/**********************************************************
*    功  能：初始化单输入框控件
*    参  数：strTitle 标题文本
*            strTips 提示文本
*            strMask 输入掩码
*            strDefault 默认值
*    返回值：true 初始化成功 false 初始化失败
**********************************************************/
+ (BOOL)InitOneInputBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle strTips:(NSString *)strTips strMask:(NSString *)strMask strDefault:(NSString *)strDefault;


/**********************************************************
*    功  能：获取单输入框的内容
*    参  数：无
*    返回值：string 输入框输入的值
**********************************************************/
+ (NSString *)GetOneInputBoxWithId:(uint32_t)ID;

/**********************************************************
*    功  能：添加按钮
*    参  数：strButtonText 按钮文本
*    返回值：无
**********************************************************/
+ (void)AddButtonWithId:(uint32_t)ID strButtonText:(NSString *)strButtonText;

/**********************************************************
*    功  能：初始化多输入框控件
*    参  数：strTitle 标题文本
*            vctTips 输入框对应的提示文本集合，一一对应
*            vctMasks 输入框对应的输入掩码，一一对应
*            vctDefaults 输入框对应的默认值，一一对应
*    返回值：无
**********************************************************/
+ (BOOL)InitManyInputBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle vctTips:(NSArray<NSString *> *)vctTips vctMasks:(NSArray<NSString *> *)vctMasks vctDefaults:(NSArray<NSString *> *)vctDefaults;

/**********************************************************
*    功  能：获取多输入框的返回值
*    参  数：无
*    返回值：vector<string> 多输入框输入值的集合
**********************************************************/
+ (NSArray<NSString *> *)GetManyInputBoxWithId:(uint32_t)ID;

//=======2022年08月22日10:47:22=======
/**********************************************************************************
*    功  能：初始化单个ComboBox下拉框控件
*
*    参  数：strTitle        标题文本
*            strTips        下拉框对应的提示文本
*            vctValue        下拉框所有能被选择的值的集合
*            strDefault        默认下拉框被选中的初始值，如果不存在于vctValue中，则认为
*                           vctValue的第一个，如果strDefault为空，下拉框被选中的初始
*                           值也是vctValue的第一个
*
*    返回值：true 初始化成功 false 初始化失败
*
*    说  明：如果vctValue的大小为1，则没有下拉框选择，只是一个不可输入的输入框显示
*            strDefault为下拉框被选中的初始值，如果strDefault为空，下拉框被选中的初始
*            值也是vctValue的第一个
************************************************************************************/
+ (BOOL)InitOneComboBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle strTips:(NSString *)strTips vctValue:(NSArray<NSString *> *)vctValue strDefault:(NSString *)strDefault;

/**********************************************************************************
*    功  能：获取单下拉框ComboBox的内容
*
*    参  数：无
*
*    返回值：string 下拉框ComboBox选择的值
************************************************************************************/
+ (NSString *)GetOneComboBoxWithId:(uint32_t)ID;


/**********************************************************************************
*    功  能：初始化多个ComboBox下拉框控件
*
*    参  数：strTitle        标题文本
*            vctTips        所有下拉框对应的提示文本的集合，一一对应
*            vctValue        所有下拉框对应的所有能被选择的值，一一对应
*            vctDefault        所有下拉框对应的初始值，默认下拉框被选中的初始值，一一对
*                           应,如果不存在于vctValue中，则认为vctValue的第一个，如果
*                           vctDefault为空，下拉框被选中的初始值也是vctValue的第一个
*
*    返回值：true 初始化成功 false 初始化失败
*
*    说  明：如果vctValue的某个元素的大小为1，则其对应的那个下拉框控件没有下拉框选择，
*            只是一个不可输入的输入框显示，vctDefault为下拉框被选中的初始值，如果
*            vctDefault的某个元素为空，则其对应的那个下拉框被选中的初始值也是
*            vctValue对应的第一个值
************************************************************************************/
+ (BOOL)InitManyComboBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle vctTips:(NSArray<NSString *> *)vctTips vctValue:(NSArray<NSArray<NSString *> *> *)vctValue vctDefaults:(NSArray<NSString *> *)vctDefaults;


/**********************************************************************************
*    功  能：获取多个下拉框ComboBox的内容
*
*    参  数：无
*
*    返回值：vector<string> 多下拉框ComboBox选择的值集合
************************************************************************************/
+ (NSArray<NSString *> *)GetManyComboBoxWithId:(uint32_t)ID;

@end

NS_ASSUME_NONNULL_END
