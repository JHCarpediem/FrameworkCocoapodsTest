//
//  TDD_ArtiMsgBoxDsResultView.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/28.
//

#import "TDD_ArtiMsgBoxDsResultView.h"
@interface TDD_ArtiMsgBoxDsResultView()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) TDD_CustomLabel *tipsLab;
@property (nonatomic, strong) TDD_CustomLabel *sysNameLab;
@property (nonatomic, assign) CGFloat scale;
@end
@implementation TDD_ArtiMsgBoxDsResultView

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _scale = IS_IPad ? HD_Height : H_Height;
    [self addSubview:self.iconImageView];
    [self addSubview:self.tipsLab];
    [self addSubview:self.sysNameLab];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(34 * _scale);
        make.size.mas_equalTo(CGSizeMake(75 * _scale, 75 * _scale));
    }];
    
    [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView.mas_bottom).offset(16 * _scale);
        make.centerX.equalTo(self);
    }];
    
    [_sysNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_tipsLab.mas_bottom).offset(4 * _scale);
        make.bottom.equalTo(self).offset(-28 * _scale);
    }];
}

- (void)setSysName:(NSString *)sysName {
    _sysName = sysName;
    _sysNameLab.text = sysName;
    
}

- (void)setIsSuccess:(BOOL)isSuccess {
    _isSuccess = isSuccess;
    if (isSuccess) {
        _iconImageView.image = kImageNamed(@"adas_pic_secuess");
        _tipsLab.text = @"校准成功!";
    }else {
        _iconImageView.image = kImageNamed(@"adas_pic_failed");
        _tipsLab.text = @"校准失败!";
    }
    
}


- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
    
}

- (TDD_CustomLabel *)tipsLab {
    if (!_tipsLab) {
        _tipsLab = [TDD_CustomLabel new];
        _tipsLab.textColor = [UIColor tdd_title];
        _tipsLab.font = [[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold] tdd_adaptHD];
    }
    return _tipsLab;;
    
}

- (TDD_CustomLabel *)sysNameLab {
    if (!_sysNameLab) {
        _sysNameLab = [TDD_CustomLabel new];
        _sysNameLab.textColor = [UIColor tdd_color666666];
        _sysNameLab.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD];
        _sysNameLab.numberOfLines = 0;
    }
    return _sysNameLab;
}
@end
