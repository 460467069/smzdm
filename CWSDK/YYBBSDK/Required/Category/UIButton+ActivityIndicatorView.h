//
//  UIButton+ActivityIndicatorView.h
//  
//
//  Created by aazhou on 13-8-13.
//  Copyright (c) 2013 joyotime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ActivityIndicatorView)

@property (nonatomic, assign) UIImage *originalImage;
@property (nonatomic, assign) NSString *originalTitle;

- (void)startAnimation:(UIActivityIndicatorViewStyle)style;
- (void)stopAnimation;

@end
