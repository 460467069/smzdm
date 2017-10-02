//
//  ZZLittleBanner.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZRedirectData.h"

@interface ZZLittleBanner : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *flag;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) ZZRedirectData *redirectData;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *channel;


@end
