//
//  TDD_ArtiListTDartsCell.m
//  AD200
//
//  Created by zhi zhou on 2/23/23.
//

#import "TDD_ArtiListTDartsCell.h"
@interface TDD_ArtiListTDartsCell()
//标题
@property (nonatomic,strong) UILabel   *titleLab;
//内容
@property (nonatomic,strong) UILabel   *contentLab;
//
@property (nonatomic,strong) UIView *lineView;
@end
@implementation TDD_ArtiListTDartsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = self.contentView.backgroundColor = UIColor.clearColor;
        self.selectionStyle       = UITableViewCellSelectionStyleNone;
        
        self.titleLab           = [[TDD_CustomLabel alloc] init];
        [self.contentView addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15*H_Height);
            make.width.mas_equalTo(64*H_Height);
            make.top.equalTo(self.contentView).offset(6*H_Height);
            make.bottom.equalTo(self.contentView).offset(-6*H_Height);
        }];
        self.titleLab.font      = kSystemFont(15);
        self.titleLab.textColor = [UIColor tdd_color666666];
        self.titleLab.numberOfLines = 0;
        
        self.contentLab         = [[TDD_CustomLabel alloc] init];
        [self.contentView addSubview:self.contentLab];
        [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab.mas_right).offset(40*H_Height);
            make.right.equalTo(self.contentView).offset(-15*H_Height);
            make.top.equalTo(self.contentView).offset(6*H_Height);
            make.bottom.equalTo(self.contentView).offset(-6*H_Height);
        }];
        self.contentLab.font      = kSystemFont(15);
        self.contentLab.textColor = [UIColor tdd_title];
        self.contentLab.numberOfLines  = 0;
        
        self.lineView = [UIView new];
        _lineView.backgroundColor = UIColor.tdd_colorEDEDED;
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.equalTo(self.contentView).offset(16*H_Height);
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        
    }
    return self;
}

- (void)setItemNames:(NSArray *)itemNames {
    _itemNames = itemNames;
    
    if (_itemNames.count>0) _titleLab.text = itemNames[0];
    
    if (_itemNames.count>1) _contentLab.text = itemNames[1];

}

- (void)setShowLine:(BOOL)showLine {
    _showLine = showLine;
    _lineView.hidden = !_showLine;
}
@end
