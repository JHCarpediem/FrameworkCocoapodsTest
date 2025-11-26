#ifndef __StdShow_h__
#define __StdShow_h__
#ifdef __cplusplus
#include <string>
#include <vector>

class __attribute__ ((visibility ("default"))) CStdShow
{
public:
    CStdShow(){}
    ~CStdShow(){}
    
public:
    /* 显示接口初始化函数，加载此模块的时候调用（应用初始化libstdshow.a） */
    static void Init();
    
    
    /* 退出此模块的时候调用，一般不需要调用 */
    static void DeInit();
    
    
    /* bFlag, true, 使能 printf */
    /* bFlag, false, 关闭 printf */
    static void EnableLogcat(bool bFlag);
    
    /*
        获取libstdshow.a版本号
        返回，例如: "May 18 2022 V1.08"
     */
    static std::string const Version();
    
    // SetRpcRecv
    // App将收到算法服务器返回的数据传给stdshow接口
    // SetRpcRecv接口是RpcSend接口的返回
    //
    // App在stdshow接口调用了"RpcSend"后，会将算法数据发送给算法服务器
    // 参考"平台API文档V1.0.34.doc"中“APP调用接口指派后台给算法服务器发信息”
    // 可能的服务器请求地址是api/client/sendAlgorithmInformation
    // 可能的服务器请求地址是api/client/queryAlgorithmResult/1
    // App在收到算法服务器返回的算法运算结果后，通过此接口将结果返回给stdshow接口
    //
    // Code                 服务器返回的结果，0成功，非0失败
    // strMsg               返回提示信息，服务如果没有返回提示信息，则为空
    // algorithmData        服务器返回的算法数据结果
    //
    // 返回值               无
    //
    // stdshow在调用了RpcSend接口后，会一直等待App的返回，直到App调用了SetRpcRecv接口
    /*
    *   void SetRpcRecv(int Code, String strMsg, byte[] algorithmData);
    *
    *   说明：此接口非阻塞，App调用stdshow，App将收到的服务器返回的算法数据结果
    *         传给stdshow
    */
    static void SetRpcRecv(uint32_t Code, const std::string& strMsg, const std::vector<uint8_t> &vctAlgorithm);
    
    // SetFcaAdInitRecv
    // APK将收到服务器返回的FCA数据传给SO
    // SetFcaAdInitRecv接口是FcaAuthDiagInit接口的返回
    //
    // Code        公司服务器返回的错误代码 "code"，例如"200"
    // Msg         公司服务器返回的描述 "msg"，例如"User authentication failed!"
    // OemInit     FCA返回，OEM特定的初始化缓冲区,对于FCA，这是AuthDiag证书
    // SessionID   FCA返回，Must be used in subsequent AuthDiag requests
    // SnApi       标记接口序号是否对应，要求App返回的值，保持与FcaInitSend收到的值一致
    //             即标记SetFcaAdInitRecv与FcaInitSend是成对的
    //             诊断调用FcaAuthDiagInit一次，此值加一，从0开始循环到0xFFFF后又从0开始
    //             诊断对此参数不可见
    //
    // 返回值               无
    //
    // SO在调用了FcaInitSend接口后，会一直等待APK的返回，直到APK调用了SetFcaAdInitRecv接口
    static void SetFcaAdInitRecv(const std::string& Code, const std::string& Msg, const std::string& OemInit, const std::string& SessionID, uint32_t SnApi);

    // SetFcaAdRequestRecv
    // APK将收到服务器返回的FCA数据传给SO
    // SetFcaAdRequestRecv接口是FcaAuthDiagRequest接口的返回
    //
    // Code         公司服务器返回的错误代码 "code"，例如"200"
    // Msg          公司服务器返回的描述 "msg"，例如"User authentication failed!"
    // strChallenge FCA返回，SGW Challenge Response（Base64）
    // SnApi        标记接口序号是否对应，要求App返回的值，保持与FcaRequestSend收到的值一致
    //              即标记SetFcaAdRequestRecv与FcaRequestSend是成对的
    //              诊断调用FcaAuthDiagRequest一次，此值加一，从0开始循环到0xFFFF后又从0开始
    //              诊断对此参数不可见
    //
    // 返回值               无
    //
    // SO在调用了FcaRequestSend接口后，会一直等待APK的返回，直到APK调用了SetFcaAdRequestRecv接口
    static void SetFcaAdRequestRecv(const std::string& Code, const std::string& Msg, const std::string& Challenge, uint32_t SnApi);
    
    // SetFcaAdTrackRecv
    // APK将收到服务器返回的FCA数据传给SO
    // SetFcaAdTrackRecv接口是FcaAuthDiagTrackResp接口的返回
    //
    // Code         公司服务器返回的错误代码 "code"，例如"200"
    // Msg          公司服务器返回的描述 "msg"，例如"User authentication failed!"
    // Success      FCA返回，In case of success, true（Base64），例如"true"
    // SnApi        标记接口序号是否对应，要求App返回的值保持与FcaTrackSend收到的值一致
    //              即标记SetFcaAdTrackRecv与FcaTrackSend是成对的
    //              诊断调用FcaAuthDiagTrackResp一次，此值加一，从0开始循环到0xFFFF后又从0开始
    //              诊断对此参数不可见
    //
    // 返回值       无
    //
    // SO在调用了FcaTrackSend接口后，会一直等待APK的返回，直到APK调用了SetFcaAdTrackRecv接口
    static void SetFcaAdTrackRecv(const std::string& Code, const std::string& Msg, const std::string& Success, uint32_t SnApi);
    
    // 用于.a库测试数据是否通畅
    static void DataTest();
    
public:
    static inline bool m_bLogcatEnable = false;
    static inline bool m_bLogFileEnable = false;
};


#endif
#endif /* __StdShow_h__ */
