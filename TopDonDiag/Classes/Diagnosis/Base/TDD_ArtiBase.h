//
//  TDD_ArtiBase.h
//  AD200
//
//  Created by 何可人 on 2022/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiBase : NSObject

///创建对象
+ (void)Construct:(uint32_t)ID;

///销毁该对象
+ (void)Destruct:(uint32_t)ID;

/**********************************************************
*    功  能：初始化动作测试控件，同时设置标题文本
*    参  数：strTitle 标题文本
*    返回值：true 初始化成功 false 初始化失败
**********************************************************/
+ (BOOL)InitTitleWithId:(uint32_t)ID strTitle:(NSString *)strTitle;

/**********************************************************
*    功  能：显示动作测试
*    参  数：无
*    返回值：uint32_t 组件界面按键返回值
*        按键：动作测试功能键，返回
**********************************************************/
+ (uint32_t)ShowWithId:(uint32_t)ID;

@end

NS_ASSUME_NONNULL_END
