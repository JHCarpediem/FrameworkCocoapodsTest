//
//  TDD_ArtiReportAttachementEditTableViewCell.h
//  TopdonDiagnosis
//
//  Created by liuyong on 2024/7/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^VoidBlock)(void);

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

- (void)fillCellWithAttachementFilePath:(NSString *)filePath fileArray:(NSString *)fileArrayStr reloadCellBlock:(VoidBlock)block;


@end

@interface TDD_ArtiReportAttachementEditImageCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *attachementImageView;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, copy) VoidBlock deleteBlock;

- (void)fillCellWithAttachementImage:(UIImage *)image;

@end

@interface TDD_ArtiReportAttachementEditAddCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, copy) VoidBlock addBlock;

@end

NS_ASSUME_NONNULL_END
