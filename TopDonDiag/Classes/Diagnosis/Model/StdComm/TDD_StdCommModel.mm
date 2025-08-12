//
//  TDD_StdCommModel.m
//  AD200
//
//  Created by 何可人 on 2022/6/14.
//

#import "TDD_StdCommModel.h"
#if useCarsFramework
#import <CarsFramework/StdComm.hpp>
#else
#import "StdComm.hpp"
#endif

#import "TDD_CTools.h"
#import "TDD_ArtiGlobalModel.h"
#import "UIDevice+TDD_Info.h"
#import "TDD_TDartsManage.h"
#import "TDD_StdShowModel.h"
@implementation TDD_StdCommModel

+ (void)registSupportTProgMethod
{
    CStdComm::GetIsSupportTProg(ArtiGetIsSupportTprog);
}

#pragma mark 注册方法
+ (void)registerMethod
{
    BLELog(@"%@ - 注册方法", [self class]);
    
    CStdComm::InitCommBridge(OpenDevice, CloseDevice, SendToDevice, ReceiveFromDevice);
    CStdComm::VciStatus(VciStatus);
    CStdComm::GetAppDataPath(GetAppDataPath);
    CStdComm::GetAppVersion(GetAppVersion);
    CStdComm::GetVehName(GetVehName);
    CStdComm::GetVIN(GetVIN);
    CStdComm::GetVehInfo(GetVehInfo);
    CStdComm::GetPhoneModel(GetPhoneModel);
    CStdComm::GetDiagVer(GetDiagVer);
    CStdComm::GetDiagMainVer(GetDiagMainVer);
    CStdComm::TProgStatus(TProgStatus);
    CStdComm::TProgInformation(TProgInformation);
    CStdComm::InitTProgCommBridge(TProgBtOpen, TProgBtClose, TProgBtSend, TProgBtReceive);
    CStdComm::GetStdShowVersion(GetStdShowVersion);
}

/**
 功能： 将打开蓝牙通信桥模块，并试图连接远端蓝牙
       调用者在成功调用此接口后，可以通过SendToBlueTooth向远端蓝牙发送数据
       也可以通过ReceiveFromBlueTooth读取从远端蓝牙发送过来的数据
       
 
 返回值定义：
     true，    打开本地蓝牙成功，与远端蓝牙配对上并且已经连接上远端蓝牙
     false，   打开本地蓝牙失败，或者与远端蓝牙配对失败，或者连接远端蓝牙失败
 */
bool OpenDevice(void)
{
    BLELog(@"stdComm - 打开蓝牙通信功能");
    
    return [[TDD_EADSessionController sharedController] openSession];
}

/**
 功能： 关闭蓝牙通信功能

       调用者在发现SendToBlueTooth返回-1（0xFFFFFFFF），或者ReceiveFromBlueTooth返回-1（0xFFFFFFFF）
       的情况下（例如蓝牙连接断开），将会立即调用CloseDevice，释放相关资源后，将会再次调用OpenDevice（再
       次尝试重新建立蓝牙连接）。

       调用者调用CloseDevice成功后，如果没有再次调用OpenDevice，就直接调用SendToBlueTooth和
       ReceiveFromBlueTooth，App 都将返回-1（0xFFFFFFFF）。
       
 返回值定义：
     true，    关闭蓝牙通信桥成功
     false，   关闭蓝牙通信桥失败
 */
bool CloseDevice(void)
{
    BLELog(@"stdComm - 关闭蓝牙通信功能");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([TDD_EADSessionController sharedController].accessory && [TDD_EADSessionController sharedController].canEventBLEError) {
            [TDD_Statistics event:Event_BLECommunicationError attributes:nil];
            [TDD_EADSessionController sharedController].canEventBLEError = NO;
        }
    });
    
    [[TDD_EADSessionController sharedController] closeSession];
    
    return YES;
}

bool ArtiGetIsSupportTprog(void) {
    
    BOOL res = YES;
    
    if isKindOfTopVCI {
        res = NO;
    }
    
    BLELog(@"stdComm - 是否支持Tprog - %d", res);
    
    return res;
}

/**
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
 */
uint32_t SendToDevice(uint8_t *pSendBuffer, uint32_t SendLength)
{
    NSData * data;
    uint32_t bytesWritten;
    
    @autoreleasepool {
        data = [NSData dataWithBytes:pSendBuffer length:SendLength];
        //DEBUG
        if ([TDD_DiagnosisManage sharedManage].appScenarios==AS_INTERNAL_USE) {
            NSString * str = [NSDate tdd_convertDataToHexStr:data];
            BLELog(@"stdComm - 向远端蓝牙发送数据:%@", str);
        }

        bytesWritten = (uint32_t)[[TDD_EADSessionController sharedController] writeData:data];
        BLELog(@"stdComm - 向远端蓝牙发送数据个数:%d", bytesWritten);
    }
    
    return bytesWritten;
}

/**
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
 */
uint32_t ReceiveFromDevice(uint8_t *pRecvBuffer, uint32_t RecvLength)
{
    if (![TDD_EADSessionController sharedController].accessory || ![TDD_EADSessionController sharedController].session) {
        BLELog(@"stdComm - 从远端蓝牙接收数据：没有连接蓝牙，返回-1");
        return -1;
    }
    
    NSData * data;
    
    @autoreleasepool {
        data = [[TDD_EADSessionController sharedController] readData:RecvLength];
        if (data.length > 0) {
            //DEBUG
            if ([TDD_DiagnosisManage sharedManage].appScenarios==AS_INTERNAL_USE) {
                NSString * str = [NSDate tdd_convertDataToHexStr:data];
                BLELog(@"stdComm - 从远端蓝牙接收数据:%@ - 期望从远端蓝牙接收数据的长度:%u - 实际长度：%lu", str, RecvLength, (unsigned long)data.length);
            }else {
                BLELog(@"stdComm - 从远端蓝牙接收数据个数:%lu", (unsigned long)[data length]);
            }
            
        }
        if ([data isEqualToData: [TDD_EADSessionController sharedController].closeData]) {
            BLELog(@"SN不一致，关闭通讯，接受返回-1");
            return -1;
        }
        auto cData = (uint8_t *)data.bytes;
        memcpy(pRecvBuffer, cData, [data length]);
    }
    
    return (uint32_t)[data length];
}

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
void VciStatus(uint32_t VciStatus, uint32_t BatteryVolt)
{
    
    if (TDD_EADSessionController.sharedController.VciStatus != VciStatus) {
        TDD_EADSessionController.sharedController.VciStatus = VciStatus;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationVciStatusDidChange object:nil];
            });

        });
        
        
    }else {
        TDD_EADSessionController.sharedController.VciStatus = VciStatus;
    }
    TDD_EADSessionController.sharedController.BatteryVolt = BatteryVolt / 1000.0;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationVciStatusChange object:nil];
    });

    BLELog(@"VCI 连接状态:%u，电压:%fV", VciStatus, BatteryVolt / 1000.0);
}

/*
 *   注册 StdComm 的静态成员函数 GetAppDataPath 回调函数
 *
 *   获取App数据路径，例如 TD/AD200，将返回TD/AD200的全路径名
 *
 *   std::string const GetAppDataPath();
 *
 *   参数：无
 *
 *   返回：App数据全路径名
 *
 */
std::string const GetAppDataPath()
{
    BLELog(@"stdComm - 获取App数据路径");
    
    NSString * documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    documentsPath = [documentsPath stringByAppendingPathComponent:@"TD/AD200"];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:documentsPath]) {
        NSError * error;
        
        [fileManager createDirectoryAtPath:documentsPath withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error) {
            BLELog(@"创建文件夹错误:%@", error);
        }
    }
    
    return [TDD_CTools NSStringToCStr:documentsPath];
}

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
uint32_t GetAppVersion()
{
    BLELog(@"stdComm - 获取App版本");
    
    return [TDD_ArtiGlobalModel GetAppVersion];
}

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
std::string const GetVehName()
{
    BLELog(@"stdComm - 获取当前车型路径的文件夹名称");
    
    NSString * name = [TDD_ArtiGlobalModel GetVehName];
    
    return [TDD_CTools NSStringToCStr:name];
}

std::string const GetStdShowVersion()
{
    NSString * version = [TDD_StdShowModel Version];
    BLELog(@"stdComm - 获取stdShow 版本:%@",version);
    return [TDD_CTools NSStringToCStr:version];
}

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
std::string const GetVIN()
{
    BLELog(@"stdComm - 获取当前车辆VIN码");
    if (isKindOfTopVCI) {
        //如果有外面传进来的VIN(绑定的车的VIN码)
        if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(carExtraInfo)]) {
            NSDictionary *carExtraInfo =
            [[TDD_DiagnosisManage sharedManage].manageDelegate carExtraInfo];
            if (carExtraInfo && carExtraInfo.allKeys.count > 0) {
                NSString *vin = carExtraInfo[@"VIN"];
                if (![NSString tdd_isEmpty:vin]) {
                    return [TDD_CTools NSStringToCStr:vin];
                }
                
            }
        }
    }
    NSString * VIN = [TDD_ArtiGlobalModel GetVIN];
    
    return [TDD_CTools NSStringToCStr:VIN];
}

/*
*   注册 StdComm 的静态成员函数 GetVehInfo 回调函数
*
*   获取当前车辆信息
*
*   std::string const GetVehInfo();
*
*   例如：宝马/3'/320Li_B48/F35/
*/
std::string const GetVehInfo()
{
    BLELog(@"stdComm - 获取当前车辆信息");
    
    NSString * info = [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarInfo;
    
    return [TDD_CTools NSStringToCStr:info];
}

/*
*   注册 StdComm 的静态成员函数 GetDiagVer 回调函数
*
*   获取当前诊断车型的版本号，此接口返回的是版本号的所见字符串
*
*   std::string const GetDiagVer();
*
*   例如：V1.00.001
*/
std::string const GetDiagVer()
{
    BLELog(@"stdComm - 获取当前诊断车型的版本号");
    
    NSString * ver = [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVersion;
    
    return [TDD_CTools NSStringToCStr:ver];
}

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
std::string const GetDiagMainVer()
{
    BLELog(@"stdComm - 获取当前诊断车型主车的版本号");
    
    NSString * ver = [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarStaticLibraryVersion;
    
    return [TDD_CTools NSStringToCStr:ver];
}

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
std::string const GetPhoneModel()
{
    TDD_DeviceInfoModel * model = [UIDevice modelInfo];
    
    if (model.modelName.length == 0) {
        model.modelName = @"unknown";
    }
    
    BLELog(@"StdComm - 获取当前手机型号:%@", model.modelName);
    
    return [TDD_CTools NSStringToCStr:model.modelName];
}

#pragma mark - T-Darts
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
void TProgStatus(uint32_t TProgStatus, uint32_t Reserved)
{
    if isKindOfTopVCI { return; }
    BLELog(@"StdComm - T-Darts - 连接状态:%d, %d", TProgStatus, Reserved);
    if (    TDD_TDartsManage.sharedManage.TProgStatus != TProgStatus) {
        TDD_TDartsManage.sharedManage.TProgStatus = TProgStatus;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationTDartsStatusDidChange object:nil];
        });
        
    }else {
        TDD_TDartsManage.sharedManage.TProgStatus = TProgStatus;
    }

    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationTDartsStatusChange object:nil];
    });
}

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
void TProgInformation(const std::string& strSn, const std::string& strCode, const std::string& strMcuId)
{
    if isKindOfTopVCI { return; }
    
    NSString * OCStrSn = [TDD_CTools CStrToNSString:strSn];
    NSString * OCStrCode = [TDD_CTools CStrToNSString:strCode];
    NSString * OCStrMcuId = [TDD_CTools CStrToNSString:strMcuId];
    
    BLELog(@"StdComm - T-Darts - 信息回调 - SN:%@ - 注册码：%@ - MCUID：%@", OCStrSn, OCStrCode, OCStrMcuId);
    
    TDD_TDartsManage.sharedManage.strSn = OCStrSn;
    TDD_TDartsManage.sharedManage.strCode = OCStrCode;
    TDD_TDartsManage.sharedManage.strMcuId = OCStrMcuId;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationTDartsVCIInfoChanged object:nil];
}

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
bool GetIsSupportTProg()
{
    if (isKindOfTopVCI) {
        return false;
    }
    return true;
}


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
*/
bool TProgBtOpen()
{
    if isKindOfTopVCI { return YES; }
    
    BLELog(@"StdComm - T-Darts - 建立TProg/TDart的蓝牙连接");
    
    return [TDD_TDartsManage.sharedManage openConnect];
}
 
/*
*   public static bool TProgBtClose();
*
*   通信库调用APK，要求断开TProg/TDart的蓝牙连接
*   与TProg/TDart的蓝牙断开连接
*
*   说明：此接口非阻塞，通信库调用App
*/

bool TProgBtClose()
{
    if isKindOfTopVCI { return YES; }
    
    BLELog(@"StdComm - T-Darts - 断开TProg/TDart的蓝牙连接");
    BOOL isConnecting = [TDD_DiagnosisTools isInBleConnectingVC];
    if (!isConnecting) {
        [TDD_TDartsManage.sharedManage cancelConnect];
    }
    
    
    
    return YES;
}

/*
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
*/
uint32_t TProgBtSend(const uint8_t *pSendBuffer, uint32_t SendLength)
{
    if isKindOfTopVCI { return -1; }
    
    BLELog(@"StdComm - T-Darts - 向远端蓝牙发送数据");
    
    return [TDD_TDartsManage.sharedManage sendBytes:pSendBuffer length:SendLength];
}

/*
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
uint32_t TProgBtReceive(uint8_t *pRecvBuffer, uint32_t RecvLength)
{
    if isKindOfTopVCI { return -1; }
    
    if (!TDD_TDartsManage.sharedManage.isConnect) {
        BLELog(@"stdComm - TDarts - 从远端蓝牙接收数据：没有连接蓝牙，返回-1");
        return -1;
    }
    
    NSData * data;
    
    @autoreleasepool {
        data = [TDD_TDartsManage.sharedManage readData:RecvLength];
        if (data.length > 0) {
            //DEBUG
            if ([TDD_DiagnosisManage sharedManage].appScenarios==AS_INTERNAL_USE) {
                NSString * str = [NSDate tdd_convertDataToHexStr:data];
                BLELog(@"stdComm - TDarts - 从远端蓝牙接收数据:%@ - 期望从远端蓝牙接收数据的长度:%u - 实际长度：%lu", str, RecvLength, (unsigned long)data.length);
            }
        }
        auto cData = (uint8_t *)data.bytes;
        memcpy(pRecvBuffer, cData, [data length]);
    }
    
    return (uint32_t)[data length];
}
//static void InitTProgCommBridge(std::function<bool()> fnTProgBtOpen,
//                           std::function<bool()> fnTProgBtClose,
//                           std::function<uint32_t(const uint8_t *, uint32_t)> fnTProgBtSend,
//                           std::function<uint32_t(uint8_t *, uint32_t)> fnTProgBtReceive);

#pragma mark -
/* 通信接口初始化函数，加载此模块的时候调用（应用初始化libstdcomm.a） */
// 此接口 app 调用 stdcomm
+ (void)stdcommInit
{
    BLELog(@"stdComm - 通信接口初始化");
    
    CStdComm::Init();
}

/* 退出此模块的时候调用 */
// 此接口  app 调用 stdcomm
+ (void)stdcommDeInit
{
    BLELog(@"stdComm - 退出此模块");
    
    CStdComm::DeInit();
}

// 使能日志打印
+ (void)SetLogEnable:(BOOL)Flag
{
    BLELog(@"stdComm - 日志打印：%d", Flag);
    
    CStdComm::SetLogEnable(Flag);
}

// 获取通信库版本号
// 通信层版本信息
// 例如通常情况为：V1.00
+ (NSString *)Version
{
    std::string verCStr = CStdComm::Version();
    
    NSString * version = [TDD_CTools CStrToNSString:verCStr];
    
    BLELog(@"stdComm - 获取通信库版本号:%@", version);
    
    return version;
}

// 开启诊断通信日志
// TypeName       对应的诊断类型，例如"DIAG"表示现在是诊断车型，或者"IMMO"表示现在是锁匠车型
// VehName        对应的车型名称，例如"Nissan"
//
// 注意，App应加载诊断车型前调用此接口，保证诊断日志的完整性
//
+ (void)StartLogWithTypeName:(NSString *)TypeName VehName:(NSString *)VehName
{
    BLELog(@"stdComm - 开启诊断通信日志");
    
    CStdComm::StartLog([TDD_CTools NSStringToCStr:TypeName], [TDD_CTools NSStringToCStr:VehName]);
}

// 停止诊断通信日志
// 返回std::string数组，数组个数为文件个数，每个元素为一个日志文件路径
// 如果std::string数组只有一个元素，则只有一个日志文件
//
// 场景1：返回一个日志文件
//        元素0为："/mnt/sdcard/Android/data/com.TD.diag.artidiag/files/TD/TD001/DataLog/Nissan/StdComm_20220113_192428__373.txt"
//
// 场景2：返回两个日志文件
//        元素0为："/mnt/sdcard/Android/data/com.td.diag.artidiag/files/TD/TD001/DataLog/Nissan/StdComm_20220113_210700___9360.txt"
//        元素1位："/mnt/sdcard/Android/data/com.td.diag.artidiag/files/TD/TD001/DataLog/Nissan/StdComm_20220113_192428__373.txt"
+ (NSArray *)StopLog
{
    std::vector<std::string> vct = CStdComm::StopLog();
    
    NSArray * arr = [TDD_CTools CVectorToStringNSArray:vct];
    
    BLELog(@"stdComm - 停止诊断通信日志:%@", arr);
    
    return arr;
}

+ (NSArray *)getLogPath
{
    std::vector<std::string> vct = CStdComm::GetLogPath();
    NSArray * arr = [TDD_CTools CVectorToStringNSArray:vct];
    
    BLELog(@"stdComm - 获取诊断通信日志:%@", arr);
    
    return arr;
}

+ (void)logVehWithString:(NSString *)strLog {
    if ([TDD_EADSessionController sharedController].isArtiDiag) {
        HLog(@"stdComm - logVehWithString - %@",strLog);
        CStdComm::LogVeh([TDD_CTools NSStringToCStr:strLog]);
    }else {
        HLog(@"stdComm - logVehWithString - 非诊断内不写入");
    }
    
    
}

// VCI固件版本信息
// 例如通常情况为：
// AD900 RelayV3 Jul  8 2021 V1.02
// App应用自己去掉前面的日期字串，例如去掉后是V1.02
+ (NSString *)FwVersion
{
    std::string str = CStdComm::FwVersion();
    
    NSString * version = [TDD_CTools CStrToNSString:str];
    
    BLELog(@"stdComm - VCI固件版本信息:%@", version);
    
    return version;
}

// 获取蓝牙软件版本号
// 蓝牙模组 JB631 蓝牙
// 例如通常情况为：F.DJ.BD025.JB6321-30B1_v1.1.4.10
+ (NSString *)BtVersion {
    std::string str = CStdComm::BtVersion();
    
    NSString * version = [TDD_CTools CStrToNSString:str];
    
    BLELog(@"stdComm - VCI固件版本信息:%@", version);
    
    return version;
}

// 设置蓝牙模组进入升级模式
// 蓝牙模组 JB6321 进入升级模式
// true, 进入成功
// false，进入升级模式失败
+ (BOOL)BtEnterUpdate {
    bool result = CStdComm::BtEnterUpdate();
    HLog(@"stdComm - BtEnterUpdate - %d",result);
    return result;
}

// 设置蓝牙模组退出升级模式
// 蓝牙模组 JB6321 退出升级模式
// true, 退出成功
// false, 退出升级模式失败
// 注意，调用此接口会断开蓝牙一次
+ (BOOL)BtExitUpdate {
    bool result = CStdComm::BtExitUpdate();
    HLog(@"stdComm - BtExitUpdate - %d",result);
    return result;
}

// 蓝牙模组复位
// true, 复位成功
// false, 复位失败
+ (BOOL)BtReset {
    bool result = CStdComm::BtReset();
    HLog(@"stdComm - BtReset - %d",result);
    return result;
}

// 国内版TOPVCI 获取空气质量等级接口【0, 100】
/*
*   返 回 值：如果设备没有连接或者指针为空，返回-1
*            返回获取到的空气传感器模组的空气质量等级，【0, 100】
*/
+ (uint32_t)GetAirQuality {
    BLELog(@"stdComm - 空气质量等级:%u", CStdComm::GetAirQuality());
    return CStdComm::GetAirQuality();
}

+ (uint32_t)GetAirUpTime {
    BLELog(@"stdComm - 空气质量更新时间:%u", CStdComm::GetAirQuality());
    return CStdComm::GetAirUpTime();
}


// FwDeviceType
//
// 获取当前VCI的设备类型
//                                         uint32_t            固件标识             VCI名称
// AD900 Tool 的设备类型是：              0x41443900         "AD900Relay207"       "AD900TOOL"
// AD900 VCI（小接头）的设备类型是：      0x4E333247         "AD900VCIN32G455"     "AD900VCI"
// Topscan Pro 的设备类型是：             0x48343837       "TSP2VCIN32H487"        "TopScanPro2VCI"
// TOPKEY EasyVCI（小接头）的设备类型是： 0x45564349         "EasyVCIGD32F305"     "EasyVCI"
// PG1000的设备类型是：                   0x31303634         "PG1000VCIRT1064"     "PG1000VCI"
// RLinkMiniVCI的设备类型是：             0x47443332         "RLMiniGD32F427"      "RLinkMiniVCI"
// AD500VCI的设备类型是：                 0x41443553         "AD500VCIN32G455"     "AD500VCI"
// 国内版TOPVCI的设备类型是：             0x50443031         "PD001N32G455"        "TP005VCI"
// 国内版TOPVCI的设备类型是：             0x444F4950        "TSMVCIN32H487"       TopScanMasterVCI
+ (uint32_t)FwDeviceType
{
    uint32_t deviceType = CStdComm::FwDeviceType();
    BLELog(@"stdComm - 获取当前VCI的设备类型 %ld", deviceType);
    
    return deviceType;
}

// VCI进入BOOT模式，调用此接口后，VCI会重启进入升级模式
// 应用程序在升级开始前判断VCI是否处于BOOT模式，如果没有
// 没有在BOOT模式，就需要调用此接口后再重新判断是否BOOT模
// 式后再进行升级数据传输
// 此接口为阻塞接口，至VCI执行了进入boot模式指令，大概时间为1秒（usb）
+ (void)FwEnterBoot
{
    BLELog(@"stdComm - VCI进入BOOT模式");
    
    CStdComm::FwEnterBoot();
}

// VCI是否处于BOOT模式
// 1，BOOT模拟，即升级模式
// 0，APP模式，即正常模式
+ (uint32_t)FwIsBoot
{
    uint32_t isBoot = CStdComm::FwIsBoot();
    
    BLELog(@"stdComm - VCI是否处于BOOT模式:%d", isBoot);
    
    return isBoot;
}

uint32_t ReadPinNum(uint32_t PinNum) {
    HLog(@"stdComm - ReadPinNum - %d",PinNum);
    return [TDD_StdCommModel readPinNum:PinNum];
}
// 获取车辆电池电压
// 注意，获取到的电池电压值，单位毫伏
+ (uint32_t)readPinNum:(uint32_t)pinNum
{
    uint32_t pin = CStdComm::ReadPinNum(pinNum);
    BLELog(@"stdComm - %d引脚获取到的电池电压值:%d", pinNum,pin);
    return pin;
}

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
+ (uint32_t)FwDownloadWithFileTotalSize:(uint32_t)FileTotalSize PackNo:(uint32_t)PackNo vctPackData:(NSData *)vctPackData
{
    BLELog(@"stdComm - 分包传输升级文件 - FileTotalSize : %d - PackNo:%d - vctPackData:%@", FileTotalSize, PackNo, vctPackData);
    
    std::vector<uint8_t> vct;
    
    Byte *bytes = (Byte *)[vctPackData bytes];
    
    for (int i = 0; i < vctPackData.length; i++) {
        
        vct.push_back(bytes[i]&0xff);
    }
    
    return CStdComm::FwDownload(FileTotalSize, PackNo, vct);
}

// 传输升级文件CheckSum
// FileTotalSize        固件总大小，即下位机的固件升级文件总大小
// CheckSum             VCI固件升级文件的校验
//
// 1，成功
// 0，失败
//              注意: 发送VCI固件升级文件的校验与总大小必须在发送完所有
//                    的固件数据包后，即在最后一个数据包发送完后发送。
+ (uint32_t)FwCheckSumWithFileTotalSize:(uint32_t)FileTotalSize CheckSum:(uint32_t)CheckSum
{
    BLELog(@"stdComm - 传输升级文件CheckSum - FileTotalSize : %u - CheckSum:%u", FileTotalSize, CheckSum);
    
    return CStdComm::FwCheckSum(FileTotalSize, CheckSum);
}

// 获取VCI的序列号
// 返回VCI的序列号, 例如：“JV0013BA100044”
// 如果VCI设备没有连接，返回空串，""
// 此接口  app 调用 stdcomm
+ (NSString *)VciSn
{
    std::string SNStr = CStdComm::VciSn();

    NSString * str = [TDD_CTools CStrToNSString:SNStr];
    
    BLELog(@"stdComm - 获取VCI的序列号:%@", str);
    
    return str;
}

// 获取VCI的6字节注册码
// 返回VCI的注册码, 例如：“123456”
// 如果VCI设备没有连接，返回空串，""
// 此接口  app 调用 stdcomm
+ (NSString *)VciCode
{
    std::string VciCodeStr = CStdComm::VciCode();

    NSString * str = [TDD_CTools CStrToNSString:VciCodeStr];
    
    BLELog(@"stdComm - 获取VCI的6字节注册码:%@", str);
    
    return str;
}

// 获取VCI的MCU的ID
// 当前MCU的唯一ID，即UID(Unique device ID)
// 此MCU的唯一ID来自MCU芯片厂商，可参考对应的MCU芯片参考手册
// 通常情况下，VCI的McuUID的长度，等于12个字节，即96位的字节
// VCI MCU的ID, 例如：[27 00 34 00 03 51 38 32 30 34 35 32]
// 返回 "270034000351383230343532"
// 此接口  app 调用 stdcomm
+ (NSString *)VciMcuId
{
    BLELog(@"stdComm - 获取VCI的MCU的ID");

    std::string VciMcuIdStr = CStdComm::VciCode();

    return [TDD_CTools CStrToNSString:VciMcuIdStr];
}

+ (uint32_t )setLock {
    uint32_t result = CStdComm::SetLock();
    HLog(@"SetLock - %d",result);
    return result;
}

+ (uint32_t )setUnLock {
#ifdef DEBUG
    //只有 DEBUG 测试使用，不给用户解锁
    if ([TDD_DiagnosisManage sharedManage].appScenarios == AS_INTERNAL_USE) {
        uint32_t result = CStdComm::SetUnLock();
        HLog(@"SetUnLock - %d",result);
        return false;
    }
    //JH:固定返回 1
    return 1;
#else
    //JH:固定返回 1
    return 1;
#endif
}

+ (uint32_t )getVCILock {
//    uint32_t result = CStdComm::GetVciLock();
//    HLog(@"getVCILock，result - %d - 固定返回 1",result);
    //JH:固定返回 1(老设备默认返回锁定状态，需要等所有设备升级固件)
    return 1;
}

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

+ (NSString *)MT7628AppVersion {
    std::string str = CStdComm::MT7628AppVersion();
    
    NSString * version = [TDD_CTools CStrToNSString:str];
    
    BLELog(@"stdComm - MT7628AppVersion信息:%@", version);
    
    return version;
    
}

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
+ (NSString *)MT7628OsVersion {
    std::string str = CStdComm::MT7628OsVersion();
    
    NSString * version = [TDD_CTools CStrToNSString:str];
    
    BLELog(@"stdComm - MT7628OsVersion信息:%@", version);
    
    return version;
    
}

// 获取MT7628的设备类型, 系统和应用软件的设备ID为同一个，
// 0x37363238，固件标识为"MasterMT7628"
//
// 返回值举例
// 成功，返回0x37363238
// 失败，返回0x00000000
+ (uint32_t)MT7628DeviceType {
    uint32_t result = CStdComm::MT7628DeviceType();
    BLELog(@"stdComm - MT7628DeviceType:%u", result);
    return result;
}

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
+ (uint32_t)MT7628Download:(uint32_t)Type FileTotalSize:(uint32_t)FileTotalSize PackNo:(uint32_t)PackNo vctPackData:(NSData *)vctPackData{
    BLELog(@"stdComm - MT7628Download - Type: %d -  FileTotalSize : %d - PackNo:%d - vctPackData:%@",Type, FileTotalSize, PackNo, vctPackData);
    
    std::vector<uint8_t> vct;
    
    Byte *bytes = (Byte *)[vctPackData bytes];
    
    for (int i = 0; i < vctPackData.length; i++) {
        
        vct.push_back(bytes[i]&0xff);
    }
    
    return CStdComm::MT7628Download(Type, FileTotalSize, PackNo, vct);
    
}


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
+ (uint32_t)MT7628CheckSum:(uint32_t)Type FileTotalSize:(uint32_t)FileTotalSize CheckSum:(uint32_t)CheckSum
{
    BLELog(@"stdComm - MT7628CheckSum - Type: %u - FileTotalSize : %u - CheckSum:%u", Type,FileTotalSize, CheckSum);
    
    return CStdComm::MT7628CheckSum(Type,FileTotalSize, CheckSum);
}

// 通常情况下MT7628启动并wifi正常，需要1分钟左右
// 此接口确定MT7628是否已经准备好
//
// 返回值举例
// 成功，1，启动完成，可以使用
// 失败，0，没有准备好
+ (uint32_t)MT7628IsReady {
    uint32_t result = CStdComm::MT7628IsReady();
    BLELog(@"stdComm - MT7628IsReady:%u", result);
    return result;
}

// WIFI模组复位
// true, 复位成功
// false, 复位失败
+ (BOOL)MT7628Reset {
    bool result = CStdComm::MT7628Reset();
    HLog(@"stdComm - MT7628Reset - %d",result);
    return result;
}

// 获取WiFi模组的SSID名称，即WiFi的名称
//
// 举例，"TopScan1234"
//
// 如果读取失败，返回空或者空串
+ (NSString *)MT7628ReadWiFiName {
    std::string str = CStdComm::MT7628ReadWiFiName();
    
    NSString * wifiName = [TDD_CTools CStrToNSString:str];
    
    BLELog(@"stdComm - MT7628ReadWiFiName信息:%@", wifiName);
    
    return wifiName;
    
}

// 获取WiFi模组的MAC，格式为XX:XX:XX:XX:XX:XX
//
// 举例，12:34:56:78:9A:BC
//
// 如果读取失败，返回空或者空串
+ (NSString *)MT7628ReadWiFiMac {
    std::string str = CStdComm::MT7628ReadWiFiMac();
    
    NSString * wifiMac = [TDD_CTools CStrToNSString:str];
    
    BLELog(@"stdComm - MT7628ReadWiFiMac信息:%@", wifiMac);
    
    return wifiMac;
    
}

// 当前连接的VCI类型是否支持MT7628
//
// true, 支持MT7628（即当前VCI有MT7628的WiFi模组）
// false, 不支持MT7628（即当前VCI没有MT7628的WiFi模组）
// 如果当前VCI没有连接，返回false
+ (BOOL)MT7628IsSupported {
    bool result = CStdComm::MT7628IsSupported();
    HLog(@"stdComm - MT7628IsSupported - %d",result);
    return result;
    
}

+ (uint32_t)btType {
    uint32_t result = CStdComm::BtType();
    BLELog(@"stdComm - btType:%u", result);
    return result;

}
@end
