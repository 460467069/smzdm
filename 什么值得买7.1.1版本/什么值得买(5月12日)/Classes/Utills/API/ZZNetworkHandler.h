//
//  ZZNetworkHandler.h
//  Fumen
//
//  Created by Wang_ruzhou on 15/11/21.
//  Copyright © 2015年 EIMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZNetworkHandler : NSObject

@property(nonatomic,assign)BOOL networkError;
/**
 * gets singleton object.
 * @return singleton
 */
+ (ZZNetworkHandler*)sharedInstance;

+ (void)startMonitoring;

@end
