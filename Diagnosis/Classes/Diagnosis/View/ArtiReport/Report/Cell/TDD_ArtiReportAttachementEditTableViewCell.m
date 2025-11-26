//
//  TDD_ArtiReportAttachementEditTableViewCell.m
//  Diagnosis
//
//  Created by liuyong on 2024/7/1.
//

#import "TDD_ArtiReportAttachementEditTableViewCell.h"
#import "TZImagePickerController.h"

@interface TDD_ArtiReportAttachementEditTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) VoidBlock block;

@end

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
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)fillCellWithAttachementFilePath:(NSString *)filePath fileArray:(NSString *)fileArrayStr reloadCellBlock:(nonnull VoidBlock)block {

    self.block = block;
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
    [self.collectionView reloadData];
}

- (void)delegateImage:(NSInteger)index {
    
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
    [self.collectionView reloadData];
    self.block();
}

- (void)addBtnClick {
    NSInteger maxCount = 12 - self.imageArray.count + self.addArray.count;
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
        [self.collectionView reloadData];
        self.block();
    }];

    imagePickerVc.showSelectedIndex = YES;
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerVc.preferredLanguage = @"en";

    [[UIViewController tdd_topViewController] presentViewController:imagePickerVc animated:YES completion:nil];

}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.imageArray.count >= 12) {
        return 12;
    }
    return self.imageArray.count + 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.imageArray.count == indexPath.row) {
        
        TDD_ArtiReportAttachementEditAddCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TDD_ArtiReportAttachementEditAddCollectionCellId" forIndexPath:indexPath];
        @kWeakObj(self)
        cell.addBlock = ^{
            @kStrongObj(self)
            [self addBtnClick];
        };
        return cell;
    } else {
        TDD_ArtiReportAttachementEditImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TDD_ArtiReportAttachementEditImageCollectionCellId" forIndexPath:indexPath];
        if (self.imageArray.count > indexPath.row) {
            [cell fillCellWithAttachementImage:self.imageArray[indexPath.row]];
            @kWeakObj(self)
            cell.deleteBlock = ^{
                @kStrongObj(self)
                [self delegateImage:indexPath.row];
            };
        }
        return cell;
    }
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

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(IS_IPad ? 120 * HD_Height + 10 : 75 * H_Height + 8, IS_IPad ? 120 * HD_Height + 20 : 75 * H_Height + 15);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth - 60, IphoneHeight) collectionViewLayout:layout];
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.contentInset = UIEdgeInsetsMake(0, IS_IPad ? 40 : 15, 0, IS_IPad ? 30 : 7);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[TDD_ArtiReportAttachementEditImageCollectionCell class] forCellWithReuseIdentifier:@"TDD_ArtiReportAttachementEditImageCollectionCellId"];
        [_collectionView registerClass:[TDD_ArtiReportAttachementEditAddCollectionCell class] forCellWithReuseIdentifier:@"TDD_ArtiReportAttachementEditAddCollectionCellId"];
    }
    return _collectionView;
}

@end


@implementation TDD_ArtiReportAttachementEditImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.attachementImageView];
    [self.contentView addSubview:self.deleteBtn];
    
    [self.attachementImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(IS_IPad ? 20 : 15);
        make.left.equalTo(self.contentView);
        make.width.height.mas_equalTo(IS_IPad ? 120 * HD_Height : 75 * H_Height);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.attachementImageView.mas_right);
        make.centerY.equalTo(self.attachementImageView.mas_top);
        make.width.height.mas_equalTo(IS_IPad ? 20 : 16);
    }];
    
}

- (void)fillCellWithAttachementImage:(UIImage *)image {
    self.attachementImageView.image = image;
}

- (void)delegateImage {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

- (UIImageView *)attachementImageView {
    if (!_attachementImageView) {
        _attachementImageView = [[UIImageView alloc] init];
        _attachementImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_attachementImageView tdd_addCornerRadius:3];
    }
    return _attachementImageView;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn tdd_addCornerRadius:IS_IPad ? 10 : 8];
        [_deleteBtn setImage:kImageNamed(@"pci_icon_del") forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(delegateImage) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.tdd_hitEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
    }
    return _deleteBtn;
}


@end

@implementation TDD_ArtiReportAttachementEditAddCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(IS_IPad ? 20 : 15);
        make.left.equalTo(self.contentView);
        make.width.height.mas_equalTo(IS_IPad ? 120 * HD_Height : 75 * H_Height);
    }];
}

- (void)addBtnClick {
    if (self.addBlock) {
        self.addBlock();
    }
}


- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn tdd_addCornerRadius:2];
        [_addBtn setImage:kImageNamed(@"report_add_pic") forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

@end
