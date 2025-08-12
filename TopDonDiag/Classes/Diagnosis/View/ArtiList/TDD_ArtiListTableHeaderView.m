//
//  TDD_ArtiListTableHeaderView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/12/15.
//

#import "TDD_ArtiListTableHeaderView.h"
@interface TDD_ArtiListTableHeaderView()
@property (nonatomic, strong) TDD_CustomLabel *titleLabel;
@property (nonatomic, strong) TDD_CustomTextView *tipsTextView;
@property (nonatomic, assign) CGFloat maxTextViewHeight;
@property (nonatomic, assign) CGFloat strHeight;
@property (nonatomic, assign) CGFloat oneLineStrHeight;
@property (nonatomic, strong) UIButton *arrowBtn;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat tipsFontSize;
@end
@implementation TDD_ArtiListTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _scale = IS_IPad ? HD_Height : H_Height;
        _tipsFontSize = IS_IPad ? 14 : 11;
        CGFloat bottomHeight  = IS_IPad ? 100 * _scale : 58 * _scale;
        _maxTextViewHeight = (IphoneHeight - NavigationHeight - (bottomHeight + iPhoneX_D))/2 - 66;
        _oneLineStrHeight = [NSString tdd_getHeightWithText:@"StrTops" width:IphoneWidth - _leftSpace * 2 fontSize:[[UIFont systemFontOfSize:_tipsFontSize weight:UIFontWeightRegular] tdd_adaptHD]];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    self.backgroundColor = [UIColor tdd_colorDiagTopTipsBackground];
    _topSpace = (IS_IPad ? 20 : 16) * _scale;
    _leftSpace = (IS_IPad ? 40 : 20) * _scale;
    
    _arrowBtn = [[UIButton alloc] init];
    [_arrowBtn setBackgroundImage:[UIImage tdd_imageDiagUpArrow] forState:UIControlStateNormal];
    [_arrowBtn setBackgroundImage:[UIImage tdd_imageDiagDownArrow] forState:UIControlStateSelected];
    [_arrowBtn addTarget:self action:@selector(showContent) forControlEvents:UIControlEventTouchUpInside];
    _arrowBtn.tdd_size = CGSizeMake(20, 20);
    _arrowBtn.tdd_hitEdgeInsets = UIEdgeInsetsMake(-12, -12, -12, -12);
    [self addSubview:_arrowBtn];
    [_arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-_leftSpace);
        make.size.mas_equalTo(CGSizeMake(16 * _scale, 16 * _scale));
        make.top.equalTo(self).offset(_topSpace);
    }];
    
    
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.tipsTextView];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.arrowBtn);
        make.left.equalTo(self).offset(_leftSpace);
        make.right.equalTo(self).offset(-16 * _scale - _leftSpace);
    }];
    [self.tipsTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.arrowBtn.mas_bottom).offset(10 * _scale);
        make.bottom.equalTo(self).offset(- _topSpace);
        make.left.equalTo(self).offset(_leftSpace);
        make.right.equalTo(self).offset(-16 * _scale - _leftSpace);
        make.height.mas_equalTo(50);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor tdd_line];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setListModel:(TDD_ArtiListModel *)listModel {
    _listModel = listModel;
    self.titleLabel.text = listModel.strTitleTopTips;
    CGFloat fontSize = ((listModel.eFontSize==0)?18:(listModel.eFontSize==1)?20:22);
    self.titleLabel.font = [[UIFont systemFontOfSize:fontSize weight:listModel.eBoldType==0?UIFontWeightMedium:UIFontWeightBold] tdd_adaptHD];
    switch (listModel.uAlignType) {
        case DT_LEFT:
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
            break;
        case DT_CENTER:
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            break;
        case DT_RIGHT:
            self.titleLabel.textAlignment = NSTextAlignmentRight;
            break;
        case DT_BOTTOM:
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            break;
        default:
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
            break;
    }
    self.tipsTextView.text = listModel.strTopTips;
    if ([NSString tdd_isEmpty:listModel.strTopTips] || _arrowBtn.selected) {
        
        if ([NSString tdd_isEmpty:listModel.strTopTips]){
            _arrowBtn.hidden = YES;
        }
        [self.arrowBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-_leftSpace);
            make.size.mas_equalTo(CGSizeMake(16 * _scale, 16 * _scale));
            make.top.equalTo(self).offset(_topSpace);
        }];
        self.tipsTextView.hidden = ![NSString tdd_isEmpty:listModel.strTitleTopTips];
        [self.tipsTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if ([NSString tdd_isEmpty:listModel.strTitleTopTips]) {
                make.top.equalTo(self.arrowBtn);
                make.height.mas_equalTo(_oneLineStrHeight);
                make.bottom.equalTo(self).offset(-_topSpace);
            }else {
                make.top.equalTo(self.titleLabel.mas_bottom).offset(10 * _scale);
                make.height.mas_equalTo(0);
                make.bottom.equalTo(self);
            }
            
            make.left.equalTo(self).offset(_leftSpace);
            make.right.equalTo(self).offset(-16 * _scale - _leftSpace);
        }];

    }else {
        _arrowBtn.hidden = NO;
        self.tipsTextView.hidden = NO;
        CGFloat tipsHeight = [NSString tdd_getHeightWithText:_listModel.strTopTips width:IphoneWidth - _leftSpace * 2 fontSize:[[UIFont systemFontOfSize:_tipsFontSize weight:UIFontWeightRegular] tdd_adaptHD]];
        self.strHeight = MIN(_maxTextViewHeight, tipsHeight);
        [self.arrowBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-_leftSpace);
            make.size.mas_equalTo(CGSizeMake(16 * _scale, 16 * _scale));
            make.top.equalTo(self).offset(_topSpace);
        }];
        [self.tipsTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10 * _scale);
            make.bottom.equalTo(self).offset(-_topSpace);
            make.left.equalTo(self).offset(_leftSpace);
            make.right.equalTo(self).offset(-16 * _scale - _leftSpace);
            make.height.mas_equalTo(self.strHeight);
        }];
    }
    
    
}

- (void)showContent{
    _arrowBtn.selected = !_arrowBtn.selected;
    _tipsTextView.scrollEnabled = !_arrowBtn.selected;
    self.listModel = _listModel;
    if (!_listModel.bIsBlock) {
        [_listModel conditionSignalWithTime:0.1];
    }
}

- (TDD_CustomLabel *)titleLabel {
    if (!_titleLabel){
        _titleLabel = [[TDD_CustomLabel alloc] init];
        _titleLabel.textColor = [UIColor tdd_colorDiagTopTipsTextColor];
        _titleLabel.font = [[UIFont systemFontOfSize:18 weight:UIFontWeightRegular] tdd_adaptHD];
    }
    
    return _titleLabel;;
}

- (TDD_CustomTextView *)tipsTextView {
    if (!_tipsTextView) {
        _tipsTextView = [[TDD_CustomTextView alloc] init];
        _tipsTextView.textColor = [UIColor tdd_colorDiagTopTipsTextColor];
        _tipsTextView.font = [[UIFont systemFontOfSize:IS_IPad ? 14 : 11 weight:UIFontWeightRegular] tdd_adaptHD];
        _tipsTextView.textAlignment = NSTextAlignmentCenter;
        _tipsTextView.showsVerticalScrollIndicator = NO;
        _tipsTextView.showsHorizontalScrollIndicator = NO;
        _tipsTextView.bounces = NO;
        _tipsTextView.textContainerInset = UIEdgeInsetsZero;
        _tipsTextView.textContainer.lineFragmentPadding = 0;
        _tipsTextView.backgroundColor = UIColor.clearColor;
        _tipsTextView.editable = NO;
    }
    return _tipsTextView;
}

@end
