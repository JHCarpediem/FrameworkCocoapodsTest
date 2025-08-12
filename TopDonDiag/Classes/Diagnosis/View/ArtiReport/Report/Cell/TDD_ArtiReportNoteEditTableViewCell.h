//
//  TDD_ArtiReportNoteEditTableViewCell.h
//  TopdonDiagnosis
//
//  Created by liuyong on 2024/7/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TDD_ArtiReportNoteEditDelegate <NSObject>

- (void)reportInfoChangedNote:(NSString *)note;

@end

@interface TDD_ArtiReportNoteEditTableViewCell : UITableViewCell

@property (nonatomic, weak) id<TDD_ArtiReportNoteEditDelegate> delegate;

- (void)setNote:(NSString *)note;

@end

NS_ASSUME_NONNULL_END
