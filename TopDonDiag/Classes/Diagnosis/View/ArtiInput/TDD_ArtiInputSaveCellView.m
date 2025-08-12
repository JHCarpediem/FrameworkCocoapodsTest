//
//  TDD_ArtiInputSaveCellVIew.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/7/28.
//

#import "TDD_ArtiInputSaveCellView.h"
@interface TDD_ArtiInputSaveCellView()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, assign) CGFloat scale;
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

    _titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.tag = 1000;
        label.font = [[UIFont systemFontOfSize:IS_IPad ? 18 : 14 weight:UIFontWeightMedium] tdd_adaptHD];
        label.numberOfLines = 0;
        label.textColor = [UIColor tdd_title];
        label;
    });
    [self addSubview:_titleLab];
        
    _lineView = [UIView new];
    _lineView.tag = 1001;
    _lineView.backgroundColor = [UIColor tdd_line];
    [self addSubview:_lineView];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setImage:kImageNamed(@"arti_input_delete") forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_deleteBtn];

    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(12 * _scale, 12 * _scale, 12 * _scale, (12 + 76) * _scale));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(54 * _scale, 22 * _scale));
        make.right.equalTo(self);
        make.centerY.equalTo(_titleLab);
    }];
}

- (void)setSaveModel:(TDD_ArtiInputSaveModel *)saveModel {
    _saveModel = saveModel;
    _titleLab.text = [NSString tdd_isEmpty:saveModel.value] ? @" " :saveModel.value;
    
}

- (void)deleteAction {
    if (self.deleteBlock) {
        self.deleteBlock(self.index);
    }
}
@end
