//
//  HMDouYUBannerModel.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/7/14.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMDouYuRoom,HMDouYuCdnswithname;
@interface HMDouYUBannerModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *pic_url;

@property (nonatomic, copy) NSString *tv_pic_url;

@property (nonatomic, strong) HMDouYuRoom *room;

@end
@interface HMDouYuRoom : NSObject

@property (nonatomic, copy) NSString *specific_status;

@property (nonatomic, copy) NSString *credit_illegal;

@property (nonatomic, copy) NSString *vertical_src;

@property (nonatomic, strong) NSArray<HMDouYuCdnswithname *> *cdnsWithName;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *game_icon_url;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *room_src;

@property (nonatomic, copy) NSString *owner_avatar;

@property (nonatomic, assign) NSInteger is_pass_player;

@property (nonatomic, copy) NSString *cur_credit;

@property (nonatomic, assign) NSInteger isVertical;

@property (nonatomic, copy) NSString *room_name;

@property (nonatomic, copy) NSString *show_details;

@property (nonatomic, copy) NSString *specific_catalog;

@property (nonatomic, copy) NSString *is_white_list;

@property (nonatomic, copy) NSString *game_name;

@property (nonatomic, copy) NSString *low_credit;

@property (nonatomic, copy) NSString *show_time;

@property (nonatomic, copy) NSString *game_url;

@property (nonatomic, copy) NSString *show_status;

@property (nonatomic, copy) NSString *owner_weight;

@property (nonatomic, copy) NSString *fans;

@property (nonatomic, copy) NSString *room_id;

@property (nonatomic, copy) NSString *owner_uid;

@property (nonatomic, copy) NSString *vod_quality;

@property (nonatomic, assign) NSInteger online;

@property (nonatomic, copy) NSString *cate_id;

@end

@interface HMDouYuCdnswithname : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *cdn;

@end

