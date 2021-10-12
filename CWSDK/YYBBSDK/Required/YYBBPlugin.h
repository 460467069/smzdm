//
//  YYBBSDK.h
//  YYBBSDK
//
//  Created by Wang_ruzhou on 15-1-21.
//  Copyright (c) 2015年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYBBConfig.h"

// YYBBPlugin 插件接口
@protocol YYBBPluginProtocol <UIApplicationDelegate>

@optional

- (BOOL)isInitCompleted;
- (void)yybb_applicationDidFinishLaunching:(UIApplication *)application;
- (BOOL)yybb_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end

@interface YYBBPlugin : NSObject<YYBBPluginProtocol>

@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) UIViewController *originalController;

-(UIView*) view;
-(UIViewController*) viewController;
-(YYBBConfig *)yybb_config;

-(id) getInterface:(Protocol *)aProtocol;

-(void) eventPlatformInit:(NSDictionary*) params;
-(void) eventUserLogin:(NSDictionary*) params;
-(void) eventUserLoginResult:(NSDictionary*) params;
-(void) eventUserLoginExt:(id) extension;
-(void) eventAddedToCart:(NSDictionary*) params;
-(void) eventPayPaid:(NSDictionary*) params;
-(void) eventCustom:(NSString*)name params:(NSDictionary*)params;

@end

