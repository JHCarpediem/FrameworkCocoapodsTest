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
    *   注册CArtiInput的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiInput对象时，在CArtiInput构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiInput的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    *
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   注册CArtiInput的析构函数Destruct的回调函数
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   参数说明    id,    哪个对象调用了析构函数
    *
    *   返回：无
    *
    *   说明： 当C++代码析构一个CArtiInput对象时，在CArtiInput的析构
    *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
     
    /*
     *   注册CArtiInput成员函数InitOneInputBox的回调函数
     *
     *   bool InitOneInputBox(uint32_t id, const std::string& strTitle, const std::string& strContent,
     *                        const std::string& strMask, const std::string& strDefault = "");
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   InitOneInputBox 函数说明见 ArtiInput.h
     */
    static void InitOneInputBox(std::function<bool(uint32_t, const std::string&, const std::string&, const std::string&, const std::string&)> fnInitOneInputBox);
    
    /*
     *   注册CArtiInput成员函数GetOneInputBox的回调函数
     *
     *   std::string const GetOneInputBox(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   GetOneInputBox 函数说明见 ArtiInput.h
     */
    static void GetOneInputBox(std::function<std::string const(uint32_t)> fnGetOneInputBox);

    /*
     *   注册CArtiInput成员函数AddButton的回调函数
     *
     *   void AddButton(uint32_t id, const std::string& strButtonText);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   AddButton 函数说明见 ArtiInput.h
     */
    static void AddButton(std::function<void(uint32_t, const std::string&)> fnAddButton);

    /*
     *   注册CArtiInput成员函数SetVisibleButtonQR的回调函数
     *
     *   uint32_t SetVisibleButtonQR(uint32_t id, bool bVisible);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   SetVisibleButtonQR 函数说明见 ArtiInput.h
     */
    static void SetVisibleButtonQR(std::function<uint32_t(uint32_t, bool)> fnSetVisibleButtonQR);
    
    /*
     *   注册CArtiInput成员函数SetVisibleButtonQREx的回调函数
     *
     *   uint32_t SetVisibleButtonQREx(uint32_t id, bool bScanVisible, bool bPasteVisible);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   SetVisibleButtonQREx 函数说明见 ArtiInput.h
     */
    static void SetVisibleButtonQREx(std::function<uint32_t(uint32_t, bool, bool)> fnSetVisibleButtonQREx);
    
    /*
     *   注册CArtiInput成员函数InitManyInputBox的回调函数
     *
     *   bool InitManyInputBox(uint32_t id, const std::string& strTitle, const std::vector<std::string>& vctContents,
     *                         const std::vector<std::string>& vctMasks, const std::vector<std::string>& vctDefaults);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   InitManyInputBox 函数说明见 ArtiInput.h
     */
    static void InitManyInputBox(std::function<bool(uint32_t,
                                                    const std::string&,
                                                    const std::vector<std::string>&,
                                                    const std::vector<std::string>&,
                                                    const std::vector<std::string>&)> fnInitManyInputBox);

    /*
     *   注册CArtiInput成员函数GetManyInputBox的回调函数
     *
     *   std::vector<std::string> GetManyInputBox(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   GetManyInputBox 函数说明见 ArtiInput.h
     */
    static void GetManyInputBox(std::function<std::vector<std::string>(uint32_t)> fnGetManyInputBox);
    
    
    /*
     *   注册CArtiInput成员函数InitOneComboBox的回调函数
     *
     *   bool InitOneComboBox(uint32_t id, const string& strTitle, const string& strTips,
     *                                     const vector<string>& vctValue, const string& strDefault = "");
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   InitOneComboBox 函数说明见 ArtiInput.h
     */
    static void InitOneComboBox(std::function<bool(uint32_t, const std::string&, const std::string&, const std::vector<std::string>&, const std::string&)> fnInitOneComboBox);
    
    
    /*
     *   注册CArtiInput成员函数GetOneComboBox的回调函数
     *
     *   std::string const GetOneComboBox(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   GetOneComboBox 函数说明见 ArtiInput.h
     */
    static void GetOneComboBox(std::function<std::string const(uint32_t)> fnGetOneComboBox);
    
    
    /*
     *   注册CArtiInput成员函数InitManyComboBox的回调函数
     *
     *   bool InitManyComboBox(uint32_t id, const std::string& strTitle, const std::vector<std::string>& vctTips,
     *                         const std::vector<std::vector<std::string>>& vctValue, const std::vector<std::string>& vctDefault);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   InitManyComboBox 函数说明见 ArtiInput.h
     */
    static void InitManyComboBox(std::function<bool(uint32_t,
                                                    const std::string&,
                                                    const std::vector<std::string>&,
                                                    const std::vector<std::vector<std::string>>&,
                                                    const std::vector<std::string>&)> fnInitManyComboBox);
    
    
    /*
     *   注册CArtiInput成员函数GetManyComboBox的回调函数
     *
     *   std::vector<std::string> GetManyComboBox(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   GetManyComboBox 函数说明见 ArtiInput.h
     */
    static void GetManyComboBox(std::function<std::vector<std::string>(uint32_t)> fnGetManyComboBox);

    /*
     *   注册CArtiInput成员函数GetManyComboBoxNum的回调函数
     *
     *   std::vector<uint16_t> GetManyComboBoxNum(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   GetManyComboBoxNum 函数说明见 ArtiInput.h
     */
    static void GetManyComboBoxNum(std::function<std::vector<uint16_t>(uint32_t)> fnGetManyComboBoxNum);
    
    /*
     *   注册CArtiInput成员函数InitMixedInputComboBox的回调函数
     *
     *   bool InitMixedInputComboBox(uint32_t id, const std::string& strTitle,
     *                               const std::vector<std::string>& vctTips,
     *                               const std::vector<std::string>& vctMasks,
     *                               const std::vector<std::string>& vctDefaults,
     *                               const std::vector<vector<std::string>>& vctComboValues,
     *                               const std::vector<std::string>& vctComboDefaults,
     *                               const std::vector<ControlType>& vctOrder);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   InitMixedInputComboBox 函数说明见 ArtiInput.h
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
     *   注册CArtiInput成员函数GetMixedInputComboBox的回调函数
     *
     *   std::vector<std::string> GetMixedInputComboBox(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   GetMixedInputComboBox 函数说明见 ArtiInput.h
     */
    static void GetMixedInputComboBox(std::function<std::vector<std::string>(uint32_t)> fnGetMixedInputComboBox);


    /*
     *   注册CArtiInput成员函数GetMixedComboBoxNum的回调函数
     *
     *   std::vector<uint16_t> GetMixedComboBoxNum(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiInput.h的说明
     *
     *   GetMixedComboBoxNum 函数说明见 ArtiInput.h
     */
    static void GetMixedComboBoxNum(std::function<std::vector<uint16_t>(uint32_t)> fnGetMixedComboBoxNum);
    
    /*
     *   注册CArtiInput的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiInput.h
     */
    static void Show(std::function<uint32_t (uint32_t)> fnShow);
};
#endif
