//
//  YYBBPlugin.m
//  YYBBPlugin
//
//  Created by Wang_ruzhou on 15-8-8.
//  Copyright (c) 2015年 Wang_ruzhou. All rights reserved.
//

#import "YYBBPlugin.h"
#import "YYBBSDK.h"

@implementation YYBBPlugin
{
    NSMutableArray* interfaces;
}


-(UIView*) view
{
    return [[YYBBSDK sharedInstance] getView];
//    return [[YYBBSDK sharedInstance] delegate].yybb_currentView;
}

-(UIViewController*) viewController
{
    return [[YYBBSDK sharedInstance] getViewController];
//    return [[[YYBBSDK sharedInstance] delegate] yybb_currentViewController];
}

- (YYBBConfig *)yybb_config {
    return [[YYBBSDK sharedInstance] config];
}

-(id) getInterface:(Protocol *)aProtocol
{
    if ([self conformsToProtocol:aProtocol])
    {
        return self;
    }
    
    if (interfaces != nil)
    {
        for (id item in interfaces) {
            if ([item conformsToProtocol:aProtocol])
            {
                return item;
            }
        }
    }
    
    return nil;
}

-(void) registerInterface:(NSObject*)aInterface
{
    if (interfaces == nil)
    {
        interfaces = [NSMutableArray arrayWithObject:aInterface];
    }
    else
    {
        [interfaces addObject:aInterface];
    }
}

-(void) eventPlatformInit:(NSDictionary*) params
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YYBBSDKPlatformInit object:self userInfo:params];
}

-(void) eventUserLogin:(NSDictionary*) params
{
    [self eventUserLoginAll:@{ @"extension":params }];
}

-(void) eventUserLoginResult:(NSDictionary*) params
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YYBBSDKLoginResultEvent object:self userInfo:params];
}

-(void)eventUserLoginExt:(id)extension
{
    [self eventUserLoginAll:@{ @"extension":extension }];
}

-(void)eventUserLoginAll:(NSDictionary*)params
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YYBBSDKUserLogin object:self userInfo:params];
}

-(void) eventAddedToCart:(NSDictionary*) params
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YYBBSDKAddedToCart object:self userInfo:params];
}

-(void) eventPayPaid:(NSDictionary*) params
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YYBBSDKPayPaid object:self userInfo:params];
}

-(void) eventCustom:(NSString*)name params:(NSDictionary*)params
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YYBBSDKCustomEvent object:self userInfo:params];
}

@end
