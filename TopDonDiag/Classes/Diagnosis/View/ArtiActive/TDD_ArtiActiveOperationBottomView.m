//
//  TDD_ArtiActiveOperationBottomView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/9/18.
//

#import "TDD_ArtiActiveOperationBottomView.h"
@interface TDD_ArtiActiveOperationBottomView()
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)TDD_CustomLabel *tipsLabel;
@property (nonatomic, strong)TDD_CustomLabel *contentLabel;
@property (nonatomic, strong)UIButton *cancelBtn;
@property (nonatomic, assign)CGFloat maxTextViewHeight;
@property (nonatomic, assign)CGFloat strHeight;
@property (nonatomic, assign)CGFloat titleHeight;
@property (nonatomic, assign)CGFloat scale;
@property (nonatomic, assign)CGFloat topSpace;
@property (nonatomic, assign)CGFloat topTextSpace;
@end
@implementation TDD_ArtiActiveOperationBottomView

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
    self.backgroundColor = [UIColor tdd_colorDiagBottomTipsBackground];
    _topSpace = (IS_IPad ? 20 : 12) * _scale;
    _topTextSpace = (IS_IPad ? 20 : 12) * _scale;
    CGFloat leftSpace = (IS_IPad ? 40 : 16) * _scale;
    CGFloat rightSpace = (IS_IPad ? 40 : 12) * _scale;
    CGFloat bottomSpace = (IS_IPad ? 20 : 12) * _scale;
    

    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setImage:[UIImage tdd_imageDiagBottomCloseIcon] forState:UIControlStateNormal];

    [_cancelBtn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.tdd_size = CGSizeMake(18, 18);
    _cancelBtn.tdd_hitEdgeInsets = UIEdgeInsetsMake(-20, -12, -20, -12);
    [self addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18 * _scale, 18 * _scale));
        make.top.equalTo(self).offset(self.topSpace);
        make.right.equalTo(self).offset(-rightSpace);
    }];
    
    _scrollView = [[UIScrollView alloc] init];
    [self addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.height.mas_equalTo(20 * _scale);
        make.right.equalTo(_cancelBtn.mas_left).offset(-6 * _scale);
    }];
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage tdd_imageDiagBottomNoteIcon]];
    [self.scrollView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20 * _scale, 20 * _scale));
        make.top.equalTo(self.scrollView).offset(self.topSpace);
        make.left.equalTo(self.scrollView).offset(leftSpace);
        
    }];
    

    _tipsLabel = [[TDD_CustomLabel alloc] init];
    _tipsLabel.textColor = [UIColor tdd_colorDiagBottomTextColor];
    _tipsLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightBold] tdd_adaptHD];

    _tipsLabel.text = TDDLocalized.note;
    _tipsLabel.numberOfLines = 0;
    [_scrollView addSubview:_tipsLabel];
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scrollView).offset(20 * _scale + leftSpace + 8 * _scale);
        make.top.equalTo(_scrollView).offset(self.topTextSpace);
        make.right.equalTo(_cancelBtn.mas_left).offset(-rightSpace * _scale);
    }];
    
    _contentLabel = [[TDD_CustomLabel alloc] init];
    _contentLabel.textColor = [UIColor tdd_colorDiagBottomTextColor];
    _contentLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD];
    _contentLabel.numberOfLines = 0;
    [_scrollView addSubview:self.contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView);
        make.top.equalTo(_tipsLabel.mas_bottom).offset(self.topTextSpace);
        make.left.equalTo(_scrollView).offset(leftSpace);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(_scrollView).offset(-self.topSpace);
    }];
    
    
}

- (void)setTitleStr:(NSString *)titleStr contentStr:(NSString *)contentStr alignType:(uint16_t)alignType fontSize:(uint16_t)fontSize boldType:(uint16_t)boldType {
    _tipsLabel.textAlignment = (alignType == DT_LEFT) ? NSTextAlignmentLeft : (alignType == DT_CENTER ? NSTextAlignmentCenter : NSTextAlignmentRight);
    NSInteger multi = IS_IPad ? 3 : 2;
    NSInteger baseFontSize = IS_IPad ? 18 : 14;
    CGFloat size = baseFontSize + fontSize * multi;
    _tipsLabel.font = [[UIFont systemFontOfSize:size weight:boldType==1?UIFontWeightBold:UIFontWeightMedium] tdd_adaptHD];
    
    if (![contentStr?:@"" isEqualToString:self.contentLabel.text?:@""] || (![titleStr?:@"" isEqualToString:self.tipsLabel.text?:@""] && !([NSString tdd_isEmpty:titleStr] && [self.tipsLabel.text isEqualToString:TDDLocalized.note]))) {
        if ([NSString tdd_isEmpty:_tipsLabel.text] || [NSString tdd_isEmpty:titleStr]) {
            titleStr = TDDLocalized.note;
        }
        _tipsLabel.text = titleStr;
        self.contentLabel.text = contentStr;
        CGFloat space = IS_IPad ? (80 * _scale) : (76 * _scale);
        CGFloat titleSpace = IS_IPad ? (132 * _scale) : (102 * _scale);
        CGSize titleSize = [_tipsLabel sizeThatFits:CGSizeMake(IphoneWidth - titleSpace, CGFLOAT_MAX)];
        CGSize contentSize = [NSString tdd_isEmpty:contentStr] ? CGSizeMake(0, 0) : [_contentLabel sizeThatFits:CGSizeMake(IphoneWidth - space - 8 *_scale, CGFLOAT_MAX)];
        CGFloat titleH = titleSize.height;
        CGFloat height = contentSize.height + 20;

        //height = MIN(height, _maxTextViewHeight);
        self.strHeight = height;
        self.titleHeight = titleH;
        BOOL isContentEmpty = [NSString tdd_isEmpty:contentStr];
        CGFloat textMargin = isContentEmpty ? (self.topTextSpace + self.topSpace) * _scale : (self.topTextSpace * 2 + self.topSpace) * _scale;
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.right.equalTo(_cancelBtn.mas_left).offset(-6 * _scale);
            make.bottom.equalTo(isContentEmpty?_tipsLabel.mas_bottom:_contentLabel.mas_bottom).offset(self.topSpace * _scale);
            make.height.mas_equalTo(MIN(self.maxTextViewHeight, _strHeight + _titleHeight + textMargin));
        }];
        _scrollView.contentSize = CGSizeMake(0, titleH + height + textMargin);
    }

}

- (void)hideView {
    
    if (self.hideBlock){
        self.hideBlock();
    }
    
}
@end
