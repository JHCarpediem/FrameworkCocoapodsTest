//
//  TDD_HTipBtnView.m
//  BT20
//
//  Created by 何可人 on 2021/10/28.
//

#import "TDD_HTipBtnView.h"

@interface TDD_HTipBtnView ()
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) HTipBtnType tipBtnType;
@property (nonatomic, strong) NSMutableArray * btnArr;
@property (nonatomic, assign) CGFloat scale;
@end

@implementation TDD_HTipBtnView

- (instancetype)initWithTitle:(NSString *)title buttonType:(HTipBtnType)tipBtnType{
    self = [super init];
    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
        self.title = title;
        self.tipBtnType = tipBtnType;
        self.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    float wHeight = isTopVCI ? 194 : 168;
    float wWidth = IS_IPad ? 480 : 316;
    float btnHeight = isTopVCI ? 44 : 48;
    float btnBottom = isTopVCI ? 24 : 0;
    float btnMargin = isTopVCI ? 20 : 0;
    btnHeight = IS_IPad ? 68 : btnHeight;
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wWidth, wHeight  * _scale)];
    whiteView.center = CGPointMake(IphoneWidth / 2, IphoneHeight / 2);
    whiteView.backgroundColor =  UIColor.tdd_alertBg;
    whiteView.layer.cornerRadius = 10;
    [self addSubview:whiteView];
    
    TDD_CustomLabel * titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.frame = CGRectMake(0, 20 * _scale, 260 * _scale, 65 * _scale);
        label.center = CGPointMake(wWidth * _scale / 2, label.center.y);
        label.font = [[UIFont systemFontOfSize:16] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.text = [TDD_HLanguage getLanguage:self.title];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        
        NSArray * arr = @[@"tip_voltage_high",@"tip_voltage_low",@"tip_voltage_very_low"];
        
        if ([arr containsObject:self.title]) {
            NSRange range1 = [label.text rangeOfString:@"("];
            NSRange range2 = [label.text rangeOfString:@")"];
            
            if (range1.length == 1 && range2.length == 1) {
                NSMutableAttributedString * attString = [NSMutableAttributedString mutableAttributedStringWithLTRString:label.text];
                [attString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range1.location, range2.location + 1 - range1.location)];
                label.attributedText = attString;
            }
        }
        
        label;
    });
    [whiteView addSubview:titleLab];
    
    [titleLab sizeToFit];
    
    float add_w = 0;
    if (titleLab.frame.size.height > 65 * _scale) {
        add_w = titleLab.frame.size.height - 65 * _scale;
    }
    
    float w = wHeight * _scale + add_w;
    
    float all_w = wHeight * _scale + add_w;
    
    UIScrollView * scrollView;
    
    if (w > IphoneHeight - 80 * _scale) {
        w = IphoneHeight - 80 * _scale;
        
        scrollView = [[UIScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 0, wWidth * _scale, w - btnHeight * _scale);
        scrollView.contentSize = CGSizeMake(wWidth * _scale, all_w - btnHeight * _scale);
        [whiteView addSubview:scrollView];
        
        [scrollView addSubview:titleLab];
    }
    
    whiteView.frame = CGRectMake(0, 0, wWidth * _scale, w);
    whiteView.center = CGPointMake(IphoneWidth / 2, IphoneHeight / 2);
    titleLab.center = CGPointMake(wWidth * _scale / 2, (all_w - btnHeight * _scale) / 2);
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, w - btnHeight * _scale, wWidth * _scale, 1 * _scale);
    // Background Code
    lineView.backgroundColor = [UIColor tdd_alertLineColor];
    [whiteView addSubview:lineView];
    lineView.hidden = isTopVCI;
    
    int btnNub = 1;
    
    NSArray * arr = @[@"app_confirm"];
    
    if (self.tipBtnType == HTipBtnTwoType) {
        btnNub = 2;
        arr = @[@"app_cancel",@"app_confirm"];
    }else if (self.tipBtnType == HTipBtnTwoYNType) {
        btnNub = 2;
        arr = @[@"app_no",@"app_yes"];
    }
    float btn_w = isTopVCI ? (whiteView.frame.size.width - 40 - (btnNub - 1 ) * 20) / btnNub : whiteView.frame.size.width / btnNub;
    
    UIView *horizontalLineView = [[UIView alloc] init];
    horizontalLineView.frame = CGRectMake(btn_w, w - btnHeight * _scale + 14 * _scale, 1, btnHeight - 28 * _scale);
    horizontalLineView.backgroundColor = [UIColor tdd_alertLineColor];
    [whiteView addSubview:horizontalLineView];
    horizontalLineView.hidden = isTopVCI && btnNub > 1;
    
    for (int i = 0; i < btnNub; i ++) {
        UIButton * btn = ({
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((btn_w + btnMargin) * i + btnMargin, w - btnBottom - btnHeight * _scale, btn_w, btnHeight * _scale);
            btn.titleLabel.font = [[UIFont systemFontOfSize:17] tdd_adaptHD];
            UIColor *txtColor = (i == 0 && btnNub == 2) ? [UIColor tdd_subTitle] : [UIColor tdd_colorDiagTheme];
            if (isTopVCI) {
                if (i == 0 && btnNub == 2){
                    btn.backgroundColor = UIColor.tdd_line;
                } else {
                    btn.backgroundColor = UIColor.tdd_colorDiagTheme;
                }
                txtColor = UIColor.tdd_title;
                btn.layer.cornerRadius = 5;
                btn.layer.masksToBounds = YES;
            }
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[TDD_HLanguage getLanguage:arr[i]] forState:UIControlStateNormal];
            [btn setTitleColor:txtColor forState:UIControlStateNormal];
            btn;
        });
        
        [whiteView addSubview:btn];
        
        [self.btnArr addObject:btn];
    }
}

/// 设置按钮文字
- (void)setupButtonTitles:(NSArray *)btnTitles
{
    if (self.btnArr.count >= 1 && btnTitles.count >= 1) {
        UIButton *btn1 = self.btnArr[0];
        [btn1 setTitle:btnTitles[0] forState:UIControlStateNormal];
    }
    if (self.tipBtnType == HTipBtnTwoType) {
        if (self.btnArr.count >= 2 && btnTitles.count >= 2) {
            UIButton *btn1 = self.btnArr[1];
            [btn1 setTitle:btnTitles[1] forState:UIControlStateNormal];
        }
    }
}

- (void)btnClick:(UIButton *)btn{
    
    int i = (int)[self.btnArr indexOfObject:btn];
    
    if ([self.delegata respondsToSelector:@selector(hTipBtnViewTag:didClickWithBtnTag:)]) {
        [self.delegata hTipBtnViewTag:(int)self.tag - 500500 didClickWithBtnTag:i];
    }
    
    if (self.clickBlock){
        self.clickBlock(i);
    }
    
    [self removeFromSuperview];
}

- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [[NSMutableArray alloc] init];
    }
    return _btnArr;
}

@end
