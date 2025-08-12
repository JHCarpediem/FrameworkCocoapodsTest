//
//  TDD_ArtiSystemScoreView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/10/25.
//

#import "TDD_ArtiSystemScoreView.h"
@interface TDD_ArtiSystemScoreView()
@property (nonatomic, strong) UIImageView *loadingBGView;
@property (nonatomic, strong) TDD_CustomLabel *scoreLab;
@property (nonatomic, strong) TDD_CustomLabel *titleLab;
@property (nonatomic, strong) TDD_CustomLabel *tipsLab;

@end
@implementation TDD_ArtiSystemScoreView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.loadingBGView];
    [self.loadingBGView addSubview:self.scoreLab];
    [self.loadingBGView addSubview:self.titleLab];
    [self.loadingBGView addSubview:self.tipsLab];
    
    [self.loadingBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
        make.height.mas_greaterThanOrEqualTo(230);
    }];
    
    [self.scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loadingBGView).offset(28);
        make.top.equalTo(self.loadingBGView).offset(7);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scoreLab.mas_bottom);
        make.left.equalTo(self.scoreLab);
        make.right.equalTo(self.loadingBGView.mas_centerX);
    }];
    [self.tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(7);
        make.left.equalTo(self.loadingBGView).offset(28);
        make.right.equalTo(self.loadingBGView.mas_centerX);
        make.bottom.equalTo(self.loadingBGView).offset(-20);
    }];
}

- (void)setScore:(NSInteger)score {
    if (_score == score && !_isLoading) {
        return;
    }
    _score = score;
    UIImage *image = kImageNamed(@"system_scan_load_finish_bg");
    [_loadingBGView setImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(170, 30, 50, 80) resizingMode:UIImageResizingModeStretch]];
    [self stopLoading];
    _loadingView.hidden = YES;
    
    _scoreLab.hidden = NO;
    _titleLab.hidden = NO;
    _tipsLab.hidden = NO;
    
    _scoreLab.text = [NSString stringWithFormat:@"%ld",score];
    UIFont *scoreFont = [[UIFont systemFontOfSize:90 weight:UIFontWeightBold] tdd_adaptHD];
    UIFont *divideFont = [[UIFont systemFontOfSize:25 weight:UIFontWeightMedium] tdd_adaptHD];
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(scoreFont:weight:)]){
        scoreFont = [[TDD_DiagnosisManage sharedManage].manageDelegate scoreFont:90 weight:UIFontWeightBold];
        divideFont = [[TDD_DiagnosisManage sharedManage].manageDelegate scoreFont:25 weight:UIFontWeightBold];
    }

    if (score == 0){
        NSString *scoreStr = [NSString stringWithFormat:@"--%@",isTopVCI?TDDLocalized.divide:@""];
        NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:scoreStr];
        
        [attStr setYy_font:scoreFont];
        [attStr yy_setFont:divideFont range:NSMakeRange(scoreStr.length-1, 1)];
        [attStr setYy_color:[UIColor tdd_errorRed]];
        _scoreLab.attributedText = attStr;

        _tipsLab.text = TDDLocalized.system_score_hint_error;
    }else {
        if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
            NSString *scoreStr = [NSString stringWithFormat:@"%ld",score];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:scoreStr];
            [attStr setYy_font:scoreFont];
            UIColor *scoreColor = [UIColor tdd_colorWithHex:0x00F4E6];
            if (score == 100) {
                _tipsLab.text = [NSString stringWithFormat:@"%@",TDDLocalized.system_score_hint_good];
                scoreColor = [UIColor tdd_colorWithHex:0x00F4E6];
            } else {
                _tipsLab.text = [NSString stringWithFormat:@"%@",TDDLocalized.system_score_hint_general_carpal];
                scoreColor = [UIColor tdd_colorWithHex:0xFFC121];
            }
            [attStr setYy_color:scoreColor];
            _scoreLab.attributedText = attStr;
            
            if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(lastSystemScanScore:scroeColor:)]) {
                [[TDD_DiagnosisManage sharedManage].manageDelegate lastSystemScanScore:score scroeColor:scoreColor];
            }
        } else {
            
            NSString *scoreStr = [NSString stringWithFormat:@"%ld%@",score,isTopVCI?TDDLocalized.divide:@""];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:scoreStr];
            [attStr setYy_font:scoreFont];
            if (isTopVCI){
                [attStr yy_setFont:divideFont range:NSMakeRange(scoreStr.length-1, 1)];
            }
            UIColor *scoreColor = [UIColor tdd_colorWithHex:0x00F4E6];
            if (score == 100) {
                _tipsLab.text = [NSString stringWithFormat:@"%@",TDDLocalized.system_score_hint_good];
                //            _tipsLab.text = TDDLocalized.system_score_hint_good;
                scoreColor = [UIColor tdd_colorWithHex:0x00F4E6];
            }else if (score >= 90){
                _tipsLab.text = [NSString stringWithFormat:@"%@",TDDLocalized.system_score_hint_general];
                //            _tipsLab.text = TDDLocalized.system_score_hint_general;
                scoreColor = [UIColor tdd_colorWithHex:0xFFC121];
            }else{
                _tipsLab.text = [NSString stringWithFormat:@"%@",TDDLocalized.system_score_hint_bad];
                //            _tipsLab.text = TDDLocalized.system_score_hint_bad;
                scoreColor = [UIColor tdd_errorRed];
            }
            [attStr setYy_color:scoreColor];
            _scoreLab.attributedText = attStr;
            
            if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(lastSystemScanScore:scroeColor:)]) {
                [[TDD_DiagnosisManage sharedManage].manageDelegate lastSystemScanScore:score scroeColor:scoreColor];
            }
        }
    }
}

- (void)startLoading {
    _isLoading = YES;
    _loadingView.hidden = NO;
    _scoreLab.hidden = YES;
    _titleLab.hidden = YES;
    _tipsLab.hidden = YES;
    [_loadingBGView setImage:kImageNamed(@"system_scan_loading_bg")];
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(diagnosisCustomLoadingViewStart:)]) {
        [[TDD_DiagnosisManage sharedManage].manageDelegate diagnosisCustomLoadingViewStart:TDD_CustomLoadingType_ScanSystem];
    }
}

- (void)stopLoading {
    _isLoading = NO;
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(diagnosisCustomLoadingViewStop:)]) {
        [[TDD_DiagnosisManage sharedManage].manageDelegate diagnosisCustomLoadingViewStop:TDD_CustomLoadingType_ScanSystem];
    }
}

#pragma mark - Lzay
- (void)setLoadingView:(UIView *)loadingView {
    _loadingView = loadingView;
    [self.loadingBGView addSubview:self.loadingView];
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.loadingBGView);
        make.size.mas_equalTo(CGSizeMake(IphoneWidth-50, 225));
    }];
}
- (UIImageView *)loadingBGView {
    if (!_loadingBGView) {
        UIImage *image = kImageNamed(@"system_scan_loading_bg");
        _loadingBGView = [[UIImageView alloc] initWithImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(170, 30, 50, 80) resizingMode:UIImageResizingModeStretch]];
        //[[UIImageView alloc] initWithImage:image];//
    }
    return _loadingBGView;
}


- (TDD_CustomLabel *)scoreLab {
    if (!_scoreLab) {
        _scoreLab = [[TDD_CustomLabel alloc] init];
        _scoreLab.textColor = [UIColor tdd_title];
        _scoreLab.font = [[UIFont systemFontOfSize:90 weight:UIFontWeightMedium] tdd_adaptHD];
        _scoreLab.hidden = YES;
    }
    return _scoreLab;
}

- (TDD_CustomLabel *)titleLab {
    if (!_titleLab){
        _titleLab = [[TDD_CustomLabel alloc] init];
        _titleLab.textColor = [UIColor tdd_title];
        _titleLab.font = [[UIFont systemFontOfSize:16 weight:UIFontWeightMedium] tdd_adaptHD];
        _titleLab.hidden = YES;
        _titleLab.text = TDDLocalized.system_fraction_title;
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

- (TDD_CustomLabel *)tipsLab {
    if (!_tipsLab){
        _tipsLab = [[TDD_CustomLabel alloc] init];
        _tipsLab.textColor = [UIColor tdd_subTitle];
        _tipsLab.font = [[UIFont systemFontOfSize:12 weight:UIFontWeightMedium] tdd_adaptHD];
        _tipsLab.numberOfLines = 0;
        _tipsLab.hidden = YES;
    }
    return _tipsLab;
}
@end
