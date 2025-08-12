<br/>

TDNetwork
==============

Topdon iOS 网络组件库

由多个子模块组成 
- [Download](#下载库-资源下载库) - 资源下载、车型下载 支持断点续传、后台下载、url参数签名
- [NetworkConfig](#networkconfig---配置) — 网络配置。
- [NetworkManager](#networkmanager) — 网络请求管理类集合。
- [NetworkResult](#tdnetworkresult-网络请求结果-response) — 网络请求`Response`序列化。

Demo 程序
==============

See `TDNetwork/Example`

安装方式
==============

### CocoaPods

1. 在 `podfile` 中添加 `source 'http://172.16.50.23:8081/topdon-app/ios/specs.git'` 私有源
2. 在 `podfile` 中添加 `pod 'TDNetwork'`
3. Run `pod install` or `pod update`.

使用
==============
项目中导入： `import TDNetwork`


## NetworkConfig - 配置 

* 使用 `TDNetworkConfig.default` 进行网络配置

    ``` swift
    // 配置
    // oc
    TDNetworkConfig *config = [TDNetworkConfig default];

    // swift
    TDNetworkConfig.default.timeout = 30;
    ```

* 自定义服务器域名 库里默认集成TopScan域名，如项目需要自定义域名， 请参考以下方式：

    1. 自定义 NetworkEnvironment 类，遵循 `TDNetworkEnvironmentProvider` 协议，实现协议中的方法 返回配置域名
    
    ```swift
    public class NetworkEnvironment: NSObject, TDNetworkEnvironmentProvider {
    
        static let shared = NetworkEnvironment()
        
        /// 发布环境
        public var distribute: TDNetworkEnvironmentModel {
            TDNetworkEnvironmentModel(environmentType: .distribute, url: "https://carpal.topdon.com/topdon-plat")
        }
        
        /// 预发布环境
        public var preDistribute: TDNetworkEnvironmentModel {
            TDNetworkEnvironmentModel(environmentType: .preDistribute, url: "https://api.topdon.com")
        }
        
        /// 开发环境
        public var development: TDNetworkEnvironmentModel {
            TDNetworkEnvironmentModel(environmentType: .development, url: "http://devapi.topdon.top:8012")
        }

        /// 测试环境
        public var test: TDNetworkEnvironmentModel {
            TDNetworkEnvironmentModel(environmentType: .test, url: "http://api.topdon.top:8022")
        }
        
        /// 自定义环境
        public func custom(with url: String) -> TDNetworkEnvironmentModel {
            TDNetworkEnvironmentModel(environmentType: .custom, url: url)
        }
    }
    
    ```
    
    2. 设置 TDNetworkConfig 的 networkEnvironment
    
    ```swift
         // 配置自定义的域名 一般在APP delegate中设置
         TDNetworkConfig.networkEnvironment = NetworkEnvironment.shared
         // 手动设置当前的环境 如不设置 默认为 `distribute` 生产环境
         TDNetworkConfig.currentEnviornment = NetworkEnvironment.shared.distribute
    ```

* 后门跳转设置网络 

    引用LMSUI库, 跳转到 `LMSNetworkSettingViewController` 控制器
     
     


## NetworkManager 

* `TDNetworking`: 网络请求类 
* `TDNetworkManager`: 网络请求代理、处理所有往前请求的回调使用
* `TDNetworkStatusManager`: 网络状态管理类 

### 接口请求、下载、上传

接口请求Api为: `TDNetworking`，调用方式： `TDNetworking.shared.post(...)` or `TDNetworking.shared.get(...)`

也可以直接使用: `NSObject.network.post(...)`，`model `继承自 `NSObject`可以使用 model 的类名直接请求

内部会将服务器返回的数据解析成当前 `Model`，保存在 `response` 的 `result` 属性中

eg:

```swift
TDUserModel.network.post(urlString: TDNetworkApi.login, parameters: parameters, shouldToken: false, headers: ["Authoration": "basic ....."], isSignParameters: true) { response in 
    guard let userModel = response.result as? TDUserModel else {
        return 
    }

    let userName = userModel.userName
    ...

 }
```


```objectivec

NSString *api = @"api/v1/msg/msgSendLog/getMsgapi/v1/msg/msgSendLog/getMsg";
[[TDNetworking shared] baseRequestWith: api method: "POST" parameters: @{@"":@""} isSignParamers: YES retryCount: 3 finish: ^(TDNetworkResponse * result){
  
}];

// 直接使用 Post
[[TDNetworking shared] postWithUrl: url parameters: parameters modelClass:nil headers: nil isSignParameters: false shouldToken: true isSilence: false finished: ^(TDNetworkResponse *result) {

}];

```

```swift

/// 发起网络请求 这个方法通常在内部使用 
/// - Parameters:
///   - urlString: 请求连接 可不需要baseURL 内部会拼接
///   - method: 请求方法 post get 默认：post
///   - paramaters: 请求参数
///   - isSignParamers: 参数是否需要签名 默认：false
///   - retryCount: 重试次数 默认: 3次
///   - isSilence: 是否静默toast错误提示 默认: false (会提示)
///   - finished: 完成回调
public func baseRequest(`with` urlString: String,
                        method: Alamofire.HTTPMethod = .post,
                        paramaters: Alamofire.Parameters? = nil,
                        modelClass: AnyClass? = nil,
                        headers: HTTPHeaders? = nil,
                        isSignParamers: Bool = false,
                        retryCount: UInt? = nil,
                        shouldToken: Bool = true,
                        isSilence: Bool = false,
                        _ finished: TDCompleteHandle? = nil)  -> DataRequest? 

/// 发起`get`请求
/// - Parameters:
///   - urlString: 请求路径 见`TDNetworkApi`
///   - parameters: 参数字典
///   - headers: `Httpheaders` 请求头
///   - isSignParameters: 是否需要对参数签名
///   - shouldToken: 是否需要`token`
///   - finished: 完成回调
/// - Returns: 返回 `sessionTask`
public func get(urlString: String,
                parameters: [String: Any]? = nil,
                modelClass: AnyClass? = nil,
                headers: [String: String]? = nil,
                isSignParameters: Bool = false,
                shouldToken: Bool = true,
                isSilence: Bool = false,
                _ finished: TDCompleteHandle?) -> URLSessionTask?


/// 发起`Post`请求
/// - Parameters:
///   - urlString: 请求路径 见`TDNetworkApi`
///   - parameters: 参数字典
///   - headers: `Httpheaders` 请求头
///   - isSignParameters: 是否需要对参数签名
///   - shouldToken: 是否需要`token`
///   - finished: 完成回调
/// - Returns: 返回 `sessionTask`
public func post(urlString: String,
                    parameters: [String: Any]? = nil,
                    modelClass: AnyClass? = nil,
                    headers: [String: String]? = nil,
                    isSignParameters: Bool = false,
                    shouldToken: Bool = true,
                    isSilence: Bool = false,
                    _ finished: TDCompleteHandle?) -> URLSessionTask?
```

### 下载任务
下载资源可使用 [Download](#下载库-资源下载库) 库，这里的下载只做最基础的下载。

```objectivec
// OC 
NSString *url = @"资源地址";
[[TDNetworking shared] downloadWith: url method: @"Post" parameters: nil progressHandle: ^(Progress *progress){
  
} compeleteHandle: ^(TDNetworkResult * result) {
  
}];
```

```swift
 
// swift
TDNetworking.shared.download(with: url, parameters: nil) { progress in // 下载进度回调 
            // progress.totalUnitCount     资源总大小
            // progress.completedUnitCount 已完成大小
        } resumeHandel: { data in  // 做断点续传用
            
        } comppleteHandle: { complete, error in  // 完成回调 返回资源目录 URL 或者 失败error
            
        }
```

### 上传任务

```swift

@objc(uploadFileWithFilePath:to:parameters:shouldToken:isSilence:progressHandle:completeHandle:)
/// 上传文件
/// - Parameters:
///   - filePath: 文件路径
///   - urlString: 上传url地址
///   - parameters: 上传参数 拼接到 mutilpaData中
///   - shouldToken: 是否需要Token
///   - isSilence: 是否静默上传
///   - progressHandle: 进度回调
///   - completeHandle: 完成回调
public func uploadFile(filePath: String,
                        to urlString: String,
                        parameters: Parameters? = nil,
                        shouldToken: Bool = true,
                        isSilence: Bool = false,
                        progressHandle: ((Progress) -> Void)? = nil,
                        completeHandle: ((TDNetworkResponse) -> Void)? = nil) {}

TDNetworking.shared.upload(fileURL: "本地资源路径", to: "服务器地址") { progress in
            // progress.totalUnitCount     资源总大小
            // progress.completedUnitCount 已完成大小
        } completeHandle: { complete in
            // complete： TDNetworkResponse
        }
        
// 上传资源文件 外部拼接 mutipartFromData 
TDNetworking.shared.upload(to: url) { multipartFormData in
            
        } progressHandle: { progress in
            
        } completeHandle: { complete in
            
        }

```

### TDNetworkResult 网络请求结果 response 

* `TDNetworkResponse`: 请求回调结果类

    Topdon 所有网络请求遵循统一协议, 网络请求回调会返回 `TDNetworkResponse`对象，通过判断 `response.Code.isSuccess`来决议请求是否成功，
    所有的数据解析成 `Object` 后会存放在 `respnse.data` 中, `response.data` 一般为字典。或者在请求时传入 `modelClass` 让请求内部自动将原始数据解析成想要的模型数据，从 `response.result` 中取出 `Model`.





## 下载库 资源下载库

适配车型资源中，签名参数在url中，带有时效性的连接。

* `SessionManager`: 下载管理类
* `DownloadTask`: 下载任务
* `Cache`: 下载文件管理

### 使用方法：

1. 创建 `SessionManager` 

    ```
    let identify = "xxx"
    var config = TDNetwork.SessionConfiguration()
    config.allowsCellularAccess = true
    config.maxConcurrentTasksLimit = 3

    let path = Sandbox.document(with: "TD/\(AppInfo.bundleName)/\(identify)/Download")

    // 下载的目录
    let cache = TDNetwork.Cache(identify, downloadPath: path)

    let manager = TDNetwork.SessionManager(identify, configuration: config, cache: cache)
    ```

2. 创建下载任务 开始下载

    支持断点续传，后台下载，无需任何处理，只需调用 `download` 方法，传入下载url地址，每个url地址生成独立的下载任务，保留在本地。下载调用下载会断点续传。

     ```swift
    // 一行代码实现下载
    let url = "http://xxxxx"
    let task = manager.download(url)
    
    task?.progress(onMainQueue: true) { (task) in
        let progress = task.progress.fractionCompleted
        print("下载中, 进度：\(progress)")
    }.success { (task) in
        print("下载完成")
    }.failure { (task) in
        print("下载失败")
    }
    
    // 下载暂停
    manager.suspend(url)
    
    // 取消下载
    manager.cancel(url)
    
    // 移除下载任务 如果需要清空已下载的资源，completely 传入true 
    manager.remove(url, completely: true)

    ```

3. 后台任务处理 

    实现AppDelegate 方法`handleEventsForBackgroundURLSession`

    ```swift
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        if identifier == manager?.identifier {
            manager?.completionHandler = completionHandler
        }
    }
    ```

<br/>

# Requirements

This library requires `iOS 10.0+` and `Xcode 10.0+`.

License
==============

TDBasis is provided under the MIT license. See LICENSE file for details.
