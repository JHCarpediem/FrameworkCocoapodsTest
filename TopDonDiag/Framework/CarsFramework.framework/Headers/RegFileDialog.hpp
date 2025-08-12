#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

// 文件选取、文件另存为

class CRegFileDialog
{
public:
    CRegFileDialog();
    ~CRegFileDialog();
    
public:
   /*
    *   注册CArtiFileDialog的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiFileDialog对象时，在CArtiFileDialog构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiFileDialog的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    *
    *         例如，CArtiFileDialog的成员函数InitType
    *
    *               C++函数声明为：void InitType(bool bType, const std::string& strPath);
    *               则app接口函数为：void InitType(uint32_t id, bool bType, const std::string& strPath);
    *
    *               app 通过id能够判定是哪个CArtiFileDialog实例调用了 InitType
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   注册CArtiFileDialog的析构函数Destruct的回调函数
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   参数说明    id,    哪个对象调用了析构函数
     *
     *   返回：无
     *
     *   说明： 当C++代码析构一个CArtiFileDialog对象时，在CArtiFileDialog的析构
     *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   注册CArtiFileDialog的成员函数InitType的回调函数
     *
     *   void InitType(uint32_t id, bool bType, const std::string& strPath);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiFileDialog.h的说明
     *
     *   InitType 函数说明见 CArtiFileDialog.h
     */
    static void InitType(std::function<void(uint32_t, bool, const std::string&)> fnInitType);

    /*
     *   注册CArtiFileDialog的成员函数SetFilter的回调函数
     *
     *   void SetFilter(uint32_t id, const std::string& strFilter);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiFileDialog.h的说明
     *
     *   SetFilter 函数说明见 ArtiFileDialog.h
     */
    static void SetFilter(std::function<void(uint32_t, const std::string&)> fnSetFilter);

    /*
     *   注册CArtiFileDialog的成员函数GetPathName的回调函数
     *
     *   const std::string GetPathName(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiFileDialog.h的说明
     *
     *   GetPathName 函数说明见 CArtiFileDialog.h
     */
    static void GetPathName(std::function<const std::string(uint32_t)> fnGetPathName);

    /*
     *   注册CArtiFileDialog的成员函数GetFileName的回调函数
     *
     *   const std::string GetFileName(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiFileDialog.h的说明
     *
     *   GetFileName 函数说明见 CArtiFileDialog.h
     */
    static void GetFileName(std::function<const std::string(uint32_t)> fnGetFileName);
    
    /*
     *   注册CArtiFileDialog的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiFileDialog.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};

#endif
