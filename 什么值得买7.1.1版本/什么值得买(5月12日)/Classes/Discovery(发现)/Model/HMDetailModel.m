//
//  HMDetailModel.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDetailModel.h"


@implementation HMDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"article_product_focus_pic_url" : @"HMProductFocusPicUrl",
             @"article_bl_author_info" : @"HMArticleAuthorInfo"
             };
}

@end

@implementation HMProductFocusPicUrl

@end

@implementation HMArticleAuthorInfo

@end