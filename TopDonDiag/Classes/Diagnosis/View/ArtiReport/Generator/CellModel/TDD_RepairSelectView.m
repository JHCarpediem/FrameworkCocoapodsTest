//
//  TDD_RepairSelectView.m
//  AD200
//
//  Created by yong liu on 2022/7/26.
//

#import "TDD_RepairSelectView.h"

@interface TDD_RepairSelectView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TDD_RepairSelectView

- (instancetype)initWithTableViewRect:(CGRect)rect
{
    self = [super init];
    if (self) {
        [self loadSubViews: rect];
    }
    return self;
}

- (void)loadSubViews:(CGRect)rect
{
    self.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(30, 300, 315, 150)];
    [self addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(rect.origin.y + rect.size.height - 5));
        make.left.equalTo(self).offset(IS_IPad ? 40 : 15);
        make.centerX.equalTo(self);
        make.height.equalTo(@150);
    }];
    shadowView.backgroundColor = [UIColor tdd_btnBackground];
    shadowView.layer.cornerRadius = 10;
    shadowView.layer.shadowColor = [UIColor tdd_title].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0, 0);
    shadowView.layer.shadowOpacity = 0.2;
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(rect.origin.y + rect.size.height - 5));
        make.left.equalTo(self).offset(IS_IPad ? 40 : 15);
        make.centerX.equalTo(self);
        make.height.equalTo(@150);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.bgView addGestureRecognizer:tap];
}

- (void)show
{
    [FLT_APP_WINDOW addSubview:self];
    [self.tableView reloadData];
}

- (void)dismiss
{
    if (self.didSelectIndex) {
        self.didSelectIndex((int)self.selectIndex);
    }
    [self removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell reuseIdentifier] forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor tdd_title];
    if (indexPath.row == 0) {
        cell.textLabel.text = TDDLocalized.report_system_type_before;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = TDDLocalized.report_system_type_after;
    } else if (indexPath.row == 2) {
        cell.textLabel.text = TDDLocalized.report_system_type_ing;
    }
    
    if (_isADAS) {
        cell.textLabel.text = [[cell.textLabel.text replaceBeforeMaintenanceToCalibration] replaceAfterMaintenanceToCalibration];
    }
    
    if (self.selectIndex == indexPath.row) {
        cell.contentView.backgroundColor = [UIColor cardBg];
    } else {
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectIndex = indexPath.row;
    [self dismiss];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth - 30, 50) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = UIColor.tdd_viewControllerBackground;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = UIColor.tdd_line;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.bounces = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell reuseIdentifier]];
        _tableView.layer.cornerRadius = 10;
//        _tableView.layer.shadowColor = [UIColor redColor].CGColor;
//        _tableView.layer.shadowOffset = CGSizeMake(0, 0);
//        _tableView.layer.shadowOpacity = 1;
//        _tableView.layer.shadowRadius = 6;
//        [_tableView addShadowViewWithColor:[UIColor tdd_colorCCCCCC] offset:CGSizeMake(4, 4) opacity:1 radius:6 tag:100];
    }
    return _tableView;
}


@end
