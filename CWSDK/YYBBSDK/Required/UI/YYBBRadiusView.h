//
//  RadiusView.h
//  
//
//  Created by Wang_ruzhou on 2018/3/10.
//  Copyright © 2018年 ZeroDistance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYBBStrokeLabel : UILabel
@property (nonatomic, strong) IBInspectable UIColor *strokeColor;
@property (nonatomic, assign) IBInspectable CGFloat strokeWidth;
@end

@interface YYBBStrokeButton : UIButton
@property (nonatomic, strong) IBInspectable UIColor *strokeColor;
@property (nonatomic, assign) IBInspectable CGFloat strokeWidth;
@end
