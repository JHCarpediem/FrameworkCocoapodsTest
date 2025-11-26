//
//  TDD_ArtiPictureModel.m
//  AD200
//
//  Created by AppTD on 2023/4/25.
//

#import "TDD_ArtiPictureModel.h"
#if useCarsFramework
#import <CarsFramework/RegPicture.hpp>
#else
#import "RegPicture.hpp"
#endif


#import "TDD_CTools.h"

@implementation TDD_ArtiPictureItemModel

- (void)setTopTips:(NSString *)topTips
{
    if ([_topTips isEqualToString:topTips]) {
        return;
    }
    
    _topTips = topTips;
    
    self.strTranslatedTopTips = _topTips;
    
    self.isStrTopTipsTranslated = NO;
}

- (void)setBottomTips:(NSString *)bottomTips
{
    if ([_bottomTips isEqualToString:bottomTips]) {
        return;
    }
    
    _bottomTips = bottomTips;
    
    self.strTranslatedBottomTips = _bottomTips;
    
    self.isStrBottomTipsTranslated = NO;
}

@end


@implementation TDD_ArtiPictureModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);
    
    CRegPicture::Construct(ArtiPictureModelConstruct);
    CRegPicture::Destruct(ArtiPictureModelDestruct);
    CRegPicture::InitTitle(ArtiPictureModelInitTitle);
    CRegPicture::Show(ArtiPictureModelShow);
    
    CRegPicture::AddButton(ArtiPictureModelAddButton);
    CRegPicture::AddPicture(ArtiPictureModelAddPicture);
    CRegPicture::AddTopTips(ArtiPictureModelAddTopTips);
    CRegPicture::AddText(ArtiPictureModelAddText);
    
}

void ArtiPictureModelConstruct(uint32_t id)
{
    [TDD_ArtiPictureModel Construct:id];
}

void ArtiPictureModelDestruct(uint32_t id)
{
    [TDD_ArtiPictureModel Destruct:id];
}

bool ArtiPictureModelInitTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiPictureModel InitTitleWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle]];
}

uint32_t ArtiPictureModelShow(uint32_t id)
{
    return [TDD_ArtiPictureModel ShowWithId:id];
}

uint32_t ArtiPictureModelAddButton(uint32_t id, const std::string& strButtonText)
{
    return [TDD_ArtiPictureModel AddButtonExWithId:id strButtonText:[TDD_CTools CStrToNSString:strButtonText]];
}

uint32_t ArtiPictureModelAddPicture(uint32_t id, const std::string& strPicturePath, const std::string& strBottomTips)
{
    return [TDD_ArtiPictureModel AddPictureWithId:id strPicturePath:[TDD_CTools CStrToNSString:strPicturePath] strBottomTips:[TDD_CTools CStrToNSString:strBottomTips]];
}

void ArtiPictureModelAddTopTips(uint32_t id, uint32_t uiPictID, const std::string& strTopTips, uint32_t eSize, uint32_t eBold)
{
    [TDD_ArtiPictureModel AddTopTipsWithId:id uiPictID:uiPictID strTopTips:[TDD_CTools CStrToNSString:strTopTips] eSize:eSize eBold:eBold];
}

void ArtiPictureModelAddText(uint32_t id, const std::string& strText)
{
    [TDD_ArtiPictureModel AddTextWithId:id strText:[TDD_CTools CStrToNSString:strText]];
}

/***************************************************************************
*    功  能：添加一个图片显示
*
*    参  数：strPicturePath 指定显示的图片路径
*                           如果strPicturePath指定图片路径串为非法路径（空串
*                           或文件不存在），返回失败
*
*            strBottomTips  图片显示的文本提示（底部）
*                           如果strBottomTips为空，代表图片底部没有文本提示
*
*    返回值：图片索引ID，如果添加失败（路径非法），返回 DF_ID_PICTURE_NONE
*            可能的返回值：
*                         DF_ID_PICTURE_0
*                         DF_ID_PICTURE_1
*                         DF_ID_PICTURE_2
*                         DF_ID_PICTURE_3
*                         DF_ID_PICTURE_XX
***************************************************************************/
+ (uint32_t)AddPictureWithId:(uint32_t)ID strPicturePath:(NSString *)strPicturePath strBottomTips:(NSString *)strBottomTips
{
    HLog(@"%@ - 添加图片显示 - ID:%d - strPicturePath ：%@ - strBottomTips : %@", [self class], ID, strPicturePath,strBottomTips);
    TDD_ArtiPictureModel * model = (TDD_ArtiPictureModel *)[self getModelWithID:ID];
    
    TDD_ArtiPictureItemModel * itemModel = [[TDD_ArtiPictureItemModel alloc] init];
    itemModel.bottomTips = strBottomTips;
    itemModel.picturePath = strPicturePath;
    
    [model.pictureArr addObject:itemModel];
    
    
    return (uint32_t)(model.pictureArr.count-1);
}

/***************************************************************************
*    功  能：在指定图片顶部添加一个文本提示
*
*    参  数：uiPictID    在指定图片的顶部添加文本的图片索引ID，即哪个图片上添加
*
*            strTopTips  在指定图片的顶部添加的提示本文
*
*            eSize            FORT_SIZE_SMALL 表示 小字体（与文本同等大小）
*                             FORT_SIZE_MEDIUM 表示 中等字体
*                             FORT_SIZE_LARGE 表示 大字体
*
*            eBold            是否粗体显示
*                             BOLD_TYPE_NONE, 表示不加粗
*                             BOLD_TYPE_BOLD, 表示加粗
*
*    返回值：图片索引ID，如果添加失败（路径非法），返回 DF_ID_PICTURE_NONE
*            可能的返回值：
*                         DF_ID_PICTURE_0
*                         DF_ID_PICTURE_1
*                         DF_ID_PICTURE_2
*                         DF_ID_PICTURE_3
*                         DF_ID_PICTURE_XX
***************************************************************************/
+ (uint32_t)AddTopTipsWithId:(uint32_t)ID uiPictID:(uint32_t)uiPictID strTopTips:(NSString *)strTopTips eSize:(uint32_t)eSize eBold:(uint32_t)eBold
{
    HLog(@"%@ - 指定图片顶部添加文本提示 - ID:%d - uiPictID ：%d - strTopTips : %@ - eSize : %d - eBold : %d", [self class], ID, uiPictID, strTopTips, eSize, eBold);
    TDD_ArtiPictureModel * model = (TDD_ArtiPictureModel *)[self getModelWithID:ID];
    
    if (uiPictID < model.pictureArr.count) {
        TDD_ArtiPictureItemModel *itemModel = model.pictureArr[uiPictID];
        itemModel.topTips = strTopTips;
        itemModel.size = eSize;
        itemModel.bold = eBold;
        return uiPictID;
    }
    
    return 0;
}

/******************************************************************************
*    功  能：在界面中添加文本框显示，具有滚动条效果，目前只支持右侧，无格式控制
*
*    参  数：strText    显示的文本
*
*    返回值：无
******************************************************************************/
+ (void)AddTextWithId:(uint32_t)ID strText:(NSString *)strText
{
    HLog(@"%@ - 添加文本框显示 - ID:%d - strText ：%@", [self class], ID, strText);
    TDD_ArtiPictureModel * model = (TDD_ArtiPictureModel *)[self getModelWithID:ID];
    
    model.text = strText;
}

#pragma mark 机器翻译 -- 后期有卡顿的话需要优化
- (void)machineTranslation
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (TDD_ArtiPictureItemModel * model in self.pictureArr) {
            if (model.topTips.length > 0 && !model.isStrTopTipsTranslated) {
                [self.translatedDic setValue:@"" forKey:model.topTips];
            }
            
            if (model.bottomTips.length > 0 && !model.isStrBottomTipsTranslated) {
                [self.translatedDic setValue:@"" forKey:model.bottomTips];
            }
        }
        
        [super machineTranslation];
    });
    
}

#pragma mark 翻译完成
- (void)translationCompleted
{
    for (TDD_ArtiPictureItemModel * model in self.pictureArr) {
        if ([self.translatedDic.allKeys containsObject:model.topTips]) {
            if ([self.translatedDic[model.topTips] length] > 0) {
                model.strTranslatedTopTips = self.translatedDic[model.topTips];
                model.isStrTopTipsTranslated = YES;
            }
        }
        
        if ([self.translatedDic.allKeys containsObject:model.bottomTips]) {
            if ([self.translatedDic[model.bottomTips] length] > 0) {
                model.strTranslatedBottomTips = self.translatedDic[model.bottomTips];
                model.isStrBottomTipsTranslated = YES;
            }
        }
    }
    
    [super translationCompleted];
}

- (NSMutableArray<TDD_ArtiPictureItemModel *> *)pictureArr {
    if (!_pictureArr) {
        _pictureArr = [NSMutableArray array];
    }
    return _pictureArr;
}
@end
