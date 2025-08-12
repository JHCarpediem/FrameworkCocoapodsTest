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



// 在这里添加诊断车型名称申明
/*
BENZ 、 SMART、 SPRINTER 三款车型使用同一个framework
 */
DIAG_EXTERN(ACCSPEED);
DIAG_EXTERN(AUTOVIN);
DIAG_EXTERN(BENZ);
DIAG_EXTERN(BMW);
DIAG_EXTERN(CHRYSLER);
DIAG_EXTERN(COMM);
DIAG_EXTERN(CHECKVCI);
DIAG_EXTERN(DEMO);
DIAG_EXTERN(DAIHATSU);
DIAG_EXTERN(EOBD);
DIAG_EXTERN(FORD);
DIAG_EXTERN(FIAT);
DIAG_EXTERN(FIATBRAZIL);
DIAG_EXTERN(GM);
DIAG_EXTERN(HONDA);
DIAG_EXTERN(HYUNDAI);
DIAG_EXTERN(HAFEI);
DIAG_EXTERN(ISUZU);
DIAG_EXTERN(IM_PRECHECK);
DIAG_EXTERN(IVECO_LD);
DIAG_EXTERN(JMC);
DIAG_EXTERN(LANDROVER);
DIAG_EXTERN(LYNKCO);
DIAG_EXTERN(MITSUBISHI);
DIAG_EXTERN(MAZDA);
DIAG_EXTERN(MAHINDRA);
DIAG_EXTERN(NISSAN);
DIAG_EXTERN(OPEL);
DIAG_EXTERN(PORSCHE);
DIAG_EXTERN(PEUGEOT);
DIAG_EXTERN(PROTON);
DIAG_EXTERN(POLESTAR);
DIAG_EXTERN(RENAULT);
DIAG_EXTERN(SUBARU);
DIAG_EXTERN(SUZUKI);
DIAG_EXTERN(SSANGYONG);
DIAG_EXTERN(SAAB);
DIAG_EXTERN(SMART);
DIAG_EXTERN(SPRINTER);
DIAG_EXTERN(TOYOTA);
DIAG_EXTERN(TATA);
DIAG_EXTERN(VW);
DIAG_EXTERN(VOLVO);
//国产
DIAG_EXTERN(BYD);
DIAG_EXTERN(BAICMOTOR);
DIAG_EXTERN(CHERY);
DIAG_EXTERN(CHANGAN);
DIAG_EXTERN(DFXK);
DIAG_EXTERN(DFFS);
DIAG_EXTERN(DFFX);
DIAG_EXTERN(JAC);
DIAG_EXTERN(PERODUA);
DIAG_EXTERN(SWMMOTOR);
DIAG_EXTERN(SAICMG);
DIAG_EXTERN(GEELY);
DIAG_EXTERN(GREATWALL);
DIAG_EXTERN(GACMOTOR);
DIAG_EXTERN(CMC);
DIAG_EXTERN(SAICMAXUS);
DIAG_EXTERN(FAWCAR);
DIAG_EXTERN(FERRARI);
DIAG_EXTERN(SGMW);
DIAG_EXTERN(MASERATI);

// 在这里添加锁匠车型名称申明
IMMO_EXTERN(ABARTH);
IMMO_EXTERN(ACURA);
IMMO_EXTERN(ALFAROMEO);
IMMO_EXTERN(AUDI);
IMMO_EXTERN(BMW);
IMMO_EXTERN(BAICMOTOR);
IMMO_EXTERN(CHERY);
IMMO_EXTERN(CHRYSLER);
IMMO_EXTERN(CITROEN);
IMMO_EXTERN(CNTOYOTA);
IMMO_EXTERN(DODGE);
IMMO_EXTERN(DS);
IMMO_EXTERN(DFHONDA);
IMMO_EXTERN(FERRARI);
IMMO_EXTERN(FIAT);
IMMO_EXTERN(FIATBRAZIL);
IMMO_EXTERN(FORD);
IMMO_EXTERN(FORDAU);
IMMO_EXTERN(FORDEU);
IMMO_EXTERN(GM);
IMMO_EXTERN(GMBRAZIL);
IMMO_EXTERN(GREATWALL);
IMMO_EXTERN(GENERATE_TRANSPONDER);
IMMO_EXTERN(GACMOTOR);
IMMO_EXTERN(HAVAL);
IMMO_EXTERN(HOLDEN);
IMMO_EXTERN(HONDA);
IMMO_EXTERN(HUMMER);
IMMO_EXTERN(HYUNDAI);
IMMO_EXTERN(INFINITI);
IMMO_EXTERN(ISUZU);
IMMO_EXTERN(JAGUAR);
IMMO_EXTERN(JEEP);
IMMO_EXTERN(JMC);
IMMO_EXTERN(KARRY);
IMMO_EXTERN(KIA);
IMMO_EXTERN(LANCIA);
IMMO_EXTERN(LANDROVER);
IMMO_EXTERN(LEXUS);
IMMO_EXTERN(MAHINDRA);
IMMO_EXTERN(MARUTI_SUZUKI);
IMMO_EXTERN(MASERATI);
IMMO_EXTERN(MAZDA);
IMMO_EXTERN(MITSUBISHI);
IMMO_EXTERN(NISSAN);
IMMO_EXTERN(OPEL);
IMMO_EXTERN(PEUGEOT);
IMMO_EXTERN(RELY);
IMMO_EXTERN(RENAULT);
IMMO_EXTERN(RIICH);
IMMO_EXTERN(SAAB);
IMMO_EXTERN(SAICMAXUS);
IMMO_EXTERN(SCION);
IMMO_EXTERN(SMART);
IMMO_EXTERN(SSANGYONG);
IMMO_EXTERN(SUBARU);
IMMO_EXTERN(SUZUKI);
IMMO_EXTERN(SKODA);
IMMO_EXTERN(SEAT);
IMMO_EXTERN(TATA);
IMMO_EXTERN(TOYOTA);
IMMO_EXTERN(VW);
IMMO_EXTERN(WEY);
IMMO_EXTERN(FREQUENCY_DETECTION);
IMMO_EXTERN(TRANSPONDER_RECOGNITION);
IMMO_EXTERN(TEST_IMMO_PKE_COIL);
IMMO_EXTERN(BUICK);
IMMO_EXTERN(CADILLAC);
IMMO_EXTERN(CHEVROLET);
IMMO_EXTERN(GMC);
IMMO_EXTERN(GZHONDA);
IMMO_EXTERN(PONTIAC);
IMMO_EXTERN(SATURN);
IMMO_EXTERN(LINCOLN);
IMMO_EXTERN(MERCURY);
IMMO_EXTERN(JAC);
IMMO_EXTERN(VAUXHALL);
IMMO_EXTERN(MG);
IMMO_EXTERN(ROEWE);
IMMO_EXTERN(WRITE_KEY_VIA_DUMP);
IMMO_EXTERN(BYD);
IMMO_EXTERN(GEELY);
IMMO_EXTERN(EMGRAND);
IMMO_EXTERN(ENGLON);
IMMO_EXTERN(GLEAGLE);
IMMO_EXTERN(MAPLE);
IMMO_EXTERN(DENZA);
IMMO_EXTERN(BAICHUANSU);
IMMO_EXTERN(BAICSENOVA);
IMMO_EXTERN(BAICWEIWANG);
IMMO_EXTERN(BJEV);
IMMO_EXTERN(GACAION);
IMMO_EXTERN(DFNISSAN);
IMMO_EXTERN(DFVENUCIA);
IMMO_EXTERN(CHANGAN);

//Motor
MOTO_EXTERN(AGUSTA);
MOTO_EXTERN(BMW);
MOTO_EXTERN(BRP);
MOTO_EXTERN(BENELLI);
MOTO_EXTERN(BROUGH);
MOTO_EXTERN(DUCATI);
MOTO_EXTERN(HARLEY);
MOTO_EXTERN(HONDA);
MOTO_EXTERN(HM);
MOTO_EXTERN(INDIAN);
MOTO_EXTERN(KAWASAKI);
MOTO_EXTERN(KTM);
MOTO_EXTERN(KYMCO);
MOTO_EXTERN(KELLER);
MOTO_EXTERN(KSRMOTO);
MOTO_EXTERN(LEXMOTO);
MOTO_EXTERN(MORINI);
MOTO_EXTERN(MGK);
MOTO_EXTERN(PIAGGIO);
MOTO_EXTERN(PEUGEOT);
MOTO_EXTERN(VICTORY);
MOTO_EXTERN(VERVE);
MOTO_EXTERN(VENT);
MOTO_EXTERN(SUZUKI);
MOTO_EXTERN(SHERCO);
MOTO_EXTERN(WOTTAN);
MOTO_EXTERN(YAMAHA);
MOTO_EXTERN(GGTECHNIK);
MOTO_EXTERN(ITALJET);
MOTO_EXTERN(POLARIS);
MOTO_EXTERN(TRIUMPH);
MOTO_EXTERN(SYM);
MOTO_EXTERN(HUSQVARNA);
MOTO_EXTERN(FANTIC);
MOTO_EXTERN(KEEWAY);
MOTO_EXTERN(MH);
MOTO_EXTERN(MALAGUTI);
MOTO_EXTERN(DEMO);
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
        // 在这里添加诊断车型入口
//        DIAG_ENTRY(ACCSPEED, 8);
        DIAG_ENTRY(AUTOVIN, 7);
//        DIAG_ENTRY(BENZ, 4);
//        DIAG_ENTRY(BMW, 3);
//        DIAG_ENTRY(CHRYSLER, 8);
//        DIAG_ENTRY(COMM, 4);
//        DIAG_ENTRY(CHECKVCI,strlen("CHECKVCI"));
        DIAG_ENTRY(DEMO, 4);
//        DIAG_ENTRY(DAIHATSU, strlen("DAIHATSU"));
        DIAG_ENTRY(EOBD, 4);
//        DIAG_ENTRY(FORD, 4);
//        DIAG_ENTRY(FIAT, strlen("FIAT"));
//        DIAG_ENTRY(FIATBRAZIL, strlen("FIATBRAZIL"));
//        DIAG_ENTRY(GM, 2);
//        DIAG_ENTRY(HONDA, 5);
//        DIAG_ENTRY(HYUNDAI, 7);
//        DIAG_ENTRY(HAFEI, strlen("HAFEI"));
//        DIAG_ENTRY(ISUZU, 5);
//        DIAG_ENTRY(IM_PRECHECK, 11);
//        DIAG_ENTRY(IVECO_LD, strlen("IVECO_LD"));
//        DIAG_ENTRY(JMC, strlen("JMC"));
//        DIAG_ENTRY(LANDROVER, 9);
//        DIAG_ENTRY(LYNKCO, strlen("LYNKCO"));
//        DIAG_ENTRY(MITSUBISHI, 10);
//        DIAG_ENTRY(MAZDA, 5);
//        DIAG_ENTRY(MAHINDRA,strlen("MAHINDRA"));
//        DIAG_ENTRY(MASERATI, strlen("MASERATI"));
//        DIAG_ENTRY(NISSAN, 6);
//        DIAG_ENTRY(OPEL,strlen("OPEL"));
//        DIAG_ENTRY(PORSCHE, 7);
//        DIAG_ENTRY(PEUGEOT, 7);
//        DIAG_ENTRY(PROTON, strlen("PROTON"));
//        DIAG_ENTRY(POLESTAR, strlen("POLESTAR"));
//        DIAG_ENTRY(RENAULT, 7);
//        DIAG_ENTRY(SUBARU, 6);
//        DIAG_ENTRY(SUZUKI, 6);
//        DIAG_ENTRY(SSANGYONG, strlen("SSANGYONG"));
//        DIAG_ENTRY(SAAB,strlen("SAAB"));
//        DIAG_ENTRY(SMART, 5);
//        DIAG_ENTRY(SPRINTER, 8);
//        DIAG_ENTRY(TOYOTA, 6);
//        DIAG_ENTRY(TATA,strlen("TATA"));
//        DIAG_ENTRY(VOLVO,strlen("VOLVO"));
//        DIAG_ENTRY(VW, strlen("VW"));
//        //国产
//        DIAG_ENTRY(BYD, strlen("BYD"));
//        DIAG_ENTRY(BAICMOTOR, strlen("BAICMOTOR"));
//        DIAG_ENTRY(CHERY, strlen("CHERY"));
//        DIAG_ENTRY(CHANGAN, strlen("CHANGAN"));
//        DIAG_ENTRY(CMC, strlen("CMC"));
//        DIAG_ENTRY(DFXK, strlen("DFXK"));
//        DIAG_ENTRY(DFFS, strlen("DFFS"));
//        DIAG_ENTRY(DFFX, strlen("DFFX"));
//        DIAG_ENTRY(JAC, strlen("JAC"));
//        DIAG_ENTRY(FAWCAR, strlen("FAWCAR"));
//        DIAG_ENTRY(FERRARI, strlen("FERRARI"));
//        DIAG_ENTRY(GEELY, strlen("GEELY"));
//        DIAG_ENTRY(GREATWALL, strlen("GREATWALL"));
//        DIAG_ENTRY(GACMOTOR, strlen("GACMOTOR"));
//        DIAG_ENTRY(PERODUA, strlen("PERODUA"));
//        DIAG_ENTRY(SWMMOTOR, strlen("SWMMOTOR"));
//        DIAG_ENTRY(SAICMG, strlen("SAICMG"));
//        DIAG_ENTRY(SAICMAXUS, strlen("SAICMAXUS"));
//        DIAG_ENTRY(SGMW, strlen("SGMW"));
        

        
        //        DIAG_ENTRY(PSA, 3);
        return -1;
    }
    
    static uint32_t ArtiImmo(const char * strVeh)
    {
        // 在这里添加锁匠车型入口
//        IMMO_ENTRY(ABARTH,strlen("ABARTH"));
//        IMMO_ENTRY(ACURA,strlen("ACURA"));
//        IMMO_ENTRY(ALFAROMEO,strlen("ALFAROMEO"));
//        IMMO_ENTRY(AUDI,strlen("AUDI"));
//        IMMO_ENTRY(BMW,strlen("BMW"));
//        IMMO_ENTRY(BUICK,strlen("BUICK"));
//        IMMO_ENTRY(BAICMOTOR,strlen("BAICMOTOR"));
//        IMMO_ENTRY(CHERY,strlen("CHERY"));
//        IMMO_ENTRY(CHRYSLER,strlen("CHRYSLER"));
//        IMMO_ENTRY(CITROEN,strlen("CITROEN"));
//        IMMO_ENTRY(CNTOYOTA,strlen("CNTOYOTA"));
//        IMMO_ENTRY(CADILLAC,strlen("CADILLAC"));
//        IMMO_ENTRY(CHEVROLET,strlen("CHEVROLET"));
//        IMMO_ENTRY(DODGE,strlen("DODGE"));
//        IMMO_ENTRY(DS,strlen("DS"));
//        IMMO_ENTRY(DFHONDA,strlen("DFHONDA"));
//        IMMO_ENTRY(FERRARI,strlen("FERRARI"));
//        IMMO_ENTRY(FIAT,strlen("FIAT"));
//        IMMO_ENTRY(FIATBRAZIL,strlen("FIATBRAZIL"));
//        IMMO_ENTRY(FORD,strlen("FORD"));
//        IMMO_ENTRY(FORDAU,strlen("FORDAU"));
//        IMMO_ENTRY(FORDEU,strlen("FORDEU"));
//        IMMO_ENTRY(FREQUENCY_DETECTION,strlen("FREQUENCY_DETECTION"));
//        IMMO_ENTRY(GENERATE_TRANSPONDER,strlen("GENERATE_TRANSPONDER"));
//        IMMO_ENTRY(GM,strlen("GM"));
//        IMMO_ENTRY(GMBRAZIL,strlen("GMBRAZIL"));
//        IMMO_ENTRY(GREATWALL,strlen("GREATWALL"));
//        IMMO_ENTRY(GMC,strlen("GMC"));
//        IMMO_ENTRY(GACMOTOR,strlen("GACMOTOR"));
//        IMMO_ENTRY(GZHONDA,strlen("GZHONDA"));
//        IMMO_ENTRY(HAVAL,strlen("HAVAL"));
//        IMMO_ENTRY(HOLDEN,strlen("HOLDEN"));
//        IMMO_ENTRY(HONDA,strlen("HONDA"));
//        IMMO_ENTRY(HUMMER,strlen("HUMMER"));
//        IMMO_ENTRY(HYUNDAI,strlen("HYUNDAI"));
//        IMMO_ENTRY(INFINITI,strlen("INFINITI"));
//        IMMO_ENTRY(ISUZU,strlen("ISUZU"));
//        IMMO_ENTRY(JAGUAR,strlen("JAGUAR"));
//        IMMO_ENTRY(JEEP,strlen("JEEP"));
//        IMMO_ENTRY(JAC,strlen("JAC"));
//        IMMO_ENTRY(JMC,strlen("JMC"));
//        IMMO_ENTRY(KARRY,strlen("KARRY"));
//        IMMO_ENTRY(KIA,strlen("KIA"));
//        IMMO_ENTRY(LANCIA,strlen("LANCIA"));
//        IMMO_ENTRY(LANDROVER,strlen("LANDROVER"));
//        IMMO_ENTRY(LEXUS,strlen("LEXUS"));
//        IMMO_ENTRY(LINCOLN,strlen("LINCOLN"));
//        IMMO_ENTRY(MAHINDRA,strlen("MAHINDRA"));
//        IMMO_ENTRY(MARUTI_SUZUKI,strlen("MARUTI_SUZUKI"));
//        IMMO_ENTRY(MASERATI,strlen("MASERATI"));
//        IMMO_ENTRY(MAZDA,strlen("MAZDA"));
//        IMMO_ENTRY(MITSUBISHI,strlen("MITSUBISHI"));
//        IMMO_ENTRY(MERCURY,strlen("MERCURY"));
//        IMMO_ENTRY(MG,strlen("MG"));
//        IMMO_ENTRY(NISSAN,strlen("NISSAN"));
//        IMMO_ENTRY(OPEL,strlen("OPEL"));
//        IMMO_ENTRY(PEUGEOT,strlen("PEUGEOT"));
//        IMMO_ENTRY(PONTIAC,strlen("PONTIAC"));
//        IMMO_ENTRY(ROEWE,strlen("ROEWE"));
//        IMMO_ENTRY(RELY,strlen("RELY"));
//        IMMO_ENTRY(RENAULT,strlen("RENAULT"));
//        IMMO_ENTRY(RIICH,strlen("RIICH"));
//        IMMO_ENTRY(SAAB,strlen("SAAB"));
//        IMMO_ENTRY(SAICMAXUS,strlen("SAICMAXUS"));
//        IMMO_ENTRY(SCION,strlen("SCION"));
//        IMMO_ENTRY(SMART,strlen("SMART"));
//        IMMO_ENTRY(SSANGYONG,strlen("SSANGYONG"));
//        IMMO_ENTRY(SUBARU,strlen("SUBARU"));
//        IMMO_ENTRY(SUZUKI,strlen("SUZUKI"));
//        IMMO_ENTRY(SATURN,strlen("SATURN"));
//        IMMO_ENTRY(SKODA,strlen("SKODA"));
//        IMMO_ENTRY(SEAT,strlen("SEAT"));
//        IMMO_ENTRY(TRANSPONDER_RECOGNITION,strlen("TRANSPONDER_RECOGNITION"));
//        IMMO_ENTRY(TEST_IMMO_PKE_COIL,strlen("TEST_IMMO_PKE_COIL"));
//        IMMO_ENTRY(TATA,strlen("TATA"));
//        IMMO_ENTRY(TOYOTA,strlen("TOYOTA"));
//        IMMO_ENTRY(VW,strlen("VW"));
//        IMMO_ENTRY(VAUXHALL,strlen("VAUXHALL"));
//        IMMO_ENTRY(WEY,strlen("WEY"));
//        IMMO_ENTRY(WRITE_KEY_VIA_DUMP,strlen("WRITE_KEY_VIA_DUMP"));
//        IMMO_ENTRY(BYD,strlen("BYD"));
//        IMMO_ENTRY(GEELY,strlen("GEELY"));
//        IMMO_ENTRY(EMGRAND,strlen("EMGRAND"));
//        IMMO_ENTRY(ENGLON,strlen("ENGLON"));
//        IMMO_ENTRY(GLEAGLE,strlen("GLEAGLE"));
//        IMMO_ENTRY(MAPLE,strlen("MAPLE"));
//        IMMO_ENTRY(DENZA,strlen("DENZA"));
//        IMMO_ENTRY(BAICHUANSU,strlen("BAICHUANSU"));
//        IMMO_ENTRY(BAICSENOVA,strlen("BAICSENOVA"));
//        IMMO_ENTRY(BAICWEIWANG,strlen("BAICWEIWANG"));
//        IMMO_ENTRY(BJEV,strlen("BJEV"));
//        IMMO_ENTRY(GACAION,strlen("GACAION"));
//        IMMO_ENTRY(DFNISSAN,strlen("DFNISSAN"));
//        IMMO_ENTRY(DFVENUCIA,strlen("DFVENUCIA"));
//        IMMO_ENTRY(CHANGAN,strlen("CHANGAN"));
        
        return -1;
    }
    
    static uint32_t ArtiMoto(const char * strVeh)
    {
        //Motor
//        MOTO_ENTRY(BMW, strlen("BMW"));
//        MOTO_ENTRY(DUCATI, strlen("DUCATI"));
//        MOTO_ENTRY(VICTORY, strlen("VICTORY"));
//        MOTO_ENTRY(HARLEY, strlen("HARLEY"));
//        MOTO_ENTRY(INDIAN, strlen("INDIAN"));
//        MOTO_ENTRY(BRP, strlen("BRP"));
//        MOTO_ENTRY(HONDA, strlen("HONDA"));
//        MOTO_ENTRY(SUZUKI, strlen("SUZUKI"));
//        MOTO_ENTRY(YAMAHA, strlen("YAMAHA"));
//        MOTO_ENTRY(KAWASAKI, strlen("KAWASAKI"));
//        MOTO_ENTRY(PIAGGIO, strlen("PIAGGIO"));
//        MOTO_ENTRY(PEUGEOT, strlen("PEUGEOT"));
//        MOTO_ENTRY(KTM, strlen("KTM"));
//        MOTO_ENTRY(BENELLI, strlen("BENELLI"));
//        MOTO_ENTRY(BROUGH, strlen("BROUGH"));
//        MOTO_ENTRY(KYMCO, strlen("KYMCO"));
//        MOTO_ENTRY(KELLER, strlen("KELLER"));
//        MOTO_ENTRY(MORINI, strlen("MORINI"));
//        MOTO_ENTRY(HM, strlen("HM"));
//        MOTO_ENTRY(KSRMOTO, strlen("KSRMOTO"));
//        MOTO_ENTRY(MGK, strlen("MGK"));
//        MOTO_ENTRY(VENT, strlen("VENT"));
//        MOTO_ENTRY(AGUSTA, strlen("AGUSTA"));
//        MOTO_ENTRY(SHERCO, strlen("SHERCO"));
//        MOTO_ENTRY(WOTTAN, strlen("WOTTAN"));
//        MOTO_ENTRY(VERVE, strlen("VERVE"));
//        MOTO_ENTRY(LEXMOTO, strlen("LEXMOTO"));
//        MOTO_ENTRY(GGTECHNIK, strlen("GGTECHNIK"));
//        MOTO_ENTRY(ITALJET, strlen("ITALJET"));
//        MOTO_ENTRY(POLARIS, strlen("POLARIS"));
//        MOTO_ENTRY(TRIUMPH, strlen("TRIUMPH"));
//        MOTO_ENTRY(SYM, strlen("SYM"));
//        MOTO_ENTRY(HUSQVARNA, strlen("HUSQVARNA"));
//        MOTO_ENTRY(FANTIC, strlen("FANTIC"));
//        MOTO_ENTRY(KEEWAY, strlen("KEEWAY"));
//        MOTO_ENTRY(MH, strlen("MH"));
//        MOTO_ENTRY(MALAGUTI, strlen("MALAGUTI"));
//        MOTO_ENTRY(DEMO, strlen("DEMO"));
        return -1;
    }
};

#endif
