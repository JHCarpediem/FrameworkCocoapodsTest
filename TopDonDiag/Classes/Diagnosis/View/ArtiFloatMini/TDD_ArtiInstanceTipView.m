//
//  TDD_ArtiInstanceTipView.m
//  TopdonDiagnosis
//
//  Created by zhouxiong on 2024/8/19.
//

#import "TDD_ArtiInstanceTipView.h"

@interface TDD_ArtiInstanceTipView()
@property (nonatomic,strong) UIImageView * clockImageView;
@property (nonatomic,strong) TDD_CustomLabel * contentLabel;

@end

@implementation TDD_ArtiInstanceTipView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configUI];
    }
    
    return self;
}

- (void)configUI {
    self.backgroundColor = [UIColor tdd_liveDataRecordBackground];
    self.clockImageView = [[UIImageView alloc] init];
    self.clockImageView.image = kImageNamed(@"artiList_pop_clock");

    self.contentLabel = [[TDD_CustomLabel alloc] init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = UIColor.tdd_colorFFFFFF;
    self.contentLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 16 : 12] tdd_adaptHD];
    
    [self addSubview:self.clockImageView];
    [self addSubview:self.contentLabel];
    
    [self.clockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IS_IPad ? @24 : @16);
        make.top.equalTo(IS_IPad ? @16 : @9);
        make.width.height.equalTo(IS_IPad ? @24 : @12);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.clockImageView.mas_right).offset(IS_IPad ? 10 : 2.5);
        make.right.equalTo(IS_IPad ? @-24 : @-16);
        make.top.equalTo(IS_IPad ? @18 : @6.5);
        make.bottom.equalTo(IS_IPad ? @-18 : @-6.5);
    }];
}

- (void)refreshContentWith:(TDD_ArtiFloatMiniModel *)model {
    self.clockImageView.hidden = !model.showTimer;
    self.contentLabel.text = model.strContent;

    if (model.showTimer) {
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.clockImageView.mas_right).offset(IS_IPad ? 10 : 2.5);
        }];
    } else {
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.clockImageView.mas_right).offset(IS_IPad ? 10 : -12);
        }];
    }

    [self layoutIfNeeded];
    self.layer.cornerRadius = IS_IPad ? 5 :self.frame.size.height/2.0;
}

@end
