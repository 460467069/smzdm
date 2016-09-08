//
//  HMContentViewController.h
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMHomeChannel.h"

typedef void(^HMContentViewControllerBlock)(CGFloat);

@interface HMContentViewController : UITableViewController

/** HMHomeChannel */
@property (nonatomic, strong) HMHomeChannel *homeChannel;

/** <##> */
@property (nonatomic, copy) HMContentViewControllerBlock offsetBlock;

@end
