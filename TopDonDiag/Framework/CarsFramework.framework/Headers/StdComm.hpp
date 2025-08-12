#pragma once

#ifdef __cplusplus
#include <functional>


/*
 +++++++++++++++++++ 固件升级相关说明 +++++++++++++++++++++++++++
 ## 1. How to offline update the ArtiDiagVCI Device Firmware

 ## 2. Interface API as below:

 ### 2.1 FwEnterBoot
 // VCI进入BOOT模式，调用此接口后，VCI会重启进入升级模式
 // 应用程序在升级开始前判断VCI是否处于BOOT模式，如果没有
 // 没有在BOOT模式，就需要调用此接口后再重新判断是否BOOT模
 // 式后再进行升级数据传输
 EXTERN_C void WINAPI FwEnterBoot();

 ### 2.2 FwIsBoot
 // VCI是否处于BOOT模式
 // 1，BOOT模拟，即升级模式
 // 0，APP模式，即正常模式
 EXTERN_C INT WINAPI FwIsBoot();

 ### 2.3 FwDownload
 // 分包传输升级文件
 // FileTotalSize        固件总大小，即下位机的固件升级文件总大小
 // PackNo               需要Download数据包所在文件中的第几包序号
 // PackLength           需要Download数据包pPackData的长度
 // pPackData            需要Download数据包数据指针
 //
 // 1，成功
 // 0，失败
 //          注意: 发送一个固件升级文件，被分成N个数据包，每个Download
 //          数据包大小为2K或者4K，即2048或者4096， 各数据包必须
 //          按顺序递增发送，中间任何一个数据包Download失败，需
 //          要重新从0个数据包重新发送
 EXTERN_C INT WINAPI FwDownload(uint32_t FileTotalSize, uint32_t PackNo, const uint8_t* pPackData, uint32_t PackLength);

 ### 2.4 FwCheckSum
 // 传输升级文件CheckSum
 // FileTotalSize        固件总大小，即下位机的固件升级文件总大小
 // CheckSum             VCI固件升级文件的校验
 //
 // 1，成功
 // 0，失败
 //              注意: 发送VCI固件升级文件的校验与总大小必须在发送完所有
 //                    的固件数据包后，即在最后一个数据包发送完后发送。
 EXTERN_C INT WINAPI FwCheckSum(uint32_t FileTotalSize, uint32_t CheckSum);


 ### 2.5 FwDeviceType
 // 获取当前VCI的设备类型
 // AD900 VCI的设备类型是： 0x41443900
 EXTERN_C uint32_t WINAPI FwDeviceType();
 
 # The ArtiDiagVCI Device Firmware Update
 ## 1.  ArtiDiagVCI Device Firmware placed in the memory address 0x08020000 start from Sector 5 in MCU.

 ## 2.  Normally, ArtiDiagVCI Device Firmware Bin File Size about 150KByte~448KByte.

 ## 3.  Update the ArtiDiagVCI Device Firmware Step as bellow:
     Step1: Check the file Firmware bin is valid
     Step2: Put the Device Enter Boot mode
     Step3: Check and Sure the the Device Enter Boot mode
     Step4: Download the Firmware
     Step5: Transfer the checksum and the length of the firmware
     
 ## 4.  "ArtiDiagVciApp.bin" -- the firmware bin file

     Image Formats View:
          _________________________
         |  ArtiDiagVCI Image Head |
         |         (64Bytes)       |
         |_________________________|
         |                         |
         |         Software        |
         |                         |
         |_________________________|


     Image Formats Structure
          _______________________________________________________________________________________________
         |  Field      |    Offset   |  Size[Bytes]  |                 Description                       |
         |=============|=============|===============|===================================================|
         | device type |    0000h    |    16         |    device type string, Example 'AD900Relay207'    |
         |_____________|_____________|_______________|___________________________________________________|
         |   version   |    0010h    |    16         |  device version string, Example 'ArtiDiag V1.02'  |
         |_____________|_____________|_______________|___________________________________________________|
         |    size     |    0020h    |     4         |    length of the firmware image code              |
         |_____________|_____________|_______________|___________________________________________________|
         |  checksum   |    0024h    |     4         |    checksum of the firmware image code            |
         |_____________|_____________|_______________|___________________________________________________|
         |  reserved   |    0028h    |    24         |     reserved                                      |
         |_____________|_____________|_______________|___________________________________________________|
         |   image     |    0040h    |     X         |     Executable code                               |
         |_____________|_____________|_______________|___________________________________________________|


     Image Formats Structure Head:

     00000000h: 41 44 39 30 30 52 65 6C 61 79 32 30 37 00 00 00 ; AD900Relay207...
     00000010h: 41 72 74 69 44 69 61 67 20 56 31 2E 30 32 00 00 ; ArtiDiag V1.02..
     00000020h: 00 03 27 00 01 2C 8D E3 00 00 00 00 00 00 00 00 ; ..'..,嶃........
     00000030h: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ; ................

     strDeviceType = "AD900Relay207"
     strDeviceVersion = "ArtiDiag V1.02"
     size = 0x00032700
     checksum = 0x012C8DE3
*/



class CStdComm
{
private:
    CStdComm() = delete;
    ~CStdComm() = delete;
    
public:
    /* 通信接口初始化函数，加载此模块的时候调用（应用初始化libstdcomm.a） */
    // 此接口 app 调用 stdcomm
    static void Init();
    
    
    /* 退出此模块的时候调用 */
    // 此接口  app 调用 stdcomm
    static void DeInit();
    
    // 使能日志打印
    static void SetLogEnable(bool Flag);
    
    
    // 获取通信库版本号
    // 通信层版本信息
    // 例如通常情况为：V1.00
    static std::string const Version();
    
    
    // 获取蓝牙软件版本号
    // 蓝牙模组 JB631 蓝牙
    // 例如通常情况为：F.DJ.BD025.JB6321-30B1_v1.1.4.10
    static std::string const BtVersion();
    
    
    // 设置蓝牙模组进入升级模式
    // 蓝牙模组 JB6321 进入升级模式
    // true, 进入成功
    // false，进入升级模式失败
    static bool BtEnterUpdate();
    
    
    // 设置蓝牙模组退出升级模式
    // 蓝牙模组 JB6321 退出升级模式
    // true, 退出成功
    // false, 退出升级模式失败
    // 注意，调用此接口会断开蓝牙一次
    static bool BtExitUpdate();
    
    
    // 蓝牙模组复位
    // true, 复位成功
    // false, 复位失败
    static bool BtReset();
    
    // 蓝牙模组类型
    // 0        中易腾达蓝牙模组
    // 1        高盛达蓝牙模组
    // 0xFF     256, 未知
    // 注意，如果VCI未连接，返回0xFF, 未知
    //       如果VCI在BOOT模式，返回0xFF, 未知
    static uint32_t BtType();
    
    // 开启诊断通信日志
    // TypeName       对应的诊断类型，例如"DIAG"表示现在是诊断车型，或者"IMMO"表示现在是锁匠车型
    // VehName        对应的车型名称，例如"Nissan"
    //
    // 注意，App应加载诊断车型前调用此接口，保证诊断日志的完整性
    //
    static void StartLog(const std::string& TypeName, const std::string& VehName);
    
    
    // 停止诊断通信日志
    // 返回std::string数组，数组个数为文件个数，每个元素为一个日志文件路径
    // 如果std::string数组只有一个元素，则只有一个日志文件
    //
    // 场景1：返回一个日志文件
    //        元素0为："/mnt/sdcard/Android/data/com.td.diag.artidiag/files/TD/TD001/DataLog/Nissan/StdComm_20220113_192428__373.txt"
    //
    // 场景2：返回两个日志文件
    //        元素0为："/mnt/sdcard/Android/data/com.TD.diag.artidiag/files/TD/TD001/DataLog/Nissan/StdComm_20220113_210700___9360.txt"
    //        元素1位："/mnt/sdcard/Android/data/com.TD.diag.artidiag/files/TD/TD001/DataLog/Nissan/StdComm_20220113_192428__373.txt"
    static std::vector<std::string> const StopLog();
    
    // 获取诊断通信日志
    // 返回std::string数组，数组个数为文件个数，每个元素为一个日志文件路径
    // 如果std::string数组只有一个元素，则只有一个日志文件
    //
    // 场景1：返回一个日志文件
    //        元素0为："/mnt/sdcard/Android/data/com.topdon.diag.artidiag/files/TopDon/TD001/DataLog/Nissan/StdComm_20220113_192428__373.txt"
    //
    // 场景2：返回两个日志文件
    //        元素0为："/mnt/sdcard/Android/data/com.topdon.diag.artidiag/files/TopDon/TD001/DataLog/Nissan/StdComm_20220113_210700___9360.txt"
    //        元素1位："/mnt/sdcard/Android/data/com.topdon.diag.artidiag/files/TopDon/TD001/DataLog/Nissan/StdComm_20220113_192428__373.txt"
    static std::vector<std::string> const GetLogPath();
    
    //
    // void LogVeh(String strLog);
    //
    // 向诊断通信日志文件中写入日志
    // strLog     需要写入日志内容
    //
    // 注意，LogVeh会自动追加换行
    //
    static void LogVeh(const std::string& strLog);

    
    
    // VCI固件相关
    //===================================================================================
    
    // VCI固件版本信息
    // 例如通常情况为：
    // AD900 RelayV3 Jul  8 2021 V1.02
    // App应用自己去掉前面的日期字串，例如去掉后是V1.02
    static std::string const FwVersion();
    
    // 国内版TOPVCI 获取空气质量等级接口【0, 100】
    /*
    *   uint32_t GetAirQuality();
    *
    *   参数
    *       无
    *
    *   返 回 值：如果设备没有连接或者指针为空，返回-1
    *            返回获取到的空气传感器模组的空气质量等级，【0, 100】
    */
    static uint32_t GetAirQuality();
    
    
    // 国内版TOPVCI 获取空气传感器已运行多少时间，单位毫秒
    /*
    *   uint32_t GetAirUpTime();
    *
    *   参数
    *       无
    *
    *   返 回 值：如果设备没有连接或者指针为空，返回-1
    *           返回获取到空气传感器已运行多少时间，单位毫秒
    */
    static uint32_t GetAirUpTime();
    
    // FwDeviceType
    //
    // 获取当前VCI的设备类型
    //                                     uint32_t            固件标识             VCI名称
    // AD900 Tool 的设备类型是：            0x41443900         "AD900Relay207"       "AD900TOOL"
    // AD900 VCI（小接头）的设备类型是：      0x4E333247         "AD900VCIN32G455"     "AD900VCI"
    // TOPKEY EasyVCI（小接头）的设备类型是： 0x45564349         "EasyVCIGD32F305"     "EasyVCI"
    static uint32_t FwDeviceType();
    
    
    // VCI进入BOOT模式，调用此接口后，VCI会重启进入升级模式
    // 应用程序在升级开始前判断VCI是否处于BOOT模式，如果没有
    // 没有在BOOT模式，就需要调用此接口后再重新判断是否BOOT模
    // 式后再进行升级数据传输
    // 此接口为阻塞接口，至VCI执行了进入boot模式指令，大概时间为1秒（usb）
    static void FwEnterBoot();
    
    
    // VCI是否处于BOOT模式
    // 1，BOOT模拟，即升级模式
    // 0，APP模式，即正常模式
    static uint32_t FwIsBoot();
    
    
    // 分包传输升级文件
    // FileTotalSize        固件总大小，即下位机的固件升级文件总大小
    // PackNo               需要Download数据包所在文件中的第几包序号
    // vctPackData          需要Download数据包
    //
    // 1，成功
    // 0，失败
    //          注意: 发送一个固件升级文件，被分成N个数据包，每个Download
    //          数据包大小为2K或者4K，即2048或者4096， 各数据包必须
    //          按顺序递增发送，中间任何一个数据包Download失败，需
    //          要重新从0个数据包重新发送
    static uint32_t FwDownload(uint32_t FileTotalSize, uint32_t PackNo, const std::vector<uint8_t>& vctPackData);
    
    
    // 传输升级文件CheckSum
    // FileTotalSize        固件总大小，即下位机的固件升级文件总大小
    // CheckSum             VCI固件升级文件的校验
    //
    // 1，成功
    // 0，失败
    //              注意: 发送VCI固件升级文件的校验与总大小必须在发送完所有
    //                    的固件数据包后，即在最后一个数据包发送完后发送。
    static uint32_t FwCheckSum(uint32_t FileTotalSize, uint32_t CheckSum);
    
    
    // 获取VCI的序列号
    // 返回VCI的序列号, 例如：“JV0013BA100044”
    // 如果VCI设备没有连接，返回空串，""
    // 此接口  app 调用 stdcomm
    static std::string VciSn();
    
    
    // 获取VCI的6字节注册码
    // 返回VCI的注册码, 例如：“123456”
    // 如果VCI设备没有连接，返回空串，""
    // 此接口  app 调用 stdcomm
    static std::string VciCode();
    
    
    // 获取VCI的MCU的ID
    // 当前MCU的唯一ID，即UID(Unique device ID)
    // 此MCU的唯一ID来自MCU芯片厂商，可参考对应的MCU芯片参考手册
    // 通常情况下，VCI的McuUID的长度，等于12个字节，即96位的字节
    // VCI MCU的ID, 例如：[27 00 34 00 03 51 38 32 30 34 35 32]
    // 返回 "270034000351383230343532"
    // 此接口  app 调用 stdcomm
    static std::string VciMcuId();
    
    
    // CANFD固件相关
    //===================================================================================
    // 获取当前CANFD的固件版本信息
    // CANFD固件版本信息
    // 例如通常情况为：V1.02
    static std::string const CanFdVersion();
    
    
    // uint32_t FwDeviceType()
    //
    // 获取当前CANFD的设备类型
    // PIC18FQ84设备类型是：           0x50484300         "PIC"
    // GD32C103的设备类型是：          0x47443332         "GD32"
    // MCP2518的设备类型是：           0x32353138         "2518"
    static uint32_t CanFdDeviceType();
    
    
    // void CanFdEnterBoot()
    //
    // CANFD进入BOOT模式，调用此接口后，CANFD会重启进入升级模式
    // 应用程序在升级开始前判断CANFD是否处于BOOT模式，如果没有
    // 没有在BOOT模式，就需要调用此接口后再重新判断是否BOOT模
    // 式后再进行升级数据传输
    static void CanFdEnterBoot();
    
    
    // int CanFdIsBoot()
    //
    // CANFD是否处于BOOT模式
    // 1，BOOT模拟，即升级模式
    // 0，APP模式，即正常模式
    static uint32_t CanFdIsBoot();
    
    
    // 分包传输CANFD升级文件
    // FileTotalSize        固件总大小，即下位机的固件升级文件总大小
    // PackNo               需要Download数据包所在文件中的第几包序号
    // dataArray            需要Download数据包dataArray
    //
    // 1，成功
    // 0，失败
    //          注意: 发送一个固件升级文件，被分成N个数据包，每个Download
    //          数据包大小为2K或者4K，即2048或者4096， 各数据包必须
    //          按顺序递增发送，中间任何一个数据包Download失败，需
    //          要重新从0个数据包重新发送
    static uint32_t CanFdDownload(uint32_t FileTotalSize, uint32_t PackNo, const std::vector<uint8_t>& vctPackData);
    
    
    // 传输升级文件CheckSum
    // FileTotalSize        固件总大小，即下位机的固件升级文件总大小
    // CheckSum             VCI固件升级文件的校验
    //
    // 1，成功
    // 0，失败
    //              注意: 发送VCI固件升级文件的校验与总大小必须在发送完所有
    //                    的固件数据包后，即在最后一个数据包发送完后发送。
    static uint32_t CanFdCheckSum(uint32_t FileTotalSize, uint32_t CheckSum);
    
    
    // MT7628固件相关
    //=================================================================================================================
    // WiFi模组MT7628包括系统软件和应用软件
    // 系统软件包含系统版本号、硬件版本号和UBOOT版本号
    // 应用软件包含应用版本号和库版本号
    //
    // 应用软件版本号返回值举例(中间换行符间隔)
    // App Version: V1.01.006
    // Lib Version: V1.01.006
    //
    // 表示App版本号为V1.01.006，Lib版本号为V1.01.006
    //
    // 如果读取失败（例如VCI在Boot模式），返回空或者空串
    static std::string const MT7628AppVersion();

    // WiFi模组MT7628包括系统软件和应用软件
    // 系统软件包含系统版本号、硬件版本号和UBOOT版本号
    // 应用软件包含应用版本号和库版本号
    //
    // OS软件版本号返回值举例(中间换行符间隔)
    // Software version:01.00.04
    // Hardware version:1.0.2
    // Uboot version:5.0.0.0
    //
    // 表示OS版本号为V1.00.04，
    // 硬件版本号为V1.00.002，
    // UBOOT版本号为V5.00.000
    //
    // 如果读取失败（例如VCI在Boot模式），返回空或者空串
    static std::string const MT7628OsVersion();

    // 获取MT7628的设备类型, 系统和应用软件的设备ID为同一个，
    // 0x37363238，固件标识为"MasterMT7628"
    //
    // 返回值举例
    // 成功，返回0x37363238
    // 失败，返回0x00000000
    static uint32_t MT7628DeviceType();

    // 分包传输升级文件
    //
    // Type              升级的文件类型
    //                   0: 系统固件升级包，
    //                   1: 应用升级包(Mt7628Manager)
    //                   2: 应用库升级包(libTcpClient.so)
    //
    // FileTotalSize     固件总大小，即下位机的固件升级文件总大小
    // PackNo            需要Download数据包所在文件中的第几包序号
    // dataArray         需要Download数据包
    //
    // 1，成功
    // 0，失败
    //          注意: 发送一个升级文件，被分成N个数据包，每个Download
    //          数据包大小为2K或者4K，即2048或者4096， 各数据包必须
    //          按顺序递增发送，中间任何一个数据包Download失败，需
    //          要重新从0个数据包重新发送
    static uint32_t MT7628Download(uint32_t Type, uint32_t FileTotalSize, uint32_t PackNo, const std::vector<uint8_t>& vctPackData);

    // 传输升级文件CheckSum
    //
    // Type              升级的文件类型
    //                   0: 系统固件升级包，
    //                   1: 应用升级包(Mt7628Manager)
    //                   2: 应用库升级包(libTcpClient.so)
    //
    // FileTotalSize     固件总大小，即对应传输的固件升级文件总大小
    // CheckSum          对应升级文件的校验
    //
    // 1，成功
    // 0，失败
    //
    // 注意: 发送升级文件的校验与总大小必须在发送完所有
    //       的文件数据包后，即在最后一个数据包发送完后发送
    static uint32_t MT7628CheckSum(uint32_t Type, uint32_t FileTotalSize, uint32_t CheckSum);

    // 通常情况下MT7628启动并wifi正常，需要1分钟左右
    // 此接口确定MT7628是否已经准备好
    //
    // 返回值举例
    // 成功，1，启动完成，可以使用
    // 失败，0，没有准备好
    static uint32_t MT7628IsReady();

    // WIFI模组复位
    // true, 复位成功
    // false, 复位失败
    static bool MT7628Reset();

    // 获取WiFi模组的SSID名称，即WiFi的名称
    //
    // 举例，"TopScan1234"
    //
    // 如果读取失败，返回空或者空串
    static std::string const MT7628ReadWiFiName();

    // 获取WiFi模组的MAC，格式为XX:XX:XX:XX:XX:XX
    //
    // 举例，12:34:56:78:9A:BC
    //
    // 如果读取失败，返回空或者空串
    static std::string const MT7628ReadWiFiMac();

    // 当前连接的VCI类型是否支持MT7628
    //
    // true, 支持MT7628（即当前VCI有MT7628的WiFi模组）
    // false, 不支持MT7628（即当前VCI没有MT7628的WiFi模组）
    // 如果当前VCI没有连接，返回false
    static bool MT7628IsSupported();

    //=================================================================================================================
    
    
    // TDarts TProg 接口相关
    //===================================================================================
    
    // TDarts/TProg 版本信息接口
    /*-----------------------------------------------------------------------------
      功    能：获取 TDarts/TProg 系统信息

      参数说明：无

      返 回 值："not connected"，设备没有连接，表示与设备没有连接，例如串口失去通信
                ""，系统信息
                "timeout"，获取超时

      说    明：获取系统信息
               App调用此接口，TDarts版本信息接口
    -----------------------------------------------------------------------------*/
    std::string const TProgSysInfo();

    
    // TDarts/TProg 升级接口
    /*-----------------------------------------------------------------------------
      功    能：跳转到BOOT（只有升级本机固件才用到）

      参数说明：无

      返 回 值：0，成功
                8，表示与设备没有连接，例如串口失去通信，或者蓝牙没有连接

      说    明：App调用此接口，TDarts/TProg跳转到BO
               App调用此接口，TDarts/TProg跳转到BOOT
    -----------------------------------------------------------------------------*/
    uint32_t TProgJumpBoot();

    
    // TDarts/TProg 升级接口
    /*-----------------------------------------------------------------------------
        功    能：升级初始化

        参数说明：uint16_t Crc16     2字节CRC16，从固件文件开始计算

                  uint16_t FmType    固件类型：
                                          0：本机固件
                                          1：蓝牙固件
                                          2：加密芯片固件
                                          3：加密芯片BOOT
                                          4：保留
                                          5：子应用程序
                                          ...

                  uint32_t FmSize    固件大小

        返 回 值：0，成功
                8，表示与设备没有连接，例如串口失去通信，或者蓝牙没有连接

        说    明：升级初始化，非阻塞接口
                 APK调用此接口，TDarts/TProg升级初始化
    -----------------------------------------------------------------------------*/
    uint32_t TProgUpdateInit(uint16_t Crc16, uint16_t FmType, uint32_t FmSize);


    // TDarts/TProg 升级接口
    /*-----------------------------------------------------------------------------
        功    能：升级写入数据


        参数说明：uint32_t AddressIdx    写入数据偏移，从0开始

                const std::vector<uint8_t>& vctDownload  本次写入的数据数组

        返 回 值：0，成功
                  8，表示与设备没有连接，例如串口失去通信
                  9，表示写入的数据太长

        说    明：升级数据写入
                APK调用此接口，TDarts/TProg升级数据传输
    -----------------------------------------------------------------------------*/
    uint32_t TProgUpdateData(uint32_t AddressIdx, const std::vector<uint8_t>& vctDownload);


    // TDarts/TProg 升级接口
    /*-----------------------------------------------------------------------------
        功    能：升级结束

        参数说明：无

        返 回 值：0，成功
                8，表示与设备没有连接，例如串口失去通信

        说    明：升级结束
                 App调用此接口，TDarts/TProg升级结束
    -----------------------------------------------------------------------------*/
    uint32_t TProgUpdateEnd();
    
    
    
//注册回调函数
//===================================================================================
public:
    /*
     可以简单理解为，App为通信层提供的一个蓝牙通信桥，通过此通信桥，通信层代码能够实现蓝牙数据的收发。
     蓝牙通信桥介于 通信层 与 App 之间，App 为 通信层 提供蓝牙通信透传功能，从而App不需要关心
     上下位机的通讯协议，通信层也不需要关心App具体的蓝牙操作（包括用户蓝牙连接交互），通信层更多
     的关注于上下位机的逻辑连接（而非蓝牙层面的连接）。
     */
    // 通信桥接的4个接口
    //  OpenDevice              @ 1
    //  CloseDevice             @ 2
    //  SendToDevice            @ 3
    //  ReceiveFromDevice       @ 4
    //
    //
    /*
     +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     bool OpenDevice(void);
     
     功能： 将打开蓝牙通信桥模块，并试图连接远端蓝牙
           调用者在成功调用此接口后，可以通过SendToBlueTooth向远端蓝牙发送数据
           也可以通过ReceiveFromBlueTooth读取从远端蓝牙发送过来的数据
           
     
     返回值定义：
         true，    打开本地蓝牙成功，与远端蓝牙配对上并且已经连接上远端蓝牙
         false，   打开本地蓝牙失败，或者与远端蓝牙配对失败，或者连接远端蓝牙失败
     
     
     
     +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     bool CloseDevice(void);
     
     功能： 关闭蓝牙通信功能

           调用者在发现SendToBlueTooth返回-1（0xFFFFFFFF），或者ReceiveFromBlueTooth返回-1（0xFFFFFFFF）
           的情况下（例如蓝牙连接断开），将会立即调用CloseDevice，释放相关资源后，将会再次调用OpenDevice（再
           次尝试重新建立蓝牙连接）。

           调用者调用CloseDevice成功后，如果没有再次调用OpenDevice，就直接调用SendToBlueTooth和
           ReceiveFromBlueTooth，App 都将返回-1（0xFFFFFFFF）。
           
     返回值定义：
         true，    关闭蓝牙通信桥成功
         false，   关闭蓝牙通信桥失败
     
     
     
     +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     uint32_t SendToDevice(uint8_t *pSendBuffer, uint32_t SendLength);
     
     功能： 向远端蓝牙发送数据
           待发送数据存放（Placed）在pSendBuffer缓存中，发送成功返回0，发送失败或者与远端蓝牙失去通信，
           返回-1（0xFFFFFFFF）。如果发送失败，调用者不会去尝试重新发送操作。此接口阻塞接口。

           如果App返回-1（0xFFFFFFFF），调用者将立即关闭蓝牙CloseDevice，重新OpenDevice。
           
           调用者负责分配pSendBuffer缓存空间，保证至少有SendLength大小
           
     参数定义：
         pSendBuffer             待发送的数据
         SendLength              待发送的数据长度
     
     返回值定义：
         -1，      发送失败，或者与远端蓝牙失去通信
         其他值，  成功发送的数据个数
     
     
     
     +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     uint32_t ReceiveFromDevice(uint8_t *pRecvBuffer, uint32_t RecvLength);
     功能：从远端蓝牙接收数据
     
           从App缓存中读取远端蓝牙接收到的数据，App将读取到的数据存放在pRecvBuffer中，并返回对应的长度。

           此接口为非阻塞函数，通信层会轮询调用此接口，并且通信层应负责上下位机的数据包解包动作。
           即，调用者将重复调用ReceiveFromDevice，直到调用者认为已经接收到相应的数据包了（数据包有
           相应的数据头和长度，App不需要关心数据包的格式）
                    
           调用者负责分配 pRecvBuffer 缓存空间，保证至少有 RecvLength 大小
           
           
     参数定义：
         pRecvBuffer             存放从远端蓝牙接收到的数据
         RecvLength              期望从远端蓝牙接收数据的长度
     
     返回值定义：
         -1，      接收远端蓝牙数据失败，或者与远端蓝牙失去通信
         其他值，  接收到远端蓝牙的实际数据个数
         如果实际接收到的蓝牙数据大于RecvLength，应返回前RecvLength长度的数据，通信层会继续接收剩余的数据

    */
    static void InitCommBridge(std::function<bool()> fnOpen,
                               std::function<bool()> fnClose,
                               std::function<uint32_t(uint8_t *, uint32_t)> fnSend,
                               std::function<uint32_t(uint8_t *, uint32_t)> fnReceive);
    
    /*
     *   注册StdComm 的静态成员函数 VciStatus 回调函数
     *
     *   VCI 连接状态 和 OBD引脚 PIN16电压
     *
     *   void VciStatus(uint32_t VciStatus, uint32_t BatteryVolt);
     *
     *   参数
     *       VciStatus 0，未连接； 1，已连接； 其他值，保留
     *       BatteryVolt 电池电压，单位毫伏
     *
     *   返回：无
     *
     */
    static void VciStatus(std::function<void(uint32_t, uint32_t)> fnVciStatus);
    
    /*
     *   注册 StdComm 的静态成员函数 GetAppDataPath 回调函数
     *
     *   获取App数据路径，例如 TD/AP200，将返回TD/AP200的全路径名
     *
     *   std::string const GetAppDataPath();
     *
     *   参数：无
     *
     *   返回：App数据全路径名
     *
     */
    static void GetAppDataPath(std::function<std::string const()> fnGetAppDataPath);
    
    /*
    *   注册 StdComm 静态成员函数 GetAppVersion 的回调函数
    *
    *   uint32_t GetAppVersion();
    *
    *   GetAppVersion 参数说明：无
    *
    *   GetAppVersion 返 回 值：32位 整型 0xHHLLYYXX
    *
    *   GetAppVersion 说    明：Coding of version numbers
    *
    *                         HH 为 最高字节, Bit 31 ~ Bit 24   主版本号（正式发行），0...255
    *                         LL 为 次高字节, Bit 23 ~ Bit 16   次版本号（正式发行），0...255
    *                         YY 为 次低字节, Bit 15 ~ Bit 8    最低版本号（测试使用），0...255
    *                         XX 为 最低字节, Bit 7 ~  Bit 0    保留
    *
    *                         例如 0x02010300, 表示 V2.01.003
    *                         例如 0x020B0000, 表示 V2.11
    */
    static void GetAppVersion(std::function<uint32_t()> fnGetAppVersion);
    
    /*
    *   注册 StdComm 的静态成员函数 GetStdShowVersion 回调函数
    *
    *   获取当前公共库stdshow的版本号，此接口返回的是版本号的所见字符串
    *
    *   std::string const GetStdShowVersion();
    *
    *   例如：V1.37.027
    */
    static void GetStdShowVersion(std::function<std::string const()> fnGetStdShowVersion);
    
    /*
     *   注册 StdComm 的静态成员函数 GetVehName 回调函数
     *
     *   当前车型路径的文件夹名称
     *
     *   std::string const GetVehName();
     *
     *   参数：无
     *
     *   返回：例如Demo
     *
     */
    static void GetVehName(std::function<std::string const()> fnGetVehName);
    
    /*
     *   注册 StdComm 的静态成员函数 GetVIN 回调函数
     *
     *   获取当前车辆VIN码
     *
     *   std::string const GetVIN();
     *
     *   参数：无
     *
     *   返回：例如 LFV3A23C2H3181097
     *
     */
    static void GetVIN(std::function<std::string const()> fnGetVIN);
    
    /*
    *   注册 StdComm 的静态成员函数 GetVehInfo 回调函数
    *
    *   获取当前车辆信息
    *
    *   std::string const GetVehInfo();
    *
    *   例如：宝马/3'/320Li_B48/F35/
    */
    static void GetVehInfo(std::function<std::string const()> fnGetVehInfo);

    /*
    *   注册 StdComm 的静态成员函数 GetDiagVer 回调函数
    *
    *   获取当前诊断车型的版本号，此接口返回的是版本号的所见字符串
    *
    *   std::string const GetDiagVer();
    *
    *   例如：V1.00.001
    */
    static void GetDiagVer(std::function<std::string const()> fnGetDiagVer);
    
    /*
    *   注册 StdComm 的静态成员函数 GetDiagMainVer 回调函数
    *
    *   获取当前诊断车型主车的版本号，此接口返回的是版本号的可见字符串
    *   如果当前车是链接车，需要返回主车的版本号
    *   例如, 当前车是宾利，是大众的链接车，此接口需要返回大众的版本号
    *         宾利是V1.01，大众是V1.22，返回V1.22
    *
    *   如果当前车不是链接车，则此接口返回空串
    *
    *   返回当前的运行车型的主车版本号
    *   std::string const GetDiagMainVer();
    *
    *   例如：V1.00.001
    */
    static void GetDiagMainVer(std::function<std::string const()> fnGetDiagMainVer);
    
    /*
     *   注册StdComm 的的静态成员函数 GetPhoneModel 回调函数
     *
     *   获取当前手机型号
     *
     *   std::string const GetPhoneModel();
     *
     *   参数
     *       无
     *
     *   返回：手机型号，例如，"iPhone 13 Pro"
     *
     */
    static void GetPhoneModel(std::function<std::string const(void)> fnGetPhoneModel);
    
    
    
    //////////////////////////////////////////////////////////////============================================================
    /*
     *   注册StdComm 的静态成员函数 TProgStatus 回调函数
     *
     *   TProgStatus 0，未连接； 1，已连接； 其他值，保留
     *
     *   void TProgStatus(uint32_t TProgStatus, uint32_t Reserved);
     *
     *   参数
     *       TProgStatus 0，未连接； 1，已连接； 其他值，保留
     *       Reserved 保留
     *
     *   返回：无
     *
     */
    static void TProgStatus(std::function<void(uint32_t, uint32_t)> fnTProgStatus);
    
    /*
     *   注册StdComm 的静态成员函数 TProgInformation 回调函数
     *
     *   TDarts 信息回调，包括SN，注册码，MCUID
     *   void TProgInformation(const std::string& strSn, const std::string& strCode, const std::string& strMcuId)
     *
     *   参数
     *       SN即TDarts的序列号, 例如：“0013BA100044”
     *       MCUID即前当前TDarts的唯一ID，即UID(Unique device ID)
     *
     *   返回：TDarts MCU的ID, 例如：[27 00 34 00 03 51 38 32 30 34 35 32]
     *        "270034000351383230343532"
     *
     */
    static void TProgInformation(std::function<void(const std::string&, const std::string&, const std::string&)> fnTProgInformation);
    
    /*
    *
    *   bool TProgBtOpen();
    *
    *   通信库调用App，要求建立TProg/TDart的蓝牙连接
    *
    *   返 回 值：
    *           true    与TProg/TDart的蓝牙配对并连接成功
    *           false   与TProg/TDart的蓝牙配对或连接失败
    *
    *   说明：此接口非阻塞，通信库调用App
    *
    *
    *
    *   public static bool TProgBtClose();
    *
    *   通信库调用APK，要求断开TProg/TDart的蓝牙连接
    *   与TProg/TDart的蓝牙断开连接
    *
    *   说明：此接口非阻塞，通信库调用App
    *
    *
    *
    *   uint32_t TProgBtSend(uint8_t *pSendBuffer, uint32_t SendLength);
    *
    *   功能： 向远端蓝牙发送数据
    *         待发送数据存放（Placed）在pSendBuffer缓存中，发送成功返回0，发送失败或者与远端蓝牙失去通信，
    *         返回-1（0xFFFFFFFF）。如果发送失败，调用者不会去尝试重新发送操作。此接口阻塞接口。
    *
    *         如果App返回-1（0xFFFFFFFF），调用者将立即关闭蓝牙TProgBtClose，重新TProgBtOpen。
    *
    *         调用者负责分配pSendBuffer缓存空间，保证至少有SendLength大小
    *
    *   参数定义：
    *       pSendBuffer             待发送的数据
    *       SendLength              待发送的数据长度
    *
    *   返回值定义：
    *       -1，      发送失败，或者与远端蓝牙失去通信
    *       其他值，  成功发送的数据个数
    *
    *
    *
    *   uint32_t TProgBtReceive(uint8_t *pRecvBuffer, uint32_t RecvLength);
    *   功能：从远端蓝牙接收数据
    *
    *         从App缓存中读取远端蓝牙接收到的数据，App将读取到的数据存放在pRecvBuffer中，并返回对应的长度。

    *         此接口为非阻塞函数，通信层会轮询调用此接口，并且通信层应负责上下位机的数据包解包动作。
    *         即，调用者将重复调用ReceiveFromDevice，直到调用者认为已经接收到相应的数据包了（数据包有
    *         相应的数据头和长度，App不需要关心数据包的格式）
    *
    *         调用者负责分配 pRecvBuffer 缓存空间，保证至少有 RecvLength 大小
    *
    *
    *   参数定义：
    *       pRecvBuffer             存放从远端蓝牙接收到的数据
    *       RecvLength              期望从远端蓝牙接收数据的长度
    *
    *   返回值定义：
    *       -1，      接收远端蓝牙数据失败，或者与远端蓝牙失去通信
    *       其他值，  接收到远端蓝牙的实际数据个数
    *       如果实际接收到的蓝牙数据大于RecvLength，应返回前RecvLength长度的数据，通信层会继续接收剩余的数据
    *   uint32_t TProgBtReceive(uint8_t *pRecvBuffer, uint32_t RecvLength);
    *
    *   说明：接收数据，总接到多少，全部返回多少
    */
    static void InitTProgCommBridge(std::function<bool()> fnTProgBtOpen,
                               std::function<bool()> fnTProgBtClose,
                               std::function<uint32_t(const uint8_t *, uint32_t)> fnTProgBtSend,
                               std::function<uint32_t(uint8_t *, uint32_t)> fnTProgBtReceive);
    
    // 获取车辆电池电压
    // 注意，获取到的电池电压值，单位毫伏
    static uint32_t ReadVBat();
    
    // 获取车辆指定引脚电压
    // 注意，获取到的引脚电压值，单位毫伏
    static uint32_t ReadPinNum(uint32_t PinNum);
    
    // 设置VCI锁状态
    // 成功返回1，失败返回0
    // 说明：此接口阻塞，耗时大概500毫秒左右
    static uint32_t SetLock();

    // 设置VCI解锁状态
    // 成功返回1，失败返回0
    // 说明：此接口非阻塞，APK调用SO，SO返回，大概耗时500毫秒左右
    static uint32_t SetUnLock();
    /*
     *   注册StdComm 的静态成员函数 GetIsSupportTProg 回调函数
     *
     *   bool GetIsSupportTProg();
     *
     *   参数：无
     *
     *   返回：无
     *
     */
    static void GetIsSupportTProg(std::function<bool()> fnGetIsSupportTProg);
    
};
#endif
