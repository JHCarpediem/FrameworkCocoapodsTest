//
//  TDD_ArtiTroubleShowStateView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/9/18.
//

#import "TDD_ArtiTroubleShowStateView.h"

@interface TDD_ArtiTroubleShowStateView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) TDD_CustomLabel *contentLabel;

@end


@implementation TDD_ArtiTroubleShowStateView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
        self.arrowHeight    = 6.0;
        self.arrowTopOffset = 20.0;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.bgView];
    [self addSubview:self.contentView];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentLabel];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

- (void)showWithPopPoint:(CGPoint)point content:(NSAttributedString *)content {
    
    self.contentLabel.attributedText = content;
    [FLT_APP_WINDOW addSubview:self];
    
    
    CGFloat contentHeight = [content boundingRectWithSize:CGSizeMake(230, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesDeviceMetrics context:nil].size.height;
    CGFloat scrollHeight = contentHeight;
    if (scrollHeight > 150) {
        scrollHeight = 150;
    }
    
    if (point.y > (IphoneHeight - point.y - self.arrowTopOffset)) {
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_left).offset(point.x + 25);
            make.width.mas_equalTo(260);
            make.height.mas_equalTo(scrollHeight + 35);
            make.bottom.equalTo(self.arrowImageView.mas_top);
        }];
    
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(self.arrowHeight);
            make.right.equalTo(self.contentView).offset(-5);
            if (_arrowDownBottomOffsetBlock) {
                make.bottom.equalTo(self).offset(_arrowDownBottomOffsetBlock(point.y - IphoneHeight));
            } else {
                make.bottom.equalTo(self).offset(point.y - IphoneHeight);
            }
        }];
        
        self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
    } else {

        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_left).offset(point.x + 25);
            make.width.mas_equalTo(260);
            make.height.mas_equalTo(scrollHeight + 35);
            make.top.equalTo(self.arrowImageView.mas_bottom);
        }];
    
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(self.arrowHeight);
            make.right.equalTo(self.contentView).offset(-5);
            make.top.equalTo(self).offset(point.y + self.arrowTopOffset);
        }];
    }
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(scrollHeight + 20);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(10);
        
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(15);
        make.width.mas_equalTo(230);
        make.top.equalTo(self.scrollView);
    }];
    
    [self layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(260, contentHeight);
    
}

- (void)dismiss {
    [self removeFromSuperview];
}


#pragma mark - lazy UI

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor tdd_troubleShowStateBackground];
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1400].CGColor;
        _contentView.layer.shadowOffset = CGSizeMake(0, 4);
        _contentView.layer.shadowOpacity = 1;
        _contentView.layer.shadowRadius = 16;
    }
    return _contentView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = isKindOfTopVCI?[kImageNamed(@"icon_diag_arrow") tdd_imageByTintColor:[UIColor tdd_colorWithHex:0x323C46]]:kImageNamed(@"icon_diag_arrow");
    }
    return _arrowImageView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (TDD_CustomLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[TDD_CustomLabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] tdd_adaptHD];
        _contentLabel.textColor = [UIColor tdd_color000000];
    }
    return _contentLabel;
}


@end
