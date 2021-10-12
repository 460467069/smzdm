//
//  UIView+YYBBAdd.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 5/5/19.
//

#import "WKWebView+YYBBAdd.h"

@implementation WKWebView (YYBBAdd)

- (void)yybb_setScrollEnabled:(BOOL)enabled {
    self.scrollView.scrollEnabled = enabled;
    self.scrollView.panGestureRecognizer.enabled = enabled;
    self.scrollView.bounces = enabled;

    // There is one subview as of iOS 8.1 of class WKScrollView
    for (UIView* subview in self.subviews) {
        if ([subview respondsToSelector:@selector(setScrollEnabled:)]) {
            [(id)subview setScrollEnabled:enabled];
        }

        if ([subview respondsToSelector:@selector(setBounces:)]) {
            [(id)subview setBounces:enabled];
        }

        if ([subview respondsToSelector:@selector(panGestureRecognizer)]) {
            [[(id)subview panGestureRecognizer] setEnabled:enabled];
        }

        // here comes the tricky part, desabling
        for (UIView* subScrollView in subview.subviews) {
            if ([subScrollView isKindOfClass:NSClassFromString(@"WKContentView")]) {
                for (id gesture in [subScrollView gestureRecognizers]) {
                    if ([gesture isKindOfClass:NSClassFromString(@"UIWebTouchEventsGestureRecognizer")])
                        [subScrollView removeGestureRecognizer:gesture];
                }
            }
        }
    }

}

@end
