//
//  TDD_ArtiEcuInfoView.m
//  AD200
//
//  Created by 何可人 on 2022/5/5.
//

#import "TDD_ArtiEcuInfoView.h"

@interface TDD_ArtiEcuInfoView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign)CGFloat scale;
@property (nonatomic, assign)CGFloat leftSpace;
@property (nonatomic, assign)CGFloat topSpace;
@property (nonatomic, assign)CGFloat minHeight;
@end

@implementation TDD_ArtiEcuInfoView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
        _leftSpace = (IS_IPad ? 40 : 15) * _scale;
        _topSpace = (IS_IPad ? 20 : 10) * _scale;
        _minHeight = (IS_IPad ? 62 : 40) * _scale;
        [self creatTableView];
    }
    
    return self;
}

- (void)setEcuInfoModel:(TDD_ArtiEcuInfoModel *)ecuInfoModel
{
    _ecuInfoModel = nil;
    
    [self.tableView reloadData];
    
    [self.tableView layoutIfNeeded];
    
    _ecuInfoModel = [ecuInfoModel yy_modelCopy];
    
    [self.tableView reloadData];
}

- (void)creatTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
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
    tableView.estimatedRowHeight = 60 * H_Height;

    tableView.estimatedSectionFooterHeight = 1;

    tableView.estimatedSectionHeaderHeight = 60 * H_Height;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerIdentify"];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColor.tdd_line;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ecuInfoModel.itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify =@"cellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    [self configureCell:cell atIndexpath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexpath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor cardBg];
    
    TDD_CustomLabel * titleLab = [cell.contentView viewWithTag:1000];
    TDD_CustomLabel * valueLab = [cell.contentView viewWithTag:1001];
    
    if (!titleLab) {
        UIView * whiteViwe = [[UIView alloc] init];
        whiteViwe.backgroundColor = UIColor.tdd_btnBackground;
        [cell.contentView addSubview:whiteViwe];
        
        titleLab = ({
            TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
            label.tag = 1000;
            label.text = @"";
            label.font = [[UIFont systemFontOfSize:16] tdd_adaptHD];
            label.textColor = [UIColor tdd_color666666];
            label.numberOfLines = 0;
            label;
        });
        [whiteViwe addSubview:titleLab];
        
        valueLab = ({
            TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
            label.tag = 1001;
            label.text = @"";
            label.font = [[UIFont systemFontOfSize:16] tdd_adaptHD];
            label.textColor = [UIColor tdd_title];
            label.textAlignment = NSTextAlignmentRight;
            label.numberOfLines = 0;
            label;
        });
        [whiteViwe addSubview:valueLab];
        
//        UIView * lineView = [[UIView alloc] init];
//        lineView.backgroundColor = [UIColor tdd_line];
//        [whiteViwe addSubview:lineView];
        
        
        [whiteViwe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(titleLab.superview).insets(UIEdgeInsetsMake(_topSpace, _leftSpace, 0, 0));
            make.width.mas_equalTo(IphoneWidth / 2 - _leftSpace * 2);
            make.height.mas_greaterThanOrEqualTo(_minHeight).priorityHigh();
            make.bottom.lessThanOrEqualTo(titleLab.superview).offset(-_topSpace).priorityHigh();
        }];
        
        [valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLab.mas_right).offset(_leftSpace * 2);
            make.top.equalTo(valueLab.superview).offset(_topSpace);
            make.width.mas_equalTo(IphoneWidth / 2 - _leftSpace * 2);
            make.height.mas_greaterThanOrEqualTo(_minHeight).priorityHigh();
            make.bottom.lessThanOrEqualTo(valueLab.superview).offset(-_topSpace).priorityHigh();
        }];
        
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.left.bottom.equalTo(whiteViwe);
//            make.height.mas_equalTo(1);
//        }];
    }
    
    NSInteger index = indexPath.row;
    
    NSArray * itemArr = self.ecuInfoModel.itemArr;
    
    if (index >= itemArr.count) {
        return;
    }
    
    ArtiEcuInfoItemModel * itemModel = itemArr[index];
    
    if (self.ecuInfoModel.isShowTranslated) {
        titleLab.text = itemModel.strTranslatedItem;
    }else {
        titleLab.text = itemModel.strItem;
    }
    
    valueLab.text = itemModel.strValue;
    
    CGFloat iFirstPercent = self.ecuInfoModel.iFirstPercent;
    
    CGFloat iSecondPercent = self.ecuInfoModel.iSecondPercent;
    
    if (itemModel.isAddGroup) {
        iFirstPercent = 1;
        iSecondPercent = 0;
        
        if (self.ecuInfoModel.isShowTranslated) {
            titleLab.text = itemModel.strTranslatedGroupName;
        }else {
            titleLab.text = itemModel.strGroupName;
        }
    }
    
    CGFloat width_all = iFirstPercent + iSecondPercent;
    
    //标题 - 长度
    CGFloat width_first = iFirstPercent / width_all;
    
    width_first = (IphoneWidth - _leftSpace * 4) * width_first;
    
    if (width_first > _leftSpace * 2) {
//        width_first = width_first - 30 * H_Height;
        [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLab.superview).offset(_leftSpace);
        }];
    }else{
        width_first = 0;
        [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLab.superview);
        }];
    }
    
    if (width_first > IphoneWidth - _leftSpace * 4) {
        width_first = IphoneWidth - _leftSpace * 4;
    }
    
    [titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width_first);
    }];
    
    //值 - 长度
    CGFloat width_second = iSecondPercent / width_all;
    
    width_second = (IphoneWidth - _leftSpace * 4) * width_second;
    
    if (width_second > _leftSpace * 2) {
//        width_second = width_second - 30 * H_Height;
    }else{
        width_second = 0;
    }
    
    if (width_second > IphoneWidth - _leftSpace * 2 - 10 * _scale) {
        width_second = IphoneWidth - _leftSpace * 2 - 10 * _scale;
    }
    
    [valueLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width_second);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

@end
