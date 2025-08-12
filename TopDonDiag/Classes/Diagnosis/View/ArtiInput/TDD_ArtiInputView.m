//
//  TDD_ArtiInputView.m
//  AD200
//
//  Created by 何可人 on 2022/5/10.
//

#import "TDD_ArtiInputView.h"
#import "TDD_ArtiInputCellView.h"
#import "TDD_ButtonTableView.h"
@import IQKeyboardManager;
@interface TDD_ArtiInputView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) TDD_ButtonTableView * tableView;
@property (nonatomic, assign) BOOL isClickClearBtn;

@end

@implementation TDD_ArtiInputView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = UIColor.tdd_viewControllerBackground;
        
        [self creatTableView];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow: newWindow];
    
    if (newWindow) {
        IQKeyboardManager.sharedManager.enable = YES;
    } else {
        IQKeyboardManager.sharedManager.enable = NO;
    }
}

- (void)setInputModel:(TDD_ArtiInputModel *)inputModel
{
    _inputModel = inputModel;
    
    [self.tableView reloadData];
    
    [self.tableView layoutIfNeeded];
    
}

- (void)creatTableView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tap.delegate = self;
    tap.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tap];
    
    TDD_ButtonTableView *tableView = [[TDD_ButtonTableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    tableView.backgroundColor = UIColor.clearColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.center.equalTo(self);
        make.height.equalTo(self);
    }];
    
    //设行高为自动计算
    tableView.rowHeight = UITableViewAutomaticDimension;
    //预计行高
    tableView.estimatedRowHeight = 44;

    tableView.estimatedSectionFooterHeight = 0;

    tableView.estimatedSectionHeaderHeight = 0;
    
//    self.tableView.fd_debugLogEnabled = YES;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"_UITextFieldClearButton"]) {
        
        _isClickClearBtn = YES;

    }

    return  YES;
}

// 隐藏键盘
- (void)hideKeyboard {
    if (!_isClickClearBtn){
        [self endEditing:YES];
    }
    _isClickClearBtn = NO;
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.inputModel.itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify =@"cellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    [self configureCell:cell atIndexpath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexpath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor clearColor];
//    cell.fd_enforceFrameLayout = NO;
    TDD_ArtiInputCellView * cellView = [cell.contentView viewWithTag:1000];
    if (!cellView) {
        cellView = [[TDD_ArtiInputCellView alloc] init];
        cellView.tag = 1000;
        [cell.contentView addSubview:cellView];
        cell.backgroundColor = UIColor.clearColor;
        
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    
    // 设置高度改变时的回调
    @kWeakObj(self)
    cellView.heightDidChange = ^() {
        @kStrongObj(self)
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    };
    
    
    NSInteger index = indexPath.row;
    
    if (index >= self.inputModel.itemArr.count) {
        return;
    }
    
    [cellView layoutIfNeeded];

    ArtiInputItemModel * itemModel = self.inputModel.itemArr[index];
    
    cellView.isShowTranslated = self.inputModel.isShowTranslated;
    
    cellView.itemModel = itemModel;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01 * H_Height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01 * H_Height;
}

#pragma mark -- 键盘监听事件

- (void)keyboardShow:(NSNotification *)noti
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:noti.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationTime animations:^{
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.bottom.equalTo(@(-keyBoardHeight + (58 * (IS_IPad ? HD_HHeight : H_HHeight ) + iPhoneX_D)));
        }];
        [self layoutIfNeeded];
    }];

}

- (void)keyboardHide:(NSNotification *)noti
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:noti.userInfo];
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationTime animations:^{
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.bottom.equalTo(@(0));
        }];
        [self layoutIfNeeded];
    }];
}


- (void)removeFromSuperview
{
    [super removeFromSuperview];
    [self hideKeyboard];
    if (_inputModel.itemArr.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

@end
