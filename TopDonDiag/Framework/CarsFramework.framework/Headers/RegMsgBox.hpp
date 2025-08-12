#ifndef __REG_MSG_BOX_H__
#define __REG_MSG_BOX_H__
#ifdef __cplusplus
#include <memory>
#include <functional>
#include "HStdShowMaco.h"
#include "HStdOtherMaco.h"
class CRegMsgBox
{
public:
    CRegMsgBox(){}
    ~CRegMsgBox(){}
    
public:
    /*
     注册全局函数artiShowMsgBox的回调函数
     
     uint32_t artiShowMsgBox(const std::string& strTitle,
                             const std::string& strContent,
                             uint32_t uButton = DF_MB_OK,
                             uint16_t uAlignType = DT_CENTER,
                             int32_t iTimer = -1);
     
     全局函数artiShowMsgBox参数说明和返回值说明，见ArtiMsgBox.h
     
     */
    static void artiShowMsgBox(std::function<uint32_t(const std::string&, const std::string&, uint32_t, uint16_t, int32_t)> fnArtiShowMsgBox);
    
    /*
     注册全局函数artiShowMsgBox的回调函数
     
    uint32_t artiShowMsgBox(uint32_t uType,
                            const string& strTitle = "",
                            const string& strContent = "",
                            uint32_t uButton = DF_MB_OK,
                            uint16_t uAlignType = DT_CENTER);
     
     全局函数artiShowMsgBox参数说明和返回值说明，见ArtiMsgBox.h
     
     */
    static void artiShowTypeMsgBox(std::function<uint32_t(uint32_t, const std::string&, const std::string&, uint32_t, uint16_t)> fnArtiShowTypeMsgBox);

    /*
     注册全局函数 artiMsgBoxActTest 的回调函数
     
     uint32_t artiMsgBoxActTest(const std::string& strTitle,
                                const std::string& strContent,
                                uint32_t uButton,
                                uint32_t uTestType,
                                uint32_t uRpm = -1,
                                uint32_t uCountDown = -1);
     
     全局函数 artiMsgBoxActTest 参数说明和返回值说明，见ArtiMsgBox.h
     */
    static void artiMsgBoxActTest(std::function<uint32_t(const std::string&, const std::string&, uint32_t, uint32_t, uint32_t, uint32_t)> fnartiMsgBoxActTest);
    
    /*
     注册全局函数 artiShowAdasStep 的回调函数
     
     uint32_t artiShowAdasStep(uint32_t uStep);
     
     全局函数 artiShowAdasStep 参数说明和返回值说明，见ArtiMsgBox.h
     */
    static void artiShowAdasStep(std::function<uint32_t(uint32_t)> fnartiShowAdasStep);
    
    /*
     注册全局函数 artiShowMsgBoxDs 的回调函数

     uint32_t artiShowMsgBoxDs(uint32_t uType,const std::string& strSysName, const std::vector<stDsReportItem>& vctItem);

     全局函数 artiShowMsgBoxDs 参数说明和返回值说明，见ArtiMsgBox.h
     */
    static void artiShowMsgBoxDs(std::function<uint32_t(uint32_t, const std::string&, const std::vector<stDsReportItem>&)> fnartiShowMsgBoxDs);
    
    /*
     注册全局函数 artiShowMsgGroup 的回调函数

     uint32_t artiShowMsgGroup(uint32_t uType, const std::string& strTitle, const std::vector<stMsgItem>& vctItem);

     全局函数 artiShowMsgGroup 参数说明和返回值说明，见ArtiMsgBox.h
     */
    static void artiShowMsgGroup(std::function<uint32_t(uint32_t, const std::string&, const std::vector<stMsgItem>&)> fnartiShowMsgGroup);
    
    /*
     注册全局函数 artiShowSpecial 的回调函数
     
     uint32_t artiShowSpecial(uint32_t uType);
     
     全局函数 artiShowSpecial 参数说明和返回值说明，见ArtiMsgBox.h
     */
    static void artiShowSpecial(std::function<uint32_t(uint32_t)> fnartiShowSpecial);
    
    
   /*
    *   注册CArtiMsgBox的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiMsgBox对象时，在CArtiMsgBox构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiMsgBox的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    *
    *         例如，CArtiMsgBox的成员函数SetTitle
    *
    *               C++函数声明为：void SetTitle(const std::string& strTitle);
    *               则app接口函数为：void SetTitle(uint32_t id, const std::string& strTitle);
    *
    *               app 通过id能够判定是哪个CArtiMsgBox实例调用了 SetTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   注册CArtiMsgBox的析构函数Destruct的回调函数
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   参数说明    id,    哪个对象调用了析构函数
     *
     *   返回：无
     *
     *   说明： 当C++代码析构一个CArtiMsgBox对象时，在CArtiMsgBox的析构
     *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    
    /*
     *   注册CArtiMsgBox的成员函数InitMsgBox的回调函数
     *
     *   bool InitMsgBox(uint32_t id, const std::string& strTitle, const std::string& strContent, uint32_t uButtonType = DF_MB_OK,
     *                   uint16_t uAlignType = DT_CENTER, int32_t iTimer = -1);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *
     *   其他参数见ArtiMsgBox.h的说明
     *   InitMsgBox 函数说明见 ArtiMsgBox.h
     */
    static void InitMsgBox(std::function<bool(uint32_t, const std::string&, const std::string&, uint32_t, uint16_t, int32_t)> fnInitMsgBox);
    
    /*
     *   注册CArtiMsgBox的成员函数SetTitle的回调函数
     *
     *   void SetTitle(uint32_t id, const std::string& strSetTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   SetTitle 函数说明见 ArtiMsgBox.h
     */
    static void SetTitle(std::function<void(uint32_t, const std::string&)> fnSetTitle);
    
    /*
     *   注册CArtiMsgBox的成员函数SetContent的回调函数
     *
     *   void SetContent(uint32_t id, const std::string& strContent);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   SetContent 函数说明见 ArtiMsgBox.h
     */
    static void SetContent(std::function<void(uint32_t, const std::string&)> fnSetContent);
    
    /*
     *   注册CArtiMsgBox的成员函数AddButton的回调函数
     *
     *   void AddButton(uint32_t id, const std::string& strButtonText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   AddButton 函数说明见 ArtiMsgBox.h
     */
    static void AddButton(std::function<void(uint32_t, const std::string&)> fnAddButton);
    
    /*
     *   注册CArtiMsgBox的成员函数AddButtonEx的回调函数
     *
     *   uint32_t AddButtonEx(uint32_t id, const std::string& strButtonText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   AddButton 函数说明见 ArtiMsgBox.h
     */
    static void AddButtonEx(std::function<uint32_t(uint32_t, const std::string&)> fnAddButtonEx);

    /*
     *   注册CArtiMsgBox的成员函数DelButton的回调函数
     *
     *   bool DelButton(uint32_t id, uint32_t uButtonId);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   DelButton 其它参数和返回值说明见 ArtiMsgBox.h
     */
    static void DelButton(std::function<bool(uint32_t, uint32_t)> fnDelButton);

    /*
     *   注册CArtiMsgBox的成员函数SetButtonType的回调函数
     *
     *   void SetButtonType(uint32_t id, uint32_t uButtonTyp);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   SetButtonType 其它参数和返回值说明见 ArtiMsgBox.h
     */
    static void SetButtonType(std::function<void(uint32_t, uint32_t)> fnSetButtonType);

    /*
     *   注册CArtiMsgBox的成员函数SetButtonStatus的回调函数
     *
     *   void SetButtonStatus(uint32_t id, uint16_t uIndex, uint32_t uStatus);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   SetButtonStatus 其它参数和返回值说明见 ArtiMsgBox.h
     */
    static void SetButtonStatus(std::function<void(uint32_t, uint16_t, uint32_t)> fnSetButtonStatus);

    /*
     *   注册CArtiMsgBox的成员函数SetButtonText的回调函数
     *
     *   void SetButtonText(uint32_t id, uint16_t uIndex, const std::string& strButtonText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   SetButtonText 其它参数和返回值说明见 ArtiMsgBox.h
     */
    static void SetButtonText(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetButtonText);
    
    /*
     *   注册CArtiMsgBox的成员函数GetButtonText的回调函数
     *
     *   const std::string GetButtonText(uint32_t id, uint32_t uButtonID);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   GetButtonText 其它参数和返回值说明见 ArtiMsgBox.h
     */
    static void GetButtonText(std::function<const std::string(uint32_t, uint32_t)> fnGetButtonText);
    
    /*
     *   注册CArtiMsgBox的成员函数SetAlignType的回调函数
     *
     *   void SetAlignType(uint32_t id, uint16_t uAlignType);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   SetAlignType 其它参数和返回值说明见 ArtiMsgBox.h
     */
    static void SetAlignType(std::function<void(uint32_t, uint16_t)> fnSetAlignType);

    /*
     *   注册CArtiMsgBox的成员函数SetTimer的回调函数
     *
     *   void SetTimer(uint32_t id, int32_t iTimer);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   SetTimer 其它参数和返回值说明见 ArtiMsgBox.h
     */
    static void SetTimer(std::function<void(uint32_t, int32_t)> fnSetTimer);

    /*
     *   注册CArtiMsgBox的成员函数SetBusyVisible的回调函数
     *
     *   void SetBusyVisible(uint32_t id, bool bIsVisible);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   SetBusyVisible 其它参数和返回值说明见 ArtiMsgBox.h
     */
    static void SetBusyVisible(std::function<void(uint32_t, bool)> fnSetBusyVisible);

    /*
     *   注册CArtiMsgBox的成员函数SetProcessBarVisible的回调函数
     *
     *   void SetProcessBarVisible(uint32_t id, bool bIsVisible);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   SetProcessBarVisible 其它参数和返回值说明见 ArtiMsgBox.h
     */
    static void SetProcessBarVisible(std::function<void(uint32_t, bool)> fnSetProcessBarVisible);

    /*
     *   注册CArtiMsgBox的成员函数SetProgressBarPercent的回调函数
     *
     *   void SetProgressBarPercent(uint32_t id, int32_t iCurPercent, int32_t iTotalPercent);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiMsgBox.h的说明
     *
     *   SetProgressBarPercent 其它参数和返回值说明见 ArtiMsgBox.h
     */
    static void SetProgressBarPercent(std::function<void(uint32_t, int32_t, int32_t)> fnSetProgressBarPercent);
    
    /*
     *   注册CArtiMsgBox的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiMsgBox.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
#endif /* __REG_MSG_BOX_H__ */
