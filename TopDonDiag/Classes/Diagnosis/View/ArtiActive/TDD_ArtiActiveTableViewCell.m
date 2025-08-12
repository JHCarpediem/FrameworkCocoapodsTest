//
//  TDD_ArtiActiveTableViewCell.m
//  AD200
//
//  Created by 何可人 on 2022/4/24.
//

#import "TDD_ArtiActiveTableViewCell.h"
#import "TDD_ArtiActiveCellView.h"

@interface TDD_ArtiActiveTableViewCell ()
@property (nonatomic, strong) TDD_ArtiActiveCellView * cellView;
@end

@implementation TDD_ArtiActiveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI{
    self.backgroundColor = self.contentView.backgroundColor = UIColor.clearColor;
    TDD_ArtiActiveCellView * cellView = [[TDD_ArtiActiveCellView alloc] init];
    [self.contentView addSubview:cellView];
    self.cellView = cellView;
    
    [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setItemModel:(ArtiActiveItemModel *)itemModel{
    _itemModel = itemModel;
    
    self.cellView.itemModel = itemModel;
}

//- (void)setHeightArr:(NSArray *)heightArr{
//    _heightArr = heightArr;
//
//    if (self.cellView.frame.size.height != self.contentView.bounds.size.height) {
//        self.cellView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
//    }
//
//    self.cellView.heightArr = heightArr;
//}

@end
