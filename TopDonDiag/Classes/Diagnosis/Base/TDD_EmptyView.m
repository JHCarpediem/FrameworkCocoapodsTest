//
//  EmptyView.m
//  AD200
//
//  Created by yong liu on 2022/7/14.
//

#import "TDD_EmptyView.h"

@implementation TDD_EmptyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self loadSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.emptyImageView];
    [self addSubview:self.tipLabel];
    
    [self.emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-80);
        make.width.mas_equalTo(118 * H_Height);
        make.height.mas_equalTo(98 * H_Height);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.equalTo(self).offset(50);
        make.top.equalTo(self.emptyImageView.mas_bottom).offset(20);
    }];
}

- (void)setEmptyImage:(NSString *)imageStr width:(CGFloat)width height:(CGFloat)height
{
    self.emptyImageView.image = kImageNamed(imageStr);
    [self.emptyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-80);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
}

- (void)setEmptyImageWidth:(CGFloat)width height:(CGFloat)height {
    [self.emptyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-80);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
}

- (void)setEmptyImage:(NSString *)imageStr width:(CGFloat)width height:(CGFloat)height topSpacing:(CGFloat)topSpacing {
    self.emptyImageView.image = kImageNamed(imageStr);
    [self.emptyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        if (topSpacing>=0){
            make.top.equalTo(self).offset(topSpacing);
        }else{
            make.centerY.equalTo(self).offset(-80);
        }
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    
}

#pragma mark - Lazy

- (UIImageView *)emptyImageView {
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc] init];
        _emptyImageView.image = isKindOfTopVCI? kImageNamed(@"default_empty_no_data"): kImageNamed(@"no_data");
    }
    return _emptyImageView;
}

- (TDD_CustomLabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[TDD_CustomLabel alloc] init];
        _tipLabel.font = [[UIFont systemFontOfSize:16] tdd_adaptHD];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = [UIColor tdd_title];
        _tipLabel.numberOfLines = 0;
        _tipLabel.text = TDDLocalized.all_search_no_data;
    }
    return _tipLabel;
}

@end
