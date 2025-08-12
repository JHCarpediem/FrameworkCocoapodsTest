#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>
#include <string>

#include "HStdShowMaco.h"

class CRegFloatMini
{
public:
    CRegFloatMini() = delete;
    ~CRegFloatMini() = delete;

public:
    /*
    *   注册CArtiFloatMini静态成员函数NewInstance的回调函数
    *
    *   static uint32_t NewInstance(uint32_t eType);
    *
    *   NewInstance 函数说明见 ArtiFloatMini.h
    */
    static void NewInstance(std::function<uint32_t(uint32_t)> fnNewInstance);

    /*
    *   注册CArtiFloatMini静态成员函数DeleteInstance的回调函数
    *
    *   static uint32_t DeleteInstance(uint32_t FloatID);
    *
    *   DeleteInstance 函数说明见 ArtiFloatMini.h
    */
    static void DeleteInstance(std::function<uint32_t(uint32_t)> fnDeleteInstance);

    /*
    *   注册CArtiFloatMini静态成员函数Display的回调函数
    *
    *   static uint32_t Display(uint32_t FloatID, const std::string& strContent);
    *
    *   Hidden 函数说明见 ArtiFloatMini.h
    */
    static void Display(std::function<uint32_t(uint32_t, const std::string&)> fnDisplay);

    /*
    *   注册CArtiFloatMini静态成员函数Hidden的回调函数
    *
    *   static uint32_t Hidden(uint32_t FloatID);
    *
    *   Hidden 函数说明见 ArtiFloatMini.h
    */
    static void Hidden(std::function<uint32_t(uint32_t)> fnHidden);
};
#endif
