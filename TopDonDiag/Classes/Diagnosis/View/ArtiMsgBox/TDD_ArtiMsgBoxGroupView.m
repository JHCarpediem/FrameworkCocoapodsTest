//
//  TDD_ArtiMsgBoxGroupView.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/16.
//

#import "TDD_ArtiMsgBoxGroupView.h"
#import "TDD_ButtonTableView.h"
#import "TDD_ArtiMsgBoxGroupViewTableViewCell.h"
@interface TDD_ArtiMsgBoxGroupView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) TDD_ButtonTableView *tableView;
@property (nonatomic, assign) CGFloat scale;
@end
@implementation TDD_ArtiMsgBoxGroupView

- (instancetype)init {
    if (self = [super init]) {
        _scale = IS_IPad ? HD_Height : H_Height;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = UIColor.tdd_collectionViewBG;
    
    [self addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groupModel.itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDD_ArtiMsgBoxGroupViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiMsgBoxGroupViewTableViewCell reuseIdentifier] forIndexPath:indexPath];
    TDD_ArtiMsgBoxGroupItemModel *itemModel = self.groupModel.itemArr[indexPath.row];
    cell.isShowTranslated = self.groupModel.isShowTranslated;
    cell.itemModel = itemModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (TDD_ButtonTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[TDD_ButtonTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.delaysContentTouches = NO;
        //设行高为自动计算
        _tableView.rowHeight = UITableViewAutomaticDimension;
        //预计行高
        _tableView.estimatedRowHeight = 100 * _scale;
        
        _tableView.estimatedSectionFooterHeight = 0.01;

        _tableView.estimatedSectionHeaderHeight = 0.01;
        
        [_tableView registerClass:[TDD_ArtiMsgBoxGroupViewTableViewCell class] forCellReuseIdentifier:[TDD_ArtiMsgBoxGroupViewTableViewCell reuseIdentifier]];
        
        if (@available(iOS 15.0, *)) {
            //iOS 15 去掉新增的默认顶部间距
            _tableView.sectionHeaderTopPadding = 0;
        } else {
            
        }
        
    }
    return _tableView;
}
@end
