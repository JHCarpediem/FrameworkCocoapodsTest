//
//  TDD_ArtiLiveDataCellView.m
//  AD200
//
//  Created by 何可人 on 2022/6/2.
//

#import "TDD_ArtiLiveDataCellView.h"
//#import "TDD_HChartView.h"
#import <TopdonDiagnosis/TopdonDiagnosis-Swift.h>
@import TDUIProvider;
@interface TDD_ArtiLiveDataCellView ()
@property (nonatomic, strong) UIView * view;
@property (nonatomic, strong) YYLabel * titleLab;
@property (nonatomic, strong) TDD_CustomLabel * valueLab;
@property (nonatomic, strong) TDD_CustomLabel * scopeLab;
@property (nonatomic, strong) CAGradientLayer * gl;
@property (nonatomic, strong) TDD_HChartViewNew * chartView;
@property (nonatomic, strong) UIButton * moreButton;
@property (nonatomic, strong) SpeedView * speedView;
@property (nonatomic, strong) UIView * speedBackView;
@property (nonatomic, strong) TDD_CustomLabel * value2Label;
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UIButton * chartButton;

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat topViewTopSpace;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat titleTopSpace;
@property (nonatomic, assign) CGFloat lableSpace;
@property (nonatomic, assign) CGFloat labelWidth;
@property (nonatomic, assign) CGFloat chartLeftSpace;
@property (nonatomic, assign) CGFloat chartViewHeight;
@property (nonatomic, assign) CGFloat chartBtnHeight;
@property (nonatomic, assign) CGFloat chartBtnRightSpace;
@property (nonatomic, assign) CGFloat chartBtnBotomSpace;
@end

@implementation TDD_ArtiLiveDataCellView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI
{
    _scale = IS_IPad ? HD_Height : H_Height;
    _topViewTopSpace = (IS_IPad ? 20 : 10) * _scale;
    _leftSpace = (IS_IPad ? 40 : 20) * _scale;
    _titleTopSpace = (IS_IPad ? 24 : 16) * _scale;
    _lableSpace = 30 * _scale;
    _labelWidth = (IphoneWidth - _leftSpace * 2 - _lableSpace)/3;
    _chartLeftSpace = (IS_IPad ? 63 : 15) * _scale;
    _chartViewHeight = (IS_IPad ? 216 : 100) * _scale;
    _chartBtnHeight = (IS_IPad ? 30 : 20) * _scale;
    _chartBtnRightSpace = (IS_IPad ? 12 : 8) * _scale;
    _chartBtnBotomSpace = (IS_IPad ? 30 : 20) * _scale;
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor tdd_liveDataCellBackground];
    [self addSubview:view];
    self.view = view;
    
    UIView * topView = ({
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor tdd_liveDataCellBackground];
        view;
    });
    [view addSubview:topView];
    self.topView = topView;
    
    YYLabel * titleLab = ({
        YYLabel * label = [[YYLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:IS_IPad ? 18 : 16 weight:UIFontWeightSemibold] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 2;
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentLeft;
        //label.backgroundColor = UIColor.redColor;
        [self setTruncationToken:label];
        label;
    });
    [topView addSubview:titleLab];
    self.titleLab = titleLab;
    
    //15*15
    UIButton * moreButton = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage tdd_imageDiagLiveDataMore] forState:UIControlStateNormal];
        btn;
    });
    [topView addSubview:moreButton];
    self.moreButton = moreButton;
    
    TDD_CustomLabel * valueLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = [UIColor tdd_colorDiagTheme];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        //label.backgroundColor = UIColor.redColor;
        label;
    });
    [view addSubview:valueLab];
    self.valueLab = valueLab;
    
    TDD_CustomLabel * value2Label = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = UIColor.tdd_colorDiagTheme;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    [view addSubview:value2Label];
    self.value2Label = value2Label;
    
    TDD_CustomLabel * scopeLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:12] tdd_adaptHD];
        label.textColor = [UIColor tdd_liveDataScoreColor];
        label.textAlignment = NSTextAlignmentRight;
        label.numberOfLines = 0;
        label;
    });
    [view addSubview:scopeLab];
    self.scopeLab = scopeLab;
    
    TDD_HChartViewNew* chartView = [[TDD_HChartViewNew alloc] init];
//    chartView.userInteractionEnabled = NO;
    chartView.hidden = YES;
    [view addSubview:chartView];
    self.chartView = chartView;
    
    // gradient
    UIView * speedBackView = [[UIView alloc] init];
    [view addSubview:speedBackView];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,250 * _scale,250 * _scale);
    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    speedBackView.layer.shadowColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0].CGColor;
    speedBackView.layer.shadowOffset = CGSizeMake(0,0);
    speedBackView.layer.shadowOpacity = 1;
    speedBackView.layer.shadowRadius = 6;
    speedBackView.layer.cornerRadius = 125 * _scale;
    speedBackView.layer.masksToBounds = YES;
    [speedBackView.layer insertSublayer:gl atIndex:0];
    self.speedBackView = speedBackView;
    
    SpeedView * speedView = [[SpeedView alloc] init];
    speedView.layer.cornerRadius = 120 * _scale;
    speedView.calculations.minValue = 0;
    speedView.calculations.maxValue = 1000;
    speedView.calculations.longSectionGapValue = 1000 / 10;
    speedView.calculations.shortSectionGapValue = 1000 / 100;
    [view addSubview:speedView];
    self.speedView = speedView;
    
    CGFloat lineWidth = .5f;
    UIColor *lineColor = UIColor.tdd_line;
    UIColor *sepLineColor = [UIColor tdd_liveDataSepLineColor];
    [self.view tdd_addLine:TDD_LinePositionTypeTop lineTag:888888 lineWidth:10 lineColor:sepLineColor edgeInsets:UIEdgeInsetsZero];
    UIView * topLine = [self.view viewWithTag:888888];
    [topLine tdd_addLine:TDD_LinePositionTypeTop lineTag:10000001 lineWidth:0.5 lineColor:lineColor edgeInsets:UIEdgeInsetsZero];
    [topLine tdd_addLine:TDD_LinePositionTypeBottom lineTag:10000001 lineWidth:0.5 lineColor:lineColor edgeInsets:UIEdgeInsetsZero];
    [self.topView tdd_addLine:TDD_LinePositionTypeTop lineTag:100003 lineWidth:lineWidth lineColor:lineColor edgeInsets:UIEdgeInsetsZero];
    [self.topView tdd_addLine:TDD_LinePositionTypeBottom lineTag:100003 lineWidth:lineWidth lineColor:lineColor edgeInsets:UIEdgeInsetsZero];
    
    UIButton * chartButton = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(chartButtonClick) forControlEvents:UIControlEventTouchUpInside];
        if isKindOfTopVCI {
            [btn setImage:kImageNamed(@"chart_full_carpal") forState:UIControlStateNormal];
        } else {
            [btn setImage:kImageNamed(@"chart_full") forState:UIControlStateNormal];
        }
        btn;
    });
    [chartView addSubview:chartButton];
    self.chartButton = chartButton;
    
    [self setupConstraints];
}


- (void)setupConstraints
{
    BOOL isIpad = IS_IPad;

    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.greaterThanOrEqualTo(self.valueLab.mas_bottom).offset(10);
        make.bottom.greaterThanOrEqualTo(self.scopeLab.mas_bottom).offset(10);
//        make.bottom.greaterThanOrEqualTo(chartView.mas_bottom).offset(8);
//        make.bottom.greaterThanOrEqualTo(speedView.mas_bottom).offset(8);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(10, 0, 0, 0));
        make.height.mas_greaterThanOrEqualTo((isIpad ? 70 : 50) * _scale);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.topView).insets(UIEdgeInsetsMake(_titleTopSpace, _leftSpace, _titleTopSpace, 0));
        make.right.equalTo(self.moreButton.mas_left).offset(-16 * _scale);
    }];
    CGFloat btnW = isIpad ? 24 * 1.2 * _scale : 24 * _scale;
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView);
        make.right.equalTo(self.topView.mas_right).inset(_leftSpace);
        make.size.mas_equalTo(CGSizeMake(btnW, btnW));
    }];
    
    
//    [@[self.valueLab, self.value2Label] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:20 tailSpacing:20];
    
    [self.valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(_leftSpace);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom).offset(_titleTopSpace );
        make.top.greaterThanOrEqualTo(self.view).offset((isIpad ? 98 : 76) * _scale );
        make.height.mas_greaterThanOrEqualTo((isIpad ? 28 : 24) * _scale);
    }];

    [self.value2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.valueLab);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.valueLab.mas_bottom).offset(6 * _scale);
        make.height.mas_greaterThanOrEqualTo((isIpad ? 28 : 24) * _scale);

    }];
    
    
    [self.scopeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).inset(_leftSpace);
        make.top.greaterThanOrEqualTo(self.topView.mas_bottom).offset(_titleTopSpace );
        make.top.greaterThanOrEqualTo(self.view).offset((isIpad ? 98 : 76) * _scale );
        make.centerY.equalTo(self.valueLab);
        make.left.equalTo(self.valueLab.mas_right).offset(_lableSpace);
    }];
    
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(_chartLeftSpace);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.valueLab.mas_bottom).offset(_topViewTopSpace);
        make.height.mas_equalTo(_chartViewHeight);
    }];
    
    [self.speedView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.left.equalTo(view).insets(UIEdgeInsetsMake(15, 15, 0, 15));
        make.top.equalTo(self.valueLab.mas_bottom).offset(20 * _scale);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(240 * _scale, 240 * _scale));
    }];
    
    [self.speedBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250 * _scale, 250 * _scale));
        make.center.equalTo(self.speedView);
    }];
    
    [self.chartButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.chartView);
        make.right.equalTo(self.chartView).offset(-_chartBtnRightSpace);
        make.bottom.equalTo(self.chartView).offset(-_chartBtnBotomSpace);
        make.width.height.mas_equalTo(_chartBtnHeight);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).priorityHigh();
    }];
}

- (void)setItemModel:(TDD_ArtiLiveDataItemModel *)itemModel
{
    if ([itemModel isKindOfClass:[NSDictionary class]]) {
        //数据流播放时是字典，需要转换
        itemModel = [TDD_ArtiLiveDataItemModel yy_modelWithDictionary:(NSDictionary *)itemModel];
        [itemModel.valueArr removeLastObject];
    }
    
    _itemModel = itemModel;
    
    if (![self.titleLab.text isEqualToString:itemModel.strName]) {
        self.titleLab.text = itemModel.strName;
//        self.titleLab.attributedText = [[NSAttributedString alloc] initWithString:itemModel.strName];
        
    }
    
    NSMutableAttributedString * attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:[NSString stringWithFormat:@"%@ %@", itemModel.strChangeValue, itemModel.strChangeUnit]];
    
//    if (![self.valueLab.text isEqualToString:attStr.mutableString]) {
    attStr.yy_font = [[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold] tdd_adaptHD];
        
    //    attStr.yy_color = self.valueLab.textColor;
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
    
//        if (itemModel.strChangeValue.length > 0 && [NSString tdd_isNum:itemModel.strChangeValue]) {
//            //值为数字
//            if (itemModel.strChangeMin.length > 0 && itemModel.strChangeMax.length > 0 && [NSString tdd_isNum:itemModel.strChangeMin] && [NSString tdd_isNum:itemModel.strChangeMax]) {
//                //范围为数字
//                if (itemModel.strChangeValue.doubleValue < itemModel.setStrMin.doubleValue || itemModel.strChangeValue.doubleValue > itemModel.setStrMax.doubleValue) {
//                    //小于最小值 或者 大于最大值 则 值为红色
//                    [attStr addAttributes:@{ NSForegroundColorAttributeName : [UIColor redColor]} range:[attStr.string rangeOfString:itemModel.strChangeValue]];
//                }
//            }
//        }
        
        if (itemModel.strChangeUnit.length > 0) {
            UIColor *textColor = [UIColor tdd_liveDataUnitNormalColor];
            [attStr addAttributes:@{ NSForegroundColorAttributeName : textColor, NSFontAttributeName : unitFont} range:[attStr.string rangeOfString:itemModel.strChangeUnit options:NSBackwardsSearch]];
        }
        
        self.valueLab.attributedText = attStr;
//    }
    
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
            make.left.equalTo(self.view).offset(_leftSpace);
            make.top.equalTo(self.topView.mas_bottom).offset(_titleTopSpace);
            make.top.lessThanOrEqualTo(self.view).offset((IS_IPad ? 98 : 76) * _scale);
            make.height.mas_greaterThanOrEqualTo((IS_IPad ? 28 : 24) * _scale);
            make.width.mas_equalTo(_labelWidth * 2);
        }];
    }
    
    self.chartView.hidden = YES;
    
    self.speedView.hidden = YES;
    
    self.speedBackView.hidden = YES;
    
    self.value2Label.hidden = YES;
    
    [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(self.valueLab.mas_bottom).offset(_titleTopSpace);
        make.bottom.greaterThanOrEqualTo(self.scopeLab.mas_bottom).offset(_titleTopSpace);
    }];
    
    if (itemModel.UIType == 0) {
       
    }else if (itemModel.UIType == 1) {
        self.chartView.hidden = NO;
        
        [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.greaterThanOrEqualTo(self.valueLab.mas_bottom).offset(_topViewTopSpace * 2 + _chartViewHeight);
            make.bottom.greaterThanOrEqualTo(self.scopeLab.mas_bottom).offset(_topViewTopSpace * 2 + _chartViewHeight);
        }];
        
        self.chartView.startTime = self.itemModel.startTime;
        
        [self.chartView setValueArr:@[itemModel.valueArr]];
        
    }else if (itemModel.UIType == 2) {
        float min = itemModel.strChangeMin.floatValue;
        
        float max = itemModel.strChangeMax.floatValue;
        
        float interval = max - min;
        
        if (interval > 0) {
            self.speedView.hidden = NO;
            
            self.speedBackView.hidden = NO;
            
            [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.greaterThanOrEqualTo(self.valueLab.mas_bottom).offset(_topViewTopSpace * 2 + 250 * _scale);
                make.bottom.greaterThanOrEqualTo(self.scopeLab.mas_bottom).offset(_topViewTopSpace * 2 + 250 * _scale);
            }];
            
            if (self.speedView.calculations.minValue != min || self.speedView.calculations.maxValue != max) {
                self.speedView.calculations.minValue = min;
                self.speedView.calculations.maxValue = max;
                self.speedView.calculations.longSectionGapValue = interval / 10.0;
                self.speedView.calculations.shortSectionGapValue = interval / 100.0;
                [self.speedView reDrawLabels];
            }
            
            self.speedView.bottomLabel.text = itemModel.strChangeUnit;
            
            [self.speedView rotateGaugeWithNewValue:itemModel.strChangeValue.floatValue duration:0.1];
        }
    }
    
    if (self.isPlay) {
        self.moreButton.hidden = YES;
    }
}

- (void)setFreezeItemModel:(TDD_ArtiFreezeItemModel *)freezeItemModel
{
    
    _freezeItemModel = freezeItemModel;
    
    NSString * titleStr = @"";
    
    if (self.isShowTranslated) {
        titleStr = freezeItemModel.strTranslatedName;
    }else {
        titleStr = freezeItemModel.strName;
    }
    
    if (![self.titleLab.text isEqualToString:titleStr]) {
        if (self.isShowTranslated) {
            self.titleLab.text = titleStr;
            [_titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(self.topView).insets(UIEdgeInsetsMake(_titleTopSpace, _leftSpace, _titleTopSpace, 0));
                make.right.equalTo(self.moreButton.mas_left).offset(-16 * _scale);
                make.height.mas_equalTo(freezeItemModel.translatedNameHeight);
            }];
        }else {
            self.titleLab.text = titleStr;
            [_titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(self.topView).insets(UIEdgeInsetsMake(_titleTopSpace, _leftSpace, _titleTopSpace, 0));
                make.right.equalTo(self.moreButton.mas_left).offset(-16 * _scale);
                make.height.mas_equalTo(freezeItemModel.nameHeight);
            }];
        }
    }

    UIColor *normalColor = UIColor.tdd_liveDataUnitNormalColor;
    UIColor *higllightColor = [UIColor tdd_liveDataValueNormalColor];
    UIFont * font = [[UIFont systemFontOfSize:IS_IPad ? 14 : 12] tdd_adaptHD];
    
    if (freezeItemModel.eColumnType == 2) {
        NSString * wholeText1 = [NSString stringWithFormat:@"%@: %@ %@", [NSString tdd_isEmpty:freezeItemModel.strHead]?@"First":freezeItemModel.strHead,freezeItemModel.strChangeValue, freezeItemModel.strChangeUnit];
        NSMutableAttributedString *text1 = [wholeText1 tdd_setHighlight:freezeItemModel.strChangeValue font:font normalColor:normalColor highlightColor:higllightColor];
        
        NSString * wholeText2 = [NSString stringWithFormat:@"%@: %@ %@", [NSString tdd_isEmpty:freezeItemModel.strHead2nd]?@"Last":freezeItemModel.strHead2nd,freezeItemModel.strChangeValue2nd, freezeItemModel.strChangeUnit];
        NSMutableAttributedString *text2 = [wholeText2 tdd_setHighlight:freezeItemModel.strChangeValue2nd font:font normalColor:normalColor highlightColor:higllightColor];
        
        self.valueLab.attributedText = text1;
        self.value2Label.attributedText = text2;
    } else {
        NSString *text = [NSString stringWithFormat:@"%@ %@", freezeItemModel.strChangeValue, freezeItemModel.strChangeUnit];
        self.valueLab.attributedText = [text tdd_setHighlight:freezeItemModel.strChangeValue font:font normalColor:normalColor highlightColor:higllightColor];
    }
    
    self.value2Label.hidden = freezeItemModel.eColumnType != 2;
    

    self.chartView.hidden = YES;
    
    self.speedView.hidden = YES;
    
    self.speedBackView.hidden = YES;
    
    [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 10, 0));
        if (self.value2Label.isHidden) {
            make.bottom.equalTo(self.valueLab.mas_bottom).offset(10);
        } else {
            make.bottom.equalTo(self.value2Label.mas_bottom).offset(10);
        }
    }];
    
    
    if (freezeItemModel.strHelp.length > 0) {
        self.moreButton.enabled = YES;
        [self.moreButton setBackgroundImage:[kImageNamed(@"artiFreeze_help") tdd_imageByTintColor:UIColor.tdd_colorDiagTheme] forState:UIControlStateNormal];
    }else {
        self.moreButton.enabled = NO;
        [self.moreButton setBackgroundImage:UIImage.tdd_imageDiagHelpUnableIcon forState:UIControlStateNormal];
    }

}

- (void)moreButtonClick
{
    if (self.itemModel) {
        if ([self.delegate respondsToSelector:@selector(TDD_ArtiLiveDataCellViewMoreButtonClick:)]) {
            [self.delegate TDD_ArtiLiveDataCellViewMoreButtonClick:self.itemModel];
        }
    }else if (self.freezeItemModel) {
        NSString * strHelp = @"";
        
        if (self.isShowTranslated) {
            strHelp = self.freezeItemModel.strTranslatedHelp;
        }else {
            strHelp = self.freezeItemModel.strHelp;
        }
        
        [LMSAlertController showIknowWithTitle:nil content:strHelp image:nil];
    }
    
}

- (void)chartButtonClick
{
    if ([self.delegate respondsToSelector:@selector(TDD_ArtiLiveDataCellViewChartButtonClick:)]) {
        [self.delegate TDD_ArtiLiveDataCellViewChartButtonClick:self.itemModel];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
//    self.view.backgroundColor = [UIColor tdd_colorDiagNormalGradient:TDD_GradientStyleTopToBottom withFrame:self.view.frame.size];
    self.view.backgroundColor = [UIColor tdd_liveDataCellBackground];
    //[self addLayer];
}

- (void)addLayer
{
    [self.gl removeFromSuperlayer];
    
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.view.bounds;
    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:242/255.0 green:248/255.0 blue:253/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 10;
    [self.view.layer insertSublayer:gl atIndex:0];
    
    self.gl = gl;
}

- (void)dealloc
{
    HLog(@"%s", __func__);
}

- (void)setTruncationToken: (YYLabel *)label
{
    NSString *moreStr = [NSString stringWithFormat:@"...%@", TDDLocalized.upgrade_more];
    NSMutableAttributedString *token = [NSMutableAttributedString mutableAttributedStringWithLTRString:moreStr];
    token.yy_font = label.font;
    token.yy_color = UIColor.tdd_title;
    
    NSRange moreRange = [token.string rangeOfString:TDDLocalized.upgrade_more];
    [token addAttributes:@{NSForegroundColorAttributeName:UIColor.tdd_color2B79D8} range:moreRange];
    //下划线
    YYTextDecoration *decor = [YYTextDecoration decorationWithStyle:YYTextLineStyleSingle width:@1 color:UIColor.tdd_colorDiagTheme];

    [token yy_setTextUnderline:decor range:moreRange];
    
    //添加详情 需要点击事件
    @kWeakObj(self)
    [token yy_setTextHighlightRange:moreRange
                              color:UIColor.tdd_colorDiagTheme
                    backgroundColor:nil
                          tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        @kStrongObj(self)
        
        NSString * strContent = @"";
        
        if (self.isShowTranslated) {
            strContent = self.freezeItemModel?self.freezeItemModel.strTranslatedName:self.itemModel.strName;
        }else {
            strContent = self.freezeItemModel?self.freezeItemModel.strName:self.itemModel.strName;
        }
        
        [LMSAlertController showIknowWithTitle:nil content:strContent image:nil];
    }];
    
    YYLabel *moreL = [[YYLabel alloc] init];
    moreL.textAlignment = NSTextAlignmentLeft;
    moreL.attributedText = token;
    [moreL sizeToFit];
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:moreL contentMode:UIViewContentModeCenter attachmentSize:moreL.frame.size alignToFont:label.font alignment:YYTextVerticalAlignmentCenter];
    label.truncationToken= truncationToken;
}

@end
