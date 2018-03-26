//
//  ZZLittleBannerLayout.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/2.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZLittleBannerLayout.h"

@implementation ZZLittleBannerLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumLineSpacing = kLitterBannerViewInset;
        self.minimumInteritemSpacing = kMinimumInteritemSpacing;
        
    }
    return self;
}

- (void)prepareLayout{
    [super prepareLayout];
    NSInteger count = kLimitCount;
    CGFloat itemWidth = (self.collectionView.width -  self.collectionView.contentInset.left - self.collectionView.contentInset.right - (count - 1) * kMinimumInteritemSpacing) / count;
    
    self.itemSize = CGSizeMake(itemWidth, kItemHeight);
}


@end
