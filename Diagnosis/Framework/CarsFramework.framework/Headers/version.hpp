#pragma once
#ifdef __cplusplus
#include <string>

extern const std::string ArtiVersion(const char*, const char*);
#define DIAG_VER_EXTERN(name) extern const std::string ArtiVerDiag_##name()
#define IMMO_VER_EXTERN(name) extern const std::string ArtiVerImmo_##name()
#define MOTO_VER_EXTERN(name) extern const std::string ArtiVerMoto_##name()
#define DIAG_VERSION(name, size)                         \
do{                                                      \
    if (strlen(strVeh) == size)                          \
    {                                                    \
        if (memcmp(strVeh, #name, size) == 0)            \
        {                                                \
            return ArtiVerDiag_##name();                 \
        }                                                \
    }                                                    \
}while(0);

#define IMMO_VERSION(name, size)                         \
do{                                                      \
    if (strlen(strVeh) == size)                          \
    {                                                    \
        if (memcmp(strVeh, #name, size) == 0)            \
        {                                                \
            return ArtiVerImmo_##name();                 \
        }                                                \
    }                                                    \
}while(0);

#define MOTO_VERSION(name, size)                         \
do{                                                      \
    if (strlen(strVeh) == size)                          \
    {                                                    \
        if (memcmp(strVeh, #name, size) == 0)            \
        {                                                \
            return ArtiVerMoto_##name();                 \
        }                                                \
    }                                                    \
}while(0);


// car_version_statement
DIAG_VER_EXTERN(DEMO);
DIAG_VER_EXTERN(EOBD);

// car_version_statement_end


// immo_version_statement

// immo_version_statement_end


// moto_version_statement

// moto_version_statement_end


class CVehVersion
{
    friend const std::string ArtiVersion(const char*, const char*);
    
private:
    CVehVersion() = delete;
    ~CVehVersion() = delete;
 
private:
    // 返回 “” 无此车型
    // 诊断车型的版本号函数调用
    
    static std::string const VehDiag(const char * strVeh)
    {
// car_version_function
        DIAG_VERSION(DEMO, strlen("DEMO"));
        DIAG_VERSION(EOBD, strlen("EOBD"));

// car_version_function_end
        return std::string("");
    }
    
    // 锁匠车型的版本号函数调用
    static std::string const VehImmo(const char * strVeh)
    {
// immo_version_function

// immo_version_function_end
        return std::string("");
    }
    
    // 摩托车车型的版本号函数调用
    static std::string const VehMoto(const char * strVeh)
    {
// moto_version_function

// moto_version_function_end
        return std::string("");
    }
};

#endif
