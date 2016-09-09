//
//  ZZCircleView.m
//  MJRefreshExample
//
//  Created by Wang_ruzhou on 16/8/7.
//  Copyright © 2016年. All rights reserved.
//

#import "ZZCircleView.h"

#define kCircleViewWH 24

@interface ZZCircleView ()
@property (nonatomic, strong)  CADisplayLink *link;
@property (nonatomic, strong) UIImageView *circleView;
@property (nonatomic, strong) UIImageView *zhiView;
@end


@implementation ZZCircleView

- (CADisplayLink *)link{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotateCirclView)];
    }
    return _link;
}

- (UIImageView *)zhiView{
    if (!_zhiView) {
        _zhiView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhi"]];
    }
    
    return _zhiView;
    
}

- (UIImageView *)circleView{
    if (!_circleView) {
        _circleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle"]];
        _circleView.hidden = YES;
    }
    
    return _circleView;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kCircleViewWH;
        frame.size.height = kCircleViewWH;
        
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.zhiView];
        [self addSubview:self.circleView];
        

    }
    return self;
}

- (void)stopAnimating {
    self.circleView.hidden = YES;
    [self.link invalidate];
    self.link = nil;
}

- (void)startAnimating {
    self.progress = 0;
    self.circleView.hidden = NO;
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}


- (void)dealloc{
    
    [self.link invalidate];
    self.link = nil;
}

- (void)rotateCirclView {
	self.circleView.transform = CGAffineTransformRotate(self.circleView.transform, M_PI_4 / 8);
}


- (void)setProgress:(float)progress{
    _progress = progress;
    
    self.circleView.hidden = YES;
    //重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    if (self.progress >= 0) {
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
        
        CGFloat lineWidth = 1;
        
        CGFloat radius = MIN(center.x, center.y) - lineWidth;
        
        CGFloat startAngle = - M_PI_2;
        
        CGFloat endAngle = 2 * M_PI * self.progress + startAngle;
        
        [bezierPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        bezierPath.lineWidth = lineWidth;
        bezierPath.lineCapStyle = kCGLineCapRound;
        [[UIColor redColor] setStroke];
        [bezierPath stroke];
    }
}
    


@end
