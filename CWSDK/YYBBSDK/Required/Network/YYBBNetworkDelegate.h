//
//  YYBBMallDelegate.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 15-1-21.
//  Copyright (c) 2015年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol YYBBResponseDelegate <NSObject>
@property (copy, nonatomic, nullable) NSString *msg;
@end
