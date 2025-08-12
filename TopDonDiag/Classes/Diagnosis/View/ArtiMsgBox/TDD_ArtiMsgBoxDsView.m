//
//  TDD_ArtiMsgBoxDsView.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/27.
//

#import "TDD_ArtiMsgBoxDsView.h"
#import "TDD_ButtonTableView.h"
#import "TDD_ArtiMsgBoxDsViewTableViewCell.h"
#import "TDD_ArtiMsgBoxDsResultView.h"
@interface TDD_ArtiMsgBoxDsView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) TDD_ButtonTableView *tableView;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) TDD_ArtiMsgBoxDsResultView *resultView;
@end
@implementation TDD_ArtiMsgBoxDsView

- (instancetype)init {
    if (self = [super init]) {
        _scale = IS_IPad ? HD_Height : H_Height;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = UIColor.tdd_collectionViewBG;
    [self addSubview:self.resultView];
    [_resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        
    }];
    
    [self addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(_resultView.mas_bottom);
    }];
}

- (void)setDsModel:(TDD_ArtiMsgBoxDsModel *)dsModel {
    _dsModel = dsModel;
    _resultView.isSuccess = YES;
    if (dsModel.isShowTranslated) {
        _resultView.sysName = dsModel.translatedSysName;
    }else {
        _resultView.sysName = dsModel.sysName;
    }
    if (_dsModel.liveDataItems.count <= 0) {
        _tableView.hidden = YES;
        [_resultView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }else {
        [_resultView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
        }];
        _tableView.hidden = NO;
        [_tableView reloadData];
    }
   
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dsModel.liveDataItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDD_ArtiMsgBoxDsViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiMsgBoxDsViewTableViewCell reuseIdentifier] forIndexPath:indexPath];
    TDD_ArtiLiveDataItemModel *itemModel = self.dsModel.liveDataItems[indexPath.row];
    cell.isShowTranslated = _dsModel.isShowTranslated;
    cell.itemModel = itemModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (TDD_ArtiMsgBoxDsResultView *)resultView {
    if (!_resultView) {
        _resultView = [[TDD_ArtiMsgBoxDsResultView alloc] init];
    }
    return _resultView;
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
        _tableView.estimatedRowHeight = 133 * _scale;
        
        _tableView.estimatedSectionFooterHeight = 0;

        _tableView.estimatedSectionHeaderHeight = 0;
        
        [_tableView registerClass:[TDD_ArtiMsgBoxDsViewTableViewCell class] forCellReuseIdentifier:[TDD_ArtiMsgBoxDsViewTableViewCell reuseIdentifier]];
        
        if (@available(iOS 15.0, *)) {
            //iOS 15 去掉新增的默认顶部间距
            _tableView.sectionHeaderTopPadding = 0;
        } else {
            
        }
        
    }
    return _tableView;
}

@end
