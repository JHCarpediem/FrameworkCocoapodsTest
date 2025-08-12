//
//  TDD_ArtiListFooterView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/12/15.
//

#import "TDD_ArtiListTableFooterView.h"
@interface TDD_ArtiListTableFooterView()
@property (nonatomic, strong) TDD_CustomTextView *tipsTextView;
@property (nonatomic, assign)CGFloat maxTextViewHeight;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat strHeight;
@end
@implementation TDD_ArtiListTableFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _scale = IS_IPad ? HD_Height : H_Height;
        _fontSize = IS_IPad ? 14 : 11;
        CGFloat bottomHeight  = IS_IPad ? 100 * _scale : 58 * _scale;
        _maxTextViewHeight = (IphoneHeight - NavigationHeight - (bottomHeight * _scale + iPhoneX_D))/3;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor tdd_colorDiagBottomTipsBackground];
    _topSpace = (IS_IPad ? 20 : 16) * _scale;
    _leftSpace = (IS_IPad ? 40 : 20) * _scale;
    CGFloat cancelSize = (IS_IPad ? 16 : 10) * _scale;
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = kImageNamed(@"close_icon");
    image = [image tdd_imageByTintColor:UIColor.blackColor];
    [_cancelBtn setImage:image forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.tdd_size = CGSizeMake(cancelSize, cancelSize);
    _cancelBtn.tdd_hitEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
    [self addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cancelSize, cancelSize));
        make.top.equalTo(self).offset(_topSpace);
        make.right.equalTo(self).offset(-_leftSpace);
    }];
    
    [self addSubview:self.tipsTextView];
    [_tipsTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cancelBtn.mas_bottom).offset(10 * _scale);
        make.bottom.equalTo(self).offset(-_topSpace);
        make.left.equalTo(self).offset(_leftSpace);
        make.centerX.equalTo(self);
    }];
    
}

- (void)setListModel:(TDD_ArtiListModel *)listModel {
    _listModel = listModel;
    _tipsTextView.text = listModel.strBottomTips;
    if ([NSString tdd_isEmpty:listModel.strBottomTips]){
        [_tipsTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_cancelBtn.mas_bottom).offset(10 * _scale);
            make.bottom.equalTo(self).offset(-_topSpace);
            make.left.equalTo(self).offset(_leftSpace);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(0);
        }];
    }else {
        CGFloat tipsHeight = [NSString tdd_getHeightWithText:_listModel.strBottomTips width:IphoneWidth - 40 fontSize:[[UIFont systemFontOfSize:_fontSize weight:UIFontWeightRegular] tdd_adaptHD]] + 5 * _scale;

        self.strHeight = MIN(tipsHeight, _maxTextViewHeight);
        [_tipsTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_cancelBtn.mas_bottom).offset(10 * _scale);
            make.bottom.equalTo(self).offset(-_topSpace);
            make.left.equalTo(self).offset(_leftSpace);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(self.strHeight);
        }];
    }
}

- (CGFloat )footViewHeight {
    
    if ([NSString tdd_isEmpty:_listModel.strBottomTips]){
        return 0;
    }

    CGFloat tipsHeight = [NSString tdd_getHeightWithText:_listModel.strBottomTips width:IphoneWidth - _leftSpace * 2 fontSize:[[UIFont systemFontOfSize:_fontSize weight:UIFontWeightRegular] tdd_adaptHD]] + 5 * _scale;

    tipsHeight = MIN(tipsHeight, _maxTextViewHeight);
    
    return tipsHeight;
    
}

- (TDD_CustomTextView *)tipsTextView {
    if (!_tipsTextView) {
        _tipsTextView = [[TDD_CustomTextView alloc] init];
        _tipsTextView.textColor = [UIColor tdd_title];
        _tipsTextView.font = [[UIFont systemFontOfSize:_fontSize weight:UIFontWeightRegular] tdd_adaptHD];
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

- (void)hideView {
    
    if (self.hideBlock){
        self.hideBlock();
    }
    
}
@end
