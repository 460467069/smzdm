//
//  MJDIYHeader.m
//  MJRefreshExample
//
//  Created by Wang_ruzhou on 16/8/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZDIYHeader.h"
#import "ZZCircleView.h"
#import "ZZRefreshTip.h"

@interface ZZDIYHeader()
@property (weak, nonatomic) UILabel *label;
@property (nonatomic, weak) ZZCircleView *circleView;
@property (nonatomic, assign, getter=isFullCover) BOOL fullCover;   //标记在回复的时候, 下拉是否画完整圆
@property (nonatomic, assign, getter=isChangeLabelText) BOOL changeLabelText;
@end

@implementation ZZDIYHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    self.backgroundColor = [UIColor whiteColor];
    
    ZZCircleView *cirleView = [[ZZCircleView alloc] init];
    [self addSubview:cirleView];
    self.circleView = cirleView;
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    self.label.text = [ZZRefreshTip randomRefreshTip];  //初始值
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    

    self.circleView.mj_y = self.mj_h - self.circleView.mj_h - 3;
    self.circleView.mj_x = (self.mj_w - self.circleView.mj_w) * 0.5;

    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = kScreenW;
    CGFloat labelH = self.mj_h - self.circleView.mj_h;
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);


    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];

}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{
    if (self.state == MJRefreshStateRefreshing) {
        self.changeLabelText = YES;
    }
    [super scrollViewPanStateDidChange:change];

}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle: {
            self.label.text = [ZZRefreshTip randomRefreshTip];
            break;
        }
        case MJRefreshStatePulling: {
            break;
        }
        case MJRefreshStateRefreshing: {
            self.fullCover = YES;
            [self.circleView startAnimating];
            break;
        }
        default: {
            
            break;
        }
    }
    

}

//- (void)endRefreshing{
//    
//    //仿值得买实现
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.label.text = [ZZRefreshTip randomRefreshTip];
//    });
//    
//    [super endRefreshing];
//}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];

    switch (self.state) {
        case MJRefreshStateIdle: {
            if (pullingPercent <= 1) { //过滤掉百分比>1的情况
                if (self.fullCover) {   //用户下拉触发了刷新
                    self.circleView.progress = 1;
                    if (pullingPercent == 0) { // pullingPercent = -0 什么情况
                        
                        self.fullCover = NO;    //重置标记 
                        
                    }
                }else{                  //用户下拉没有触发刷新
                    self.circleView.progress = pullingPercent;
                }
                
                
            }
            break;
        }
        case MJRefreshStatePulling: {
            self.circleView.progress = 1;
            break;
        }
        case MJRefreshStateRefreshing: {
            self.fullCover = YES;
            break;
        }
        case MJRefreshStateWillRefresh: {
            self.circleView.progress = 0;
            
            break;
        }
        case MJRefreshStateNoMoreData: {
            
            break;
        }
    }
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
//    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
