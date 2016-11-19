//
//  ZZLittleBannerCell.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZLittleBanner.h"
#import "ZZTitleBannelOption.h"

@interface ZZLittleBannerCell : UICollectionViewCell
@property (nonatomic, strong) ZZLittleBanner *littleBanner;
@property (nonatomic, strong) ZZTitleBannelOption *littleBannerOptions;
@end
