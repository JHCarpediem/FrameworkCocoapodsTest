//
//  TDD_ArtiLiveDataSetModel.m
//  AD200
//
//  Created by AppTD on 2022/8/10.
//

#import "TDD_ArtiLiveDataSetModel.h"
@implementation TDD_ArtiLiveUnitModel

@end
@implementation TDD_ArtiLiveDataSetModel


- (uint32_t)show
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self userInfo:nil];
    
    return 0;
}

- (void)backClick
{
    self.liveDataModel.isShowOtherView = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self.liveDataModel userInfo:nil];
}

@end
