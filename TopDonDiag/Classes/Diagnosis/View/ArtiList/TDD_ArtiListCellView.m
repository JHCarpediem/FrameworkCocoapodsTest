//
//  TDD_ArtiListCellView.m
//  AD200
//
//  Created by 何可人 on 2022/5/13.
//

#import "TDD_ArtiListCellView.h"
@interface TDD_ArtiListCellView ()
@property (nonatomic, strong) NSMutableArray * UIArr;
@property (nonatomic, strong) TDD_CustomLabel * titleLab;
@property (nonatomic, strong) UIView * backView;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIButton * selectButton;
@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, assign) CGFloat leftSpace;
@end

@implementation TDD_ArtiListCellView

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
    _topSpace = (IS_IPad ? 20 : 15) * _scale;
    _leftSpace = (IS_IPad ? 40 : 20) * _scale;
    
    TDD_CustomLabel * titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:14] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 0;
        label;
    });
    [self addSubview:titleLab];
    self.titleLab = titleLab;
    
    UIView * backView = [[UIView alloc] init];
    [self addSubview:backView];
    self.backView = backView;
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor tdd_line];
    [self addSubview:lineView];
    self.lineView = lineView;
    
    UIButton * button = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self addSubview:button];
    self.button = button;
    
    UIButton * selectButton = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 40 * _scale, 40 * _scale);
        [btn addTarget:self action:@selector(selectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:kImageNamed(@"test_result_cell_select") forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(10 * _scale, 10 * _scale, 10 * _scale, 10 * _scale)];
        btn.hidden = YES;
        btn;
    });
    [self addSubview:selectButton];
    self.selectButton = selectButton;
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.hidden = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backView addSubview:imageView];

    self.imageView = imageView;
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(_topSpace);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-_topSpace);
        make.left.equalTo(self).offset(_leftSpace);
    }];

    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(_topSpace, _leftSpace, _topSpace, _leftSpace));
        make.height.mas_lessThanOrEqualTo(IphoneHeight/2);
    }];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];

    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40 * _scale, 40 * _scale));
    }];
}

- (void)setIsHeader:(BOOL)isHeader
{
    _isHeader = isHeader;
    
    if (isHeader) {
        [self.selectButton removeFromSuperview];
    }else {
        [self addSubview:self.selectButton];
    }
    
}

- (void)setItemModel:(ArtiListItemModel *)itemModel
{
    _itemModel = itemModel;
    BOOL isLock = (_model.isLockFirstRow && itemModel.index == 0);
    [self reframeLabelView];
    
    if (itemModel.isGroup) {
        self.backView.hidden = YES;
        self.titleLab.hidden = NO;
        self.titleLab.text = _itemModel.strGroupName;
        self.titleLab.textColor = isLock ? [UIColor tdd_titleLock]  : [UIColor tdd_title];
        
    }else{
        self.backView.hidden = NO;
        self.titleLab.hidden = YES;
        self.titleLab.text = @"";
    }
    
    if (self.listViewType == ITEM_WITH_CHECKBOX_SINGLE || self.listViewType == ITEM_WITH_CHECKBOX_MULTI) {
        [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(40 * _scale);
        }];
        
        if (_itemModel.isGroup) {
            self.selectButton.hidden = YES;
        }else {
            self.selectButton.hidden = NO;
        }
        
    }else {
        [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(_leftSpace);
        }];
        self.selectButton.hidden = YES;
    }
    
    //图片
    if (self.isShowImage && !itemModel.isGroup) {
        self.imageView.hidden = NO;
        
        self.imageView.image = [UIImage imageWithContentsOfFile:self.imageUrlStr];
        
        if (self.uColImageIndex >= 0 && self.uColImageIndex < self.UIArr.count) {
            ASTextNode * label = self.UIArr[self.uColImageIndex];
            
            label.hidden = YES;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.backView layoutIfNeeded];

                [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(label.view);
                    make.top.equalTo(self.backView);
                    make.height.mas_equalTo(self.backView.tdd_height);
                }];
            });
            
        }
    }else {
        self.imageView.hidden = YES;
    }
    [self layoutIfNeeded];
    if (!self.isHeader) {
        if (itemModel.bIsHighLight) {
            if (itemModel.eHighLighColorType == 0){
                self.backgroundColor = [UIColor tdd_colorDiagHightLightColor:CGSizeMake(IphoneWidth, self.tdd_height + 50)];
            }else {
                self.backgroundColor = [UIColor tdd_listBackground];
            }
            
        }else {
            self.backgroundColor = [UIColor clearColor];
        }
    }
}

- (void)reframeLabelView
{
    NSUInteger max = self.UIArr.count;
    
    if (self.vctColWidth.count > max) {
        max = self.vctColWidth.count;
    }
    //CGFloat maxHeight = (IphoneHeight - NavigationHeight - (58 * _scale + iPhoneX_D))/3;
    for (int i = 0; i < max; i ++) {

        ASTextNode * titleLab;

        if (i < self.UIArr.count) {
            titleLab = self.UIArr[i];
        }else{
            titleLab = [self creatTextView];
        }
        titleLab.attributedText = [NSAttributedString new];
        titleLab.hidden = NO;
        
        NSString * titleStr = @"";

        if (i < _itemModel.vctItems.count) {
            titleStr = _itemModel.vctItems[i];
        }
        //空字符串 会导致 UI 位置错位
        if ([titleStr isKindOfClass:[NSString class]]) {
            if (titleStr.length == 0) {
                titleStr = @" ";
            }
        }else {
            NSLog(@"LIST 值不是 string")
            titleStr = @" ";
        }

        BOOL isChangeHeight = NO;
        
        if (![titleLab.attributedText.string isEqualToString:titleStr]) {
            titleLab.attributedText = [self attributedStringForDescription:titleStr];
            isChangeHeight = YES;
        }
        
        if (isChangeHeight) {
            
            CGFloat width = 0;

            if (i < self.vctColWidth.count) {

                CGFloat maxWidth = IphoneWidth - _leftSpace * 2;

                if (self.listViewType == ITEM_WITH_CHECKBOX_SINGLE || self.listViewType == ITEM_WITH_CHECKBOX_MULTI) {
                    maxWidth = IphoneWidth - _leftSpace * 2 - _leftSpace;
                }

                width = [self.vctColWidth[i] floatValue] / 100.0 * (maxWidth);
            }
            
//            titleLab.preferredMaxLayoutWidth = width;
            [titleLab layoutThatFits:ASSizeRangeMake(CGSizeMake(0, 0), CGSizeMake(width, CGFLOAT_MAX))];
            
            if (self.isHeader) {
                [titleLab layoutThatFits:ASSizeRangeMake(CGSizeMake(0, 0), CGSizeMake(width, CGFLOAT_MAX))];
            }
            [titleLab.view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(titleLab.calculatedSize.height + 1);
            }];
        }
    }
}

- (ASTextNode *)creatTextView
{
    ASTextNode * lastView = self.UIArr.lastObject;
    
    ASTextNode * textNode = [[ASTextNode alloc] init];
    
    textNode.attributedText = [self attributedStringForDescription:@""];
//    textNode.displaysAsynchronously = NO;
    textNode.placeholderEnabled = YES;
    textNode.placeholderFadeDuration = 0.15;
    textNode.placeholderColor = [UIColor clearColor];
    if (@available(ios 11.0, *)) {
        textNode.maximumNumberOfLines = 200;
    }else {
        textNode.maximumNumberOfLines = 47;
    }
    [self.backView addSubview:textNode.view];
    
    [self.UIArr addObject:textNode];
    
    [textNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (lastView) {
            make.left.equalTo(lastView.view.mas_right);
        }else{
            make.left.equalTo(self.backView);
        }
        make.top.equalTo(self.backView);
        make.bottom.lessThanOrEqualTo(self.backView);
    }];
    
    return textNode;
}

- (NSAttributedString *)attributedStringForDescription:(NSString *)text {
    BOOL isLock = (_model.isLockFirstRow && _itemModel.index == 0);
    NSMutableDictionary *descriptionAttributes = @{NSFontAttributeName: [[UIFont systemFontOfSize:IS_IPad ? 14 : 12] tdd_adaptHD],
                                          NSForegroundColorAttributeName: isLock ? [UIColor tdd_titleLock] : [UIColor tdd_title],
                                          NSBackgroundColorAttributeName: [UIColor clearColor]}.mutableCopy;
    // 创建 NSParagraphStyle 并设置对齐方式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.alignment = NSTextAlignmentLeft; // 设置为居中对齐（可选：NSTextAlignmentLeft / NSTextAlignmentRight / NSTextAlignmentNatural）
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text attributes:descriptionAttributes];
    [attStr addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, attStr.length)];
    

    return attStr;
}

- (void)btnClick
{
    if (self.itemModel.bIsHighLight) {
        return;
    }
    
    if ([self.delegate respondsToSelector: @selector(TDD_ArtiListCellViewUnderButtonClick:)]) {
        [self.delegate TDD_ArtiListCellViewUnderButtonClick:self];
    }
}

- (void)selectButtonClick
{
    if ([self.delegate respondsToSelector: @selector(TDD_ArtiListCellViewSelectButtonClick:)]) {
        [self.delegate TDD_ArtiListCellViewSelectButtonClick:self];
    }
}

- (void)changeSelectButtonWithIsSelect:(BOOL)isSelect
{
    if (isSelect) {
        if (self.listViewType == ITEM_WITH_CHECKBOX_SINGLE){
            [self.selectButton setImage:[UIImage tdd_imageSingleCheckDidSelect] forState:UIControlStateNormal];
        }else {
            [self.selectButton setImage:[UIImage tdd_imageCheckDidSelect] forState:UIControlStateNormal];
        }

        
    }else {
        if (self.listViewType == ITEM_WITH_CHECKBOX_SINGLE){
            [self.selectButton setImage:[UIImage tdd_imageSingleCheckUnSelect] forState:UIControlStateNormal];
        }else {
            [self.selectButton setImage:kImageNamed(@"test_result_cell_select") forState:UIControlStateNormal];
        }

    }
}

- (NSMutableArray *)UIArr
{
    if (!_UIArr) {
        _UIArr = [[NSMutableArray alloc] init];
    }
    
    return _UIArr;
}
@end
