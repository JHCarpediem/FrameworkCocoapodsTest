//
//  TDD_ArtiPictureCellView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/8/10.
//

#import "TDD_ArtiPictureCellView.h"
#import <WebKit/WebKit.h>
@interface TDD_ArtiPictureCellView()
@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) TDD_CustomLabel * topLabel;
@property (nonatomic, strong) TDD_CustomTextView * topTextView;
@property (nonatomic, strong) TDD_CustomLabel * bottomLabel;
@property (nonatomic, strong) WKWebView *webImageView;//显示SVG大图
@end
@implementation TDD_ArtiPictureCellView

+ (NSString *)reuseIdentifier {
    return @"pictureCellIdentifier";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (IS_IPad){
            [self createIPadUI];
        }else {
            [self createUI];
        }
        
    }
    return self;
}

- (void)createUI {
    
    self.contentView.backgroundColor = [UIColor tdd_cellBackground];
    
    UIView *imageBorderView = [UIView new];
    imageBorderView.backgroundColor = UIColor.clearColor;
    [imageBorderView.layer setBorderColor:UIColor.tdd_line.CGColor];
    [imageBorderView.layer setBorderWidth:0.5f];
    [self.contentView addSubview:imageBorderView];
    
    [imageBorderView addSubview:self.bgImageView];
    [imageBorderView addSubview:self.webImageView];
    [self.contentView addSubview:self.topLabel];
    [self.contentView addSubview:self.bottomLabel];

    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColor.tdd_line;
    [self.contentView addSubview:lineView];
    
    
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(30);
    }];
    
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-16);
    }];
    
    [imageBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.topLabel.mas_bottom).offset(8);
        make.bottom.equalTo(self.bottomLabel.mas_top).offset(-8);
        make.height.mas_equalTo(258);
    }];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imageBorderView);
        make.top.equalTo(imageBorderView).offset(10);
        make.bottom.equalTo(imageBorderView).offset(-10);
    }];
    
    [_webImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imageBorderView);
        make.top.equalTo(imageBorderView).offset(10);
        make.bottom.equalTo(imageBorderView).offset(-10);
    }];

    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.right.bottom.equalTo(self.contentView);
    }];
}

- (void)createIPadUI {
    [self.contentView addSubview:self.bgImageView];
    [self.contentView addSubview:self.webImageView];
    [self.contentView addSubview:self.topTextView];
    [self.contentView addSubview:self.bottomLabel];

    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColor.tdd_line;
    [self.contentView addSubview:lineView];
    
    
    [_topTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-40 * HD_Height);
        make.left.equalTo(self.contentView).offset(532 * HD_Height);
        make.top.equalTo(self.contentView).offset(20 * HD_HHeight);
        make.height.mas_lessThanOrEqualTo(340 * HD_Height);
    }];
    
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(40 * HD_Height);
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-20 * HD_HHeight);
    }];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(40 * HD_Height);
        make.size.mas_equalTo(CGSizeMake(452 * HD_Height, 340 * HD_Height));
        make.top.equalTo(self.contentView).offset(20 * HD_HHeight);
    }];
    
    [_webImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(40 * HD_Height);
        make.size.mas_equalTo(CGSizeMake(452 * HD_Height, 340 * HD_Height));
        make.top.equalTo(self.contentView).offset(20 * HD_HHeight);
    }];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.right.bottom.equalTo(self.contentView);
    }];
}

- (void)setItemModel:(TDD_ArtiPictureItemModel *)itemModel {
    NSInteger multi = IS_IPad ? 3 : 2;
    NSInteger baseFontSize = IS_IPad ? 18 : 14;
    CGFloat fontSize = baseFontSize + itemModel.size * multi;
    if (![NSString tdd_isEmpty:itemModel.topTips]){
        if (IS_IPad) {
            _topTextView.hidden = NO;
            if (self.isShowTranslated) {
                _topTextView.text = itemModel.strTranslatedTopTips;
            }else {
                _topTextView.text = itemModel.topTips;
            }
            
            self.topTextView.font = [[UIFont systemFontOfSize:fontSize weight:itemModel.bold==1?UIFontWeightBold:UIFontWeightMedium] tdd_adaptHD];
        }else {
            _topLabel.hidden = NO;
            if (self.isShowTranslated) {
                _topLabel.text = itemModel.strTranslatedTopTips;
            }else {
                _topLabel.text = itemModel.topTips;
            }
            
            self.topLabel.font = [[UIFont systemFontOfSize:fontSize weight:itemModel.bold==1?UIFontWeightBold:UIFontWeightMedium] tdd_adaptHD];
        }
        
        

    }else {
        if (IS_IPad) {
            _topTextView.hidden = YES;
            _topTextView.text = @"";
        }else {
            _topLabel.hidden = YES;
            _topLabel.text = @"";
        }
        
    }
    
    if (![NSString tdd_isEmpty:itemModel.bottomTips]) {
        _bottomLabel.hidden = NO;
        
        if (self.isShowTranslated) {
            _bottomLabel.text = itemModel.strTranslatedBottomTips;
        }else {
            _bottomLabel.text = itemModel.bottomTips;
        }
        
        self.bottomLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightMedium] tdd_adaptHD];
    }else {
        _bottomLabel.hidden = YES;
        _bottomLabel.text = @"";
    }
    NSString *suff = [itemModel.picturePath pathExtension];
    NSArray *imgArr = @[@"PNG", @"JPEG", @"JPG", @"GIF", @"WEBP", @"APNG"];
    BOOL showImage = NO;
    if ([imgArr containsObject:suff.uppercaseString]){
        _bgImageView.hidden = NO;
        _webImageView.hidden = YES;
        [_bgImageView setImage:[UIImage imageWithContentsOfFile:itemModel.picturePath]];
        showImage = YES;
    }else if ([suff.uppercaseString isEqualToString:@"SVG"]){
        _bgImageView.hidden = YES;
        _webImageView.hidden = NO;
        [self.webImageView loadData:[NSData dataWithContentsOfFile:itemModel.picturePath] MIMEType:@"image/svg+xml" characterEncodingName:@"UTF-8" baseURL:NSURL.new];
        showImage = YES;
    }else {
        _bgImageView.hidden = YES;
        _webImageView.hidden = YES;
        showImage = NO;
    }
    if (IS_IPad){
        [_bottomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(40 * HD_Height);
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-20 * HD_HHeight);
            make.top.equalTo(showImage?_webImageView.mas_bottom:_topTextView.mas_bottom).offset(20 * HD_HHeight);
        }];
        CGFloat maxWidth = showImage? IphoneWidth - 572 * HD_Height : IphoneWidth - 80 * HD_Height;
        // 计算文本高度
        CGRect textRect = [_topTextView.text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   attributes:@{NSFontAttributeName: _topTextView.font}
                                                      context:nil];
        [_topTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-40 * HD_Height);
            make.left.equalTo(self.contentView).offset(showImage? 532 * HD_Height : 40 * HD_Height);
            make.top.equalTo(self.contentView).offset(20 * HD_HHeight);
            make.height.mas_equalTo(MIN(340 * HD_Height, textRect.size.height + _topTextView.textContainerInset.top + _topTextView.textContainerInset.bottom));
        }];
    }


}

#pragma mark Lazy

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bgImageView;
    
}

- (TDD_CustomLabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [TDD_CustomLabel new];
        [_topLabel setTextColor:[UIColor tdd_color666666]];
        [_topLabel setFont:[[UIFont systemFontOfSize:15] tdd_adaptHD]];
        _topLabel.textAlignment = NSTextAlignmentLeft;
        _topLabel.numberOfLines = 0;
        
    }
    return _topLabel;;
}

- (TDD_CustomTextView *)topTextView {
    if (!_topTextView) {
        _topTextView = [TDD_CustomTextView new];
        [_topTextView setTextColor:[UIColor tdd_color666666]];
        [_topTextView setFont:[[UIFont systemFontOfSize:15] tdd_adaptHD]];
        _topTextView.textAlignment = NSTextAlignmentLeft;
        _topTextView.bounces = NO;
    }
    return _topTextView;
}

- (TDD_CustomLabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [TDD_CustomLabel new];
        [_bottomLabel setTextColor:[UIColor tdd_color666666]];
        [_bottomLabel setFont:[[UIFont systemFontOfSize:15] tdd_adaptHD]];
        _bottomLabel.textAlignment = NSTextAlignmentLeft;
        _bottomLabel.numberOfLines = 0;
    }
    return _bottomLabel;;
}

- (WKWebView *)webImageView {
    if (!_webImageView){
        _webImageView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight)];
        _webImageView.backgroundColor = UIColor.clearColor;
        _webImageView.userInteractionEnabled = NO;
        _webImageView.scrollView.scrollEnabled = NO;
        _webImageView.hidden = YES;
    }
    return _webImageView;
}
@end
