//
//  ZZProductModel.h
//  什么值得买(5月7日)
//
//  Created by Wang_ruzhou on 16/5/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "ZZRedirectData.h"
#import "ZZEnums.h"
#import "ZZLittleBanner.h"

@interface ZZWorthyArticle : NSObject
/** 5 */
@property (nonatomic, assign) NSInteger article_channel_id;
/** 海淘 */
@property (nonatomic, copy, nullable) NSString *article_channel_name;
/** 5 */
@property (nonatomic, copy, nullable) NSString *article_type_id;
/** 生活记录对应的type是4 */
@property (nonatomic, copy, nullable) NSString *article_type_name;
/** 6330508 */
@property (nonatomic, copy, nullable) NSString *article_id;
/** http://haitao.smzdm.com/p/6330508 */
@property (nonatomic, copy, nullable) NSString *article_url;
/** ASICS 亚瑟士 Oc Runner 亚瑟士休闲跑鞋 */
@property (nonatomic, copy, nullable) NSString *article_title;
/** £20+£9.41含税直邮 */
@property (nonatomic, copy, nullable) NSString *article_price;
/** 2016-08-15 23:20:12 */
@property (nonatomic, copy, nullable) NSString *article_date;
/** 08-15 */
@property (nonatomic, copy, nullable) NSString *article_format_date;
/** false */
@property (nonatomic, assign) BOOL article_anonymous;
/** 图片地址 */
@property (nonatomic, copy, nullable) NSString *article_pic;
/** 值 */
@property (nonatomic, copy, nullable) NSString *article_worthy;
/** 不值 */
@property (nonatomic, copy, nullable) NSString *article_unworthy;
/** 赞数 */
@property (nonatomic, copy, nullable) NSString *article_favorite;
/** 是否卖出? */
@property (nonatomic, assign, nullable) NSString *article_is_sold_out;
/** 是否超时 */
@property (nonatomic, copy, nullable) NSString *article_is_timeout;
/** article_collection */
@property (nonatomic, copy, nullable) NSString *article_collection;
/** 评论 */
@property (nonatomic, copy, nullable) NSString *article_comment;
/** 英国亚马逊 */
@property (nonatomic, copy, nullable) NSString *article_mall;
/** article_top 1为置顶 */
@property (nonatomic, copy, nullable) NSString *article_top;
/** article_tag */
@property (nonatomic, copy, nullable) NSString *article_tag;
/** 是否推广 */
@property (nonatomic, assign) ZDMPromotionType promotion_type;
/** article_district */
@property (nonatomic, copy, nullable) NSString *article_district;
/** 为"资讯" 等 的时候取这个字段 */
@property (nonatomic, copy, nullable) NSString *article_rzlx;

/** ---------------------暂时返现白菜特有的3个字段--------------------- */
@property (nonatomic, copy, nullable) NSString *article_status_name;
@property (nonatomic, copy, nullable) NSString *sync_home;
/** 子标题 */
@property (nonatomic, copy, nullable) NSString *subtitle;

/** time_sort 上拉加载更多时需要此参数 */
@property (nonatomic, copy, nullable) NSString *time_sort;


@property (nonatomic, strong, nullable) ZZRedirectData *redirect_data;

//原创独有? (发现资讯里边也有)

/** article_region_title */
@property (nonatomic, copy, nullable) NSString *article_region_title;
/** probreport_id */
@property (nonatomic, copy, nullable) NSString *probreport_id;
/** 总评? */
@property (nonatomic, copy, nullable) NSString *sum_collect_comment;
/** 昵称 */
@property (nonatomic, copy, nullable) NSString *article_referrals;
/** 头像 */
@property (nonatomic, copy, nullable) NSString *article_avatar;
/** user_smzdm_id */
@property (nonatomic, copy, nullable) NSString *user_smzdm_id;
/** article_filter_content */
@property (nonatomic, copy, nullable) NSString *article_filter_content;
/** article_type */
@property (nonatomic, copy, nullable) NSString *article_type; //4
/** article_recommend */
@property (nonatomic, copy, nullable) NSString *article_recommend;
/** article_love_count */
@property (nonatomic, copy, nullable) NSString *article_love_count;
/** page_timesort */
@property (nonatomic, copy, nullable) NSString *page_timesort;
/** 分享文字 */
@property (nonatomic, copy, nullable) NSString *share_title;
/** share_title_other */
@property (nonatomic, copy, nullable) NSString *share_title_other;
/** share_pic_title */
@property (nonatomic, copy, nullable) NSString *share_pic_title;
/** 分享图片? */
@property (nonatomic, copy, nullable) NSString *share_pic;
/** b_share_title */
@property (nonatomic, copy, nullable) NSString *b_share_title;
/** share_title_separate */
@property (nonatomic, copy, nullable) NSString *share_title_separate;
/** share_reward */
@property (nonatomic, copy, nullable) NSString *share_reward;
/** #宠狗 */
@property (nonatomic, copy, nullable) NSString *tag_name;
/** #宠物家居日用 */
@property (nonatomic, copy, nullable) NSString *category_name;
/** #宠物 #宠物家居日用  */
@property (nonatomic, copy, nullable) NSString *tag_category;

//推广特有?
@property (nonatomic, copy, nullable) NSString *title;
/** 如:推广 */
@property (nonatomic, copy, nullable) NSString *tag;
/** 图片 */
@property (nonatomic, copy, nullable) NSString *img;
@property (nonatomic, copy, nullable) NSString *link;
@property (nonatomic, copy, nullable) NSString *channel;

//话题特有?
/** 开始时间 */
@property (nonatomic, copy, nullable) NSString *article_start_date;
/** 结束时间 */
@property (nonatomic, copy, nullable) NSString *article_end_date;
/** 简介 */
@property (nonatomic, copy, nullable) NSString *article_brief;
/** 总共篇数 */
@property (nonatomic, copy, nullable) NSString *article_product_count;

//promotion_type为3的字段
@property (nonatomic, copy, nullable) NSString *vice_title;
@property (nonatomic, copy, nullable) NSString *position;
@property (nonatomic, assign) BOOL is_show_tag;
@property (nonatomic, copy, nullable) NSString *cell_type;
//promotion_type为8的字段
@property (nonatomic, strong, nullable) NSArray<ZZLittleBanner *> *rows;
@end


