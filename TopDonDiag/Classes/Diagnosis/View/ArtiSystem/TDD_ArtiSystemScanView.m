//
//  TDD_ArtiSystemScanView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/9/12.
//

#import "TDD_ArtiSystemScanView.h"
@interface TDD_ArtiSystemScanView()
@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)TDD_CustomLabel *tipsLabel;
@property (nonatomic, strong)UIView *progressBGView;
@property (nonatomic, strong)UIView *progressView;
@property (nonatomic, assign)CGFloat scale;
@property (nonatomic, assign)CGFloat progressWidth;
@end
@implementation TDD_ArtiSystemScanView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = UIColor.whiteColor;
    _scale = IS_IPad ? HD_Height : H_Height;
    CGFloat iconSize = IS_IPad ? 100 : 76;
    CGFloat leftSpace = IS_IPad ? 40 : 20;
    CGFloat topSpace = IS_IPad ? 17 : 20;
    CGFloat bottomSpace = IS_IPad ? 30 : 27;
    CGFloat midSpace = IS_IPad ? 23 : 16;
    CGFloat progressHeight = IS_IPad ? 10 : 6;
    _progressWidth = IphoneWidth - (iconSize + leftSpace + midSpace + leftSpace) * _scale;
    [self addSubview:self.iconView];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.progressBGView];
    [self addSubview:self.progressView];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconSize * _scale, iconSize * _scale));
        make.left.equalTo(self).offset(leftSpace * _scale);
        make.top.equalTo(self).offset(11 * _scale);
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(midSpace * _scale);
        make.top.equalTo(_iconView).offset(topSpace * _scale);
    }];
    
    [_progressBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(midSpace * _scale);
        make.bottom.equalTo(_iconView.mas_bottom).offset(-20 * _scale);
        make.right.equalTo(self.mas_right).offset(-leftSpace * _scale);
        make.height.mas_equalTo(progressHeight * _scale);
    }];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(midSpace * _scale);
        make.bottom.equalTo(_iconView.mas_bottom).offset(-20 * _scale);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(progressHeight * _scale);
    }];
    self.progress = 0;
}

- (void)setEtype:(NSInteger)etype {
    if (etype == 1) {
        [_iconView setImage:kImageNamed(@"adas_icon_scan")];
    }else {
        TDD_CarModel *carModel = [TDD_DiagnosisManage sharedManage].carModel;
        if ([carModel.strType isEqualToString:@"MOTO"]) {
            [_iconView setImage:kImageNamed(@"system_scan_progress_moto")];
        }else {
            [_iconView setImage:kImageNamed(@"system_scan_progress_car")];
        }
    }
}

- (void)setProgress:(CGFloat)progress {
    if (isnan(progress)) {
        progress = 0;
    }
    _progress = progress;
    NSString *tipStr = [TDDLocalized.scan_progress stringByReplacingOccurrencesOfString:@"%@" withString:[NSString stringWithFormat:@"%.0f",progress*100]];
    NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:tipStr];
    [attStr setYy_font:[[UIFont systemFontOfSize:14 weight:UIFontWeightBold] tdd_adaptHD]];
    [attStr yy_setFont:[[UIFont systemFontOfSize:11 weight:UIFontWeightMedium] tdd_adaptHD] range:NSMakeRange(tipStr.length-1, 1)];
    _tipsLabel.attributedText = attStr;
    
    if (!_progressView || !_progressView.superview) {
        NSLog(@"progressView为空");
        return;
    }
    [_progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_progressWidth * progress);
    }];
    
    CGFloat progressHeight = IS_IPad ? 10 : 6;
    _progressView.backgroundColor = [UIColor tdd_colorDiagProgressGradient:TDD_GradientStyleLeftToRight withFrame:CGSizeMake(_progressWidth * progress, progressHeight * _scale)];
    
}

- (UIImageView *)iconView {
    if (!_iconView) {
        TDD_CarModel *carModel = [TDD_DiagnosisManage sharedManage].carModel;
        if ([carModel.strType isEqualToString:@"MOTO"]) {
            _iconView = [[UIImageView alloc] initWithImage:kImageNamed(@"system_scan_progress_moto")];
        }else {
            _iconView = [[UIImageView alloc] initWithImage:kImageNamed(@"system_scan_progress_car")];
        }
        
    }
    
    return _iconView;
}

- (TDD_CustomLabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [TDD_CustomLabel new];
        _tipsLabel.textColor = UIColor.tdd_color333333;
        _tipsLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 24 : 13.5 weight:UIFontWeightBold] tdd_adaptHD];
    }
    return _tipsLabel;
}

- (UIView *)progressBGView {
    if (!_progressBGView) {
        _progressBGView = [UIView new];
        _progressBGView.layer.masksToBounds = YES;
        _progressBGView.layer.cornerRadius = IS_IPad ? 5 : 3;
        _progressBGView.backgroundColor = [UIColor tdd_colorWithHex:0xF5F2F2];
    }
    return _progressBGView;
}

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [UIView new];
        _progressView.layer.masksToBounds = YES;
        _progressView.layer.cornerRadius = IS_IPad ? 5 : 3;
    }
    return _progressView;
}

@end
