//
//  TDD_ArtiMsgBoxGroupViewTableViewCell.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/16.
//

#import "TDD_ArtiMsgBoxGroupViewTableViewCell.h"
@interface TDD_ArtiMsgBoxGroupViewTableViewCell()
@property (nonatomic, strong)UIView *titleBGView;
@property (nonatomic, strong)TDD_CustomLabel *titleLab;
@property (nonatomic, strong)TDD_CustomLabel *contentLab;
@property (nonatomic, assign) CGFloat scale;
@end
@implementation TDD_ArtiMsgBoxGroupViewTableViewCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass(self);
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _scale = IS_IPad ? HD_Height : H_Height;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.titleBGView];
    [_titleBGView addSubview:self.titleLab];
    [self.contentView addSubview:self.contentLab];
    
    [_titleBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_titleBGView).inset(16 * _scale);
        make.centerY.equalTo(_titleBGView);
        make.top.equalTo(_titleBGView).offset(8 * _scale);
    }];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(20 * _scale);
        //make.bottom.equalTo(self.contentView).offset(-16 * _scale);
        make.top.equalTo(_titleBGView.mas_bottom).offset(16 * _scale);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(_contentLab.mas_bottom).offset(16 * H_Height);
    }];
}

- (void)setItemModel:(TDD_ArtiMsgBoxGroupItemModel *)itemModel {
    _itemModel = itemModel;
    NSString *title;
    NSString *content;
    if (self.isShowTranslated) {
        title = itemModel.translatedTitle;
        content = itemModel.translatedContent;
    }else {
        title= itemModel.title;
        content = itemModel.content;
    }
    _titleLab.text = title;
    _contentLab.text = content;
}

- (UIView *)titleBGView {
    if (!_titleBGView) {
        _titleBGView = [UIView new];
        _titleBGView.backgroundColor = [UIColor tdd_colorF5F5F5];
        
    }
    return _titleBGView;
}

- (TDD_CustomLabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [TDD_CustomLabel new];
        _titleLab.textColor = [UIColor tdd_color999999];
        _titleLab.font = [[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] tdd_adaptHD];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

- (TDD_CustomLabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [TDD_CustomLabel new];
        _contentLab.textColor = [UIColor tdd_color333333];
        _contentLab.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}
@end
