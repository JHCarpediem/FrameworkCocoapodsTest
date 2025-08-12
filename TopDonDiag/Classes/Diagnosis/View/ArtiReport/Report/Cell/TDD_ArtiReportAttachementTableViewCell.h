//
//  TDD_ArtiReportAttachementTableViewCell.h
//  TopDonDiag
//
//  Created by yong liu on 2023/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportAttachementTableViewCell : UITableViewCell


- (void)fillCellWithAttachementFilePath:(NSString *)filePath fileArray:(NSString *)fileArrayStr isA4:(BOOL)isA4;

@end

NS_ASSUME_NONNULL_END
