//
//  HMRows.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMRedirectData.h"


@interface HMHeadLine : NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, strong) HMRedirectData *redirectdata;
@end
