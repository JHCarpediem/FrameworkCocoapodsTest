//
//  TDDataFlowCell.m
//  AD200
//
//  Created by yong liu on 2022/8/24.
//

#import "TDDataFlowCell.h"

@interface TDDataFlowCell ()

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) TDD_DataFlowModel *model;

@end

@implementation TDDataFlowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.timeLabel];
    
    UIImageView * arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"cell_right_arrow"];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:arrowImageView];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColor.tdd_colorF5F5F5;
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16 * H_Height);
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@(20 * H_Height));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(55 * H_Height);
    }];

    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right).offset(-24 * H_Height);
        make.centerY.equalTo(self.contentView);

        make.size.mas_equalTo(CGSizeMake(12 * H_Height, 12 * H_Height));
        
    }];
}

- (void)fillCellWithModel:(TDD_DataFlowModel *)model
{
    self.model = model;
    self.timeLabel.text = model.name;
}

- (void)cellSelected:(BOOL)isSelect
{
    self.selectBtn.selected = isSelect;
}

- (void)cellEditState:(BOOL)isEdit
{
    self.selectBtn.hidden = !isEdit;
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(isEdit ? 48 * H_Height : 15 *H_Height);
        
    }];
}

- (void)selectBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataFlowSelect:)]) {
        [self.delegate dataFlowSelect:self.model];
    }
}

#pragma mark -- 懒加载UI
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn tdd_addCornerRadius:2];
        [_selectBtn setImage:kImageNamed(@"check_box_normal") forState:UIControlStateNormal];
        [_selectBtn setImage:kImageNamed(@"check_box_selected") forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = kSystemFont(15);
        _timeLabel.textColor = [UIColor tdd_color333333];
    }
    return _timeLabel;
}

@end
