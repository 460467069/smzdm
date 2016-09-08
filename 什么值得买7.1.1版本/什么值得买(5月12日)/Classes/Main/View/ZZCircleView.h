//
//  ZZCircleView.h
//  MJRefreshExample
//
//  Created by Wang_ruzhou on 16/8/7.
//  Copyright © 2016年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZCircleView : UIView


// 接收外界传入的百分比
@property (nonatomic,assign) float progress;

- (void)stopAnimating;

- (void)startAnimating;

@end
