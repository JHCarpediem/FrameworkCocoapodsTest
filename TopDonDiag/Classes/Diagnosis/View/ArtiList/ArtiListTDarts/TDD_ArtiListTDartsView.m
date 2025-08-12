//
//  TDD_ArtiListTDartsView.m
//  AD200
//
//  Created by zhi zhou on 2/23/23.
//

#import "TDD_ArtiListTDartsView.h"
#import "TDD_ArtiListTDartsCell.h"
#import "TDD_ArtiListTDartsHeadView.h"

@interface TDD_ArtiListTDartsView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) TDD_ArtiListTDartsHeadView *headView;
@end
@implementation TDD_ArtiListTDartsView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.tdd_colorF5F5F5;
        self.bgView = [UIView new];
        _bgView.layer.cornerRadius = 20;
        [self addSubview:_bgView];
        
        self.tableView            = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        self.tableView.backgroundColor = UIColor.clearColor;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.bounces = NO;
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
        self.tableView.estimatedRowHeight = 49*H_Height;
        [self.tableView registerClass:[TDD_ArtiListTDartsCell class] forCellReuseIdentifier:@"TDD_ArtiListTDartsCell"];
        TDD_ArtiListTDartsHeadView *headView = [[TDD_ArtiListTDartsHeadView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, 290*H_Height)];
        _headView = headView;
        self.tableView.tableHeaderView = headView;
        [self addSubview:self.tableView];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20*H_Height);
            make.bottom.equalTo(self).offset(-20*H_Height);
            make.left.equalTo(self).offset(20*H_Height);
            make.right.equalTo(self).offset(-20*H_Height);
        }];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_bgView);
        }];

    }
    return self;
}

- (void)setListModel:(TDD_ArtiListModel *)listModel {
    _listModel = listModel;
    _headView.imgPath = listModel.IMMOStrPicturePath;
    _headView.tips = listModel.IMMOStrPictureTips;
    [self.tableView reloadData];
    [self layoutIfNeeded];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    _bgView.backgroundColor = [UIColor tdd_colorDiagNormalGradient:TDD_GradientStyleTopToBottom withFrame:_tableView.tdd_size];
    _bgView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0500].CGColor;
    _bgView.layer.shadowOffset = CGSizeMake(0,2);
    _bgView.layer.shadowOpacity = 0.8;
    _bgView.layer.shadowRadius = 8 ;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _listModel.itemArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TDD_ArtiListTDartsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TDD_ArtiListTDartsCell"];
    if(!cell){
        cell = [[TDD_ArtiListTDartsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TDD_ArtiListTDartsCell"];
    }
    ArtiListItemModel *item = _listModel.itemArr[indexPath.row];
    cell.itemNames = item.vctItems;
    cell.showLine = (indexPath.row != _listModel.itemArr.count-1);
    return cell;
}


@end
