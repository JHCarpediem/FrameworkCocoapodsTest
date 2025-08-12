//
//  TDD_ArtiReportAttachementEditTableViewCell.h
//  TopdonDiagnosis
//
//  Created by liuyong on 2024/7/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportAttachementEditTableViewCell : UITableViewCell

/// 所有图片
@property (nonatomic, strong) NSMutableArray *imageArray;

/// 编辑前已缓存图片
@property (nonatomic, strong) NSMutableArray *localImageArray;

/// 编辑前已缓存图片地址
@property (nonatomic, strong) NSMutableArray *localImageSringArray;

/// 新添加图片
@property (nonatomic, strong) NSMutableArray *addArray;

///
@property (nonatomic, strong) NSMutableArray *addAssets;

- (void)fillCellWithAttachementFilePath:(NSString *)filePath fileArray:(NSString *)fileArrayStr;


@end

NS_ASSUME_NONNULL_END
