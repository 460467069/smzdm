//
//  HMHomeChannel.h
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMHomeChannel : NSObject

/** 频道名称 */
@property (nonatomic, copy) NSString *title;
/** URl(tableView数据)要拼接的 */
@property (nonatomic, copy) NSString *URLString;
/** 头部数据请求字段 */
@property (nonatomic, copy) NSString *type;
/** URl(tableView头部数据)要拼接的 */
@property (nonatomic, copy) NSString *headerURLString;


+ (NSArray *)homeChannels;

@end
