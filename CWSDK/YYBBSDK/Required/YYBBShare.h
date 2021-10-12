//
//  YYBBSDK.h
//  YYBBSDK
//
//  Created by Wang_ruzhou on 15-1-21.
//  Copyright (c) 2015年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYBBPlugin.h"

@class YYBBShareInfo;
//分享接口
@protocol YYBBShare<NSObject>

@optional;
- (NSArray *)supportPlatforms;
- (void)share:(YYBBShareInfo*)shareInfo;
- (void)share:(YYBBShareInfo*)shareInfo sourceView:(UIView *)sourceView;
- (void)shareTo:(NSString*)platform shareParams:(YYBBShareInfo*)shareInfo;
- (void)invite;
- (void)like;

@end


@interface YYBBShareInfo : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *actionUrl;
@property (copy, nonatomic) NSString *imgUrl;

@end
