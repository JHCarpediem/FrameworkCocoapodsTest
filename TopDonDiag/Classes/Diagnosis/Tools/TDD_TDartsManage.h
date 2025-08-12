//
//  TDD_TDartsManage.h
//  AD200
//
//  Created by AppTD on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_TDartsManage : NSObject
@property (nonatomic,assign)BOOL isConnect; //蓝牙是否连接
@property (nonatomic,assign) uint32_t TProgStatus; //0，未连接； 1，已连接；
@property (nonatomic,strong) NSString * strSn; //SN
@property (nonatomic,strong) NSString * strCode; //注册码
@property (nonatomic,strong) NSString * strMcuId; //MCUID

+ (TDD_TDartsManage *)sharedManage;
- (BOOL)openConnect;
- (void)cancelConnect;
- (uint32_t)sendBytes:(const uint8_t *)sendBuffer length:(uint32_t)length;
- (NSData *)readData:(NSUInteger)bytesToRead;
@end

NS_ASSUME_NONNULL_END
