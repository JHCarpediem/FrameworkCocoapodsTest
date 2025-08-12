//
//  TDD_ArtiMenuCellView.m
//  AD200
//
//  Created by 何可人 on 2022/4/19.
//

#import "TDD_ArtiMenuCellView.h"

@interface TDD_ArtiMenuCellView ()
@property (nonatomic, strong) UIScrollView * bgView;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIImageView * tipImageView;
@property (nonatomic, strong) TDD_CustomLabel * titleLab;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat insetSpace;
@property (nonatomic, assign) CGFloat imgHeight;
@property (nonatomic, assign) CGFloat fontSize;
@end

@implementation TDD_ArtiMenuCellView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
        _insetSpace = (IS_IPad ? 20 : 10) * _scale;
        _imgHeight = (IS_IPad ? 138 : 100) * _scale;
        _fontSize = IS_IPad ? 20 : 17;
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI{
    self.bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.tdd_width, self.tdd_height)];
    self.bgView.bounces = NO;
    self.bgView.userInteractionEnabled = NO;
    [self addGestureRecognizer: self.bgView.panGestureRecognizer];//解决滚动与点击冲突
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIImageView * tipIcon = [[UIImageView alloc] init];
    tipIcon.hidden = YES;
    [tipIcon setImage:kImageNamed(@"diag_trouble_btn_lock")];
    self.tipImageView = tipIcon;
    [self.bgView addSubview:tipIcon];
    [tipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22 * _scale, 22 * _scale));
        make.top.equalTo(self).offset(10 * _scale);
        make.right.equalTo(self.mas_right).offset(-10 * _scale);
    }];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.bgView addSubview:imageView];
    imageView.hidden = YES;
    self.imageView = imageView;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.left.mas_equalTo(_insetSpace);
        make.height.equalTo(self).multipliedBy(0.62);
    }];
    
    TDD_CustomLabel * titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:_fontSize] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label;
    });

    [self.bgView addSubview:titleLab];
    self.titleLab = titleLab;
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgView).insets(UIEdgeInsetsMake(_insetSpace, _insetSpace, _insetSpace, _insetSpace));
    }];
    
    if ([TDD_DiagnosisTools isDebug]) {
        self.titleLab.accessibilityIdentifier = @"menuTitleLabel";
    }
}

-(void)setingTitelLabelColor:(UIColor *)color;
{
    self.titleLab.textColor = color;
}

- (void)setItemModel:(ArtiMenuItemModel *)itemModel{
    _itemModel = itemModel;
    
    //过期加锁图标
    _tipImageView.hidden = (itemModel.uStatus != DF_ST_MENU_EXPIR);
    
    CGFloat height = 0;
    NSString *text;
    if (self.isShowTranslated) {
        text= itemModel.strTranslatedItem;
    }else {
        text= itemModel.strItem;
    }
    self.titleLab.text = text;
    CGFloat strHeight = [NSString tdd_getHeightWithText:text width:_itemHeight - _insetSpace * 2 fontSize:self.titleLab.font];
    height += strHeight + _insetSpace * 2;
    if (itemModel.strIconPath.length > 0) {
        //有图片
        self.imageView.hidden = NO;
        
        self.imageView.image = [UIImage imageWithContentsOfFile:itemModel.strIconPath];
        [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(_insetSpace);
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(self.imageView.mas_bottom).offset(_insetSpace);
        }];
        height += self.tdd_height * 0.62 + _insetSpace;
    }else{
        //无图片
        self.imageView.hidden = YES;
        
        [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(_insetSpace);
            if (height > _itemHeight){
                make.centerX.equalTo(self.bgView);
            }else {
                make.center.equalTo(self.bgView);
            }
            
            make.top.equalTo(self.bgView).offset(_insetSpace);
        }];
    }

    if (height > _imgHeight){
        _bgView.contentSize = CGSizeMake(0, height);
        _bgView.showsVerticalScrollIndicator = YES;
    }else {
        _bgView.contentSize = CGSizeMake(0, 0);
        _bgView.showsVerticalScrollIndicator = NO;
    }
    
}

@end
