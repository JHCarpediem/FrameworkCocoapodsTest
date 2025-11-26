#pragma once
#ifdef __cplusplus
#include <string>

extern "C" uint32_t ArtiDiag(const char*, const char*);
#define DIAG_EXTERN(name) extern "C" void ArtiDiag_##name()
#define IMMO_EXTERN(name) extern "C" void ArtiImmo_##name()
#define MOTO_EXTERN(name) extern "C" void ArtiMoto_##name()
#define DIAG_ENTRY(name, size)                           \
do{                                                      \
    if (strlen(strVeh) == size)                          \
    {                                                    \
        if (memcmp(strVeh, #name, size) == 0)            \
        {                                                \
            ArtiDiag_##name();                           \
            return 0;                                    \
        }                                                \
    }                                                    \
}while(0);

#define IMMO_ENTRY(name, size)                           \
do{                                                      \
    if (strlen(strVeh) == size)                          \
    {                                                    \
        if (memcmp(strVeh, #name, size) == 0)            \
        {                                                \
            ArtiImmo_##name();                           \
            return 0;                                    \
        }                                                \
    }                                                    \
}while(0);

#define MOTO_ENTRY(name, size)                           \
do{                                                      \
    if (strlen(strVeh) == size)                          \
    {                                                    \
        if (memcmp(strVeh, #name, size) == 0)            \
        {                                                \
            ArtiMoto_##name();                           \
            return 0;                                    \
        }                                                \
    }                                                    \
}while(0);


// car_loadera_statement
DIAG_EXTERN(DEMO);
DIAG_EXTERN(EOBD);

// car_loadera_statement_end


// immo_loadera_statement

// immo_loadera_statement_end


// moto_loadera_statement

// moto_loadera_statement_end

class CLoader
{
    friend uint32_t ArtiDiag(const char*, const char*);
    
private:
    CLoader() = delete;
    ~CLoader() = delete;
 
private:
    // 返回 -1 无此车型
    static uint32_t ArtiDiag(const char * strVeh)
    {
// car_loadera_function
        DIAG_ENTRY(DEMO, strlen("DEMO"));
        DIAG_ENTRY(EOBD, strlen("EOBD"));

// car_loadera_function_end
        return -1;
    }
    
    static uint32_t ArtiImmo(const char * strVeh)
    {
// immo_loadera_function

// immo_loadera_function_end
        return -1;
    }
    
    static uint32_t ArtiMoto(const char * strVeh)
    {
// moto_loadera_function

// moto_loadera_function_end
        return -1;
    }
};

#endif
