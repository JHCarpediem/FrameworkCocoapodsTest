//
//  TDD_ArtiFileDialogView.m
//  AD200
//
//  Created by 何可人 on 2022/5/24.
//

#import "TDD_ArtiFileDialogView.h"

@interface TDD_ArtiFileDialogView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray * pathArr;

@property (nonatomic, strong) TDD_CustomLabel * titleLab;

@property (nonatomic, assign) int selectNub;

@property (nonatomic, assign)CGFloat scale;

@property (nonatomic, assign)CGFloat leftSpace;

@property (nonatomic, assign)CGFloat topSpace;

@property (nonatomic, assign)CGFloat fontSize;

@end

@implementation TDD_ArtiFileDialogView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = UIColor.tdd_viewControllerBackground;
        
        self.selectNub = -1;
        
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI {
    _scale = IS_IPad ? HD_Height : H_Height;
    
    _leftSpace = (IS_IPad ? 40 : 20) * _scale;
    _topSpace = (IS_IPad ? 16 : 12) * _scale;
    _fontSize = (IS_IPad ? 18 : 15);
    
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor tdd_reportMilesNormalBackground];
    [self addSubview:topView];
    

    TDD_CustomLabel * titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:16] tdd_adaptHD];
        label.textColor = [UIColor tdd_color666666];
        label.numberOfLines = 0;
        label;
    });
    [topView addSubview:titleLab];
    self.titleLab = titleLab;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.tdd_viewControllerBackground;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(topView).insets(UIEdgeInsetsMake(12 * _scale, _leftSpace, 15 * _scale, _leftSpace));
        
    }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    //设行高为自动计算
    tableView.rowHeight = UITableViewAutomaticDimension;
    //预计行高
    tableView.estimatedRowHeight = (IS_IPad ? 60 : 50) * _scale;

    tableView.estimatedSectionFooterHeight = 0;

    tableView.estimatedSectionHeaderHeight = 44;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerIdentify"];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pathArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify =@"cellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    [self configureCell:cell atIndexpath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexpath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    TDD_CustomLabel * titleLab = [cell.contentView viewWithTag:1000];
    UIImageView * icon = [cell.contentView viewWithTag:1001];
    

    if (!titleLab) {
        titleLab = ({
            TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
            label.tag = 1000;
            label.font = [[UIFont systemFontOfSize:_fontSize] tdd_adaptHD];
            label.textColor = [UIColor tdd_color000000];
            label.numberOfLines = 0;
            label;
        });
        [cell.contentView addSubview:titleLab];
        
        if (!icon) {
            icon = [UIImageView new];
            icon.tag = 1001;
            [cell.contentView addSubview:icon];
        }
        
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor tdd_line];
        [cell.contentView addSubview:lineView];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30 * _scale, 30 * _scale));
            make.left.equalTo(cell.contentView).offset(_leftSpace);
            make.centerY.equalTo(cell.contentView);
        }];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.left.equalTo(icon.mas_right).offset(8 * _scale);
            make.right.equalTo(cell.contentView).offset(-_leftSpace);
            make.top.equalTo(cell.contentView).offset(_topSpace);
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(cell.contentView);
            make.height.mas_equalTo(1);
            make.left.equalTo(icon);
        }];
    }
    
    int row = (int)indexPath.row;
    
    if (row >= self.pathArr.count) {
        return;
    }
    
    ArtiFileDialogFileModel * fileModel = self.pathArr[row];
    
    titleLab.text = fileModel.fileName;
    
    if (fileModel.type > 0) {
        icon.image = [UIImage tdd_imageDiagFileDictIcon];

    }else {
        icon.image = kImageNamed(@"arti_diag_log_file");
    }
    
    if (self.selectNub == indexPath.row) {
        cell.backgroundColor = [UIColor tdd_systemScanBgGradient:TDD_GradientStyleLeftToRight withFrame:CGSizeMake(IphoneWidth, (IS_IPad ? 60 : 50) * _scale)];
    }else {
        cell.backgroundColor = [UIColor clearColor];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor tdd_systemScanBgGradient:TDD_GradientStyleLeftToRight withFrame:CGSizeMake(IphoneWidth, (IS_IPad ? 60 : 50) * _scale)];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = (int)indexPath.row;
    
    if (row >= self.pathArr.count) {
        return;
    }
    
    ArtiFileDialogFileModel * fileModel = self.pathArr[row];
    
    if (fileModel.type == 0) {
        //文件
        self.selectNub = (int)indexPath.row;
        
        self.fileDialogModel.currentFileName = fileModel.fileName;
    }else {
        if (fileModel.type == 2) {
            //根目录
            self.fileDialogModel.currentPath = self.fileDialogModel.strPath;
            
        }else if (fileModel.type == 3) {
            //上一级目录
            NSString * lastPathComponent = [self.fileDialogModel.currentPath lastPathComponent];
            
            lastPathComponent = [NSString stringWithFormat:@"/%@", lastPathComponent];
            
            self.fileDialogModel.currentPath = [self.fileDialogModel.currentPath stringByReplacingOccurrencesOfString:lastPathComponent withString:@""];
            
        }else if (fileModel.type == 1) {
            //普通目录
            self.fileDialogModel.currentPath = [self.fileDialogModel.currentPath stringByAppendingPathComponent:fileModel.fileName];
            
        }
        
        self.selectNub = -1;
        
        self.fileDialogModel.currentFileName = @"";
        
        self.pathArr = [self getContentsOfDirectoryAtPath:self.fileDialogModel.currentPath];
        
    }
    
    [self.tableView reloadData];
    
    [self updataTitleLab];
}

#pragma mark - 设置model
- (void)setFileDialogModel:(TDD_ArtiFileDialogModel *)fileDialogModel
{
    _fileDialogModel = fileDialogModel;
    
    self.selectNub = -1;
    
    self.pathArr = [self getContentsOfDirectoryAtPath:fileDialogModel.currentPath];
    
    [self.tableView reloadData];
    
    [self updataTitleLab];
}

- (void)updataTitleLab
{
    NSString * path = [self.fileDialogModel.currentPath stringByAppendingPathComponent:self.fileDialogModel.currentFileName];
    
    NSString * documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString * lastPathComponent = [documentsPath lastPathComponent];
    
    documentsPath = [documentsPath stringByReplacingOccurrencesOfString:lastPathComponent withString:@""];
    
    path = [path stringByReplacingOccurrencesOfString:documentsPath withString:@""];
    self.titleLab.text = [NSString stringWithFormat:@"%@: %@", TDDLocalized.diag_position,path];
}

- (NSArray *)getContentsOfDirectoryAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError * error;
    
    NSArray * contentsArr = [fileManager contentsOfDirectoryAtPath:path error:&error];
    
    NSMutableArray * modelArr = [[NSMutableArray alloc] init];
    
    NSArray * directoryArr = @[TDDLocalized.diag_root_dict];
    if (![self.fileDialogModel.currentPath isEqualToString:self.fileDialogModel.strPath]) {
        directoryArr = @[TDDLocalized.diag_root_dict, TDDLocalized.diag_pre_dict];
    }
    
    for (int i = 0; i < directoryArr.count; i ++) {
        NSString * fileName = directoryArr[i];
        
        ArtiFileDialogFileModel * fileModel = [[ArtiFileDialogFileModel alloc] init];
        
        fileModel.fileName = fileName;
        
        fileModel.type = 2 + i;
        
        [modelArr addObject:fileModel];
    }
    
    if (error) {
        HLog(@"文件夹遍历错误：%@",error);
    }else{
        for (NSString * fileName in contentsArr) {
            
            BOOL isDirectory = NO;
            
            NSString * filePath = [path stringByAppendingPathComponent:fileName];
            
            [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
            
            ArtiFileDialogFileModel * fileModel = [[ArtiFileDialogFileModel alloc] init];
            
            fileModel.fileName = fileName;
            
            fileModel.type = isDirectory;
            
            if (self.fileDialogModel.strFilter.length > 0) {
                //需要过滤
                if (!isDirectory) {
                    NSString * suffix = [fileName componentsSeparatedByString:@"."].lastObject;
                    
                    if (suffix != self.fileDialogModel.strFilter) {
                        continue;
                    }
                }
            }
            
            [modelArr addObject:fileModel];
        }
    }
    
    return modelArr;
}

@end
