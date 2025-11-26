//
//  TDD_VXXScrollLabel.m
//  TDD_VXXScrollLabel
//
//  Created by Volitation小星 on 16/10/17.
//  Copyright © 2016年 Volitation小星. All rights reserved.
//

#import "TDD_VXXScrollLabel.h"

@interface TDD_VXXScrollLabel ()

@property (assign,nonatomic) CGRect tmpFrame;

@property (strong,nonatomic) CADisplayLink* displayLink;

@property (assign,nonatomic) BOOL isLeft;

@property (assign,nonatomic) CGFloat speedPoint;

@property (assign,nonatomic) BOOL shouldScroll;

@property (nonatomic,strong) UIColor* textColorNor;

@end


@implementation TDD_VXXScrollLabel

-(TDD_CustomLabel *)scrollLabel{
    if (_scrollLabel == nil) {
        _scrollLabel = [TDD_CustomLabel new];
        _scrollLabel.frame = self.bounds;
        _scrollLabel.text = self.text;
        _scrollLabel.textColor = self.textColorNor;
        _scrollLabel.shadowColor = self.shadowColor;
        _scrollLabel.font = self.font;
        _scrollLabel.attributedText = self.attributedText;
        _scrollLabel.textAlignment = self.textAlignment;
        self.textColor = [UIColor clearColor];
    }
    
    return _scrollLabel;
}

-(TDD_CustomLabel *)scrollLabel2{
    
    if (_scrollLabel2 == nil) {
        _scrollLabel2 = [TDD_CustomLabel new];
        _scrollLabel2.frame = _scrollLabel.bounds;
        _scrollLabel2.text = _scrollLabel.text;
        _scrollLabel2.textColor = self.textColorNor;
        _scrollLabel2.shadowColor = _scrollLabel.shadowColor;
        _scrollLabel2.font = _scrollLabel.font;
        _scrollLabel2.attributedText = _scrollLabel.attributedText;
        _scrollLabel2.textAlignment = _scrollLabel.textAlignment;
        self.textColor = [UIColor clearColor];
    }
    
    return _scrollLabel2;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.speedPoint = 0.2;
    self.margin = 10;
    self.scrollDirection = TDD_VXXScrollLabelLeftDirection;
    self.textColorNor = [UIColor blackColor];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.speedPoint = 0.2;
        self.margin = 10;
        self.scrollDirection = TDD_VXXScrollLabelLeftDirection;
        self.textColorNor = [UIColor blackColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(VCdealloc:) name:@"VCdealloc" object:nil];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.tmpFrame = self.frame;
    
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    
    //需要滚动
    if(size.width > self.tmpFrame.size.width){
        
        self.shouldScroll = YES;
        
        [self addSubview:self.scrollLabel];
        
        [self.scrollLabel sizeToFit];
        
        if (self.scrollDirection == TDD_VXXScrollLabelLeftDirection || self.scrollDirection == TDD_VXXScrollLabelRightDirection) {
            [self.scrollLabel2 sizeToFit];
            [self addSubview:self.scrollLabel2];
        }
        self.textColor = [UIColor clearColor];
        
        self.scrollLabel.textColor =  self.textColorNor;
        
        self.scrollLabel2.textColor =  self.textColorNor;
        
//        if (!self.scrollLabel.attributedText) {
//            self.scrollLabel.textColor =  self.textColorNor;
//        }
//        if (!self.scrollLabel2.attributedText) {
//            self.scrollLabel2.textColor =  self.textColorNor;
//        }
        
        self.layer.masksToBounds = YES;
        
        if (self.displayLink == nil) {
            
            self.displayLink = [CADisplayLink  displayLinkWithTarget:self selector:@selector(displayLink:)];
            
            [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]forMode:NSDefaultRunLoopMode];
            
            CGRect frame = self.scrollLabel.frame;
            
            frame.origin.y = (self.tmpFrame.size.height - frame.size.height) * 0.5;
            
            self.scrollLabel.frame = frame;
            
            if (self.scrollDirection == TDD_VXXScrollLabelLeftDirection || self.scrollDirection == TDD_VXXScrollLabelRightDirection) {
                
                CGRect fame2 = frame;
                
                fame2.origin.x = frame.origin.x + frame.size.width + self.margin;
                
                self.scrollLabel2.frame = fame2;
            }
            
        }

            
    }

}


-(void)setText:(NSString *)text{
    //何 - 新增
    if ([self.text isEqualToString:text]) {
        return;
    }
    
    [self.displayLink invalidate];
    self.displayLink = nil;
    
    [_scrollLabel removeFromSuperview];
    _scrollLabel = nil;
    [_scrollLabel2 removeFromSuperview];
    _scrollLabel2 =nil;
    
    self.textColor = self.textColorNor;
    
    [super setText:text];

    [self setNeedsLayout];

    
 }

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [self.displayLink invalidate];
    self.displayLink = nil;
    
    [_scrollLabel removeFromSuperview];
    _scrollLabel = nil;
    [_scrollLabel2 removeFromSuperview];
    _scrollLabel2 =nil;
    
    [super setAttributedText:attributedText];
    
    [self setNeedsLayout];
}

-(void)setTextColor:(UIColor *)textColor{
    [super setTextColor:textColor];
    
    if(!CGColorEqualToColor(textColor.CGColor, [UIColor clearColor].CGColor)){
        
        self.textColorNor = textColor;
        
        //何 - 新增
        if (_scrollLabel.text.length != 0) {
            _scrollLabel.textColor =  self.textColorNor;
        }
        if (_scrollLabel2.text.length != 0) {
            _scrollLabel2.textColor =  self.textColorNor;
        }
        
        [self setNeedsLayout];
    }
    
}

//往返滚动的方法
-(void)displayLink:(CADisplayLink*)displayLink{
    
    if (self.scrollDirection == TDD_VXXScrollLabelReSetDirection) {
        if (self.bounds.size.width - self.scrollLabel.bounds.size.width - self.margin > self.scrollLabel.frame.origin.x) {
            self.isLeft = NO;
        }
        
        if (self.scrollLabel.frame.origin.x >= self.margin) {
            self.isLeft = YES;
        }
        
        if (self.isLeft) {
            
            CGRect frame = self.scrollLabel.frame;
            
            frame.origin.x = frame.origin.x - 0.2;
            
            self.scrollLabel.frame = frame;
            
            
        }else{
            
            __block CGRect frame = self.scrollLabel.frame;
            
            frame.origin.x = self.margin;
            
            self.scrollLabel.frame = frame;
        }
    }
    
    
    if (self.scrollDirection == TDD_VXXScrollLabelDirectionComeAndBack) {
        if (self.bounds.size.width - self.scrollLabel.bounds.size.width - self.margin > self.scrollLabel.frame.origin.x) {
            self.isLeft = NO;
        }
        
        if (self.scrollLabel.frame.origin.x >= self.margin) {
            self.isLeft = YES;
        }
        
        if (self.isLeft) {
            
            CGRect frame = self.scrollLabel.frame;
            
            frame.origin.x = frame.origin.x - 0.2;
            
            self.scrollLabel.frame = frame;
            
            
        }else{
            
            CGRect frame = self.scrollLabel.frame;
            
            frame.origin.x = frame.origin.x + 0.2;
            
            self.scrollLabel.frame = frame;
        }
        
    }
    
    if (self.scrollDirection == TDD_VXXScrollLabelLeftDirection || self.scrollDirection == TDD_VXXScrollLabelRightDirection) {
        
        CGRect frame = self.scrollLabel.frame;
        
        if (self.scrollDirection == TDD_VXXScrollLabelLeftDirection) {
                frame.origin.x = frame.origin.x - 0.2;
        }else{
                frame.origin.x = frame.origin.x + 0.2;
        }
        
        
        self.scrollLabel.frame = frame;
        
        CGRect frame1 = self.scrollLabel2.frame;
        
        if (self.scrollDirection == TDD_VXXScrollLabelLeftDirection) {
              frame1.origin.x = frame1.origin.x - 0.2;
        }else{
              frame1.origin.x = frame1.origin.x + 0.2;
        }
        
        self.scrollLabel2.frame = frame1;
        
        //判读label位置是否需要重置
        if([self judgeLocation:self.scrollLabel]){
            
            if (self.scrollDirection == TDD_VXXScrollLabelLeftDirection) {
                CGRect frame = self.scrollLabel.frame;
                
                frame.origin.x = self.scrollLabel2.frame.origin.x + self.scrollLabel2.frame.size.width + self.margin;
                
                self.scrollLabel.frame = frame;
            }else{
            
                CGRect frame = self.scrollLabel.frame;
                frame.origin.x = self.scrollLabel2.frame.origin.x - self.margin - self.scrollLabel.frame.size.width;
                self.scrollLabel.frame = frame;
                
            }
        };
        
        if([self judgeLocation:self.scrollLabel2]){
            if (self.scrollDirection == TDD_VXXScrollLabelLeftDirection) {

            CGRect frame = self.scrollLabel2.frame;
            
            frame.origin.x = self.scrollLabel.frame.origin.x + self.scrollLabel.frame.size.width + self.margin;
                self.scrollLabel2.frame = frame;
            }else{
                
            CGRect frame = self.scrollLabel2.frame;
                
                frame.origin.x = self.scrollLabel.frame.origin.x - self.margin - self.scrollLabel2.frame.size.width;
            self.scrollLabel2.frame = frame;
            
            }
            
        };
        
    }
    
    
    
}

-(BOOL)judgeLocation:(UILabel*)label{
    
    if (self.scrollDirection == TDD_VXXScrollLabelLeftDirection) {
        if((label.frame.origin.x + label.frame.size.width) < 0){
            return YES;
        }
    }else{
        if(label.frame.origin.x > self.frame.size.width){
            return YES;
        }
    }
    
    return NO;
}

-(void)setScrollDirection:(TDD_VXXScrollLabelDirection)scrollDirection{
    _scrollDirection = scrollDirection;
    [self.displayLink invalidate];
    self.displayLink = nil;
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
    
    if (scrollDirection == TDD_VXXScrollLabelDirectionComeAndBack) {
        [_scrollLabel2 removeFromSuperview];
        _scrollLabel2 = nil;
    }
}

-(void)setSpeed:(float)speed{
    _speed = speed;
    self.speedPoint = 0.2 * speed;
}


-(void)setScrollColor:(UIColor *)color{
    [self setTextColor:color];
}

- (void)VCdealloc:(NSNotification *)noti{
    Class class = noti.object;
    
    BOOL isRemove = NO;
    
    UIView * superView = self.superview;
    
    while (superView) {
        if ([superView class] == class) {
            isRemove = YES;
            break;
        }else {
            superView = superView.superview;
        }
    }
    
    if (!isRemove) {
        UIViewController * vc = [self viewController];
        
        if ([vc class] == class) {
            isRemove = YES;
        }
        
        if (!self.superview) {
            isRemove = YES;
        }
    }
    
    if (isRemove) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        if (self.displayLink) {
            [self.displayLink invalidate];
            self.displayLink = nil;
        }
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

- (void)dealloc{

    NSLog(@"%s",__func__);
}

@end
