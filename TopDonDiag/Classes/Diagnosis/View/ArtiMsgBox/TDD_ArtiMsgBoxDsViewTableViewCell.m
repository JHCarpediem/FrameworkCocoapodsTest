//
//  TDD_ArtiMsgBoxDsViewTableViewCell.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/28.
//

#import "TDD_ArtiMsgBoxDsViewTableViewCell.h"
@interface TDD_ArtiMsgBoxDsViewTableViewCell()
@property (nonatomic, strong)TDD_CustomLabel *titleLab;
@property (nonatomic, strong)TDD_CustomLabel *valueLab;
@property (nonatomic, strong)TDD_CustomLabel *scopeLab;
@property (nonatomic, strong)UIView *topView;
@property (nonatomic, assign) CGFloat scale;
@end
@implementation TDD_ArtiMsgBoxDsViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _scale = IS_IPad ? HD_Height : H_Height;
    [self addSubview:self.titleLab];
    [self addSubview:self.valueLab];
    [self addSubview:self.scopeLab];
    
    _topView = [UIView new];
    _topView.backgroundColor = [UIColor tdd_colorWithHex:0xf8f8f8];
    [self addSubview:_topView];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor tdd_ColorEEEEEE];
    [self addSubview:lineView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(10 * _scale);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * _scale);
        make.top.equalTo(_topView.mas_bottom).offset(16 * _scale);
        make.right.mas_equalTo(-20 * _scale);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_titleLab.mas_bottom).offset(16 * _scale);
        make.height.mas_equalTo(1 * _scale);
    }];
    
    [_valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLab);
        make.top.equalTo(lineView.mas_bottom).offset(16 * _scale);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-16 * _scale);
    }];
    
    [_scopeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(4 * _scale);
        make.centerY.equalTo(_valueLab);
        make.left.mas_greaterThanOrEqualTo(_valueLab.mas_right).offset(20 * _scale);
    }];
}

- (void)setItemModel:(TDD_ArtiLiveDataItemModel *)itemModel {
    _itemModel = itemModel;
    
//    if (self.isShowTranslated) {
//        if (![self.titleLab.text isEqualToString:itemModel.strTranslatedName]) {
//            self.titleLab.text = itemModel.strTranslatedName;
//        }
//    }else {
        if (![self.titleLab.text isEqualToString:itemModel.strName]) {
            self.titleLab.text = itemModel.strName;
        }
//    }

    NSMutableAttributedString * attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:[NSString stringWithFormat:@"%@ %@", itemModel.strChangeValue, itemModel.strChangeUnit]];
    
    attStr.yy_font = [[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold] tdd_adaptHD];
        
    attStr.yy_color = [UIColor tdd_liveDataValueNormalColor];
    UIFont * unitFont = [[UIFont systemFontOfSize:12] tdd_adaptHD];
        
    if (itemModel.strChangeMin.length > 0 && itemModel.strChangeMax.length > 0 && [NSString tdd_isNum:itemModel.strChangeMin] && [NSString tdd_isNum:itemModel.strChangeMax]) {
        //范围为数字
        if (itemModel.strChangeValue.length > 0 && [NSString tdd_isNum:itemModel.strChangeValue]) {
            //值为数字
            if (itemModel.strChangeValue.doubleValue < itemModel.setStrMin.doubleValue || itemModel.strChangeValue.doubleValue > itemModel.setStrMax.doubleValue) {
                //小于最小值 或者 大于最大值 则 值为红色
                [attStr addAttributes:@{ NSForegroundColorAttributeName : [UIColor redColor]} range:[attStr.string rangeOfString:itemModel.strChangeValue]];
                
            }
        }else {
            //值不为数字，值为红色
            [attStr addAttributes:@{ NSForegroundColorAttributeName : [UIColor redColor]} range:[attStr.string rangeOfString:itemModel.strChangeValue]];
        }
    }
    if (itemModel.strChangeUnit.length > 0) {
        UIColor *textColor = [UIColor tdd_liveDataUnitNormalColor];
        [attStr addAttributes:@{ NSForegroundColorAttributeName : textColor, NSFontAttributeName : unitFont} range:[attStr.string rangeOfString:itemModel.strChangeUnit options:NSBackwardsSearch]];
    }
    
    self.valueLab.attributedText = attStr;

    NSString * reference;
    
    if (_itemModel.setStrMin.length > 0 && _itemModel.setStrMax.length > 0) {
        reference = [NSString stringWithFormat:@"%@-%@", _itemModel.setStrMin, _itemModel.setStrMax];
    }else if (_itemModel.setStrMin.length > 0){
        reference = [NSString stringWithFormat:@">=%@", _itemModel.setStrMin];
    }else if (_itemModel.setStrMax.length > 0){
        reference = [NSString stringWithFormat:@"<=%@", _itemModel.setStrMax];
    }else {
        reference = itemModel.strReference;
    }
    
    if (![self.scopeLab.text isEqualToString:reference]) {
        self.scopeLab.text = reference;
        [self.valueLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20 * _scale);
            make.top.equalTo(self.topView.mas_bottom).offset(16 * _scale);
            make.top.greaterThanOrEqualTo(self.contentView).offset((IS_IPad ? 98 : 76) * _scale);
            make.height.mas_greaterThanOrEqualTo((IS_IPad ? 28 : 24) * _scale);
            make.width.mas_equalTo(30 * _scale * 2);
        }];
    }
}


- (TDD_CustomLabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [TDD_CustomLabel new];
        _titleLab.textColor = [UIColor tdd_title];
        _titleLab.font = [[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold] tdd_adaptHD];
        _titleLab.text = @"Engine speed";
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

- (TDD_CustomLabel *)valueLab {
    if (!_valueLab) {
        _valueLab = [TDD_CustomLabel new];
        _valueLab.textColor = [UIColor tdd_reportCodeTitleTextColor];
        _valueLab.font = [[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold] tdd_adaptHD];
        _valueLab.text = @"521.25";
        _valueLab.numberOfLines = 0;
    }
    return _valueLab;
    
}

- (TDD_CustomLabel *)scopeLab {
    if (!_scopeLab) {
        _scopeLab = [TDD_CustomLabel new];
        _scopeLab.textColor = [UIColor tdd_color666666];
        _scopeLab.font = [[UIFont systemFontOfSize:16 weight:UIFontWeightMedium] tdd_adaptHD];
        _scopeLab.text = @"0-1000";
    }
    return _scopeLab;
    
}
@end
