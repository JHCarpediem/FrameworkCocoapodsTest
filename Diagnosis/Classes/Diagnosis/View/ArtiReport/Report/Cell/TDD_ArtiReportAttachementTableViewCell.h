//
//  TDD_ArtiReportAttachementTableViewCell.h
//  Diag
//
//  Created by yong liu on 2023/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportAttachementTableViewCell : UITableViewCell


- (void)fillCellWithAttachementFilePath:(NSString *)filePath fileArray:(NSString *)fileArrayStr isA4:(BOOL)isA4;

@end

@interface TDD_ArtiReportAttachementImageCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *attachementImageView;

@property (nonatomic, assign) BOOL isA4;

- (void)fillCellWithAttachementImage:(UIImage *)image isA4:(BOOL)isA4;

@end

NS_ASSUME_NONNULL_END
