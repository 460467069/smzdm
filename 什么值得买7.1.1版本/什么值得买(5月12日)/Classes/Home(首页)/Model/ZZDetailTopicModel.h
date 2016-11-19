//
//  ZZDetailTopicModel.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZZCommentPicList;
@interface ZZDetailTopicModel : NSObject

@property (nonatomic, copy) NSString *is_delete;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *pro_id;

@property (nonatomic, copy) NSString *report_num;
/** 用户名 */
@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *origin_type;

@property (nonatomic, copy) NSString *topic_ids;

@property (nonatomic, copy) NSString *advantage_content;

@property (nonatomic, copy) NSString *is_access;

@property (nonatomic, copy) NSString *pro_collect_count;

@property (nonatomic, copy) NSString *custom_support;
/** 副标题 */
@property (nonatomic, copy) NSString *summary_content;
/** 星星数 ★ */
@property (nonatomic, assign) NSInteger pro_score;

@property (nonatomic, copy) NSString *is_pro_creator;

@property (nonatomic, copy) NSString *hash_comment_id;

@property (nonatomic, copy) NSString *custom_tread;
/** 主标题  */
@property (nonatomic, copy) NSString *pro_name;

@property (nonatomic, copy) NSString *hash_id;

@property (nonatomic, copy) NSString *topic_title;
/** 评论数 */
@property (nonatomic, copy) NSString *review_num;

@property (nonatomic, copy) NSString *comment_pic_count;
/*
 使用时长
     0. 没用过
     1. 短暂体验
     2. 1-3个月
     3. 3个月-1年
 */
@property (nonatomic, copy) NSString *use_time;
/** 用户头像 */
@property (nonatomic, copy) NSString *user_pic;
/** 推荐原因 */
@property (nonatomic, copy) NSString *reason_content;
/** 发表时间 */
@property (nonatomic, copy) NSString *publish_date;
/** 点赞数 */
@property (nonatomic, copy) NSString *support_num;

@property (nonatomic, copy) NSString *pro_recommend_count;

@property (nonatomic, copy) NSString *custom_sort;
/** 价格 19 */
@property (nonatomic, copy) NSString *pro_price;

@property (nonatomic, copy) NSString *pro_comment_count;

@property (nonatomic, copy) NSString *smzdm_user_id;

@property (nonatomic, copy) NSString *tread_num;

@property (nonatomic, copy) NSString *user_create_id;

@property (nonatomic, copy) NSString *is_jinghua;

@property (nonatomic, copy) NSString *topic_id;

@property (nonatomic, copy) NSString *pro_pic;

@property (nonatomic, copy) NSString *haowu_is_show;

@property (nonatomic, strong) NSArray<ZZCommentPicList *> *comment_pic_list;

@property (nonatomic, copy) NSString *disadvantage_content;

@property (nonatomic, copy) NSString *update_date;

@end
@interface ZZCommentPicList : NSObject

@property (nonatomic, copy) NSString *is_topimg;

@property (nonatomic, copy) NSString *pic_url;

@property (nonatomic, copy) NSString *pic_height;

@property (nonatomic, copy) NSString *pic_width;

@end

