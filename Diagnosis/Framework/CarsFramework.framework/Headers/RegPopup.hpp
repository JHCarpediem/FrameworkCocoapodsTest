#ifndef __REG_POPUP_H__
#define __REG_POPUP_H__
#ifdef __cplusplus
#include <memory>
#include <functional>

class CRegPopup
{
public:
    CRegPopup(){}
    ~CRegPopup(){}
    
public:
   /*
    *   注册CArtiPopup的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiPopup对象时，在CArtiPopup构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiPopup的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    *
    *         例如，CArtiPopup的成员函数SetTitle
    *
    *               C++函数声明为：void SetTitle(const std::string& strTitle);
    *               则app接口函数为：void SetTitle(uint32_t id, const std::string& strTitle);
    *
    *               app 通过id能够判定是哪个CArtiPopup实例调用了 SetTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   注册CArtiPopup的析构函数Destruct的回调函数
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   参数说明    id,    哪个对象调用了析构函数
     *
     *   返回：无
     *
     *   说明： 当C++代码析构一个CArtiPopup对象时，在CArtiPopup的析构
     *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    
    /*
     *   注册CArtiPopup的成员函数InitTitle的回调函数
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle, uint32_t uPopupType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *
     *   其他参数见ArtiPopup.h的说明
     *   InitTitle 函数说明见 ArtiPopup.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&, uint32_t)> fnInitTitle);
    
    
    /*
     *   注册CArtiPopup的成员函数SetTitle的回调函数
     *
     *   void SetTitle(uint32_t id, const std::string& strSetTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiPopup.h的说明
     *
     *   SetTitle 函数说明见 ArtiPopup.h
     */
    static void SetTitle(std::function<void(uint32_t, const std::string&)> fnSetTitle);
    
    
    /*
     *   注册CArtiPopup的成员函数SetContent的回调函数
     *
     *   void SetContent(uint32_t id, const std::string& strContent);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiPopup.h的说明
     *
     *   SetContent 函数说明见 ArtiPopup.h
     */
    static void SetContent(std::function<void(uint32_t, const std::string&)> fnSetContent);
    
    
    /*
     *   注册CArtiPopup的成员函数SetContent的回调函数
     *
     *   void SetPopDirection(uint32_t id, uint32_t uDirection);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiPopup.h的说明
     *
     *   SetContent 函数说明见 ArtiPopup.h
     */
    static void SetPopDirection(std::function<void(uint32_t, uint32_t)> fnSetPopDirection);
    
    
    /*
     *   注册CArtiPopup的成员函数AddButton的回调函数
     *
     *   uint32_t AddButton(uint32_t id, const std::string& strButtonText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiPopup.h的说明
     *
     *   AddButton 函数说明见 ArtiPopup.h
     */
    static void AddButton(std::function<uint32_t(uint32_t, const std::string&)> fnAddButton);

    
    /*
     *   注册CArtiPopup的成员函数SetButtonText的回调函数
     *
     *   void SetButtonText(uint32_t id, uint16_t uIndex, const std::string& strButtonText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiPopup.h的说明
     *
     *   SetButtonText 其它参数和返回值说明见 ArtiPopup.h
     */
    static void SetButtonText(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetButtonText);
    
    
    /*
     *   注册CArtiPopup的成员函数SetColWidth的回调函数
     *
     *   void SetColWidth(uint32_t id, const std::vector<uint32_t>& vctColWidth);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiPopup.h的说明
     *
     *   SetColWidth 函数说明见 ArtiPopup.h
     */
    static void SetColWidth(std::function<void(uint32_t, const std::vector<uint32_t>&)> fnSetColWidth);
    
    
    /*
     *   注册CArtiPopup的成员函数AddItem的回调函数
     *
     *   void AddItemVec(uint32_t id, const std::vector<std::string>& vctItems);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiPopup.h的说明
     *
     *   AddItem 函数说明见 ArtiPopup.h
     *   AddItemVec 映射到ArtiPopup.h是AddItem函数
     */
    static void AddItemVec(std::function<void(uint32_t, const std::vector<std::string>&)> fnAddItem);
    
    
    /*
     *   注册CArtiPopup的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiPopup.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
#endif /* __REG_POPUP_H__ */
