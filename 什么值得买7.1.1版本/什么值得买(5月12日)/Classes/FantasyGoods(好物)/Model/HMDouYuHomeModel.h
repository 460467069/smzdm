//
//  HMDouYuHomeModel.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/7/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMDouYURoom_List;
@interface HMDouYuHomeModel : NSObject

@property (nonatomic, assign) NSInteger tag_id;

@property (nonatomic, copy) NSString *tag_name;

@property (nonatomic, copy) NSString *icon_url;

@property (nonatomic, copy) NSString *push_vertical_screen;

@property (nonatomic, strong) NSArray<HMDouYURoom_List *> *room_list;

@end
@interface HMDouYURoom_List : NSObject

@property (nonatomic, copy) NSString *room_id;

@property (nonatomic, copy) NSString *subject;

@property (nonatomic, copy) NSString *vod_quality;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger online;

@property (nonatomic, copy) NSString *room_name;

@property (nonatomic, copy) NSString *vertical_src;

@property (nonatomic, copy) NSString *show_time;

@property (nonatomic, copy) NSString *show_status;

@property (nonatomic, copy) NSString *specific_catalog;

@property (nonatomic, copy) NSString *game_name;

@property (nonatomic, copy) NSString *child_id;

@property (nonatomic, assign) NSInteger ranktype;

@property (nonatomic, copy) NSString *specific_status;

@property (nonatomic, copy) NSString *owner_uid;

@property (nonatomic, copy) NSString *room_src;

@property (nonatomic, assign) NSInteger isVertical;

@property (nonatomic, copy) NSString *cate_id;

@end

