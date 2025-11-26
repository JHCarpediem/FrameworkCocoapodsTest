//
//  TDD_VXXScrollButton.h
//  Discovery
//
//  Created by Volitation小星 on 16/10/12.
//  Copyright © 2016年 军鸽. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TDD_VXXScrollButtonReSetDirection, //重置
    TDD_VXXScrollButtonLeftDirection, //向左
    TDD_VXXScrollButtonRightDirection, //向右
    TDD_VXXScrollButtonDirectionComeAndBack //往返
} TDD_VXXScrollButtonDirection;



@interface TDD_VXXScrollButton : UIButton

@property (assign,nonatomic) CGFloat margin;

//滚动方向，默认往返
@property (assign,nonatomic) TDD_VXXScrollButtonDirection scrollDirection;
//速度   0.2 * speed * 60 点
@property (assign,nonatomic) float speed;


@end
