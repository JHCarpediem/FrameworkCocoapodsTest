//
//  TDD_ArtiReportAttachementEditTableViewCell.m
//  TopdonDiagnosis
//
//  Created by liuyong on 2024/7/1.
//

#import "TDD_ArtiReportAttachementEditTableViewCell.h"
#import "TZImagePickerController.h"

@implementation TDD_ArtiReportAttachementEditTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
        
}

- (void)fillCellWithAttachementFilePath:(NSString *)filePath fileArray:(NSString *)fileArrayStr {

    NSArray *fileArray = [fileArrayStr componentsSeparatedByString:@","];
    if ([NSString tdd_isEmpty:fileArrayStr]) {
        fileArray = @[];
    }
    [self.localImageSringArray removeAllObjects];
    [self.localImageArray removeAllObjects];
    
    for (NSInteger i = 0; i < fileArray.count; i++) {
        NSString *fileStr = fileArray[i];
        [self.localImageSringArray addObject:fileStr];
        UIImage *image = [UIImage imageWithContentsOfFile:[filePath stringByAppendingFormat:@"/%@", fileStr]];
        if (image) {
            [self.localImageArray addObject:image];
        }
    }
    self.imageArray = [NSMutableArray arrayWithArray:self.localImageArray];
    [self.imageArray addObjectsFromArray:self.addArray];
    [self refreshUI];
    
}

- (void)refreshUI {
    
    while (self.contentView.subviews.count > 0) {
        UIView *view = self.contentView.subviews[0];
        [view removeFromSuperview];
    }
    CGFloat imageWidth = IS_IPad ? 120 * IphoneWidth / 1024.0 : 75 * H_Height;
    CGFloat imageSpace = IS_IPad ? 20 * IphoneWidth / 1024.0 : (IphoneWidth - 30 - imageWidth * 4) / 3;
    CGFloat leftGap = IS_IPad ? 40 : 15;
    CGFloat top = IS_IPad ? 20 * IphoneWidth / 1024.0 : 6;
    for (NSInteger i = 0; i < self.imageArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftGap + (imageWidth + imageSpace) * i, top, imageWidth, imageWidth)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView tdd_addCornerRadius:3];
        imageView.image = self.imageArray[i];
        [self.contentView addSubview:imageView];
        
        CGFloat deleteBtnWidth = IS_IPad ? 20 : 16;
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn tdd_addCornerRadius:deleteBtnWidth / 2];
        [deleteBtn setImage:kImageNamed(@"pci_icon_del") forState:UIControlStateNormal];
        deleteBtn.tag = 10 + i;
        [deleteBtn addTarget:self action:@selector(delegateImage:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.tdd_hitEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
        [self.contentView addSubview:deleteBtn];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView).offset(-deleteBtnWidth / 2);
            make.left.equalTo(imageView.mas_right).offset(-deleteBtnWidth / 2);
            make.width.height.mas_equalTo(deleteBtnWidth);
        }];
        
    }
    
    if (self.imageArray.count < 4) {
        UIImageView *addImage = [[UIImageView alloc] init];
        addImage.frame = CGRectMake(leftGap + (imageWidth + imageSpace) * self.imageArray.count, top, imageWidth, imageWidth);
        addImage.image = kImageNamed(@"report_add_pic");
        [addImage tdd_addCornerRadius:2];
        addImage.userInteractionEnabled = YES;
        [self.contentView addSubview:addImage];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBtnClick)];
        [addImage addGestureRecognizer:tap];
    }
}

- (void)delegateImage:(UIButton *)btn {
    
    NSInteger index = btn.tag - 10;
    if (index < self.localImageArray.count) {
        [self.localImageArray removeObjectAtIndex:index];
        [self.localImageSringArray removeObjectAtIndex:index];
    } else {
        NSInteger addIndex = index - self.localImageArray.count;
        [self.addArray removeObjectAtIndex:addIndex];
        [self.addAssets removeObjectAtIndex:addIndex];
    }
    self.imageArray = [NSMutableArray arrayWithArray:self.localImageArray];
    [self.imageArray addObjectsFromArray:self.addArray];
    [self refreshUI];
}

- (void)addBtnClick {
    NSInteger maxCount = 4 - self.imageArray.count + self.addArray.count;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount delegate:nil];
    imagePickerVc.maxImagesCount = maxCount;
    imagePickerVc.selectedAssets = self.addAssets;  // 目前已经选中的图片数组
    imagePickerVc.isSelectOriginalPhoto = YES;
    imagePickerVc.allowTakePicture = YES;  // 在内部显示拍照
    imagePickerVc.autoSelectCurrentWhenDone = NO;
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];

    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPreview = NO;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.sortAscendingByModificationDate = NO;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;

//    imagePickerVc.naviTitleFont = [UIFont boldSystemFontOfSize:16];
//    imagePickerVc.naviBgColor = [UIColor colorFFFFFF];
    @kWeakObj(self)
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        @kStrongObj(self)
        self.addArray = photos.mutableCopy;
        self.addAssets = assets.mutableCopy;
        self.imageArray = [NSMutableArray arrayWithArray:self.localImageArray];
        [self.imageArray addObjectsFromArray:self.addArray];
        [self refreshUI];
    }];

    imagePickerVc.showSelectedIndex = YES;
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerVc.preferredLanguage = @"en";

    [[UIViewController tdd_topViewController] presentViewController:imagePickerVc animated:YES completion:nil];

}


- (NSMutableArray *)localImageSringArray {
    if (!_localImageSringArray) {
        _localImageSringArray = [NSMutableArray array];
    }
    return _localImageSringArray;
}

- (NSMutableArray *)localImageArray {
    if (!_localImageArray) {
        _localImageArray = [NSMutableArray array];
    }
    return _localImageArray;
}

- (NSMutableArray *)addArray {
    if (!_addArray) {
        _addArray = [NSMutableArray array];
    }
    return _addArray;
}

@end
