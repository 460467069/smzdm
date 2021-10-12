//
//  CDCommunityHelper.h
//  BusOnline
//
//  Created by HuangKai on 16/8/3.
//  Copyright © 2016年 Goome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYWebImage/YYWebImage.h>

@interface ZZCyclePicHelper : NSObject
// 圆角头像的 manager
+ (YYWebImageManager *)avatarImageManager;
// 普通图片的 manager
+ (YYWebImageManager *)normalImageManager;

@end
