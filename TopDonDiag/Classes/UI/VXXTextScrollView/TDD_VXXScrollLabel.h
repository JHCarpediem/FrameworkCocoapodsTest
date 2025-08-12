//
//  TDD_VXXScrollLabel.h
//  TDD_VXXScrollLabel
//
//  Created by Volitation小星 on 16/10/17.
//  Copyright © 2016年 Volitation小星. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TDD_VXXScrollLabelReSetDirection, //重置
    TDD_VXXScrollLabelLeftDirection, //向左
    TDD_VXXScrollLabelRightDirection, //向右
    TDD_VXXScrollLabelDirectionComeAndBack //往返
} TDD_VXXScrollLabelDirection;

@interface TDD_VXXScrollLabel : UILabel

//速度   0.2 * speed * 60 点
@property (assign,nonatomic) float speed;
//滚动方向，默认向左
@property (assign,nonatomic) TDD_VXXScrollLabelDirection scrollDirection;

//往返滚动距离边界  默认10  如果是向左方法则是两个lablel的间距
@property (assign,nonatomic) CGFloat margin;

//当文字不够长的时候滚动的Label
@property (strong,nonatomic) UILabel* scrollLabel;

//当方向 向左右的第二个label
@property (strong,nonatomic) UILabel* scrollLabel2;

-(void)setScrollColor:(UIColor *)color;

@end
