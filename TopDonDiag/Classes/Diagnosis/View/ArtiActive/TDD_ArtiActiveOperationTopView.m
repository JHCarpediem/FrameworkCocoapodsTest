//
//  TDD_ArtiActiveOperationTopView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/9/18.
//


#import "TDD_ArtiActiveOperationTopView.h"
@interface TDD_ArtiActiveOperationTopView()
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)TDD_CustomLabel *tipsLabel;
@property (nonatomic, strong)TDD_CustomLabel *contentLabel;
@property (nonatomic, strong)UIButton *arrowBtn;
@property (nonatomic, assign)CGFloat maxTextViewHeight;
@property (nonatomic, assign)CGFloat strHeight;
@property (nonatomic, assign)CGFloat titleHeight;
@property (nonatomic, assign)CGFloat titleLineHeight;
@property (nonatomic, assign)CGFloat scale;
@property (nonatomic, assign)CGFloat topSpace;
@property (nonatomic, assign)CGFloat topTextSpace;
@end


@implementation TDD_ArtiActiveOperationTopView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        _scale = IS_IPad ? HD_Height : H_Height;
        CGFloat bottomHeight  = IS_IPad ? 100 * _scale : 58 * _scale;
        _maxTextViewHeight = (IphoneHeight - NavigationHeight - (bottomHeight + iPhoneX_D)  - 112* _scale )/2;
        [self createView];
    }
    return self;
    
}

- (void)createView {
    self.backgroundColor = [UIColor tdd_colorDiagTopTipsBackground];
    _topSpace = (IS_IPad ? 20 : 12) * _scale;
    _topTextSpace = (IS_IPad ? 20 : 14) * _scale;
    CGFloat leftSpace = (IS_IPad ? 40 : 20) * _scale;
    CGFloat rightSpace = (IS_IPad ? 40 : 20) * _scale;
    
    _arrowBtn = [[UIButton alloc] init];
    [_arrowBtn setBackgroundImage:[UIImage tdd_imageDiagUpArrow] forState:UIControlStateNormal];
    [_arrowBtn setBackgroundImage:[UIImage tdd_imageDiagDownArrow] forState:UIControlStateSelected];
    [_arrowBtn addTarget:self action:@selector(showContent) forControlEvents:UIControlEventTouchUpInside];
    _arrowBtn.tdd_size = CGSizeMake(20, 20);
    _arrowBtn.tdd_hitEdgeInsets = UIEdgeInsetsMake(-12, -12, -12, -12);
    [self addSubview:_arrowBtn];

    _scrollView = [[UIScrollView alloc] init];
    [self addSubview:self.scrollView];

    UIImageView *iconView = [[UIImageView alloc] initWithImage:kImageNamed(@"trouble_icon_conditions")];
    [_scrollView addSubview:iconView];

    
    _tipsLabel = [[TDD_CustomLabel alloc] init];
    _tipsLabel.textColor = [UIColor tdd_colorDiagTopTipsTextColor];
    _tipsLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightBold] tdd_adaptHD];
    _titleLineHeight = _tipsLabel.font.lineHeight;
    _tipsLabel.text = TDDLocalized.list_conditions;
    _tipsLabel.numberOfLines = 0;
    [_scrollView addSubview:_tipsLabel];
    
    _contentLabel = [[TDD_CustomLabel alloc] init];
    _contentLabel.textColor = [UIColor tdd_colorDiagTopTipsTextColor];
    _contentLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD];
    _contentLabel.numberOfLines = 0;
    [_scrollView addSubview:self.contentLabel];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18 * _scale, 18 * _scale));
        make.top.equalTo(_scrollView).offset(_topSpace);
        make.left.equalTo(_scrollView).offset(leftSpace);
    }];
    
    [_arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-rightSpace);
        make.size.mas_equalTo(CGSizeMake(20 * _scale, 20 * _scale));
        make.top.equalTo(self).offset(_topSpace);
    }];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.height.mas_equalTo(20 * _scale);
        make.right.equalTo(_arrowBtn.mas_left).offset(4 * _scale);
        //make.bottom.equalTo(_contentLabel.mas_bottom).offset(bottomSpace);
    }];
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.mas_right).offset(8 * _scale);
        make.top.equalTo(_scrollView).offset(_topTextSpace);
        make.right.equalTo(_arrowBtn.mas_left).offset(-rightSpace);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView);
        make.top.equalTo(_tipsLabel.mas_bottom).offset(_topTextSpace);
        make.left.equalTo(_scrollView).offset(leftSpace);
        make.height.mas_equalTo(20);
        //make.bottom.equalTo(_scrollView).offset(-bottomSpace);
    }];
    
}

- (void)setTitleStr:(NSString *)titleStr contentStr:(NSString *)contentStr alignType:(uint16_t)alignType fontSize:(uint16_t)fontSize boldType:(uint16_t)boldType {
    
    _tipsLabel.textAlignment = (alignType == DT_LEFT) ? NSTextAlignmentLeft : (alignType == DT_CENTER ? NSTextAlignmentCenter : NSTextAlignmentRight);
    NSInteger multi = IS_IPad ? 3 : 2;
    NSInteger baseFontSize = IS_IPad ? 18 : 14;
    CGFloat size = baseFontSize + fontSize * multi;
    _tipsLabel.font = [[UIFont systemFontOfSize:size weight:boldType==1?UIFontWeightBold:UIFontWeightMedium] tdd_adaptHD];
    
    if (![contentStr?:@"" isEqualToString:self.contentLabel.text?:@""] || (![titleStr?:@"" isEqualToString:self.tipsLabel.text?:@""] && !([NSString tdd_isEmpty:titleStr] && [self.tipsLabel.text isEqualToString:TDDLocalized.list_conditions]))) {
        if ([NSString tdd_isEmpty:_tipsLabel.text] || [NSString tdd_isEmpty:titleStr]) {
            titleStr = TDDLocalized.list_conditions;
        }
        _tipsLabel.text = titleStr;
        self.contentLabel.text = contentStr;
        CGFloat titleSpace = IS_IPad ? (80 * _scale) : (106 * _scale);
        CGFloat space = IS_IPad ? (80 * _scale) : (40 * _scale);
        CGSize titleSize = [_tipsLabel sizeThatFits:CGSizeMake(IphoneWidth - titleSpace, CGFLOAT_MAX)];
        CGSize contentSize = [NSString tdd_isEmpty:contentStr] ? CGSizeMake(0, 0) : [_contentLabel sizeThatFits:CGSizeMake(IphoneWidth - space - space/2 - 4 * _scale, CGFLOAT_MAX)];
        CGFloat titleH = titleSize.height;
        CGFloat height = contentSize.height;

        //height = MIN(height, _maxTextViewHeight);
        self.strHeight = height;
        self.titleHeight = titleH;
        
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        
        CGFloat h = titleH + height;
        if ([NSString tdd_isEmpty:contentStr]) {
            _arrowBtn.hidden = (titleH < self.tipsLabel.font.lineHeight * 2 + 5);
            h = h + (_topTextSpace + _topSpace);
            [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.equalTo(self);
                make.height.mas_equalTo(MIN(self.maxTextViewHeight, h));
                make.right.equalTo(_arrowBtn.mas_left).offset(-4 * _scale);
                make.bottom.equalTo(_tipsLabel.mas_bottom).offset(_topSpace);
            }];
        }else {
            _arrowBtn.hidden = NO;
            h =  h + (_topTextSpace * 2 + _topSpace);
            [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.equalTo(self);
                make.height.mas_equalTo(MIN(self.maxTextViewHeight, h));
                make.right.equalTo(_arrowBtn.mas_left).offset(-4 * _scale);
                make.bottom.equalTo(_contentLabel.mas_bottom).offset(_topSpace);
            }];
        }
        
        _scrollView.contentSize = CGSizeMake(0, h);
    }
}

- (void)showContent {
    _arrowBtn.selected = !_arrowBtn.selected;
    _scrollView.scrollEnabled = !_arrowBtn.selected;
    _scrollView.showsVerticalScrollIndicator = !_arrowBtn.selected;
    self.tipsLabel.numberOfLines = _arrowBtn.selected?2:0;
    self.contentLabel.hidden = _arrowBtn.selected;
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_arrowBtn.selected ?1 :_strHeight);
    }];
    
    CGSize titleSize = CGSizeMake(0, 0);
    if (_arrowBtn.selected) {
        CGFloat titleSpace = IS_IPad ? (80 * _scale) : (106 * _scale);
        titleSize = [_tipsLabel sizeThatFits:CGSizeMake(IphoneWidth - titleSpace, CGFLOAT_MAX)];
        [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.height.mas_equalTo(MIN(self.maxTextViewHeight, MIN(titleSize.height + _topSpace * 2, _titleLineHeight * 2 + _topSpace * 2)));
            make.right.equalTo(_arrowBtn.mas_left).offset(4 * _scale);
            make.bottom.equalTo(_tipsLabel.mas_bottom).offset(12 * _scale);
        }];
    }else {
        BOOL isContentEmpty = [NSString tdd_isEmpty:self.contentLabel.text];
        CGFloat textMargin = isContentEmpty ? (_topTextSpace + _topSpace) : (_topTextSpace * 2 + _topSpace);
        [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.height.mas_equalTo(MIN(self.maxTextViewHeight, _strHeight + _titleHeight + textMargin));
            make.right.equalTo(_arrowBtn.mas_left).offset(4 * _scale);
            make.bottom.equalTo(isContentEmpty ? _tipsLabel.mas_bottom : _contentLabel.mas_bottom).offset(12 * _scale);
        }];
    }
    
}


@end
