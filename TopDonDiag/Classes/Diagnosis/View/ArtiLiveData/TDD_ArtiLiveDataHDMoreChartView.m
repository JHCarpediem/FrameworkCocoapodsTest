//
//  TDD_ArtiLiveDataHDMoreChartView.m
//  TopdonDiagnosis
//
//  Created by lk_ios2023002 on 2024/2/22.
//

#import "TDD_ArtiLiveDataHDMoreChartView.h"
#import "TDD_HMoreChartView.h"

@interface TDD_ArtiLiveDataHDMoreSelectItemView()
@property (nonatomic, strong)UIView *colorView;
@property (nonatomic, strong)TDD_CustomLabel *titleLab;
@property (nonatomic, strong)TDD_CustomLabel *valueLab;
@property (nonatomic, strong)TDD_CustomLabel *unitLab;
@end
@implementation TDD_ArtiLiveDataHDMoreSelectItemView
- (instancetype)init{
    self = [super init];
    
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI {
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    _colorView = [[UIView alloc] init];
    [_colorView tdd_addRoundCorner:3 rectCorner:UIRectCornerTopLeft|UIRectCornerBottomLeft];
    [self addSubview:_colorView];
    
    _titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 0;
        label.text = @"";
        label;
    });
    [self addSubview:_titleLab];
    
    _valueLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.tag = 1004;
        label.font = [[UIFont systemFontOfSize:13] tdd_adaptHD];
        label.textColor = [UIColor tdd_color666666];
        label.numberOfLines = 0;
        label.text = @"";
        label;
    });
    [self addSubview:_valueLab];
    
    _unitLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.tag = 1005;
        label.font = [[UIFont systemFontOfSize:13] tdd_adaptHD];
        label.textColor = [UIColor tdd_color666666];
        label.numberOfLines = 0;
        label.text = @"";
        label;
    });
    [self addSubview:_unitLab];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColor.tdd_line;// [UIColor tdd_colorF5F5F5];
    [self addSubview:lineView];
    
    [_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(8 * HD_Height);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15 * HD_Height);
        make.left.equalTo(self.colorView).offset(12 * HD_Height);
        make.right.equalTo(self).offset(-20 * HD_Height);
    }];
    
    [_valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-15 * HD_Height);
        make.left.equalTo(self.colorView).offset(12 * HD_Height);
        make.right.equalTo(self).offset(-20 * HD_Height);
    }];
    
    [_unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).insets(UIEdgeInsetsMake(10 * H_Height, 145 * H_Height, 0, 0));
        make.top.equalTo(_titleLab.mas_bottom).offset(5 * H_Height);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(10 * H_Height, 20 * H_Height, 0, 0));
        make.top.equalTo(_unitLab.mas_bottom).offset(10 * H_Height);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self);
    }];
    
}

- (void)setItemModel:(TDD_ArtiLiveDataItemModel *)itemModel {
    _itemModel = itemModel;
    _titleLab.text = itemModel.strName;
    _valueLab.text = [NSString stringWithFormat:@"%@:%@", TDDLocalized.report_data_stream_number, itemModel.strChangeValue];
    _unitLab.text = [NSString stringWithFormat:@"%@:%@", TDDLocalized.diagnosis_unit, itemModel.strChangeUnit];
    
}

- (void)setColor:(UIColor *)color {
    _colorView.backgroundColor = color;
}

- (void)setTitle:(NSString *)title {
    
}
@end

@interface TDD_ArtiLiveDataHDMoreChartView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic,strong) NSArray * colorArr;
@end

@implementation TDD_ArtiLiveDataHDMoreChartView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = UIColor.tdd_viewControllerBackground;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TDD_ArtiLiveDataModelShow:) name:@"TDD_ArtiLiveDataModelShow" object:nil];
        
        [self creatUI];
    }
    
    return self;
}

- (void)TDD_ArtiLiveDataModelShow:(TDD_ArtiLiveDataModel *)liveDataModel
{
    [self.tableView reloadData];
}

- (void)creatUI {
    self.backgroundColor = UIColor.tdd_viewControllerBackground;
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.clearColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //设行高为自动计算
    tableView.rowHeight = UITableViewAutomaticDimension;
    //预计行高
    tableView.estimatedRowHeight = 68 * H_Height;

    tableView.estimatedSectionFooterHeight = 0;

    tableView.estimatedSectionHeaderHeight = 0;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor tdd_line];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma tableView--delegate
#pragma tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.selectItmes.count / 2  + self.model.selectItmes.count % 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColor.clearColor;
    
    TDD_ArtiLiveDataHDMoreSelectItemView *leftView = [[TDD_ArtiLiveDataHDMoreSelectItemView alloc] init];
    leftView.color = self.colorArr[MIN(indexPath.row % 2  + indexPath.row, self.colorArr.count-2)];
    leftView.itemModel = self.model.selectItmes[indexPath.row % 2  + indexPath.row];
    [cell.contentView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView).offset(20 * HD_Height);
        make.top.equalTo(cell.contentView);
        make.bottom.equalTo(cell.contentView).offset(-10 * HD_Height);
        make.width.mas_equalTo((IphoneWidth - 20 * HD_Height)/2);
    }];
    
    if (_model.selectItmes.count > indexPath.row % 2 + indexPath.row + 1){
        TDD_ArtiLiveDataHDMoreSelectItemView *rightView = [[TDD_ArtiLiveDataHDMoreSelectItemView alloc] init];
        rightView.color = self.colorArr[MIN(indexPath.row % 2 + indexPath.row + 1, self.colorArr.count-1)];
        rightView.itemModel = self.model.selectItmes[indexPath.row % 2  + indexPath.row];
        [cell.contentView addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(-20 * HD_Height);
            make.top.equalTo(cell.contentView);
            make.bottom.equalTo(cell.contentView).offset(-10 * HD_Height);
            make.width.mas_equalTo((IphoneWidth - 20 * HD_Height)/2);
        }];
    }

    return cell;
}

- (NSArray *)colorArr
{
    if (!_colorArr) {
        _colorArr = [TDD_DiagBridge chart4Colors];
    }
    
    return _colorArr;
}

- (void)dealloc
{
    HLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
