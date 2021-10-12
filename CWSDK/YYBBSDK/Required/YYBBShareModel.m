//
//  YYBBShareModel.m
//  YYBBSDK
//
//  Created by Kris Liu on 9/23/17.
//  Copyright © 2017 Wang_ruzhou. All rights reserved.
//

#import "YYBBShareModel.h"

@implementation YYBBShareModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
        @"shareIcon" : @"share_icon",
        @"shareIconHighlighted" : @"share_icon_highlighted",
    };
}

@end
