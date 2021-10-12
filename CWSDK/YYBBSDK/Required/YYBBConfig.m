//
//  YYBBConfig.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/9/10.
//

#import "YYBBConfig.h"
#import "YYBBSDK.h"

@implementation YYBBURL

@end

@implementation YYBBConfig

+ (instancetype)currentConfig {
    return [YYBBSDK sharedInstance].config;
}

@end
