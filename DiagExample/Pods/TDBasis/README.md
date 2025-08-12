TDBasis
==============

## V4.30 更新日志

* TDLogger 集成 TopdonLog 库
⚠️注意：集成 V4.30 版本的 TDBasis 库后， 如果是用 TDLogger 中的方法打印日志 需要在 APP 中初始化 TopdonLog 库， 否则无法打印信息，日志收集的文件路径为 DDLog 的默认路径

* 4.30.003 更新新增日志在 APP 中可视化调试工具
新增 Api： `TDLogger.isLogDebugViewEnabled` 
此属性只在 DEBUG 环境生效，建议在后门添加开关，设置 开启调试视图。

```swift

    // 显示调试视图 isExpand: 是否直接展开 默认为 false 只显示小图标，点击小图标后展开
    LogDebugView.shared.showLogView(isExpand: false)
    
    // 隐藏调试视图
    LogDebugView.shared.hideLogView()
    
    // 设置这个属性内部回调用显示/隐藏视图 
    TDLogger.isLogDebugViewEnabled = false 
    
    
    /// 设置自定义过滤 item
    /// 诊断项目 默认添加了 AD200蓝牙和 AD200诊断 配合项目打印
    /// eg: `LogDebugView.extraCustomLogLevels.append(.custom(key: "埋点"))`
    /// or: `LogDebugView.extraCustomLogLevels = [.custom(key: "固件升级")]`
    public static var extraCustomLogLevels: [ItemsDataSource.FilterSink] = [.custom(key: "【AD200蓝牙】"),
                                                                            .custom(key: "【AD200诊断】")]                                     
    /// 设置忽略的日志等级
    /// 配合 TDLog 日志打印等级
    /// eg: `LogDebugView.ignoreLogLevels = [.debug, .error]`
    public static var ignoreLogLevels: [ItemsDataSource.FilterSink] = [.warnning]
```

## V4.20.038 更新日志

* LMS 4.50 TDBasis 4.20.038 版本修改 toast 位置
 TDHUD Toast 弹出默认位置 修改为屏幕 2/3 的位置
 
 如果项目需要使用不通的 toast 的位置 可在 `TDHUDConfig` 配置中设置 `toastPosition` 这个枚举
 OC 提供两个函数配置
  
 ```objective-C 
 
     // 设置位置 百分比 2/3
     [TDHUDCOnfig setToastPositionPercent: 0.67];
     
     // 设置位置 top/center/bottom  0: top, 1: center, bottom: 2
     [TDHUDCOnfig setToastPosition: 1];
 
 ```


Topdon iOS 私有基础组件库

由多个子仓库组成 


* [DB](#db-数据库) — Topdon 数据库组件 包含用户信息 `TDUserModel`。
* [Config](#配置-config) — Topdon 配置组件。
* [Extensions](#分类封装-extensions) — Topdon 分类集合。
* [Logger](#日志库-logger) —Topdon 日志组件。
* [UIPackage](#uipackage)  —  Toast/HUD组件

Demo 程序
==============
See `TDBasis/Example`


安装方式
==============

### CocoaPods

1. 在 `podfile` 中添加 `source 'http://172.16.50.23:8081/topdon-app/ios/specs.git'` 私有源
2. 在 `podfile` 中添加 `pod 'TDBasis'`
3. Run `pod install` or `pod update`.

只引用子仓库：
[Logger]: `pod 'TDBasis/Logger'`
[DB]:       `pod 'TDBasis/DB'`
[Config]:  `pod 'TDBasis/Config'`

使用
==============

项目中导入： `import TDBasis`

## DB 数据库 

* TDDBModel 基于FMDB的数据库模型

  有需要进行数据库存储的模型，继承自`TDDBModel`。
  
  使用：

  ```
  class Model: TDDBModel {
    @objc dynamic var name: String = ""

    // 如果需要将数据保存到 Topdon keychain group 只需要在model类中 复写 storeGroupID 属性
    // 这个属性覆写 返回一个groupID 这个模型就会存在 keychain中 可多个项目一起使用访问
    override static var storeGroupID: String {
      return ""
    }
  }

  let model = Model()

  // 数据存储、更新
  model.save()
  model.saveOrUpdate()

  // 数据删除
  model.deleteObject()
  
  // 数据查询
  let models = Model.find(by: "where name='123'")
  let model1 = Model.findFirst(by: "where name='123'")

  ```

* `TDUserModel` 全局用户信息模块 用户信息

  * `TDUserModel.current`: 当前用户 

  * `TDUserModel.isValid`: 当前用户是否是有效 `userId != 0 && !topdonId.isEmpty`

  * `TDUserManager.isLogin`: 当前是否登录
 
  * `TDUserManager.logout()`: 退出登录

  * `TDUserManager.checkLogin(_ completeHandle: (Bool)->Void)`: 检测是否登录、如果未登录将跳转登录页面。登录完成回调handle

    在回调中判断 TDUserManager.isLogin 做后续逻辑处理。


* 加密模块 
  * TDCrypto
  * TDHAESEncryption (兼容老版本加密 AES加密)


## 配置 Config

### Global 

*  屏幕尺寸相关

    ```

    UI.xxx

    // 屏幕宽度
    UI.SCREEN_WIDTH
    // 屏幕高度
    UI.SCREEN_HEIGHT
    // 导航栏 + 状态栏高度
    UI.STATUS_NAV_BAR_HEIGHT
    // 获取当前控制器
    UI.topViewController
    ...

    ```

* Block 结构体 快捷创建 Swift的block
  1. `Block.VoidBlock` 不带参数、没有返回值的block
  2. `Block.ParameterBlock<type>` 带一个参数、没有返回值的block
  3. `Block.MutiParameterBlock<type1, type2>` 带两个参数、没有返回值的block
  4. `Block.ReturnBlock<type>` 没有参数，有返回值的block




* SandBox 结构体
快捷获取沙盒路劲、根据子路径获取全路径

    ```
    // document path 
    let documentPath = Sandbox.documentPath

    // cache path 
    let cachePath = Sandbox.cachePath

    // temp path 
    let tempPath = Sandbox.tempPath

    // 根据子路径获取 全路径 可控制是否创建文件夹
    let documentPath = Sandbox.document(with: subPath, createDir: true) 
    let cachePath = Sandbox.cache(with: subPath, createDir: false)

    ```

* `AppInfo` 结构体

  获取App 通用信息



* UIDevice 拓展

  快捷获取设备信息： 手机总存储空间、可用空间、手机型号、可用内存、CPU型号、CPU核数、手机当前IP

  ```
  UIDevice.freeDiskSpace  // 手机总存储空间
  UIDevice.totalDiskSpace // 可用空间
  ...
  ```

* `TDLanguage` 获取APP当前语言

    ```

    // OC 
    NSString *lan = TDLanguage.currentLanguage;  
    // Swift 
    let lan = TDLanguage.current

    // 多语言对应的 LocalStrings的proj 
    let lanStr = lan.stringValue 
    let lanStr1 = lan.lproj 
    // lanStr == lanStr1 这两种方式获取的值一致

    // 服务器语言ID
    let serverId = lan.serverId
    // 获取服务器语言code
    let serverCode = lan.serverCode

    // 通过服务器ID创建 TDLanguage 
    let serverId = 1
    let lan1 = TDLanguage(rawValue: serverId) ?? .en 


    ```

## 分类封装  Extensions

Topdon 分类采用 `td` 作为命名空间

`OC`中命名规范 ： `[NSString td_xxx];`

`swift`中命名规范：`String.td.xxx` 

更多拓展: [Api](Extension.md)

## 日志库 Logger

日志打印分级别：

Level:  `Debug` 、`Warnning` 、 `Error` 、`Custom`

使用：

`TDLogDebug(xxx)` 

`TDLogError(xxx)`

`TDLogWarnning(xxx)`

## UIPackage
UIPackage 封装了 `Toast` 和 `HUD`加载控件

```
// 屏幕中间的提示 Toast 
TDHUD.show(message)
// 屏幕底部的提示 Toast 
TDHUD.toast(message)
// loading
TDHUD.showLoading()
// hide loading 
TDHUD.hideLoading()

// 自定义toast
static func show(with title: String? = nil,
                message: String?,
                image: UIImage? = nil,
                inView: UIView? = nil,
                duration: TimeInterval = 1.5,
                position: ToastPosition = .center,
                style: ToastStyle? = nil) 
{
  
}
```


Requirements
==============
This library requires `iOS 10.0+` and `Xcode 10.0+`.

License
==============
TDBasis is provided under the MIT license. See LICENSE file for details.


