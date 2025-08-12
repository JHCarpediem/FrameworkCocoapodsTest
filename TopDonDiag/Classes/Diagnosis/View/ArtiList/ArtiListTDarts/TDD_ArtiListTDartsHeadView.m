//
//  TDD_ArtiListTDartsHeadView.m
//  AD200
//
//  Created by lk_ios2023002 on 2023/3/6.
//

#import "TDD_ArtiListTDartsHeadView.h"
@interface TDD_ArtiListTDartsHeadView()
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)TDD_CustomLabel *tipLab;
@end
@implementation TDD_ArtiListTDartsHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.layer.cornerRadius = 20;
    self.imgView = [[UIImageView alloc] init];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.tipLab = [[TDD_CustomLabel alloc] initWithFrame:CGRectZero];
    self.tipLab.textColor = UIColor.tdd_title;
    self.tipLab.font = kSystemFont(16);
    self.tipLab.numberOfLines = 0;
    
    [self addSubview:self.imgView];
    [self addSubview:self.tipLab];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(198*H_Height, 198*H_Height));
        make.top.equalTo(self).offset(56*H_Height);
        make.centerX.equalTo(self);
    }];
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(44*H_Height);
        make.right.equalTo(self).offset(-18*H_Height);
        make.left.equalTo(self.imgView).offset(108*H_Height);
    }];
}

- (void)setImgPath:(NSString *)imgPath {
    _imgPath = imgPath;
    //返回图片路径多带了
    NSString *filePath = [imgPath stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    _imgView.image = image;
}

- (void)setTips:(NSString *)tips {
    _tips = tips;
    [_tipLab setText:tips];
}
@end
