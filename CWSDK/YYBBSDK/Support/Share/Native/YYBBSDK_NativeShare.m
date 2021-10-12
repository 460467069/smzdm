//
//  YYBBSDK_NativeShare.m
//  YYBBSDKDemo
//
//  Created by Wang_Ruzhou on 2019/5/14.
//  Copyright © 2019年 Wang_Ruzhou. All rights reserved.
//

#import "YYBBSDK_NativeShare.h"
#import "NSArray+YYBBAdd.h"
#import "UIViewController+YYBBAdd.h"

@implementation YYBBSDK_NativeShare

- (void)yybb_applicationDidFinishLaunching:(UIApplication *)application {
    
}

- (void)share:(YYBBShareInfo *)shareInfo sourceView:(UIView *)sourceView {
    // 文字+图片+链接
    NSMutableArray *activityItems = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:shareInfo.actionUrl];
    UIImage *image = [UIImage imageNamed:shareInfo.imgUrl];
    [activityItems addObjectSafe:shareInfo.title];
    [activityItems addObjectSafe:url];
    [activityItems addObjectSafe:image];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    NSMutableArray *excludedActivityTypes = [NSMutableArray arrayWithArray:@[UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList, UIActivityTypeAirDrop, UIActivityTypeOpenInIBooks]];
    if (@available(iOS 11.0, *)) {
        [excludedActivityTypes addObject:UIActivityTypeMarkupAsPDF];
    }
    activityViewController.excludedActivityTypes = excludedActivityTypes.copy;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *popoverPresentationController = activityViewController.popoverPresentationController;
        popoverPresentationController.sourceView = sourceView;
        popoverPresentationController.sourceRect = sourceView.bounds;
        popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    
    [[UIViewController currentViewController] presentViewController:activityViewController animated:YES completion:nil];
}

@end
