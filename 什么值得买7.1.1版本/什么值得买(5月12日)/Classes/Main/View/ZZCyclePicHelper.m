//
//  CDCommunityHelper.m
//  BusOnline
//
//  Created by HuangKai on 16/8/3.
//  Copyright © 2016年 Goome. All rights reserved.
//

#import "ZZCyclePicHelper.h"

@implementation ZZCyclePicHelper

+ (YYWebImageManager *)avatarImageManager {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"ZZSMZDM.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^(UIImage *image, NSURL *url) {
            if (!image) return image;
            return [image imageByRoundCornerRadius:100]; // a large value
        };
    });
    return manager;
}

+ (YYWebImageManager *)normalImageManager {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"ZZSMZDM.normal"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
            if (!image) {
                return image;
            }
            return [image imageByRoundCornerRadius:20];
        };
    });
    return manager;
}

@end
