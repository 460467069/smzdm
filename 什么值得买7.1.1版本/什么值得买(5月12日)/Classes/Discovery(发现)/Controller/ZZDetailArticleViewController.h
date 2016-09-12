//
//  ZZDetailViewController.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/30.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMWorthyArticle.h"
#import "HMSecondBaseViewController.h"

@interface ZZDetailArticleViewController : HMSecondBaseViewController
@property (nonatomic, strong) HMWorthyArticle *article;
@property (nonatomic, assign) NSInteger channelID;
@property (nonatomic, copy) NSString *article_id;
@end
