//
//  TDD_ArtiPictureCellView.h
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/8/10.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiPictureModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiPictureCellView : UITableViewCell
@property (nonatomic, strong)TDD_ArtiPictureItemModel * itemModel;
@property (nonatomic, assign) BOOL isShowTranslated; //是否显示翻译内容

+ (NSString *)reuseIdentifier;
@end

NS_ASSUME_NONNULL_END
