//
//  ZDM_RequestURL.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#ifndef ZDM_RequestURL_h
#define ZDM_RequestURL_h

#define kBaseURL        @"https://api.smzdm.com"
#define kDeviceID       @"u2n7E7g8GN614PhgRRMTDF9mLo7nKcI/2MZzQ5N8TCijPn9NXBbmkw=="
#define kSMZDMID        @"7768066096"

static NSString * const kZDM_Platform = @"iphone";
static NSString * const kZDM_Vesion   = @"8.2";

/** 首页 */
static NSString * const kZDM_UtilBanner            = @"v2/util/banner";             /**< 广告, 及下面的九宫格 */
static NSString * const kZDM_Home_UtilFloor        = @"v1/util/floor";              /**< 值精选, 值友福利 */
static NSString * const kZDM_Home_EditorsRecommend = @"v1/util/editors_recommend";  /**< 编辑精选 */

/** 好价 */
static NSString * const kZDM_HaoJia_FaXian   = @"v1/faxian/articles";                       /**< 发现 */
static NSString * const kZDM_HaoJia_JingXuan = @"v1/home/articles";                         /**< 精选 */
static NSString * const kZDM_HaoJia_GuoNei   = @"v1/youhui/articles";                       /**< 国内 */
static NSString * const kZDM_HaoJia_HaiTao   = @"v1/haitao/articles";                       /**< 海淘 */

/** 好物 */
static NSString * const kZDM_HaoWu_Category  = @"v1/haowu/haowu_category";                  /**< 分类 */
static NSString * const kZDM_HaoWu_TopicList = @"v1/haowu/haowu_topic_list";                /**< 列表 */

/** 搜索 */
static NSString * const kZDM_Search_HotTags  = @"v2/filter/tags/hot_tags";                  /**< 热门标签 */
static NSString * const kZDM_Search          = @"v1/list";                                  /**< 搜索 */

/** 好文 */
static NSString * const kZDM_HaoWen          = @"v1/sns/home?";                            /**< 列表 */

#endif /* ZDM_RequestURL_h */
