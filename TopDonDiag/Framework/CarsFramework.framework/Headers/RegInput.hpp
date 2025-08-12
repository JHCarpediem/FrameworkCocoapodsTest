#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>
class CRegInput
{
public:
    CRegInput() = delete;
    ~CRegInput() = delete;
    
public:
    /*
    *   ע��CArtiInput��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiInput����ʱ����CArtiInput����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiInput�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    *
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   ע��CArtiInput����������Destruct�Ļص�����
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   ����˵��    id,    �ĸ������������������
    *
    *   ���أ���
    *
    *   ˵���� ��C++��������һ��CArtiInput����ʱ����CArtiInput������
    *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
     
    /*
     *   ע��CArtiInput��Ա����InitOneInputBox�Ļص�����
     *
     *   bool InitOneInputBox(uint32_t id, const std::string& strTitle, const std::string& strContent,
     *                        const std::string& strMask, const std::string& strDefault = "");
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   InitOneInputBox ����˵���� ArtiInput.h
     */
    static void InitOneInputBox(std::function<bool(uint32_t, const std::string&, const std::string&, const std::string&, const std::string&)> fnInitOneInputBox);
    
    /*
     *   ע��CArtiInput��Ա����GetOneInputBox�Ļص�����
     *
     *   std::string const GetOneInputBox(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   GetOneInputBox ����˵���� ArtiInput.h
     */
    static void GetOneInputBox(std::function<std::string const(uint32_t)> fnGetOneInputBox);

    /*
     *   ע��CArtiInput��Ա����AddButton�Ļص�����
     *
     *   void AddButton(uint32_t id, const std::string& strButtonText);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   AddButton ����˵���� ArtiInput.h
     */
    static void AddButton(std::function<void(uint32_t, const std::string&)> fnAddButton);

    /*
     *   ע��CArtiInput��Ա����SetVisibleButtonQR�Ļص�����
     *
     *   uint32_t SetVisibleButtonQR(uint32_t id, bool bVisible);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   SetVisibleButtonQR ����˵���� ArtiInput.h
     */
    static void SetVisibleButtonQR(std::function<uint32_t(uint32_t, bool)> fnSetVisibleButtonQR);
    
    /*
     *   ע��CArtiInput��Ա����SetVisibleButtonQREx�Ļص�����
     *
     *   uint32_t SetVisibleButtonQREx(uint32_t id, bool bScanVisible, bool bPasteVisible);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   SetVisibleButtonQREx ����˵���� ArtiInput.h
     */
    static void SetVisibleButtonQREx(std::function<uint32_t(uint32_t, bool, bool)> fnSetVisibleButtonQREx);
    
    /*
     *   ע��CArtiInput��Ա����InitManyInputBox�Ļص�����
     *
     *   bool InitManyInputBox(uint32_t id, const std::string& strTitle, const std::vector<std::string>& vctContents,
     *                         const std::vector<std::string>& vctMasks, const std::vector<std::string>& vctDefaults);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   InitManyInputBox ����˵���� ArtiInput.h
     */
    static void InitManyInputBox(std::function<bool(uint32_t,
                                                    const std::string&,
                                                    const std::vector<std::string>&,
                                                    const std::vector<std::string>&,
                                                    const std::vector<std::string>&)> fnInitManyInputBox);

    /*
     *   ע��CArtiInput��Ա����GetManyInputBox�Ļص�����
     *
     *   std::vector<std::string> GetManyInputBox(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   GetManyInputBox ����˵���� ArtiInput.h
     */
    static void GetManyInputBox(std::function<std::vector<std::string>(uint32_t)> fnGetManyInputBox);
    
    
    /*
     *   ע��CArtiInput��Ա����InitOneComboBox�Ļص�����
     *
     *   bool InitOneComboBox(uint32_t id, const string& strTitle, const string& strTips,
     *                                     const vector<string>& vctValue, const string& strDefault = "");
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   InitOneComboBox ����˵���� ArtiInput.h
     */
    static void InitOneComboBox(std::function<bool(uint32_t, const std::string&, const std::string&, const std::vector<std::string>&, const std::string&)> fnInitOneComboBox);
    
    
    /*
     *   ע��CArtiInput��Ա����GetOneComboBox�Ļص�����
     *
     *   std::string const GetOneComboBox(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   GetOneComboBox ����˵���� ArtiInput.h
     */
    static void GetOneComboBox(std::function<std::string const(uint32_t)> fnGetOneComboBox);
    
    
    /*
     *   ע��CArtiInput��Ա����InitManyComboBox�Ļص�����
     *
     *   bool InitManyComboBox(uint32_t id, const std::string& strTitle, const std::vector<std::string>& vctTips,
     *                         const std::vector<std::vector<std::string>>& vctValue, const std::vector<std::string>& vctDefault);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   InitManyComboBox ����˵���� ArtiInput.h
     */
    static void InitManyComboBox(std::function<bool(uint32_t,
                                                    const std::string&,
                                                    const std::vector<std::string>&,
                                                    const std::vector<std::vector<std::string>>&,
                                                    const std::vector<std::string>&)> fnInitManyComboBox);
    
    
    /*
     *   ע��CArtiInput��Ա����GetManyComboBox�Ļص�����
     *
     *   std::vector<std::string> GetManyComboBox(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   GetManyComboBox ����˵���� ArtiInput.h
     */
    static void GetManyComboBox(std::function<std::vector<std::string>(uint32_t)> fnGetManyComboBox);

    /*
     *   ע��CArtiInput��Ա����GetManyComboBoxNum�Ļص�����
     *
     *   std::vector<uint16_t> GetManyComboBoxNum(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   GetManyComboBoxNum ����˵���� ArtiInput.h
     */
    static void GetManyComboBoxNum(std::function<std::vector<uint16_t>(uint32_t)> fnGetManyComboBoxNum);
    
    /*
     *   ע��CArtiInput��Ա����InitMixedInputComboBox�Ļص�����
     *
     *   bool InitMixedInputComboBox(uint32_t id, const std::string& strTitle,
     *                               const std::vector<std::string>& vctTips,
     *                               const std::vector<std::string>& vctMasks,
     *                               const std::vector<std::string>& vctDefaults,
     *                               const std::vector<vector<std::string>>& vctComboValues,
     *                               const std::vector<std::string>& vctComboDefaults,
     *                               const std::vector<ControlType>& vctOrder);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   InitMixedInputComboBox ����˵���� ArtiInput.h
     */
    static void InitMixedInputComboBox(std::function<bool(uint32_t,
                                                          const std::string&,
                                                          const std::vector<std::string>&,
                                                          const std::vector<std::string>&,
                                                          const std::vector<std::string>&,
                                                          const std::vector<std::vector<std::string>>&,
                                                          const std::vector<std::string>&,
                                                          const std::vector<uint32_t>&)> fnInitMixedInputComboBox);

    /*
     *   ע��CArtiInput��Ա����GetMixedInputComboBox�Ļص�����
     *
     *   std::vector<std::string> GetMixedInputComboBox(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   GetMixedInputComboBox ����˵���� ArtiInput.h
     */
    static void GetMixedInputComboBox(std::function<std::vector<std::string>(uint32_t)> fnGetMixedInputComboBox);


    /*
     *   ע��CArtiInput��Ա����GetMixedComboBoxNum�Ļص�����
     *
     *   std::vector<uint16_t> GetMixedComboBoxNum(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiInput.h��˵��
     *
     *   GetMixedComboBoxNum ����˵���� ArtiInput.h
     */
    static void GetMixedComboBoxNum(std::function<std::vector<uint16_t>(uint32_t)> fnGetMixedComboBoxNum);
    
    /*
     *   ע��CArtiInput�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiInput.h
     */
    static void Show(std::function<uint32_t (uint32_t)> fnShow);
};
#endif
