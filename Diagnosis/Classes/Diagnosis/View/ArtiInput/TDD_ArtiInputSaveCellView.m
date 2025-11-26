//
//  TDD_ArtiInputSaveCellVIew.m
//  Diagnosis
//
//  Created by Diag on 2025/7/28.
//

#import "TDD_ArtiInputSaveCellView.h"
@interface TDD_ArtiInputSaveCellView()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat topSpace;
@end

@implementation TDD_ArtiInputSaveCellView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    _scale = IS_IPad ? HD_Height : H_Height;
    _topSpace = (IS_IPad ? 20 : 12) * _scale;

    _titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.tag = 1000;
        label.font = [[UIFont systemFontOfSize:IS_IPad ? 20 : 14 weight:UIFontWeightMedium] tdd_adaptHD];
        label.numberOfLines = 2;
        label.textColor = [UIColor tdd_title];
        label;
    });
    [self addSubview:_titleLab];
        
    _lineView = [UIView new];
    _lineView.tag = 1001;
    _lineView.backgroundColor = [UIColor tdd_line];
    [self addSubview:_lineView];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setBackgroundImage:kImageNamed(@"arti_input_delete") forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn.tdd_hitEdgeInsets = UIEdgeInsetsMake(-10, -16, -10, -16);
    [self addSubview:_deleteBtn];

    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16 * _scale);
        make.top.equalTo(self).offset(_topSpace);
        make.bottom.equalTo(self).offset(-_topSpace);
        make.right.equalTo(self).offset(-(16 + 28) * _scale);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(16 * _scale);
        make.right.equalTo(self).offset(-16 * _scale);
        make.height.mas_equalTo(1);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((IS_IPad ? 28 : 22) * _scale, (IS_IPad ? 28 : 22) * _scale));
        make.right.equalTo(self).offset(-16 * _scale);
        make.centerY.equalTo(_titleLab);
    }];
}

- (void)setSaveModel:(TDD_ArtiInputSaveModel *)saveModel {
    _saveModel = saveModel;
    _titleLab.text = [NSString tdd_isEmpty:saveModel.value] ? @" " :saveModel.value;
    
}

- (void)setIsDropDownBox:(BOOL)isDropDownBox {
    _isDropDownBox = isDropDownBox;
    _deleteBtn.hidden = isDropDownBox;
    [_titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16 * _scale);
        make.top.equalTo(self).offset(_topSpace);
        make.bottom.equalTo(self).offset(-_topSpace);
        make.right.equalTo(self).offset(-(16 + (isDropDownBox? 0 : (IS_IPad ? 44 : 38))) * _scale);
    }];
}

- (void)setIsLast:(BOOL)isLast {
    _lineView.hidden = isLast;
}

- (void)deleteAction {
    if (self.deleteBlock) {
        self.deleteBlock(self.index);
    }
}
@end
