//
//  TDD_ArtiPictureView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/8/10.
//

#import "TDD_ArtiPictureView.h"
#import "TDD_ArtiPictureCellView.h"
#import "TDD_ArtiPictureHeadCell.h"

#import "YBImageBrowser.h"
#import <WebKit/WebKit.h>
@interface TDD_ArtiPictureView()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView * imageTableView;
@property (nonatomic, strong) WKWebView *webImageView;//显示SVG大图

@end


@implementation TDD_ArtiPictureView
- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)setPictureModel:(TDD_ArtiPictureModel *)pictureModel {
    _pictureModel = pictureModel;
    [_imageTableView reloadData];
    
}

- (void)createUI {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.tdd_viewControllerBackground;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.delaysContentTouches = NO;
    [self addSubview:tableView];
    self.imageTableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = (IphoneWidth - 42)/2 + 80;
    
    [tableView registerClass:[TDD_ArtiPictureCellView class] forCellReuseIdentifier:[TDD_ArtiPictureCellView reuseIdentifier]];
    [tableView registerClass:[TDD_ArtiPictureHeadCell class] forCellReuseIdentifier:[TDD_ArtiPictureHeadCell reuseIdentifier]];
    
}


#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (![NSString tdd_isEmpty:self.pictureModel.text]) {
        return self.pictureModel.pictureArr.count + 1;
    }
    return self.pictureModel.pictureArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL hadText = ![NSString tdd_isEmpty:self.pictureModel.text];
    if (indexPath.row == 0 && hadText){
        TDD_ArtiPictureHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiPictureHeadCell reuseIdentifier] forIndexPath:indexPath];
        [cell setTitle:self.pictureModel.text];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    TDD_ArtiPictureCellView *cell = [tableView dequeueReusableCellWithIdentifier:[TDD_ArtiPictureCellView reuseIdentifier] forIndexPath:indexPath];
    TDD_ArtiPictureItemModel *itemModel = self.pictureModel.pictureArr[hadText?indexPath.row-1:indexPath.row];
    cell.isShowTranslated = self.pictureModel.isShowTranslated;

    itemModel.picturePath = [itemModel.picturePath stringByReplacingOccurrencesOfString:@"//" withString:@"/"];

    cell.itemModel = itemModel;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && ![NSString tdd_isEmpty:self.pictureModel.text]){
        return;
    }
    BOOL hadText = ![NSString tdd_isEmpty:self.pictureModel.text];
    TDD_ArtiPictureItemModel *itemModel = self.pictureModel.pictureArr[hadText?indexPath.row-1:indexPath.row];
    itemModel.picturePath = [itemModel.picturePath stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
    NSString *suff = [itemModel.picturePath pathExtension];
    NSArray *imgArr = @[@"PNG", @"JPEG", @"JPG", @"GIF", @"WEBP", @"APNG"];
    if ([imgArr containsObject:suff.uppercaseString]){
        YBIBImageData *imageData = [[YBIBImageData alloc] init];
        imageData.imagePath = itemModel.picturePath;
        // 打开图片黑屏问题全部是14 系统，需要重写YYImage - YYAnimatedImageView.m 的中的displayLayer方法大概在529 行
        YBImageBrowser *browser = [[YBImageBrowser alloc] init];
        browser.toolViewHandlers = @[]; // 去掉browser工具视图处理器
        browser.dataSourceArray = @[imageData];
    //                browser.currentPage = self.currentIndex;
        [browser show];
    }else if ([suff.uppercaseString isEqualToString:@"SVG"]){
        //加载SVG图片
        [FLT_APP_WINDOW addSubview:self.webImageView];
        [self.webImageView loadData:[NSData dataWithContentsOfFile:itemModel.picturePath] MIMEType:@"image/svg+xml" characterEncodingName:@"UTF-8" baseURL:NSURL.new];
    }

}


// 收起SVG图片预览
- (void)hideImage {
    [self.webImageView removeFromSuperview];
    self.webImageView = nil;
}

- (WKWebView *)webImageView {
    if (!_webImageView){
        _webImageView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight)];
        _webImageView.backgroundColor = UIColor.clearColor;
        _webImageView.userInteractionEnabled = YES;
        _webImageView.scrollView.scrollEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage)];
        tap.delegate = self;
        [_webImageView addGestureRecognizer:tap];
    }
    return _webImageView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;
}
@end
