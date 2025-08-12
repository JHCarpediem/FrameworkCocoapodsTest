//
//  TDD_ArtiLiveDataMoreChartView.m
//  AD200
//
//  Created by AppTD on 2022/9/7.
//

#import "TDD_ArtiLiveDataMoreChartView.h"
#import "TDD_HMoreChartView.h"

@interface TDD_ArtiLiveDataMoreChartView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic,strong) NSArray * colorArr;

@property (nonatomic, assign) CGFloat scale;
@end

@implementation TDD_ArtiLiveDataMoreChartView

- (instancetype)init{
    self = [super init];

    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
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

- (void)creatUI{
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
    tableView.estimatedRowHeight = 68 * _scale;

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
    return self.model.selectItmes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColor.clearColor;
    
    TDD_HMoreChartView * moreChartView = [cell.contentView viewWithTag:1000];
    UIView * contenView = [cell.contentView viewWithTag:1001];
    UIView * colorView = [cell.contentView viewWithTag:1002];
    TDD_CustomLabel * titleLabel = [cell.contentView viewWithTag:1003];
    TDD_CustomLabel * valueLabel = [cell.contentView viewWithTag:1004];
    TDD_CustomLabel * unityLabel = [cell.contentView viewWithTag:1005];
    UIView * grayView = [cell.contentView viewWithTag:1006];
    
    
    if (!moreChartView) {
        moreChartView = [[TDD_HMoreChartView alloc] init];
        moreChartView.userInteractionEnabled = NO;
        moreChartView.tag = 1000;
        [cell.contentView addSubview:moreChartView];
        
        grayView = [[UIView alloc] init];
        grayView.tag = 1006;
        grayView.backgroundColor = [UIColor tdd_liveDataSegmentationBackground];
        [cell.contentView addSubview:grayView];
        
        contenView = [[UIView alloc] init];
        contenView.tag = 1001;
        [cell.contentView addSubview:contenView];
        
        colorView = [[UIView alloc] init];
        colorView.tag = 1002;
        colorView.layer.cornerRadius = 5 * _scale;
        [contenView addSubview:colorView];
        
        titleLabel = ({
            TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
            label.tag = 1003;
            label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
            label.textColor = [UIColor tdd_title];
            label.numberOfLines = 0;
            label.text = @"";
            label;
        });
        [contenView addSubview:titleLabel];
        
        valueLabel = ({
            TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
            label.tag = 1004;
            label.font = [[UIFont systemFontOfSize:13] tdd_adaptHD];
            label.textColor = [UIColor tdd_color666666];
            label.numberOfLines = 0;
            label.text = @"";
            label;
        });
        [contenView addSubview:valueLabel];
        
        unityLabel = ({
            TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
            label.tag = 1005;
            label.font = [[UIFont systemFontOfSize:13] tdd_adaptHD];
            label.textColor = [UIColor tdd_color666666];
            label.numberOfLines = 0;
            label.text = @"";
            label;
        });
        [contenView addSubview:unityLabel];
        
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColor.tdd_line;// [UIColor tdd_colorF5F5F5];
        [contenView addSubview:lineView];
        
        [moreChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(cell.contentView).insets(UIEdgeInsetsMake(15 * _scale, 15 * _scale, 0, 15 * _scale));
            make.height.mas_equalTo(200 * _scale);
        }];
        
        [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(moreChartView.mas_bottom).offset(23 * _scale);
            make.left.right.equalTo(cell.contentView);
            make.height.mas_equalTo(20 * _scale);
        }];
        
        [contenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(grayView.mas_bottom);
            make.left.right.equalTo(cell.contentView);
            make.bottom.equalTo(cell.contentView);
        }];
        
        [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(contenView).insets(UIEdgeInsetsMake(15 * _scale, 20 * _scale, 0, 0));
            make.size.mas_equalTo(CGSizeMake(10 * _scale, 10 * _scale));
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(contenView).insets(UIEdgeInsetsMake(10 * _scale, 45 * _scale, 0, 0));
        }];
        
        [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contenView).insets(UIEdgeInsetsMake(10 * _scale, 45 * _scale, 0, 0));
            make.top.equalTo(titleLabel.mas_bottom).offset(5 * _scale);
        }];
        
        [unityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contenView).insets(UIEdgeInsetsMake(10 * _scale, 145 * _scale, 0, 0));
            make.top.equalTo(titleLabel.mas_bottom).offset(5 * _scale);
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contenView).insets(UIEdgeInsetsMake(10 * _scale, 20 * _scale, 0, 0));
            make.top.equalTo(unityLabel.mas_bottom).offset(10 * _scale);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(cell.contentView);
        }];
    }
    
    int index = (int)indexPath.row;
    
    if (index == 0) {
        moreChartView.hidden = NO;
        
        grayView.hidden = NO;
        
        [contenView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(grayView.mas_bottom);
            make.left.right.equalTo(cell.contentView);
            make.bottom.equalTo(cell.contentView);
        }];
        
        NSMutableArray * valueArr = [[NSMutableArray alloc] init];
        
        for (TDD_ArtiLiveDataItemModel * itemModel in self.model.selectItmes) {
            [valueArr addObject:itemModel.valueArr];
        }
        
        moreChartView.valueArr = valueArr;
    }else {
        moreChartView.hidden = YES;
        
        grayView.hidden = YES;
        
        [contenView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView);
            make.left.right.equalTo(cell.contentView);
            make.bottom.equalTo(cell.contentView);
        }];
    }
    
    colorView.backgroundColor = self.colorArr[index % 4];
    
    if (index > self.model.selectItmes.count - 1) {
        return cell;
    }
    
    TDD_ArtiLiveDataItemModel * itemModel = self.model.selectItmes[index];
    
    titleLabel.text = itemModel.strName;
    valueLabel.text = [NSString stringWithFormat:@"%@:%@", TDDLocalized.report_data_stream_number, itemModel.strChangeValue];
    unityLabel.text = [NSString stringWithFormat:@"%@:%@", TDDLocalized.diagnosis_unit, itemModel.strChangeUnit];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)setModel:(TDD_ArtiLiveDataMoreChartModel *)model
{
    _model = model;
    
    [self.tableView reloadData];
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
