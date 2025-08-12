//
//  TDD_VXXScrollButton.m
//  Discovery
//
//  Created by Volitation小星 on 16/10/12.
//  Copyright © 2016年 军鸽. All rights reserved.
//

#import "TDD_VXXScrollButton.h"

@interface TDD_VXXScrollButton ()

@property (assign,nonatomic) BOOL isLeft;

@property (strong,nonatomic) CADisplayLink* displayLink;

@property (assign,nonatomic) CGFloat speedPoint;

@property (nonatomic,assign) CGFloat currentX;

@end


@implementation TDD_VXXScrollButton


-(void)awakeFromNib{
    [super awakeFromNib];
    self.speedPoint = 0.2;
    self.margin = 10;
    self.scrollDirection = TDD_VXXScrollButtonLeftDirection;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.speedPoint = 0.2;
        self.margin = 10;
        self.scrollDirection = TDD_VXXScrollButtonLeftDirection;
        self.margin = 10;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(VCdealloc:) name:@"VCdealloc" object:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
        
    if (self.titleLabel.bounds.size.width > self.bounds.size.width - self.titleEdgeInsets.left) {
        self.layer.masksToBounds = YES;
        
        CGRect frame = self.titleLabel.frame;
        
        frame.origin.x = self.currentX;
        
        self.titleLabel.frame = frame;
        
        if (self.displayLink == nil) {
            self.displayLink = [CADisplayLink  displayLinkWithTarget:self selector:@selector(displayLink:)];
            
            [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]forMode:NSDefaultRunLoopMode];
        }
    }
}


-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    
    [self removeLink];
    
    [super setTitle:title forState:state];
    
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void)removeLink{
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)VCdealloc:(NSNotification *)noti{
    Class class = noti.object;
    
    UIViewController * vc = [self viewController];
    
    if ([vc class] == class) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self removeLink];
    }
    
    if (!self.superview) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        [self removeLink];
    }
}

//获得当前View所在的ViewController  这里的self是 UIView
-(UIViewController*)viewController{
    UIResponder *nextResponder =  self;
    do{
    nextResponder = [nextResponder nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController*)nextResponder;
    } while (nextResponder != nil);
    return nil;
}

-(void)displayLink:(CADisplayLink*)displayLink{
    
    if (self.scrollDirection == TDD_VXXScrollButtonReSetDirection) {
        
        if (self.bounds.size.width - self.titleLabel.bounds.size.width - self.margin > self.titleLabel.frame.origin.x) {
            self.isLeft = NO;
        }
        
        if (self.titleLabel.frame.origin.x >= self.margin) {
            self.isLeft = YES;
        }
        
        if (self.isLeft) {
            
            CGRect frame = self.titleLabel.frame;
            
            frame.origin.x = self.currentX - self.speedPoint;
            
            self.currentX =  frame.origin.x;
            
            self.titleLabel.frame = frame;
            
            
        }else{
            
            CGRect frame = self.titleLabel.frame;
            
            frame.origin.x = self.margin;
            
            self.currentX =  frame.origin.x;
            
            self.titleLabel.frame = frame;
        }
        return;
    }
    
    if (self.scrollDirection == TDD_VXXScrollButtonDirectionComeAndBack) {
        
        if (self.bounds.size.width - self.titleLabel.bounds.size.width - self.margin > self.titleLabel.frame.origin.x) {
            self.isLeft = NO;
        }
        
        if (self.titleLabel.frame.origin.x >= self.margin) {
            self.isLeft = YES;
        }
        
        if (self.isLeft) {
            
            CGRect frame = self.titleLabel.frame;
            
            frame.origin.x = self.currentX - self.speedPoint;
            
            self.currentX =  frame.origin.x;
            
            self.titleLabel.frame = frame;
            
            
        }else{
            
            CGRect frame = self.titleLabel.frame;
            
            frame.origin.x = self.currentX + self.speedPoint;
            
            self.currentX =  frame.origin.x;
            
            self.titleLabel.frame = frame;
        }
        return;
    }
    
    if (self.scrollDirection == TDD_VXXScrollButtonLeftDirection) {
        if(self.bounds.size.width - self.titleLabel.bounds.size.width - self.margin > self.titleLabel.frame.origin.x){
            
            CGRect frame = self.titleLabel.frame;
            
            frame.origin.x  = self.margin;
            
            self.currentX = frame.origin.x;
            
            self.titleLabel.frame = frame;

        }else{
            
            CGRect frame = self.titleLabel.frame;
            
            frame.origin.x = self.currentX - self.speedPoint;
            
            self.currentX = frame.origin.x;
            
            self.titleLabel.frame = frame;
            
        }
    }
    
    if (self.scrollDirection == TDD_VXXScrollButtonRightDirection) {
        if(self.margin == self.titleLabel.frame.origin.x){
            
            CGRect frame = self.titleLabel.frame;
            
            frame.origin.x  = self.bounds.size.width - self.titleLabel.bounds.size.width - self.margin;
            
            self.currentX = frame.origin.x;
            
            self.titleLabel.frame = frame;
            
        }else{
            
            CGRect frame = self.titleLabel.frame;
            
            frame.origin.x = self.currentX - self.speedPoint;

            self.currentX = frame.origin.x;
            
            self.titleLabel.frame = frame;
            
        }
    }

    
    
}

-(void)setScrollDirection:(TDD_VXXScrollButtonDirection)scrollDirection{
    _scrollDirection = scrollDirection;
    [self.displayLink invalidate];
    self.displayLink = nil;

    [self setNeedsDisplay];
    [self setNeedsLayout];
}

-(void)setSpeed:(float)speed{
    _speed = speed;
    self.speedPoint = 0.2 * speed;
}

- (void)dealloc{
    NSLog(@"滑动按钮 -- dealloc");
}

@end
