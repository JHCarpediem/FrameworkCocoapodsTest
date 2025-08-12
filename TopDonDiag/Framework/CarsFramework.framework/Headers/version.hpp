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



// 在这里添加诊断车型版本号接口声明
DIAG_VER_EXTERN(ACCSPEED);
DIAG_VER_EXTERN(AUTOVIN);
DIAG_VER_EXTERN(BENZ);
DIAG_VER_EXTERN(BMW);
DIAG_VER_EXTERN(SMART);
DIAG_VER_EXTERN(SPRINTER);
DIAG_VER_EXTERN(CHRYSLER);
DIAG_VER_EXTERN(DEMO);
DIAG_VER_EXTERN(FORD);
DIAG_VER_EXTERN(MAZDA);
DIAG_VER_EXTERN(GM);
DIAG_VER_EXTERN(HONDA);
DIAG_VER_EXTERN(HAFEI);
DIAG_VER_EXTERN(HYUNDAI);
DIAG_VER_EXTERN(JMC);
DIAG_VER_EXTERN(LANDROVER);
DIAG_VER_EXTERN(MITSUBISHI);
DIAG_VER_EXTERN(NISSAN);
DIAG_VER_EXTERN(PORSCHE);
DIAG_VER_EXTERN(PSA);
DIAG_VER_EXTERN(RENAULT);
DIAG_VER_EXTERN(SUBARU);
DIAG_VER_EXTERN(SUZUKI);
DIAG_VER_EXTERN(TOYOTA);
DIAG_VER_EXTERN(VW);
DIAG_VER_EXTERN(ISUZU);
DIAG_VER_EXTERN(COMM);
DIAG_VER_EXTERN(EOBD);
DIAG_VER_EXTERN(PEUGEOT);
DIAG_VER_EXTERN(PROTON);
DIAG_VER_EXTERN(IM_PRECHECK);
DIAG_VER_EXTERN(IVECO_LD);
DIAG_VER_EXTERN(TATA);
DIAG_VER_EXTERN(SAAB);
DIAG_VER_EXTERN(OPEL);
DIAG_VER_EXTERN(MAHINDRA);
DIAG_VER_EXTERN(VOLVO);
DIAG_VER_EXTERN(SSANGYONG);
DIAG_VER_EXTERN(FIAT);
DIAG_VER_EXTERN(FIATBRAZIL);
DIAG_VER_EXTERN(DAIHATSU);
DIAG_VER_EXTERN(LYNKCO);
DIAG_VER_EXTERN(POLESTAR);
DIAG_VER_EXTERN(MASERATI);
//国产
DIAG_VER_EXTERN(BYD);
DIAG_VER_EXTERN(BAICMOTOR);
DIAG_VER_EXTERN(CHERY);
DIAG_VER_EXTERN(CMC);
DIAG_VER_EXTERN(CHANGAN);
DIAG_VER_EXTERN(DFXK);
DIAG_VER_EXTERN(DFFS);
DIAG_VER_EXTERN(DFFX);
DIAG_VER_EXTERN(JAC);
DIAG_VER_EXTERN(PERODUA);
DIAG_VER_EXTERN(SWMMOTOR);
DIAG_VER_EXTERN(SAICMG);
DIAG_VER_EXTERN(GEELY);
DIAG_VER_EXTERN(GREATWALL);
DIAG_VER_EXTERN(GACMOTOR);
DIAG_VER_EXTERN(SAICMAXUS);
DIAG_VER_EXTERN(FAWCAR);
DIAG_VER_EXTERN(FERRARI);
DIAG_VER_EXTERN(SGMW);

// 在这里添加锁匠车型版本号接口声明
//IMMO_VER_EXTERN(Ford);
IMMO_VER_EXTERN(ABARTH);
IMMO_VER_EXTERN(ACURA);
IMMO_VER_EXTERN(ALFAROMEO);
IMMO_VER_EXTERN(AUDI);
IMMO_VER_EXTERN(BMW);
IMMO_VER_EXTERN(BUICK);
IMMO_VER_EXTERN(BAICMOTOR);
IMMO_VER_EXTERN(CHERY);
IMMO_VER_EXTERN(CHRYSLER);
IMMO_VER_EXTERN(CITROEN);
IMMO_VER_EXTERN(CNTOYOTA);
IMMO_VER_EXTERN(CADILLAC);
IMMO_VER_EXTERN(CHEVROLET);
IMMO_VER_EXTERN(DODGE);
IMMO_VER_EXTERN(DS);
IMMO_VER_EXTERN(DFHONDA);
IMMO_VER_EXTERN(FERRARI);
IMMO_VER_EXTERN(FIAT);
IMMO_VER_EXTERN(FIATBRAZIL);
IMMO_VER_EXTERN(FORD);
IMMO_VER_EXTERN(FORDAU);
IMMO_VER_EXTERN(FORDEU);
IMMO_VER_EXTERN(FREQUENCY_DETECTION);
IMMO_VER_EXTERN(GM);
IMMO_VER_EXTERN(GMBRAZIL);
IMMO_VER_EXTERN(GREATWALL);
IMMO_VER_EXTERN(GENERATE_TRANSPONDER);
IMMO_VER_EXTERN(GMC);
IMMO_VER_EXTERN(GACMOTOR);
IMMO_VER_EXTERN(GZHONDA);
IMMO_VER_EXTERN(HAVAL);
IMMO_VER_EXTERN(HOLDEN);
IMMO_VER_EXTERN(HONDA);
IMMO_VER_EXTERN(HUMMER);
IMMO_VER_EXTERN(HYUNDAI);
IMMO_VER_EXTERN(INFINITI);
IMMO_VER_EXTERN(ISUZU);
IMMO_VER_EXTERN(JAGUAR);
IMMO_VER_EXTERN(JEEP);
IMMO_VER_EXTERN(JAC);
IMMO_VER_EXTERN(JMC);
IMMO_VER_EXTERN(KARRY);
IMMO_VER_EXTERN(KIA);
IMMO_VER_EXTERN(LANCIA);
IMMO_VER_EXTERN(LANDROVER);
IMMO_VER_EXTERN(LEXUS);
IMMO_VER_EXTERN(LINCOLN);
IMMO_VER_EXTERN(MAHINDRA);
IMMO_VER_EXTERN(MARUTI_SUZUKI);
IMMO_VER_EXTERN(MASERATI);
IMMO_VER_EXTERN(MAZDA);
IMMO_VER_EXTERN(MITSUBISHI);
IMMO_VER_EXTERN(MERCURY);
IMMO_VER_EXTERN(MG);
IMMO_VER_EXTERN(NISSAN);
IMMO_VER_EXTERN(OPEL);
IMMO_VER_EXTERN(PEUGEOT);
IMMO_VER_EXTERN(PONTIAC);
IMMO_VER_EXTERN(RELY);
IMMO_VER_EXTERN(RENAULT);
IMMO_VER_EXTERN(RIICH);
IMMO_VER_EXTERN(ROEWE);
IMMO_VER_EXTERN(SAAB);
IMMO_VER_EXTERN(SAICMAXUS);
IMMO_VER_EXTERN(SCION);
IMMO_VER_EXTERN(SMART);
IMMO_VER_EXTERN(SSANGYONG);
IMMO_VER_EXTERN(SUBARU);
IMMO_VER_EXTERN(SUZUKI);
IMMO_VER_EXTERN(SATURN);
IMMO_VER_EXTERN(SKODA);
IMMO_VER_EXTERN(SEAT);
IMMO_VER_EXTERN(TATA);
IMMO_VER_EXTERN(TOYOTA);
IMMO_VER_EXTERN(TRANSPONDER_RECOGNITION);
IMMO_VER_EXTERN(TEST_IMMO_PKE_COIL);
IMMO_VER_EXTERN(VW);
IMMO_VER_EXTERN(VAUXHALL);
IMMO_VER_EXTERN(WEY);
IMMO_VER_EXTERN(WRITE_KEY_VIA_DUMP);
IMMO_VER_EXTERN(BYD);
IMMO_VER_EXTERN(GEELY);
IMMO_VER_EXTERN(EMGRAND);
IMMO_VER_EXTERN(ENGLON);
IMMO_VER_EXTERN(GLEAGLE);
IMMO_VER_EXTERN(MAPLE);
IMMO_VER_EXTERN(DENZA);
IMMO_VER_EXTERN(BAICHUANSU);
IMMO_VER_EXTERN(BAICSENOVA);
IMMO_VER_EXTERN(BAICWEIWANG);
IMMO_VER_EXTERN(BJEV);
IMMO_VER_EXTERN(GACAION);
IMMO_VER_EXTERN(DFNISSAN);
IMMO_VER_EXTERN(DFVENUCIA);
IMMO_VER_EXTERN(CHANGAN);

//Motor
MOTO_VER_EXTERN(BMW);
MOTO_VER_EXTERN(BRP);
MOTO_VER_EXTERN(BENELLI);
MOTO_VER_EXTERN(BROUGH);
MOTO_VER_EXTERN(DUCATI);
MOTO_VER_EXTERN(HARLEY);
MOTO_VER_EXTERN(HONDA);
MOTO_VER_EXTERN(INDIAN);
MOTO_VER_EXTERN(KAWASAKI);
MOTO_VER_EXTERN(KTM);
MOTO_VER_EXTERN(KYMCO);
MOTO_VER_EXTERN(KELLER);
MOTO_VER_EXTERN(PIAGGIO);
MOTO_VER_EXTERN(PEUGEOT);
MOTO_VER_EXTERN(VICTORY);
MOTO_VER_EXTERN(SUZUKI);
MOTO_VER_EXTERN(YAMAHA);
MOTO_VER_EXTERN(MORINI);
MOTO_VER_EXTERN(HM);
MOTO_VER_EXTERN(KSRMOTO);
MOTO_VER_EXTERN(MGK);
MOTO_VER_EXTERN(VENT);
MOTO_VER_EXTERN(AGUSTA);
MOTO_VER_EXTERN(SHERCO);
MOTO_VER_EXTERN(WOTTAN);
MOTO_VER_EXTERN(VERVE);
MOTO_VER_EXTERN(LEXMOTO);
MOTO_VER_EXTERN(GGTECHNIK);
MOTO_VER_EXTERN(ITALJET);
MOTO_VER_EXTERN(POLARIS);
MOTO_VER_EXTERN(TRIUMPH);
MOTO_VER_EXTERN(SYM);
MOTO_VER_EXTERN(HUSQVARNA);
MOTO_VER_EXTERN(FANTIC);
MOTO_VER_EXTERN(KEEWAY);
MOTO_VER_EXTERN(MH);
MOTO_VER_EXTERN(MALAGUTI);
MOTO_VER_EXTERN(DEMO);
class CVehVersion
{
    friend const std::string ArtiVersion(const char*, const char*);
    
private:
    CVehVersion() = delete;
    ~CVehVersion() = delete;
 
private:
    // 返回 “” 无此车型
    static std::string const VehDiag(const char * strVeh)
    {
        // 在这里添加诊断车型的版本号函数调用
//        DIAG_VERSION(ACCSPEED, 8);
        DIAG_VERSION(AUTOVIN, 7);
//        DIAG_VERSION(BENZ, 4);
//        DIAG_VERSION(BMW, 3);
//        DIAG_VERSION(SMART, 5);
//        DIAG_VERSION(SPRINTER, 8);
//        DIAG_VERSION(CHRYSLER, 8);
        DIAG_VERSION(DEMO, 4);
//        DIAG_VERSION(FORD, 4);
//        DIAG_VERSION(MAZDA, 5);
//        DIAG_VERSION(GM, 2);
//        DIAG_VERSION(HONDA, 5);
//        DIAG_VERSION(HAFEI, strlen("HAFEI"));
//        DIAG_VERSION(HYUNDAI, 7);
//        DIAG_VERSION(LANDROVER, 9);
//        DIAG_VERSION(MITSUBISHI, 10);
//        DIAG_VERSION(NISSAN, 6);
//        DIAG_VERSION(PORSCHE, 7);
//        DIAG_VERSION(RENAULT, 7);
//        DIAG_VERSION(SUBARU, 6);
//        DIAG_VERSION(SUZUKI, 6);
//        DIAG_VERSION(TOYOTA, 6);
//        DIAG_VERSION(VW, 2);
//        DIAG_VERSION(ISUZU, 5);
        DIAG_VERSION(EOBD, 4);
//        DIAG_VERSION(PEUGEOT, 7);
//        DIAG_VERSION(PROTON, strlen("PROTON"));
//        DIAG_VERSION(IM_PRECHECK, 11);
//        DIAG_VERSION(IVECO_LD, strlen("IVECO_LD"));
//        DIAG_VERSION(JMC, strlen("JMC"))
//        DIAG_VERSION(TATA,strlen("TATA"));
//        DIAG_VERSION(SAAB,strlen("SAAB"));
//        DIAG_VERSION(OPEL,strlen("OPEL"));
//        DIAG_VERSION(MAHINDRA,strlen("MAHINDRA"));
//        DIAG_VERSION(VOLVO,strlen("VOLVO"));
//        DIAG_VERSION(SSANGYONG,strlen("SSANGYONG"));
//        DIAG_VERSION(FIAT, strlen("FIAT"));
//        DIAG_VERSION(FIATBRAZIL, strlen("FIATBRAZIL"));
//        DIAG_VERSION(DAIHATSU, strlen("DAIHATSU"));
//        DIAG_VERSION(LYNKCO, strlen("LYNKCO"));
//        DIAG_VERSION(POLESTAR, strlen("POLESTAR"));
//        DIAG_VERSION(MASERATI, strlen("MASERATI"));
//        //国产
//        DIAG_VERSION(BYD, strlen("BYD"));
//        DIAG_VERSION(BAICMOTOR, strlen("BAICMOTOR"));
//        DIAG_VERSION(CHERY, strlen("CHERY"));
//        DIAG_VERSION(CMC, strlen("CMC"));
//        DIAG_VERSION(CHANGAN, strlen("CHANGAN"));
//        DIAG_VERSION(DFXK, strlen("DFXK"));
//        DIAG_VERSION(DFFS, strlen("DFFS"));
//        DIAG_VERSION(DFFX, strlen("DFFX"));
//        DIAG_VERSION(JAC, strlen("JAC"));
//        DIAG_VERSION(FAWCAR, strlen("FAWCAR"));
//        DIAG_VERSION(FERRARI, strlen("FERRARI"));
//        DIAG_VERSION(GEELY, strlen("GEELY"));
//        DIAG_VERSION(GREATWALL, strlen("GREATWALL"));
//        DIAG_VERSION(GACMOTOR, strlen("GACMOTOR"));
//        DIAG_VERSION(PERODUA, strlen("PERODUA"));
//        DIAG_VERSION(SWMMOTOR, strlen("SWMMOTOR"));
//        DIAG_VERSION(SAICMG, strlen("SAICMG"));
//        DIAG_VERSION(SAICMAXUS, strlen("SAICMAXUS"));
//        DIAG_VERSION(SGMW, strlen("SGMW"));
        return std::string("");
    }
    
    static std::string const VehImmo(const char * strVeh)
    {
        // 在这里添加锁匠车型的版本号函数调用
//        IMMO_VERSION(ABARTH,strlen("ABARTH"));
//        IMMO_VERSION(ACURA,strlen("ACURA"));
//        IMMO_VERSION(ALFAROMEO,strlen("ALFAROMEO"));
//        IMMO_VERSION(AUDI,strlen("AUDI"));
//        IMMO_VERSION(BAICMOTOR,strlen("BAICMOTOR"));
//        IMMO_VERSION(CHERY,strlen("CHERY"));
//        IMMO_VERSION(BMW,strlen("BMW"));
//        IMMO_VERSION(CHRYSLER,strlen("CHRYSLER"));
//        IMMO_VERSION(CITROEN,strlen("CITROEN"));
//        IMMO_VERSION(CNTOYOTA,strlen("CNTOYOTA"));
//        IMMO_VERSION(DODGE,strlen("DODGE"));
//        IMMO_VERSION(DS,strlen("DS"));
//        IMMO_VERSION(DFHONDA,strlen("DFHONDA"));
//        IMMO_VERSION(FERRARI,strlen("FERRARI"));
//        IMMO_VERSION(FIAT,strlen("FIAT"));
//        IMMO_VERSION(FIATBRAZIL,strlen("FIATBRAZIL"));
//        IMMO_VERSION(FORD,strlen("FORD"));
//        IMMO_VERSION(FORDAU,strlen("FORDAU"));
//        IMMO_VERSION(FORDEU,strlen("FORDEU"));
//        IMMO_VERSION(GM,strlen("GM"));
//        IMMO_VERSION(GMBRAZIL,strlen("GMBRAZIL"));
//        IMMO_VERSION(GREATWALL,strlen("GREATWALL"));
//        IMMO_VERSION(GACMOTOR,strlen("GACMOTOR"));
//        IMMO_VERSION(GZHONDA,strlen("GZHONDA"));
//        IMMO_VERSION(HAVAL,strlen("HAVAL"));
//        IMMO_VERSION(HOLDEN,strlen("HOLDEN"));
//        IMMO_VERSION(HONDA,strlen("HONDA"));
//        IMMO_VERSION(HUMMER,strlen("HUMMER"));
//        IMMO_VERSION(HYUNDAI,strlen("HYUNDAI"));
//        IMMO_VERSION(INFINITI,strlen("INFINITI"));
//        IMMO_VERSION(ISUZU,strlen("ISUZU"));
//        IMMO_VERSION(JAGUAR,strlen("JAGUAR"));
//        IMMO_VERSION(JEEP,strlen("JEEP"));
//        IMMO_VERSION(JMC,strlen("JMC"));
//        IMMO_VERSION(KARRY,strlen("KARRY"));
//        IMMO_VERSION(KIA,strlen("KIA"));
//        IMMO_VERSION(LANCIA,strlen("LANCIA"));
//        IMMO_VERSION(LANDROVER,strlen("LANDROVER"));
//        IMMO_VERSION(LEXUS,strlen("LEXUS"));
//        IMMO_VERSION(MAHINDRA,strlen("MAHINDRA"));
//        IMMO_VERSION(MARUTI_SUZUKI,strlen("MARUTI_SUZUKI"));
//        IMMO_VERSION(MASERATI,strlen("MASERATI"));
//        IMMO_VERSION(MAZDA,strlen("MAZDA"));
//        IMMO_VERSION(MITSUBISHI,strlen("MITSUBISHI"));
//        IMMO_VERSION(NISSAN,strlen("NISSAN"));
//        IMMO_VERSION(OPEL,strlen("OPEL"));
//        IMMO_VERSION(PEUGEOT,strlen("PEUGEOT"));
//        IMMO_VERSION(RELY,strlen("RELY"));
//        IMMO_VERSION(RENAULT,strlen("RENAULT"));
//        IMMO_VERSION(RIICH,strlen("RIICH"));
//        IMMO_VERSION(SAAB,strlen("SAAB"));
//        IMMO_VERSION(SAICMAXUS,strlen("SAICMAXUS"));
//        IMMO_VERSION(SCION,strlen("SCION"));
//        IMMO_VERSION(SMART,strlen("SMART"));
//        IMMO_VERSION(SSANGYONG,strlen("SSANGYONG"));
//        IMMO_VERSION(SUBARU,strlen("SUBARU"));
//        IMMO_VERSION(SUZUKI,strlen("SUZUKI"));
//        IMMO_VERSION(SKODA,strlen("SKODA"));
//        IMMO_VERSION(SEAT,strlen("SEAT"));
//        IMMO_VERSION(TATA,strlen("TATA"));
//        IMMO_VERSION(TOYOTA,strlen("TOYOTA"));
//        IMMO_VERSION(VW,strlen("VW"));
//        IMMO_VERSION(WEY,strlen("WEY"));
//        IMMO_VERSION(FREQUENCY_DETECTION,strlen("FREQUENCY_DETECTION"));
//        IMMO_VERSION(GENERATE_TRANSPONDER,strlen("GENERATE_TRANSPONDER"));
//        IMMO_VERSION(TRANSPONDER_RECOGNITION,strlen("TRANSPONDER_RECOGNITION"));
//        IMMO_VERSION(TEST_IMMO_PKE_COIL,strlen("TEST_IMMO_PKE_COIL"));
//        IMMO_VERSION(BUICK,strlen("BUICK"));
//        IMMO_VERSION(CADILLAC,strlen("CADILLAC"));
//        IMMO_VERSION(CHEVROLET,strlen("CHEVROLET"));
//        IMMO_VERSION(GMC,strlen("GMC"));
//        IMMO_VERSION(PONTIAC,strlen("PONTIAC"));
//        IMMO_VERSION(SATURN,strlen("SATURN"));
//        IMMO_VERSION(LINCOLN,strlen("LINCOLN"));
//        IMMO_VERSION(MERCURY,strlen("MERCURY"));
//        IMMO_VERSION(VAUXHALL,strlen("VAUXHALL"));
//        IMMO_VERSION(JAC, strlen("JAC"));
//        IMMO_VERSION(MG, strlen("MG"));
//        IMMO_VERSION(ROEWE, strlen("ROEWE"));
//        IMMO_VERSION(WRITE_KEY_VIA_DUMP,strlen("WRITE_KEY_VIA_DUMP"));
//        IMMO_VERSION(BYD,strlen("BYD"));
//        IMMO_VERSION(GEELY,strlen("GEELY"));
//        IMMO_VERSION(EMGRAND,strlen("EMGRAND"));
//        IMMO_VERSION(ENGLON,strlen("ENGLON"));
//        IMMO_VERSION(GLEAGLE,strlen("GLEAGLE"));
//        IMMO_VERSION(MAPLE,strlen("MAPLE"));
//        IMMO_VERSION(DENZA,strlen("DENZA"));
//        IMMO_VERSION(BAICHUANSU,strlen("BAICHUANSU"));
//        IMMO_VERSION(BAICSENOVA,strlen("BAICSENOVA"));
//        IMMO_VERSION(BAICWEIWANG,strlen("BAICWEIWANG"));
//        IMMO_VERSION(BJEV,strlen("BJEV"));
//        IMMO_VERSION(GACAION,strlen("GACAION"));
//        IMMO_VERSION(DFNISSAN,strlen("DFNISSAN"));
//        IMMO_VERSION(DFVENUCIA,strlen("DFVENUCIA"));
//        IMMO_VERSION(CHANGAN,strlen("CHANGAN"));
        
        return std::string("");
    }
    
    static std::string const VehMoto(const char * strVeh)
    {
        //Motor
//        MOTO_VERSION(BMW, strlen("BMW"));
//        MOTO_VERSION(DUCATI, strlen("DUCATI"));
//        MOTO_VERSION(HARLEY, strlen("HARLEY"));
//        MOTO_VERSION(INDIAN, strlen("INDIAN"));
//        MOTO_VERSION(BRP, strlen("BRP"));
//        MOTO_VERSION(HONDA, strlen("HONDA"));
//        MOTO_VERSION(SUZUKI, strlen("SUZUKI"));
//        MOTO_VERSION(YAMAHA, strlen("YAMAHA"));
//        MOTO_VERSION(KAWASAKI, strlen("KAWASAKI"));
//        MOTO_VERSION(PIAGGIO, strlen("PIAGGIO"));
//        MOTO_VERSION(PEUGEOT, strlen("PEUGEOT"));
//        MOTO_VERSION(KTM, strlen("KTM"));
//        MOTO_VERSION(VICTORY, strlen("VICTORY"));
//        MOTO_VERSION(BENELLI, strlen("BENELLI"));
//        MOTO_VERSION(BROUGH, strlen("BROUGH"));
//        MOTO_VERSION(KYMCO, strlen("KYMCO"));
//        MOTO_VERSION(KELLER, strlen("KELLER"));
//        MOTO_VERSION(MORINI, strlen("MORINI"));
//        MOTO_VERSION(HM, strlen("HM"));
//        MOTO_VERSION(KSRMOTO, strlen("KSRMOTO"));
//        MOTO_VERSION(MGK, strlen("MGK"));
//        MOTO_VERSION(VENT, strlen("VENT"));
//        MOTO_VERSION(AGUSTA, strlen("AGUSTA"));
//        MOTO_VERSION(SHERCO, strlen("SHERCO"));
//        MOTO_VERSION(WOTTAN, strlen("WOTTAN"));
//        MOTO_VERSION(VERVE, strlen("VERVE"));
//        MOTO_VERSION(LEXMOTO, strlen("LEXMOTO"));
//        MOTO_VERSION(GGTECHNIK, strlen("GGTECHNIK"));
//        MOTO_VERSION(ITALJET, strlen("ITALJET"));
//        MOTO_VERSION(POLARIS, strlen("POLARIS"));
//        MOTO_VERSION(TRIUMPH, strlen("TRIUMPH"));
//        MOTO_VERSION(SYM, strlen("SYM"));
//        MOTO_VERSION(HUSQVARNA, strlen("HUSQVARNA"));
//        MOTO_VERSION(FANTIC, strlen("FANTIC"));
//        MOTO_VERSION(KEEWAY, strlen("KEEWAY"));
//        MOTO_VERSION(MH, strlen("MH"));
//        MOTO_VERSION(MALAGUTI, strlen("MALAGUTI"));
//        MOTO_VERSION(DEMO, strlen("DEMO"));
        return std::string("");
        
    }
};

#endif
