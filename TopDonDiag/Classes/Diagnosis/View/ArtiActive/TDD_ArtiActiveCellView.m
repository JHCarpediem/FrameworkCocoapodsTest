//
//  TDD_ArtiActiveCellView.m
//  AD200
//
//  Created by 何可人 on 2022/4/24.
//

#import "TDD_ArtiActiveCellView.h"

@interface TDD_ArtiActiveCellView ()
@property (nonatomic, strong) UIScrollView * bgView;
@property (nonatomic, strong) TDD_CustomLabel * titleLab;
@property (nonatomic, strong) TDD_CustomLabel * valueLab;
@property (nonatomic, strong) TDD_CustomLabel * unitLab;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat spaceHeight;
@property (nonatomic, assign) CGFloat centerspaceWidth;
@property (nonatomic, assign) CGFloat spaceWidth;
@end

@implementation TDD_ArtiActiveCellView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = UIColor.tdd_viewControllerBackground;
        _scale = IS_IPad ? HD_Height : H_Height;
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI {
    UIScrollView *bgView = [[UIScrollView alloc] init];
    bgView.scrollEnabled = NO;
    bgView.bounces = YES;
    
    self.bgView = bgView;
    [self addSubview:bgView];
    
    _spaceWidth = 0;
    _centerspaceWidth = 0;
    _spaceHeight = 0;
    CGFloat valueFontSize = 0;
    
    if (IS_IPad){
        _spaceWidth = _centerspaceWidth =  40 * _scale;
        valueFontSize = 18;
        _spaceHeight = 20 * HD_HHeight;
    }else {
        _spaceWidth =  16 * _scale;
        _centerspaceWidth = 25 * _scale;
        valueFontSize = 14;
        _spaceHeight = 16 * H_HHeight;
    }
    CGFloat width = (IphoneWidth - _spaceWidth * 2 - _centerspaceWidth)/4;

    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerX.equalTo(self);
        make.top.bottom.equalTo(self);
    }];
    
    TDD_CustomLabel * titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.text = @"";
        label.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 0;
        label;
    });
    [bgView addSubview:titleLab];
    self.titleLab = titleLab;
    
    TDD_CustomLabel * valueLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.text = @"";
        label.font = [[UIFont systemFontOfSize:valueFontSize weight:UIFontWeightMedium] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 0;
        label;
    });
    [bgView addSubview:valueLab];
    self.valueLab = valueLab;
    
    TDD_CustomLabel * unitLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.text = @"";
        label.font = [[UIFont systemFontOfSize:12] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 0;
//        label.displaysAsynchronously = YES;
//        label.preferredMaxLayoutWidth = IphoneWidth / 4.0;
        label;
    });
    [bgView addSubview:unitLab];
    self.unitLab = unitLab;
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor tdd_line];
    [self addSubview:lineView];
    self.lineView = lineView;
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(bgView).insets(UIEdgeInsetsMake(_spaceHeight, _spaceWidth, 0, 0));
        make.width.mas_equalTo(width  * 3);
        make.bottom.lessThanOrEqualTo(bgView).offset(-_spaceHeight).priorityLow();
    }];

    [valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(_spaceHeight);
        make.bottom.lessThanOrEqualTo(bgView).offset(-_spaceHeight).priorityLow();
        make.left.equalTo(titleLab.mas_right).offset(_centerspaceWidth);
        make.width.mas_equalTo(width);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.mas_equalTo(IphoneWidth);
        make.height.mas_equalTo(1);
    }];

}

- (void)setItemModel:(ArtiActiveItemModel *)itemModel{
    _bgView.backgroundColor = _isHeader?[UIColor tdd_cellHeadBackground]:[UIColor tdd_reportBackground];
    _lineView.hidden = _isHeader;
    _itemModel = itemModel;
    
    NSString * title = itemModel.strItem;
    
    NSString * value = itemModel.strValue;
    
    NSString * unit = itemModel.strUnit;
    
    if (itemModel.bIsLocked) {
        self.titleLab.textColor = [UIColor tdd_titleLock];
    }else{
        self.titleLab.textColor = [UIColor tdd_title];
    }
    
    if (![self.titleLab.text isEqualToString:title]) {
        self.titleLab.text = title;
        if (_isHeader) {
            _bgView.scrollEnabled = itemModel.headHeight >= itemModel.headMaxHeight;
            [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.centerX.equalTo(self);
                make.top.bottom.equalTo(self);
                make.height.mas_equalTo(itemModel.headHeight);
            }];
        }
    }
    if (_isHeader){
        self.valueLab.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD];
        if (![self.valueLab.text isEqualToString:value]){
            self.valueLab.text = value;
            self.valueLab.textColor = [UIColor tdd_color666666];
            _bgView.scrollEnabled = itemModel.headHeight >= itemModel.headMaxHeight;
            [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.centerX.equalTo(self);
                make.top.bottom.equalTo(self);
                make.height.mas_equalTo(itemModel.headHeight);
            }];
        }

    }else {
        _bgView.scrollEnabled = NO;
        if ((![self.valueLab.attributedText.string isEqualToString:[NSString stringWithFormat:@"%@ %@",value,unit]])) {
            //&& ![NSString tdd_isEmpty:value]
            //value没有值的时候，单位有值，把单位显示出来
            NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:[NSString stringWithFormat:@"%@ %@",value,unit]];
            NSRange valueRange = NSMakeRange(0, value.length);
            [attStr setYy_font:[[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] tdd_adaptHD]];
            [attStr yy_setFont:self.valueLab.font range:valueRange];
            [attStr setYy_color:itemModel.bIsLocked?[UIColor tdd_titleLock]:[UIColor tdd_title]];
            [attStr yy_setColor:itemModel.bIsLocked?[UIColor tdd_titleLock]:[UIColor tdd_color2B79D8] range:valueRange];
            self.valueLab.attributedText = attStr;
//            [self.valueLab sizeToFit];
//            [self layoutIfNeeded];
//            CGFloat h = self.valueLab.frame.size.height;

            [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.centerX.equalTo(self);
                make.top.bottom.equalTo(self);
                make.height.mas_equalTo(itemModel.textMaxHeight);
            }];
            
        }
    }

}


@end
