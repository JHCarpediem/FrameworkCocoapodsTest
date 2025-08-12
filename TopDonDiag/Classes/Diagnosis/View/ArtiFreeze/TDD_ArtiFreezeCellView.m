//
//  TDD_ArtiFreezeCellView.m
//  AD200
//
//  Created by 何可人 on 2022/5/6.
//

#import "TDD_ArtiFreezeCellView.h"

@interface TDD_ArtiFreezeCellView ()
@property (nonatomic, strong) TDD_CustomLabel * titleLab;
@property (nonatomic, strong) TDD_CustomLabel * valueLab;
@property (nonatomic, strong) TDD_CustomLabel * unitLab;
@property (nonatomic, strong) UIButton * helpButton;
@end

@implementation TDD_ArtiFreezeCellView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = UIColor.tdd_viewControllerBackground;
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI{
    UIButton * helpButton = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(helpButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[kImageNamed(@"artiFreeze_help") tdd_imageByTintColor:UIColor.tdd_colorDiagTheme] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(10 * H_Height, 10 * H_Height, 10 * H_Height, 10 * H_Height)];
        btn;
    });
    [self addSubview:helpButton];
    self.helpButton = helpButton;
    
    TDD_CustomLabel * titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.text = @"";
        label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = [UIColor tdd_color666666];
        label.numberOfLines = 0;
        label;
    });
    [self addSubview:titleLab];
    self.titleLab = titleLab;
    
    TDD_CustomLabel * valueLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.text = @"";
        label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.textAlignment = NSTextAlignmentRight;
        label.numberOfLines = 0;
        label;
    });
    [self addSubview:valueLab];
    self.valueLab = valueLab;
    
    TDD_CustomLabel * unitLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.text = @"";
        label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.textAlignment = NSTextAlignmentRight;
        label.numberOfLines = 0;
        label;
    });
    [self addSubview:unitLab];
    self.unitLab = unitLab;
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor tdd_line];
    [self addSubview:lineView];
    
    double width = IphoneWidth - 40 * H_Height - 40 * H_Height;
    
    [helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5 * H_Height);
        make.centerY.equalTo(titleLab);
        make.size.mas_equalTo(CGSizeMake(37 * H_Height, 37 * H_Height));
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(titleLab.superview).insets(UIEdgeInsetsMake(10 * H_Height, 40 * H_Height, 0, 0));
        make.width.mas_equalTo(width / 2.0);
        make.bottom.lessThanOrEqualTo(titleLab.superview).offset(-10 * H_Height).priorityHigh();
        make.height.mas_greaterThanOrEqualTo(50 * H_Height);
    }];
    
    [valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLab.mas_right).offset(10 * H_Height);
        make.top.equalTo(valueLab.superview).offset(10 * H_Height);
        make.width.mas_equalTo(width / 4.0);
        make.bottom.lessThanOrEqualTo(valueLab.superview).offset(-10 * H_Height).priorityHigh();
        make.height.mas_greaterThanOrEqualTo(50 * H_Height);
    }];
    
    [unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(valueLab.mas_right).offset(10 * H_Height);
        make.top.equalTo(unitLab.superview).offset(10 * H_Height);
        make.width.mas_equalTo(width / 4.0);
        make.bottom.lessThanOrEqualTo(unitLab.superview).offset(-10 * H_Height).priorityHigh();
        make.height.mas_greaterThanOrEqualTo(50 * H_Height);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (void)setItemModel:(TDD_ArtiFreezeItemModel *)itemModel
{
    _itemModel = [itemModel yy_modelCopy];
    
    if (self.isShowTranslated) {
        self.titleLab.text = [TDD_HLanguage getLanguage:_itemModel.strTranslatedName];
    }else {
        self.titleLab.text = [TDD_HLanguage getLanguage:_itemModel.strName];
    }
    
    self.valueLab.text = [NSString stringWithFormat:@"%@", [TDD_HLanguage getLanguage:_itemModel.strValue]];
    
    self.unitLab.text = [TDD_HLanguage getLanguage:_itemModel.strUnit];
    
    if (itemModel.isShowHelpButton) {
        self.helpButton.hidden = NO;
    }else {
        self.helpButton.hidden = YES;
    }
}

- (void)helpButtonClick
{
    NSString * strHelp = @"";
    
    if (self.isShowTranslated) {
        strHelp = self.itemModel.strTranslatedHelp;
    }else {
        strHelp = self.itemModel.strHelp;
    }
    [TDD_HTipManage showBtnTipViewWithTitle:strHelp buttonType:HTipBtnOneType block:^(NSInteger btnTag) {
        
    }];
}
@end
