//
//  TDD_ArtiUnlockTypeSelectView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/12/1.
//

#import "TDD_ArtiUnlockTypeSelectView.h"
@interface TDD_ArtiUnlockTypeSelectView()
@property (nonatomic, assign)CGFloat scale;
@end
@implementation TDD_ArtiUnlockTypeSelectView {
    NSInteger _selectTag;
}

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _scale = IS_IPad ? HD_HHeight : H_Height;
    CGFloat leftSpace = (IS_IPad ? 212 : 40) * _scale;
    CGFloat heightSpace = (IS_IPad ? 60 : 40) * _scale;
    CGFloat fontSize = (IS_IPad ? 20 : 14);
    UIView *shadowView = [UIView new];
    shadowView.layer.cornerRadius = 10 * H_Height;
    shadowView.layer.masksToBounds = YES;
    shadowView.backgroundColor = [UIColor tdd_alertBg];
    [self addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.14].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,2);
    self.layer.shadowOpacity = 1 * H_Height;
    self.layer.shadowRadius = 25 * H_Height;

    
    NSArray *unlockTypeLabelTitleArr = @[TDDLocalized.topdon_account, TDDLocalized.europe_fca_official_site];
    self.backgroundColor = UIColor.clearColor;
    for (int i = 0; i < unlockTypeLabelTitleArr.count; i++) {
        int j = i;//用于计算frame
        UIButton *unlockTypeLabelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        unlockTypeLabelBtn.tag = 100 + i;
        [unlockTypeLabelBtn setBackgroundImage:[UIImage tdd_imageWithColor:[UIColor tdd_alertBg] rect:CGRectMake(0, 0, IphoneWidth - leftSpace * 2, heightSpace)] forState:UIControlStateNormal];
        [unlockTypeLabelBtn setBackgroundImage:[UIImage tdd_imageWithColor:[UIColor tdd_fcaAreaBackGroundColor] rect:CGRectMake(0, 0, IphoneWidth - leftSpace * 2, heightSpace)] forState:UIControlStateSelected];
        [unlockTypeLabelBtn setTitleColor:[UIColor tdd_title] forState:UIControlStateNormal];
        [unlockTypeLabelBtn setTitleColor:[UIColor tdd_colorDiagTheme] forState:UIControlStateSelected];
        unlockTypeLabelBtn.titleLabel.font = [[UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium] tdd_adaptHD];
        [unlockTypeLabelBtn addTarget:self action:@selector(unlockTypeLabelClick:) forControlEvents:UIControlEventTouchUpInside];
        [unlockTypeLabelBtn setTitle:unlockTypeLabelTitleArr[i] forState:UIControlStateNormal];
        
        NSString *unlockTypeLabelStr;

        if (_unlockType < unlockTypeLabelTitleArr.count){
            unlockTypeLabelStr = unlockTypeLabelTitleArr[_unlockType];
        } else {
            unlockTypeLabelStr = unlockTypeLabelTitleArr[0];
        }
        
        if (unlockTypeLabelTitleArr[i] == unlockTypeLabelStr) {
            [unlockTypeLabelBtn setSelected:YES];
        } else {
            [unlockTypeLabelBtn setSelected:NO];
        }

        [shadowView insertSubview:unlockTypeLabelBtn atIndex:0];
        [unlockTypeLabelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(heightSpace);
            make.left.right.equalTo(shadowView);
            make.top.equalTo(shadowView).offset(heightSpace * j);
            if (i == unlockTypeLabelTitleArr.count - 1){
                make.bottom.equalTo(shadowView);
            }
        }];
        if (i < unlockTypeLabelTitleArr.count - 1){
            UIView *lineView = [UIView new];
            lineView.backgroundColor = [UIColor tdd_line];
            [shadowView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(shadowView).offset(IS_IPad ? 0 : (16 * _scale));
                make.height.mas_equalTo(1);
                make.top.equalTo(shadowView).offset((heightSpace - 1) * (j + 1));
                make.right.equalTo(shadowView);
            }];
        }
    }

}


- (void)setUnlockType:(NSInteger)unlockType {
    
    UIButton *oldSelBtn = [self viewWithTag:100 + _unlockType];
    if (oldSelBtn) {
        [oldSelBtn setSelected:NO];
    }
    _unlockType = unlockType;
    _selectTag = 100 + _unlockType;
    UIButton *selBtn = [self viewWithTag:_selectTag];
    if (selBtn) {
        [selBtn setSelected:YES];
    }
    
}

- (void)unlockTypeLabelClick:(UIButton *)sender {
    if (sender.tag != 102){
        UIButton *oldSelBtn = [self viewWithTag:_selectTag];
        if (oldSelBtn) {
            [oldSelBtn setSelected:NO];
        }
        [sender setSelected:YES];
        _selectTag = sender.tag;
    }

    if (self.selectBlock){
        self.selectBlock(sender.tag - 100);
    }
    
}
@end
