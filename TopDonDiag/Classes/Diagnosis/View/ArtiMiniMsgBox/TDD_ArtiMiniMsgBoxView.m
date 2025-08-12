//
//  TDD_ArtiMiniMsgBoxView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/7/18.
//

#import "TDD_ArtiMiniMsgBoxView.h"
#import "TDD_LoadingView.h"

@interface TDD_ArtiMiniMsgBoxView ()
@property (nonatomic, strong) UIView    *alertView;
@property (nonatomic, strong) TDD_LoadingView *loadingView;
@property (nonatomic, strong) UIView    *contentView;
@property (nonatomic, strong) TDD_CustomLabel   *titleLabel;
@property (nonatomic, strong) UITextView   *contentLabel;
@property (nonatomic, strong) UIButton *firstBtn;
@property (nonatomic, strong) UIButton *secondBtn;
@property (nonatomic, strong) UIView    *topLine;
@property (nonatomic, strong) UIView    *midLine;

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat buttonHeight;
@end


@implementation TDD_ArtiMiniMsgBoxView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor tdd_colorWithHex:0x000000 alpha:0.7];
        
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI
{
    _scale = IS_IPad ? HD_Height : H_Height;
    _leftSpace = (IS_IPad  ? 20 : 10 ) * _scale;
    _fontSize = IS_IPad ? 20 : 17;
    CGFloat titleTopSpace = (IS_IPad ? 30 : 22) * _scale;
    CGFloat vSpace = (IS_IPad ? 20 : 15) * _scale;
    CGFloat loadingHeight = (IS_IPad ? 80 : 70) * _scale;
    CGFloat alertWidth = (IS_IPad ? 480 : 282) * _scale;
    _buttonHeight = (IS_IPad ? 68 : 48) * _scale;
    
    UIView *alertView = [[UIView alloc] init];
    alertView.backgroundColor = [UIColor tdd_alertBg];
    [alertView tdd_addCornerRadius:2.5];
    [self addSubview:alertView];
    self.alertView = alertView;
    
    TDD_CustomLabel *titleLabel = [[TDD_CustomLabel alloc] init];
    titleLabel.text = [NSString stringWithFormat:@""];
    titleLabel.font = [[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold] tdd_adaptHD];
    titleLabel.textColor = [UIColor tdd_title];
    titleLabel.numberOfLines = 0;
    [alertView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    
    UIView *contentView = [[UIView alloc] init];
    [alertView addSubview:contentView];
    self.contentView = contentView;
    
    TDD_LoadingView *loadingView = [[TDD_LoadingView alloc] initWithFrame:CGRectMake(0, 0, loadingHeight, loadingHeight)];
    [contentView addSubview:loadingView];
    [loadingView setBGColor:UIColor.cardBg];
    self.loadingView = loadingView;
    [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView).offset(14);
        make.size.mas_equalTo(CGSizeMake(loadingHeight, loadingHeight));
    }];
    
    UITextView *contentLabel = [[UITextView alloc] init];
    contentLabel.backgroundColor = UIColor.clearColor;
    contentLabel.editable = NO;
    contentLabel.text = [NSString stringWithFormat:@""];
    contentLabel.font = [[UIFont systemFontOfSize:14] tdd_adaptHD];
    contentLabel.textColor = [UIColor tdd_title];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.indicatorStyle = isKindOfTopVCI ? UIScrollViewIndicatorStyleWhite : UIScrollViewIndicatorStyleBlack;
    contentLabel.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
    
    [contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [UIColor tdd_line];
    [alertView addSubview:topLine];
    self.topLine = topLine;
    
    UIView *midLine = [UIView new];
    midLine.backgroundColor = [UIColor tdd_line];
    [alertView addSubview:midLine];
    self.midLine = midLine;
    
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.tag = 100;
    [firstBtn setTitleColor:[UIColor tdd_title] forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor tdd_colorCCCCCC] forState:UIControlStateDisabled];
    firstBtn.titleLabel.font = [[UIFont systemFontOfSize:16 weight:UIFontWeightMedium] tdd_adaptHD];
    [firstBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:firstBtn];
    self.firstBtn = firstBtn;
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.tag = 101;
    [secondBtn setTitleColor:[UIColor tdd_title] forState:UIControlStateNormal];
    [secondBtn setTitleColor:[UIColor tdd_colorCCCCCC] forState:UIControlStateDisabled];
    secondBtn.titleLabel.font = [[UIFont systemFontOfSize:16 weight:UIFontWeightMedium] tdd_adaptHD];
    [secondBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:secondBtn];
    self.secondBtn = secondBtn;
    CGFloat h = IphoneHeight / 1.5;
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(alertWidth);
        make.height.mas_lessThanOrEqualTo(h);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertView).offset(titleTopSpace);
        make.centerX.equalTo(alertView);
        make.left.greaterThanOrEqualTo(alertView).offset(_leftSpace);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(vSpace);
        make.centerX.equalTo(alertView);
        make.left.equalTo(alertView).offset(_leftSpace);
        make.height.mas_greaterThanOrEqualTo(150 * _scale);
        make.height.mas_lessThanOrEqualTo(215 * _scale);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(contentView).offset(_leftSpace);
    }];
    
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(24 * _scale);
        make.left.bottom.equalTo(alertView);
        make.height.mas_equalTo(_buttonHeight);
        make.right.equalTo(alertView.mas_centerX);
    }];
    
    [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(24 * _scale);
        make.right.bottom.equalTo(alertView);
        make.height.mas_equalTo(_buttonHeight);
        make.left.equalTo(alertView.mas_centerX);
    }];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(firstBtn.mas_top);
        make.left.right.equalTo(alertView);
        make.height.mas_equalTo(1);
    }];
    
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(firstBtn);
        make.left.equalTo(firstBtn.mas_right);
        make.width.mas_equalTo(1);
    }];
}

- (void)setMiniMsgBoxModel:(TDD_ArtiMiniMsgBoxModel *)miniMsgBoxModel
{
    _miniMsgBoxModel = miniMsgBoxModel;
    
    self.titleLabel.text = miniMsgBoxModel.strTitle;
    self.contentLabel.text = miniMsgBoxModel.strContent;
    self.loadingView.hidden = !miniMsgBoxModel.isBusyVisible;
    [self changeUI];
    [self layoutIfNeeded];
    [self contentSizeToFit:(_miniMsgBoxModel.uAlignType == DT_BOTTOM) ? 2 : 1];

    
    if (!miniMsgBoxModel.bIsBlock) {
        [miniMsgBoxModel conditionSignalWithTime:0.1];
    }
    
}

// textView 0居上、1居中、2居下
- (void)contentSizeToFit:(NSInteger )type {
    //先判断一下有没有文字（没文字就没必要设置居中了）
    if([self.contentLabel.text length]>0){
            //textView的contentSize属性
            CGSize contentSize =self.contentLabel.contentSize;

            //textView的内边距属性
            UIEdgeInsets offset;;

            //如果文字内容高度没有超过textView的高度
            if(contentSize.height<=self.contentLabel.frame.size.height){

            //textView的高度减去文字高度除以2就是Y方向的偏移量，也就是textView的上内边距
                CGFloat offsetY = 0;
                switch (type) {
                    case 0:
                        {
                            offsetY = 0;
                        }
                        break;
                    case 1:
                        {
                            offsetY = (self.contentLabel.frame.size.height - contentSize.height)/2;
                        }
                        break;
                    case 2:
                        {
                            offsetY = self.contentLabel.frame.size.height - contentSize.height;
                        }
                        break;
                        
                    default:
                        offsetY = 0;
                        break;
                }
                
            offset = UIEdgeInsetsMake(offsetY,0,0,0);
            [self.contentLabel setContentInset:offset];
        }
    }
}


- (void)changeUI
{
    CGFloat textTopSpace = (IS_IPad ? 10 : 5) * _scale;
    if (self.miniMsgBoxModel.isBusyVisible) {
        self.loadingView.hidden = NO;
        [self.loadingView startAnimated];
    }else {
        self.loadingView.hidden = YES;
        [self.loadingView stopAnimated];
    }
    
    if (self.miniMsgBoxModel.buttonArr.count==1){
        TDD_ArtiButtonModel *btnModel = self.miniMsgBoxModel.buttonArr.firstObject;
        if (btnModel.uStatus == ArtiButtonStatus_UNVISIBLE) {
            [self showBtnWithCount:0 unVisibleIndex:0];
        }else {
            [self showBtnWithCount:1 unVisibleIndex:0];
        }
        

    }else if (self.miniMsgBoxModel.buttonArr.count>=2){
        TDD_ArtiButtonModel *btnModelFir = self.miniMsgBoxModel.buttonArr.firstObject;
        TDD_ArtiButtonModel *btnModelSec = self.miniMsgBoxModel.buttonArr.lastObject;
        if (btnModelFir.uStatus == 2 && btnModelSec.uStatus == 2){
            [self showBtnWithCount:0 unVisibleIndex:0];
        }else if (btnModelFir.uStatus != 2 && btnModelSec.uStatus != 2) {
            [self showBtnWithCount:2 unVisibleIndex:0];
        }else {
            if (btnModelFir.uStatus != 2) {
                [self showBtnWithCount:1 unVisibleIndex:0];
            }else {
                [self showBtnWithCount:1 unVisibleIndex:1];
            }
        }
        

    }else if (self.miniMsgBoxModel.buttonArr.count==0){
        [self showBtnWithCount:0 unVisibleIndex:0];
    }
    
    int alignType = self.miniMsgBoxModel.uAlignType;
    switch (alignType) {
        case DT_LEFT:
        {
            [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (self.loadingView.hidden){
                    make.top.equalTo(self.contentView);
                }else{
                    make.top.equalTo(self.loadingView.mas_bottom).offset(textTopSpace);
                }
                make.bottom.equalTo(self.contentView.mas_bottom);
                make.right.equalTo(self.contentView.mas_centerX).offset(_leftSpace);
                make.left.equalTo(self.contentView);
            }];
        }
            break;
        case DT_RIGHT:
        {
            [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (self.loadingView.hidden){
                    make.top.equalTo(self.contentView);
                }else{
                    make.top.equalTo(self.loadingView.mas_bottom).offset(textTopSpace);
                }
                make.bottom.equalTo(self.contentView.mas_bottom);
                make.left.equalTo(self.contentView.mas_centerX).offset(-_leftSpace);
                make.right.equalTo(self.contentView);
            }];
        }
            break;
        case DT_CENTER:
        {
            [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (self.loadingView.hidden){
                    make.top.bottom.equalTo(self.contentView);
                }else{
                    make.top.equalTo(self.loadingView.mas_bottom).offset(textTopSpace);
                    make.bottom.equalTo(self.contentView.mas_bottom);
                }
                make.centerX.equalTo(self.contentView);
                make.left.equalTo(self.contentView).offset(_leftSpace);
            }];
        }
            break;
        case DT_BOTTOM:
        {
            [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (self.loadingView.hidden){
                    make.top.bottom.equalTo(self.contentView);
                }else{
                    make.top.equalTo(self.loadingView.mas_bottom).offset(textTopSpace);
                    make.bottom.equalTo(self.contentView.mas_bottom);
                }
                make.centerX.equalTo(self.contentView);
                make.left.equalTo(self.contentView).offset(_leftSpace);
            }];
        }
            break;
        default:
        {
            [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (self.loadingView.hidden){
                    make.centerX.equalTo(self.contentView);
                    make.top.bottom.equalTo(self.contentView);
                }else{
                    make.top.equalTo(self.loadingView.mas_bottom).offset(textTopSpace);
                    make.bottom.equalTo(self.contentView.mas_bottom);
                    make.centerX.equalTo(self.contentView);
                }
                make.left.equalTo(self.contentView).offset(_leftSpace);
            }];
        }
            break;
    }
}


/// 按钮显示规则
/// - Parameters:
///   - count: 显示的按钮数量
///   - index: 显示的按钮处于数组的位置(只有count=1时用到)
- (void)showBtnWithCount:(NSInteger )count unVisibleIndex:(NSInteger )index{
    CGFloat textTopSpace = (IS_IPad ? 10 : 5) * _scale;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(textTopSpace);
        make.centerX.equalTo(_alertView);
        make.left.equalTo(_alertView).offset(_leftSpace);
        make.height.mas_greaterThanOrEqualTo(150 * _scale);
        make.height.mas_lessThanOrEqualTo(215 * _scale);
        if (count == 0){
            make.bottom.equalTo(_alertView).offset(-_leftSpace);
        }
        
    }];
    switch (count) {
        case 0:
            {
                self.topLine.hidden = YES;
                self.firstBtn.hidden = YES;
                self.secondBtn.hidden = YES;
                self.midLine.hidden = YES;
            }
            break;
        case 1:
            {
                TDD_ArtiButtonModel *btnModel;
                if (index == 0) {
                    btnModel = self.miniMsgBoxModel.buttonArr.firstObject;
                }else {
                    btnModel = self.miniMsgBoxModel.buttonArr.lastObject;
                }
                self.topLine.hidden = NO;
                self.firstBtn.hidden = NO;
                self.secondBtn.hidden = YES;
                self.midLine.hidden = YES;
                [self.firstBtn setTitle:btnModel.strButtonText forState:0];
                self.firstBtn.enabled = (btnModel.uStatus == ArtiButtonStatus_ENABLE);
                
                [self.firstBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView.mas_bottom).offset(24 * _scale);
                    make.left.right.bottom.equalTo(self.alertView);
                    make.height.mas_equalTo(_buttonHeight);
                }];
            }
            break;
        case 2:
            {
                TDD_ArtiButtonModel *btnModelFir = self.miniMsgBoxModel.buttonArr.firstObject;
                TDD_ArtiButtonModel *btnModelSec = self.miniMsgBoxModel.buttonArr.lastObject;
                
                self.topLine.hidden = NO;
                self.firstBtn.hidden = NO;
                self.secondBtn.hidden = NO;
                self.midLine.hidden = NO;
                
                [self.firstBtn setTitle:btnModelFir.strButtonText forState:0];
                self.firstBtn.enabled = (btnModelFir.uStatus == ArtiButtonStatus_ENABLE);
                
                
                [self.secondBtn setTitle:btnModelSec.strButtonText forState:0];
                self.secondBtn.enabled = (btnModelSec.uStatus == ArtiButtonStatus_ENABLE);
                [self.firstBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView.mas_bottom).offset(24 * _scale);
                    make.left.bottom.equalTo(self.alertView);
                    make.height.mas_equalTo(_buttonHeight);
                    make.right.equalTo(self.alertView.mas_centerX);
                }];
                
                [self.secondBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView.mas_bottom).offset(24 * _scale);
                    make.right.bottom.equalTo(self.alertView);
                    make.height.mas_equalTo(_buttonHeight);
                    make.left.equalTo(self.alertView.mas_centerX);
                }];
            }
            break;
            
        default:
            break;
    }
}

- (void)btnClick:(UIControl *)sender {
    
    if (self.miniMsgBoxModel.buttonArr.count > sender.tag - 100) {
        TDD_ArtiButtonModel * model = self.miniMsgBoxModel.buttonArr[sender.tag - 100];
        HLog(@"按钮点击：%u", model.uButtonId);
        
        BOOL isBlack = [self.miniMsgBoxModel ArtiButtonClick:model.uButtonId];

        if (isBlack && self.miniMsgBoxModel.isLock) {
            
            self.miniMsgBoxModel.returnID = model.uButtonId;
            
            [self.miniMsgBoxModel conditionSignal];
        }
    }
}

@end
