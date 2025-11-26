#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

// 图片显示组件

class CRegPicture
{
public:
    CRegPicture();
    ~CRegPicture();
    
public:
   /*
    *   注册CArtiPicture的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiPicture对象时，在CArtiPicture构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiPicture的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    *
    *         例如，CArtiPicture的成员函数InitTitle
    *
    *               C++函数声明为：void InitTitle(const std::string& strTitle);
    *               则app接口函数为：void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app 通过id能够判定是哪个CArtiPicture实例调用了 InitTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   注册CArtiPicture的析构函数Destruct的回调函数
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   参数说明    id,    哪个对象调用了析构函数
     *
     *   返回：无
     *
     *   说明： 当C++代码析构一个CArtiPicture对象时，在CArtiPicture的析构
     *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   注册CArtiPicture的成员函数InitTitle的回调函数
     *
     *   void InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiPicture.h的说明
     *
     *   InitTitle 函数说明见 ArtiPicture.h
     */
    static void InitTitle(std::function<void(uint32_t, const std::string&)> fnInitTitle);
    
    /*
     *   注册CArtiPicture的成员函数AddButton的回调函数
     *
     *   uint32_t AddButton(uint32_t id, const std::string& strButtonText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiPicture.h的说明
     *
     *   AddButton 函数说明见 ArtiPicture.h
     */
    static void AddButton(std::function<uint32_t(uint32_t, const std::string&)> fnAddButton);
    
    
    /*
     *   注册CArtiPicture的成员函数AddPicture的回调函数
     *
     *   uint32_t AddPicture(uint32_t id, const std::string& strPicturePath, const std::string& strBottomTips);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiPicture.h的说明
     *
     *   AddPicture 函数说明见 ArtiPicture.h
     */
    static void AddPicture(std::function<uint32_t(uint32_t, const std::string&, const std::string&)> fnAddPicture);
    
    
    /*
     *   注册CArtiPicture的成员函数AddTopTips的回调函数
     *
     *   void AddTopTips(uint32_t id, uint32_t uiPictID, const std::string& strTopTips, eFontSize eSize, eBoldType eBold));
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiPicture.h的说明
     *
     *   AddTopTips 函数说明见 ArtiPicture.h
     */
    static void AddTopTips(std::function<void(uint32_t, uint32_t, const std::string&, uint32_t, uint32_t)> fnAddTopTips);

    
    /*
     *   注册CArtiPicture的成员函数AddText的回调函数
     *
     *   void AddText(uint32_t id, const std::string& strText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiPicture.h的说明
     *
     *   AddText 函数说明见 ArtiPicture.h
     */
    static void AddText(std::function<void(uint32_t, const std::string&)> fnAddText);
    
    
    /*
     *   注册CArtiPicture的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiPicture.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
