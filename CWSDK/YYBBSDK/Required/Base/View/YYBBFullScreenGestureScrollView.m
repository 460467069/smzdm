//
//  YYBBFullScreenGestureScrollView.m
//  JXPagerViewExample-OC
//
//  Created by jiaxin on 2020/4/21.
//  Copyright © 2020 jiaxin. All rights reserved.
//

#import "YYBBFullScreenGestureScrollView.h"

//如果你自定义的类，还要支持categoryView嵌套pagingView，你自己把JXPagerListContainerScrollView类的里面的gestureRecognizerShouldBegin方法复制过来即可。
@implementation YYBBFullScreenGestureScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//详情参考：https://github.com/forkingdog/FDFullscreenPopGesture#view-controller-with-scrollview
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.contentOffset.x <= 0) {
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
            return YES;
        }
    }
    return NO;
}

@end
