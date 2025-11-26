//
//  TDD_ArtiReportAttachementTableViewCell.m
//  Diag
//
//  Created by yong liu on 2023/11/21.
//

#import "TDD_ArtiReportAttachementTableViewCell.h"

@interface TDD_ArtiReportAttachementTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) BOOL isA4;

@end

@implementation TDD_ArtiReportAttachementTableViewCell

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

- (void)fillCellWithAttachementFilePath:(NSString *)filePath fileArray:(NSString *)fileArrayStr isA4:(BOOL)isA4 {

    self.isA4 = isA4;
    if (self.isA4) {
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 0);
    } else {
        self.collectionView.contentInset = UIEdgeInsetsMake(0, IS_IPad ? 40 : 15, 0, IS_IPad ? 30 : 7);
    }
    
    [self.imageArray removeAllObjects];
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSArray *fileArray = [fileArrayStr componentsSeparatedByString:@","];
    for (NSInteger i = 0; i < fileArray.count; i++) {
        NSString *fileStr = fileArray[i];
        [self.imageArray addObject:[UIImage imageWithContentsOfFile:[filePath stringByAppendingFormat:@"/%@", fileStr]]];
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    TDD_ArtiReportAttachementImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TDD_ArtiReportAttachementImageCollectionCellId" forIndexPath:indexPath];
    if (self.imageArray.count > indexPath.row) {
        [cell fillCellWithAttachementImage:self.imageArray[indexPath.row] isA4:self.isA4];
    }
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isA4) {
        CGFloat imageWidth = (A4Width - 15 * 5) / 4;
        return CGSizeMake(imageWidth + 15, imageWidth + 15);
    }
    return CGSizeMake(IS_IPad ? 120 * HD_Height + 10 : 75 * H_Height + 8, IS_IPad ? 120 * HD_Height + 20 : 75 * H_Height + 15);
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
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
        [_collectionView registerClass:[TDD_ArtiReportAttachementImageCollectionCell class] forCellWithReuseIdentifier:@"TDD_ArtiReportAttachementImageCollectionCellId"];
    }
    return _collectionView;
}

@end

@implementation TDD_ArtiReportAttachementImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.attachementImageView];
    [self.attachementImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(IS_IPad ? 20 : 15);
        make.left.equalTo(self.contentView);
        make.width.height.mas_equalTo(IS_IPad ? 120 * HD_Height : 75 * H_Height);
    }];
    
}

- (void)fillCellWithAttachementImage:(UIImage *)image isA4:(BOOL)isA4 {
    
    if (isA4) {
        [self.attachementImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15);
            make.left.equalTo(self.contentView);
            make.width.height.mas_equalTo((A4Width - 15 * 5) / 4);
        }];
    } else {
        [self.attachementImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(IS_IPad ? 20 : 15);
            make.left.equalTo(self.contentView);
            make.width.height.mas_equalTo(IS_IPad ? 120 * HD_Height : 75 * H_Height);
        }];
    }
    self.isA4 = isA4;
    self.attachementImageView.image = image;
}

- (UIImageView *)attachementImageView {
    if (!_attachementImageView) {
        _attachementImageView = [[UIImageView alloc] init];
        _attachementImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_attachementImageView tdd_addCornerRadius:3];
    }
    return _attachementImageView;
}

@end
