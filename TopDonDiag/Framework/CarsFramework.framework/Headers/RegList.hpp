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
    *   ע��CArtiList��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiList����ʱ����CArtiList����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiList�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   ע��CArtiList����������Destruct�Ļص�����
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   ����˵��    id,    �ĸ������������������
    *
    *   ���أ���
    *
    *   ˵���� ��C++��������һ��CArtiList����ʱ����CArtiList������
    *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   ע��CArtiList�ĳ�Ա����InitTitle�Ļص�����
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   CArtiList ����˵���� ArtiList.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);
    
    /*
     *   ע��CArtiList�ĳ�Ա����InitTitle�Ļص�����
     *
     *   void InitTitleType(uint32_t id, const std::string& strTitle, uint32_t Type);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   InitTitle ����˵���� ArtiList.h
     *   InitTitleTypeӳ�䵽ArtiList.h��InitTitle
     */
    static void InitTitleType(std::function<bool(uint32_t, const std::string&, uint32_t)> fnInitTitle);
    
    /*
     *   ע��CArtiList�ĳ�Ա����SetColWidth�Ļص�����
     *
     *   void SetColWidth(uint32_t id, const std::vector<int32_t>& vctColWidth);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetColWidth ����˵���� ArtiList.h
     */
    static void SetColWidth(std::function<void(uint32_t, const std::vector<int32_t>&)> fnSetColWidth);

    /*
     *   ע��CArtiList�ĳ�Ա����SetHeads�Ļص�����
     *
     *   void SetHeads(uint32_t id, const std::vector<std::string>& vctHeadNames);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetHeads ����˵���� ArtiList.h
     */
    static void SetHeads(std::function<void(uint32_t, const std::vector<std::string>&)> fnSetHeads);
    
    /*
     *   ע��CArtiList�ĳ�Ա����SetTipsOnTop�Ļص�����
     *
     *   void SetTipsOnTop(uint32_t id, const std::string& strTips, uint32_t uAlignType);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetTipsOnTop ����˵���� ArtiList.h
     */
    static void SetTipsOnTop(std::function<void(uint32_t, const std::string&, uint32_t)> fnSetTipsOnTop);
    
    /*
     *   ע��CArtiList�ĳ�Ա����SetTipsTitleOnTop�Ļص�����
     *
     *   void SetTipsTitleOnTop(uint32_t id, const std::string& strTips, uint32_t uAlignType, eFontSize eSize, eBoldType eBold);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetTipsTitleOnTop ����˵���� ArtiList.h
     */
    static void SetTipsTitleOnTop(std::function<void(uint32_t, const std::string&, uint32_t, uint32_t, uint32_t)> fnSetTipsTitleOnTop);

    /*
     *   ע��CArtiList�ĳ�Ա����SetTipsOnBottom�Ļص�����
     *
     *   void SetTipsOnBottom(uint32_t id, const std::string& strTips);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetTipsOnBottom ����˵���� ArtiList.h
     */
    static void SetTipsOnBottom(std::function<void(uint32_t, const std::string&)> fnSetTipsOnBottom);
    
    /*
     *   ע��CArtiList�ĳ�Ա����SetBlockStatus�Ļص�����
     *
     *   void SetBlockStatus(uint32_t id, bool bIsBlock);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetBlockStatus ����˵���� ArtiList.h
     */
    static void SetBlockStatus(std::function<void(uint32_t, bool)> fnSetBlockStatus);

    /*
     *   ע��CArtiList�ĳ�Ա����AddButton�Ļص�����
     *
     *   void AddButton(uint32_t id, const std::string& strButtonText);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   AddButton ����˵���� ArtiList.h
     */
    static void AddButton(std::function<void(uint32_t, const std::string&)> fnAddButton);
    
    /*
     *   ע��CArtiList�ĳ�Ա����AddButtonEx�Ļص�����
     *
     *   uint32_t AddButtonEx(uint32_t id, const std::string& strButtonText);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   AddButton ����˵���� ArtiList.h
     */
    static void AddButtonEx(std::function<uint32_t(uint32_t, const std::string&)> fnAddButtonEx);

    /*
     *   ע��CArtiList�ĳ�Ա����DelButton�Ļص�����
     *
     *   bool DelButton(uint32_t id, uint32_t uButtonId);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   DelButton ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void DelButton(std::function<bool(uint32_t, uint32_t)> fnDelButton);

    /*
     *   ע��CArtiList�ĳ�Ա����SetShareButtonVisible�Ļص�����
     *
     *   uint32_t SetShareButtonVisible(uint32_t id, bool bVisible, const std::string& strTitle, const std::string& strContent);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetShareButtonVisible ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void SetShareButtonVisible(std::function<bool(uint32_t, bool, const std::string&, const std::string&)> fnSetShareButtonVisible);
    
    /*
     *   ע��CArtiList�ĳ�Ա����AddGroup�Ļص�����
     *
     *   void AddGroup(uint32_t id, const std::string& strGroupName);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   AddGroup ����˵���� ArtiList.h
     */
    static void AddGroup(std::function<void(uint32_t, const std::string&)> fnAddGroup);

    /*
     *   ע��CArtiList�ĳ�Ա����AddItem�Ļص�����
     *
     *   void AddItemVec(uint32_t id, const std::vector<std::string>& vctItems, bool bIsHighLight);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   AddItem ����˵���� ArtiList.h
     *   AddItemVec ӳ�䵽ArtiList.h��AddItem����
     */
    static void AddItemVec(std::function<void(uint32_t, const std::vector<std::string>&, bool)> fnAddItem);
    
    /*
     *   ע��CArtiList�ĳ�Ա����AddItem�Ļص�����
     *
     *   void AddItem(uint32_t id, const std::string& strItem);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   AddItem ����˵���� ArtiList.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&)> fnAddItem);

    /*
     *   ע��CArtiList�ĳ�Ա����SetItem�Ļص�����
     *
     *   void SetItem(uint32_t id, uint16_t uRowIndex, uint16_t uColIndex, const std::string& strValue);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetItem ����˵���� ArtiList.h
     */
    static void SetItem(std::function<void(uint32_t, uint16_t, uint16_t, const std::string&)> fnSetItem);
    
    /*
     *   ע��CArtiList�ĳ�Ա����SetItemPicture�Ļص�����
     *
     *   void SetItemPicture(uint32_t id, uint16_t uColIndex, const std::vector<std::string>& vctPath);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetItemPicture ����˵���� ArtiList.h
     */
    static void SetItemPicture(std::function<void(uint32_t, uint16_t, const std::vector<std::string>&)> fnSetItemPicture);
    
    /*
     *   ע��CArtiList�ĳ�Ա����SetLeftLayoutPicture�Ļص�����
     *
     *   bool SetLeftLayoutPicture(uint32_t id, const std::string& strPicturePath, const std::string& strPictureTips, uint16_t uAlignType);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetLeftLayoutPicture ����˵���� ArtiList.h
     */
    static void SetLeftLayoutPicture(std::function<bool(uint32_t, const std::string&, const std::string&, uint16_t)> fnSetLeftLayoutPicture);

    /*
     *   ע��CArtiList�ĳ�Ա����SetRowHighLight�Ļص�����
     *
     *   void SetRowHighLight(uint32_t id, uint16_t uRowIndex);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetRowHighLight ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void SetRowHighLight(std::function<void(uint32_t, uint16_t)> fnSetRowHighLight);

    /*
     *   ע��CArtiList�ĳ�Ա����SetRowHighLight�Ļص�����
     *
     *   void SetRowHighLight(uint32_t id, uint16_t uRowIndex, eColourType uColourType);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetRowHighLight ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void SetRowHighLightColour(std::function<void(uint32_t, uint16_t, eColourType)> fnSetRowHighLight);
    
    /*
     *   ע��CArtiList�ĳ�Ա����SetRowHighLight�Ļص�����
     *
     *   void SetRowHighLight(uint32_t id, const std::vector<uint16_t>& vctRowIndex, const std::vector<eColourType>& vctColourType);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetRowHighLight ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void SetRowHighLightColour(std::function<void(uint32_t, const std::vector<uint16_t>&, const std::vector<uint16_t>&)> fnSetRowHighLightColourVct);
    
    /*
     *   ע��CArtiList�ĳ�Ա����SetLockFirstRow�Ļص�����
     *
     *   void SetLockFirstRow(uint32_t id);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetLockFirstRow ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void SetLockFirstRow(std::function<void(uint32_t)> fnSetLockFirstRow);

    /*
     *   ע��CArtiList�ĳ�Ա����SetDefaultSelectedRow�Ļص�����
     *
     *   void SetDefaultSelectedRow(uint32_t id, uint16_t uRowIndex);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetDefaultSelectedRow ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void SetDefaultSelectedRow(std::function<void(uint32_t, uint16_t)> fnSetDefaultSelectedRow);

    /*
     *   ע��CArtiList�ĳ�Ա����SetCheckBoxStatus�Ļص�����
     *
     *   void SetCheckBoxStatus(uint32_t id, uint16_t uRowIndex, bool bChecked);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetCheckBoxStatus ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void SetCheckBoxStatus(std::function<void(uint32_t, uint16_t, bool)> fnSetCheckBoxStatus);

    /*
     *   ע��CArtiList�ĳ�Ա����SetButtonStatus�Ļص�����
     *
     *   void SetButtonStatus(uint32_t id, uint8_t uIndex, bool bIsEnable);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetButtonStatus ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void SetButtonStatus(std::function<void(uint32_t, uint8_t, bool)> fnSetButtonStatus);

    /*
     *   ע��CArtiList�ĳ�Ա����SetButtonStatus�Ļص�����
     *
     *   void SetButtonStatusU32(uint32_t id, uint16_t uIndex, uint32_t uStatus);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetButtonStatus ���������ͷ���ֵ˵���� ArtiList.h
     *   SetButtonStatusU32 ��Ӧ�� ArtiList.h�� SetButtonStatus
     */
    static void SetButtonStatusU32(std::function<void(uint32_t, uint16_t, uint32_t)> fnSetButtonStatus);

    /*
     *   ע��CArtiList�ĳ�Ա����SetButtonText�Ļص�����
     *
     *   void SetButtonText(uint32_t id, uint8_t uIndex, const std::string& strButtonText);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetButtonText ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void SetButtonText(std::function<void(uint32_t, uint8_t, const std::string&)> fnSetButtonText);

    /*
     *   ע��CArtiList�ĳ�Ա����GetSelectedRow�Ļص�����
     *
     *   uint16_t GetSelectedRow(uint32_t id);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   GetSelectedRow ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void GetSelectedRow(std::function<uint16_t(uint32_t)> fnGetSelectedRow);

    /*
     *   ע��CArtiList�ĳ�Ա����GetSelectedRowEx�Ļص�����
     *
     *   std::vector<uint16_t> GetSelectedRowEx(uint32_t id);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   GetSelectedRowEx ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void GetSelectedRowEx(std::function<std::vector<uint16_t>(uint32_t)> fnGetSelectedRowEx);

    /*
     *   ע��CArtiList�ĳ�Ա����SetSelectedType�Ļص�����
     *
     *   uint32_t SetSelectedType(uint32_t id, eListSelectType lstType);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetSelectedType ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void SetSelectedType(std::function<uint32_t(uint32_t, uint32_t)> fnSetSelectedType);
    
    /*
     *   ע��CArtiList�ĳ�Ա����SetRowInCurrentScreen�Ļص�����
     *
     *   uint32_t SetRowInCurrentScreen(uint32_t id, CArtiList::eScreenRowType rowType, uint32_t uIndex);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiList.h��˵��
     *
     *   SetRowInCurrentScreen ���������ͷ���ֵ˵���� ArtiList.h
     */
    static void SetRowInCurrentScreen(std::function<uint32_t(uint32_t, uint32_t, uint32_t)> fnSetRowInCurrentScreen);
    
    /*
     *   ע��CArtiList�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiList.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);

};

#endif
