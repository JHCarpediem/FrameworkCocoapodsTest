#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>
#include "HStdOtherMaco.h"

class CRegList
{
public:
    CRegList() = delete;
    ~CRegList() = delete;
    
public:
    /*
    *   注册CArtiList的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiList对象时，在CArtiList构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiList的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   注册CArtiList的析构函数Destruct的回调函数
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   参数说明    id,    哪个对象调用了析构函数
    *
    *   返回：无
    *
    *   说明： 当C++代码析构一个CArtiList对象时，在CArtiList的析构
    *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   注册CArtiList的成员函数InitTitle的回调函数
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   CArtiList 函数说明见 ArtiList.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);
    
    /*
     *   注册CArtiList的成员函数InitTitle的回调函数
     *
     *   void InitTitleType(uint32_t id, const std::string& strTitle, uint32_t Type);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   InitTitle 函数说明见 ArtiList.h
     *   InitTitleType映射到ArtiList.h是InitTitle
     */
    static void InitTitleType(std::function<bool(uint32_t, const std::string&, uint32_t)> fnInitTitle);
    
    /*
     *   注册CArtiList的成员函数SetColWidth的回调函数
     *
     *   void SetColWidth(uint32_t id, const std::vector<int32_t>& vctColWidth);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetColWidth 函数说明见 ArtiList.h
     */
    static void SetColWidth(std::function<void(uint32_t, const std::vector<int32_t>&)> fnSetColWidth);

    /*
     *   注册CArtiList的成员函数SetHeads的回调函数
     *
     *   void SetHeads(uint32_t id, const std::vector<std::string>& vctHeadNames);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetHeads 函数说明见 ArtiList.h
     */
    static void SetHeads(std::function<void(uint32_t, const std::vector<std::string>&)> fnSetHeads);
    
    /*
     *   注册CArtiList的成员函数SetTipsOnTop的回调函数
     *
     *   void SetTipsOnTop(uint32_t id, const std::string& strTips, uint32_t uAlignType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetTipsOnTop 函数说明见 ArtiList.h
     */
    static void SetTipsOnTop(std::function<void(uint32_t, const std::string&, uint32_t)> fnSetTipsOnTop);
    
    /*
     *   注册CArtiList的成员函数SetTipsTitleOnTop的回调函数
     *
     *   void SetTipsTitleOnTop(uint32_t id, const std::string& strTips, uint32_t uAlignType, eFontSize eSize, eBoldType eBold);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetTipsTitleOnTop 函数说明见 ArtiList.h
     */
    static void SetTipsTitleOnTop(std::function<void(uint32_t, const std::string&, uint32_t, uint32_t, uint32_t)> fnSetTipsTitleOnTop);

    /*
     *   注册CArtiList的成员函数SetTipsOnBottom的回调函数
     *
     *   void SetTipsOnBottom(uint32_t id, const std::string& strTips);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetTipsOnBottom 函数说明见 ArtiList.h
     */
    static void SetTipsOnBottom(std::function<void(uint32_t, const std::string&)> fnSetTipsOnBottom);
    
    /*
     *   注册CArtiList的成员函数SetBlockStatus的回调函数
     *
     *   void SetBlockStatus(uint32_t id, bool bIsBlock);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetBlockStatus 函数说明见 ArtiList.h
     */
    static void SetBlockStatus(std::function<void(uint32_t, bool)> fnSetBlockStatus);

    /*
     *   注册CArtiList的成员函数AddButton的回调函数
     *
     *   void AddButton(uint32_t id, const std::string& strButtonText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   AddButton 函数说明见 ArtiList.h
     */
    static void AddButton(std::function<void(uint32_t, const std::string&)> fnAddButton);
    
    /*
     *   注册CArtiList的成员函数AddButtonEx的回调函数
     *
     *   uint32_t AddButtonEx(uint32_t id, const std::string& strButtonText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   AddButton 函数说明见 ArtiList.h
     */
    static void AddButtonEx(std::function<uint32_t(uint32_t, const std::string&)> fnAddButtonEx);

    /*
     *   注册CArtiList的成员函数DelButton的回调函数
     *
     *   bool DelButton(uint32_t id, uint32_t uButtonId);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   DelButton 其它参数和返回值说明见 ArtiList.h
     */
    static void DelButton(std::function<bool(uint32_t, uint32_t)> fnDelButton);

    /*
     *   注册CArtiList的成员函数SetShareButtonVisible的回调函数
     *
     *   uint32_t SetShareButtonVisible(uint32_t id, bool bVisible, const std::string& strTitle, const std::string& strContent);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetShareButtonVisible 其它参数和返回值说明见 ArtiList.h
     */
    static void SetShareButtonVisible(std::function<bool(uint32_t, bool, const std::string&, const std::string&)> fnSetShareButtonVisible);
    
    /*
     *   注册CArtiList的成员函数AddGroup的回调函数
     *
     *   void AddGroup(uint32_t id, const std::string& strGroupName);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   AddGroup 函数说明见 ArtiList.h
     */
    static void AddGroup(std::function<void(uint32_t, const std::string&)> fnAddGroup);

    /*
     *   注册CArtiList的成员函数AddItem的回调函数
     *
     *   void AddItemVec(uint32_t id, const std::vector<std::string>& vctItems, bool bIsHighLight);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   AddItem 函数说明见 ArtiList.h
     *   AddItemVec 映射到ArtiList.h是AddItem函数
     */
    static void AddItemVec(std::function<void(uint32_t, const std::vector<std::string>&, bool)> fnAddItem);
    
    /*
     *   注册CArtiList的成员函数AddItem的回调函数
     *
     *   void AddItem(uint32_t id, const std::string& strItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   AddItem 函数说明见 ArtiList.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&)> fnAddItem);

    /*
     *   注册CArtiList的成员函数SetItem的回调函数
     *
     *   void SetItem(uint32_t id, uint16_t uRowIndex, uint16_t uColIndex, const std::string& strValue);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetItem 函数说明见 ArtiList.h
     */
    static void SetItem(std::function<void(uint32_t, uint16_t, uint16_t, const std::string&)> fnSetItem);
    
    /*
     *   注册CArtiList的成员函数SetItemPicture的回调函数
     *
     *   void SetItemPicture(uint32_t id, uint16_t uColIndex, const std::vector<std::string>& vctPath);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetItemPicture 函数说明见 ArtiList.h
     */
    static void SetItemPicture(std::function<void(uint32_t, uint16_t, const std::vector<std::string>&)> fnSetItemPicture);
    
    /*
     *   注册CArtiList的成员函数SetLeftLayoutPicture的回调函数
     *
     *   bool SetLeftLayoutPicture(uint32_t id, const std::string& strPicturePath, const std::string& strPictureTips, uint16_t uAlignType);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetLeftLayoutPicture 函数说明见 ArtiList.h
     */
    static void SetLeftLayoutPicture(std::function<bool(uint32_t, const std::string&, const std::string&, uint16_t)> fnSetLeftLayoutPicture);

    /*
     *   注册CArtiList的成员函数SetRowHighLight的回调函数
     *
     *   void SetRowHighLight(uint32_t id, uint16_t uRowIndex);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetRowHighLight 其它参数和返回值说明见 ArtiList.h
     */
    static void SetRowHighLight(std::function<void(uint32_t, uint16_t)> fnSetRowHighLight);

    /*
     *   注册CArtiList的成员函数SetRowHighLight的回调函数
     *
     *   void SetRowHighLight(uint32_t id, uint16_t uRowIndex, eColourType uColourType);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetRowHighLight 其它参数和返回值说明见 ArtiList.h
     */
    static void SetRowHighLightColour(std::function<void(uint32_t, uint16_t, eColourType)> fnSetRowHighLight);
    
    /*
     *   注册CArtiList的成员函数SetRowHighLight的回调函数
     *
     *   void SetRowHighLight(uint32_t id, const std::vector<uint16_t>& vctRowIndex, const std::vector<eColourType>& vctColourType);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetRowHighLight 其它参数和返回值说明见 ArtiList.h
     */
    static void SetRowHighLightColour(std::function<void(uint32_t, const std::vector<uint16_t>&, const std::vector<uint16_t>&)> fnSetRowHighLightColourVct);
    
    /*
     *   注册CArtiList的成员函数SetLockFirstRow的回调函数
     *
     *   void SetLockFirstRow(uint32_t id);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetLockFirstRow 其它参数和返回值说明见 ArtiList.h
     */
    static void SetLockFirstRow(std::function<void(uint32_t)> fnSetLockFirstRow);

    /*
     *   注册CArtiList的成员函数SetDefaultSelectedRow的回调函数
     *
     *   void SetDefaultSelectedRow(uint32_t id, uint16_t uRowIndex);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetDefaultSelectedRow 其它参数和返回值说明见 ArtiList.h
     */
    static void SetDefaultSelectedRow(std::function<void(uint32_t, uint16_t)> fnSetDefaultSelectedRow);

    /*
     *   注册CArtiList的成员函数SetCheckBoxStatus的回调函数
     *
     *   void SetCheckBoxStatus(uint32_t id, uint16_t uRowIndex, bool bChecked);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetCheckBoxStatus 其它参数和返回值说明见 ArtiList.h
     */
    static void SetCheckBoxStatus(std::function<void(uint32_t, uint16_t, bool)> fnSetCheckBoxStatus);

    /*
     *   注册CArtiList的成员函数SetButtonStatus的回调函数
     *
     *   void SetButtonStatus(uint32_t id, uint8_t uIndex, bool bIsEnable);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetButtonStatus 其它参数和返回值说明见 ArtiList.h
     */
    static void SetButtonStatus(std::function<void(uint32_t, uint8_t, bool)> fnSetButtonStatus);

    /*
     *   注册CArtiList的成员函数SetButtonStatus的回调函数
     *
     *   void SetButtonStatusU32(uint32_t id, uint16_t uIndex, uint32_t uStatus);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetButtonStatus 其它参数和返回值说明见 ArtiList.h
     *   SetButtonStatusU32 对应于 ArtiList.h的 SetButtonStatus
     */
    static void SetButtonStatusU32(std::function<void(uint32_t, uint16_t, uint32_t)> fnSetButtonStatus);

    /*
     *   注册CArtiList的成员函数SetButtonText的回调函数
     *
     *   void SetButtonText(uint32_t id, uint8_t uIndex, const std::string& strButtonText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetButtonText 其它参数和返回值说明见 ArtiList.h
     */
    static void SetButtonText(std::function<void(uint32_t, uint8_t, const std::string&)> fnSetButtonText);

    /*
     *   注册CArtiList的成员函数GetSelectedRow的回调函数
     *
     *   uint16_t GetSelectedRow(uint32_t id);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   GetSelectedRow 其它参数和返回值说明见 ArtiList.h
     */
    static void GetSelectedRow(std::function<uint16_t(uint32_t)> fnGetSelectedRow);

    /*
     *   注册CArtiList的成员函数GetSelectedRowEx的回调函数
     *
     *   std::vector<uint16_t> GetSelectedRowEx(uint32_t id);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   GetSelectedRowEx 其它参数和返回值说明见 ArtiList.h
     */
    static void GetSelectedRowEx(std::function<std::vector<uint16_t>(uint32_t)> fnGetSelectedRowEx);

    /*
     *   注册CArtiList的成员函数SetSelectedType的回调函数
     *
     *   uint32_t SetSelectedType(uint32_t id, eListSelectType lstType);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetSelectedType 其它参数和返回值说明见 ArtiList.h
     */
    static void SetSelectedType(std::function<uint32_t(uint32_t, uint32_t)> fnSetSelectedType);
    
    /*
     *   注册CArtiList的成员函数SetRowInCurrentScreen的回调函数
     *
     *   uint32_t SetRowInCurrentScreen(uint32_t id, CArtiList::eScreenRowType rowType, uint32_t uIndex);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiList.h的说明
     *
     *   SetRowInCurrentScreen 其它参数和返回值说明见 ArtiList.h
     */
    static void SetRowInCurrentScreen(std::function<uint32_t(uint32_t, uint32_t, uint32_t)> fnSetRowInCurrentScreen);
    
    /*
     *   注册CArtiList的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiList.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);

};

#endif
