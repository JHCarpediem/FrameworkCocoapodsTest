#ifndef __T_PROG_MACO_H__
#define __T_PROG_MACO_H__

#include <cstdint>
#include <memory>

namespace CTprogMaco
{
    enum class MainFuncType :uint8_t
    {
        //主业务类型定义
        MFT_SYS         = 0x01,     // 系统，即TProg设备，应用一般不需要设置此类型，TProg设备的功能接口不在此设置

        MFT_EEPROM      = 0x02,     // 存储器
        MFT_MCU         = 0x03,     // MCU
        MFT_FREQ        = 0x04,     // 遥控频率
        MFT_RFID        = 0x05,     // RFID
        MFT_LinkTp      = 0x06,     // 写启动，钥匙生成

        INVALID         = 0xFF
    };

    // 业务开始前必须先初始化，所用到的参数全部都在对应的XML数据表
    typedef struct tagInit
    {
        // 初始化结构体
        uint8_t progType;    // proType,指编程类型(操作类型)
                             // 01 EEPROM       02 MCU
                             // 03 频率测试     04 RFID

        uint8_t subType;     // 子类型， progType的子类型
                             // 如当操作的是EEPROM时
                             // 01:  SPI类型  02 类SPI   03 IIC  04...

        uint8_t area;        // 指要操作的区域
                             // 01 EEPROM     02 FLASH
                             // 03 DFLASH     04 ID
                             // 05 分区       06 锁定
                             // 07 解锁       08 CONFIG
                             // 09 芯片信息

        uint32_t size;       // 大小

        uint8_t voltage;     // 电压，单位100mv
                             // 33=3.3V，120 = 12V

        // 配置参数1
        uint32_t config1;    // 例如，管脚配置，地址开始位置

        // 配置参数2
        uint32_t config2;    // 例如，分区大小
    }stINIT;


    typedef enum 
    {
        ST_START    = 0x00, //未初始化
        ST_INIT     = 0x01, //处于最初状态
        ST_END      = 0x8A, //完成生产
    }e_macStatus;

    typedef struct 
    {
        uint8_t     SN[14];         //SN
        uint8_t     BleMac[6];      //蓝牙MAC
        uint8_t     APP_ver[3];     //APP版本
        uint8_t     BLE_ver[2];     //蓝牙版本
        uint8_t     ACM_ver[2];     //加密芯片程序版本
        int8_t      BleName[32];    //蓝牙名称
        uint8_t     RN[6];          //RN
        e_macStatus status;         //状态(1个字节)
        uint16_t    crc16;
    }s_productInfo;

    typedef struct 
    {
        uint16_t    appID;          // 应用ID
        uint8_t     rev1[2];        // 保留
        uint32_t    appVersion;     // 应用版本;
        uint8_t     rev2[6];        // 保留
        uint16_t    flag;           // 52D2
    }s_sAppFunsInfo;

}


#endif // __T_PROG_MACO_H__


