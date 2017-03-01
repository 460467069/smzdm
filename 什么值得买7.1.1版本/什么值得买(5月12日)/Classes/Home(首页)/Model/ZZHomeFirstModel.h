//
//  ZZHomeFirstModel.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZBaseRequest.h"

@interface ZZHomeFirstRequest : ZZBaseRequest
@property (nonatomic, copy) NSString *channel_id;
@end

@interface ZZHomeEditorRecommendRequest : ZZHomeFirstRequest
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *limit;
@property (nonatomic, copy) NSString *time_sort;
@property (nonatomic, copy) NSString *smzdm_id;
@property (nonatomic, copy) NSString *device_id;
@end

@class ZZFloorMulti,ZZRedirectData,ZZFloorYuanchuangMaster,ZZFloorSingle,ZZRedirectData;
@interface ZZHomeFirstModel : NSObject

@property (nonatomic, copy) NSString *floor_model_id;

@property (nonatomic, copy) NSString *floor_title;
/** 轮播 */
@property (nonatomic, strong) NSArray<ZZFloorMulti *> *floor_multi;
/** (水平滚动)原创 */
@property (nonatomic, strong) NSArray<ZZFloorYuanchuangMaster *> *floor_yuanchuang_master;

@property (nonatomic, copy) NSString *floor_title_color;
/** 四张混排的图片 */
@property (nonatomic, strong) NSArray<ZZFloorSingle *> *floor_single;

@property (nonatomic, copy) NSString *floor_head_pic_url;

@end
@interface ZZFloorMulti : NSObject

@property (nonatomic, strong) ZZRedirectData *redirect_data;

@property (nonatomic, copy) NSString *pic_url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *link;

@end


@interface ZZFloorYuanchuangMaster : NSObject

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *col;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *smzdm_id;

@property (nonatomic, copy) NSString *fans_num;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *zan_col;

@property (nonatomic, copy) NSString *follower_num;

@property (nonatomic, copy) NSString *zan;

@end

@interface ZZFloorSingle : NSObject

@property (nonatomic, strong) ZZRedirectData *redirect_data;

@property (nonatomic, copy) NSString *pic_url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *link;

@end

