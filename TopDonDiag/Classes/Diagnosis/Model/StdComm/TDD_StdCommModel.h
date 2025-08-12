//
//  AD200
//
//  Created by 何可人 on 2022/6/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_StdCommModel : NSObject
#pragma mark 注册方法
+ (void)registSupportTProgMethod;
+ (void)registerMethod;

/* 通信接口初始化函数，加载此模块的时候调用（应用初始化libstdcomm.a） */
// 此接口 app 调用 stdcomm
+ (void)stdcommInit;

/* 退出此模块的时候调用 */
// 此接口  app 调用 stdcomm
+ (void)stdcommDeInit;

// 使能日志打印
+ (void)SetLogEnable:(BOOL)Flag;

// 获取通信库版本号
// 通信层版本信息
// 例如通常情况为：V1.00
+ (NSString *)Version NS_SWIFT_NAME(stdVersion());

// 开启诊断通信日志
// TypeName       对应的诊断类型，例如"DIAG"表示现在是诊断车型，或者"IMMO"表示现在是锁匠车型
// VehName        对应的车型名称，例如"Nissan"
//
// 注意，App应加载诊断车型前调用此接口，保证诊断日志的完整性
//
+ (void)StartLogWithTypeName:(NSString *)TypeName VehName:(NSString *)VehName;

// 停止诊断通信日志
// 返回std::string数组，数组个数为文件个数，每个元素为一个日志文件路径
// 如果std::string数组只有一个元素，则只有一个日志文件
//
// 场景1：返回一个日志文件
//        元素0为："/mnt/sdcard/Android/data/com.td.diag.artidiag/files/TD/TD001/DataLog/Nissan/StdComm_20220113_192428__373.txt"
//
// 场景2：返回两个日志文件
//        元素0为："/mnt/sdcard/Android/data/com.td.diag.artidiag/files/TD/TD001/DataLog/Nissan/StdComm_20220113_210700___9360.txt"
//        元素1位："/mnt/sdcard/Android/data/com.td.diag.artidiag/files/TD/TD001/DataLog/Nissan/StdComm_20220113_192428__373.txt"
+ (NSArray *)StopLog;

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
+ (NSArray *)getLogPath;

+ (void)logVehWithString:(NSString *)strLog;

// VCI固件版本信息
// 例如通常情况为：
// AD900 RelayV3 Jul  8 2021 V1.02
// App应用自己去掉前面的日期字串，例如去掉后是V1.02
+ (NSString *)FwVersion;

// 获取蓝牙软件版本号
// 蓝牙模组 JB631 蓝牙
// 例如通常情况为：F.DJ.BD025.JB6321-30B1_v1.1.4.10
+ (NSString *)BtVersion;

// 设置蓝牙模组进入升级模式
// 蓝牙模组 JB6321 进入升级模式
// true, 进入成功
// false，进入升级模式失败
+ (BOOL)BtEnterUpdate;

// 设置蓝牙模组退出升级模式
// 蓝牙模组 JB6321 退出升级模式
// true, 退出成功
// false, 退出升级模式失败
// 注意，调用此接口会断开蓝牙一次
+ (BOOL)BtExitUpdate;

// 蓝牙模组复位
// true, 复位成功
// false, 复位失败
+ (BOOL)BtReset;

// 国内版TOPVCI 获取空气质量等级接口【0, 100】
/*
*   返 回 值：如果设备没有连接或者指针为空，返回-1
*            返回获取到的空气传感器模组的空气质量等级，【0, 100】
*/
+ (uint32_t)GetAirQuality;

// 国内版TOPVCI 获取空气传感器已运行多少时间，单位毫秒
/*
*   uint32_t GetAirUpTime();
*
*   参数
*       无
*
*   返 回 值：如果设备没有连接或者指针为空，返回-1 0xfffffff
*           返回获取到空气传感器已运行多少时间，单位毫秒
*/
+ (uint32_t)GetAirUpTime;

// FwDeviceType
//
// 获取当前VCI的设备类型
//                                     uint32_t            固件标识             VCI名称
// AD900 Tool 的设备类型是：            0x41443900         "AD900Relay207"       "AD900TOOL"
// AD900 VCI（小接头）的设备类型是：      0x4E333247         "AD900VCIN32G455"     "AD900VCI"
// TOPKEY EasyVCI（小接头）的设备类型是： 0x45564349         "EasyVCIGD32F305"     "EasyVCI"
+ (uint32_t)FwDeviceType;

// VCI进入BOOT模式，调用此接口后，VCI会重启进入升级模式
// 应用程序在升级开始前判断VCI是否处于BOOT模式，如果没有
// 没有在BOOT模式，就需要调用此接口后再重新判断是否BOOT模
// 式后再进行升级数据传输
// 此接口为阻塞接口，至VCI执行了进入boot模式指令，大概时间为1秒（usb）
+ (void)FwEnterBoot;

// VCI是否处于BOOT模式
// 1，BOOT模拟，即升级模式
// 0，APP模式，即正常模式
+ (uint32_t)FwIsBoot;

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
//static uint32_t FwDownload(uint32_t FileTotalSize, uint32_t PackNo, const std::vector<uint8_t>& vctPackData);
+ (uint32_t)FwDownloadWithFileTotalSize:(uint32_t)FileTotalSize PackNo:(uint32_t)PackNo vctPackData:(NSData *)vctPackData;

// 传输升级文件CheckSum
// FileTotalSize        固件总大小，即下位机的固件升级文件总大小
// CheckSum             VCI固件升级文件的校验
//
// 1，成功
// 0，失败
//              注意: 发送VCI固件升级文件的校验与总大小必须在发送完所有
//                    的固件数据包后，即在最后一个数据包发送完后发送。
+ (uint32_t)FwCheckSumWithFileTotalSize:(uint32_t)FileTotalSize CheckSum:(uint32_t)CheckSum;

// 获取VCI的序列号
// 返回VCI的序列号, 例如：“JV0013BA100044”
// 如果VCI设备没有连接，返回空串，""
// 此接口  app 调用 stdcomm
+ (NSString *)VciSn;

// 获取VCI的6字节注册码
// 返回VCI的注册码, 例如：“123456”
// 如果VCI设备没有连接，返回空串，""
// 此接口  app 调用 stdcomm
+ (NSString *)VciCode;

// 获取VCI的MCU的ID
// 当前MCU的唯一ID，即UID(Unique device ID)
// 此MCU的唯一ID来自MCU芯片厂商，可参考对应的MCU芯片参考手册
// 通常情况下，VCI的McuUID的长度，等于12个字节，即96位的字节
// VCI MCU的ID, 例如：[27 00 34 00 03 51 38 32 30 34 35 32]
// 返回 "270034000351383230343532"
// 此接口  app 调用 stdcomm
+ (NSString *)VciMcuId;

+ (uint32_t)readPinNum:(uint32_t)pinNum;


/// 锁机(上层控制线程)
// 设置VCI锁状态
// 成功返回1，失败返回0
// 说明：此接口阻塞，耗时大概500毫秒左右
+ (uint32_t )setLock;
// 设置VCI解锁状态
// 成功返回1，失败返回0
// 说明：此接口非阻塞，APK调用SO，SO返回，大概耗时500毫秒左右
+ (uint32_t )setUnLock;
// 获取锁状态
// 获取成功并且未锁返回1
// 获取成功并且已锁返回2
// 获取失败返回0
+ (uint32_t )getVCILock;
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

+ (NSString *)MT7628AppVersion;

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
+ (NSString *)MT7628OsVersion;

// 获取MT7628的设备类型, 系统和应用软件的设备ID为同一个，
// 0x37363238，固件标识为"MasterMT7628"
//
// 返回值举例
// 成功，返回0x37363238
// 失败，返回0x00000000
+ (uint32_t)MT7628DeviceType;

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
+ (uint32_t)MT7628Download:(uint32_t)Type FileTotalSize:(uint32_t)FileTotalSize PackNo:(uint32_t)PackNo vctPackData:(NSData *)vctPackData;

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
+ (uint32_t)MT7628CheckSum:(uint32_t)Type FileTotalSize:(uint32_t)FileTotalSize CheckSum:(uint32_t)CheckSum;

// 通常情况下MT7628启动并wifi正常，需要1分钟左右
// 此接口确定MT7628是否已经准备好
//
// 返回值举例
// 成功，1，启动完成，可以使用
// 失败，0，没有准备好
+ (uint32_t)MT7628IsReady;

// WIFI模组复位
// true, 复位成功
// false, 复位失败
+ (BOOL)MT7628Reset;

// 获取WiFi模组的SSID名称，即WiFi的名称
//
// 举例，"TopScan1234"
//
// 如果读取失败，返回空或者空串
+ (NSString *)MT7628ReadWiFiName;

// 获取WiFi模组的MAC，格式为XX:XX:XX:XX:XX:XX
//
// 举例，12:34:56:78:9A:BC
//
// 如果读取失败，返回空或者空串
+ (NSString *)MT7628ReadWiFiMac;

// 当前连接的VCI类型是否支持MT7628
//
// true, 支持MT7628（即当前VCI有MT7628的WiFi模组）
// false, 不支持MT7628（即当前VCI没有MT7628的WiFi模组）
// 如果当前VCI没有连接，返回false
+ (BOOL)MT7628IsSupported;

// 蓝牙模组类型
// 0        中易腾达蓝牙模组
// 1        高盛达蓝牙模组
// 0xFF     256, 未知
// 注意，如果VCI未连接，返回0xFF, 未知
//       如果VCI在BOOT模式，返回0xFF, 未知
+ (uint32_t)btType;
@end

NS_ASSUME_NONNULL_END
