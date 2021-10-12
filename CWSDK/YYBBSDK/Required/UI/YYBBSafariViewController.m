//
//  YYBBSafariViewController.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 10/24/18.
//

#import "YYBBSafariViewController.h"

@interface YYBBSafariViewController ()<SFSafariViewControllerDelegate>

@end

@implementation YYBBSafariViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    if (@available(iOS 11.0, *)) {
        self.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleClose;
    } else {
        
    }
}



@end
