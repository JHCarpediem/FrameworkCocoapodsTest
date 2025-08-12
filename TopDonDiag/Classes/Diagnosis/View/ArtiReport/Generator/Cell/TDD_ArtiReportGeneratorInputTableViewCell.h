//
//  TDD_ArtiReportGeneratorInputTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportGeneratorInputTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) TDD_CustomLabel *nameLabel;
@property (nonatomic, strong) TDD_CustomTextField *inputTextField;
@property (nonatomic, copy) void(^didChangedText)(NSString*);
//TODO: 行驶里程 需要新增单位切换
@property (nonatomic, assign) BOOL isMileage;
@property (nonatomic, copy) void(^didMileageInputChanged)(NSString* unit, double value);
@property (nonatomic, copy) NSString * diagnosticUnit;
@property (nonatomic, copy) void(^didDiagnosticUnitChanged)(NSString* unit);
@property (nonatomic, assign) double inputMileValue;
@property (nonatomic, assign) double inputKmValue;

- (void)setInputText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
