//
//  ZZDetailModel.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZDetailModel.h"


@implementation ZZDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"article_product_focus_pic_url" : @"ZZProductFocusPicUrl",
             @"article_bl_author_info" : @"ZZArticleAuthorInfo"
             };
}

@end

@implementation ZZProductFocusPicUrl

@end

@implementation ZZArticleAuthorInfo

@end