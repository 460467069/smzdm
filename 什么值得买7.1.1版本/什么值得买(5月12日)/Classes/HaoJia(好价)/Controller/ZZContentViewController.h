//
//  ZZContentViewController.h
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZHomeChannel.h"

typedef void(^ZZContentViewControllerBlock)(CGFloat);

@interface ZZContentViewController : UITableViewController

/** ZZHomeChannel */
@property (nonatomic, strong) ZZHomeChannel *homeChannel;

/** <##> */
@property (nonatomic, copy) ZZContentViewControllerBlock offsetBlock;

@end
