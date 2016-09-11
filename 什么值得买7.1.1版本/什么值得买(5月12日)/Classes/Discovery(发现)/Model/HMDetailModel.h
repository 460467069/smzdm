//
//  HMDetailModel.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMProductFocusPicUrl, HMArticleAuthorInfo;

@interface HMDetailModel : NSObject

@property (nonatomic, strong) NSArray <HMProductFocusPicUrl *> *article_product_focus_pic_url;
@property (nonatomic, strong) NSArray <HMArticleAuthorInfo *> *article_bl_author_info;

@property (nonatomic, copy) NSString *article_comment;
@property (nonatomic, copy) NSString *article_favorite;
@property (nonatomic, copy) NSString *article_worthy;
@property (nonatomic, copy) NSString *article_unworthy;
/** 京东全球购 */
@property (nonatomic, copy) NSString *article_mall;
@property (nonatomic, copy) NSString *article_format_date;
@property (nonatomic, copy) NSString *html5_content;
@property (nonatomic, copy) NSString *article_filter_content;
@property (nonatomic, copy) NSString *article_title;
@property (nonatomic, copy) NSString *article_link_name;
@property (nonatomic, copy) NSString *article_price;
@property (nonatomic, copy) NSString *article_pic;

/** 文章为原创时, 显示的作者昵称 */
@property (nonatomic, copy) NSString *article_referrals;
/** 文章为原创时, 显示的作者头像 */
@property (nonatomic, copy) NSString *article_avatar;
@end


@interface HMProductFocusPicUrl : NSObject
@property (nonatomic, copy) NSString *pic_id;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *is_focus;
@end

@interface HMArticleAuthorInfo : NSObject
@property (nonatomic, copy) NSString *head;
@property (nonatomic, copy) NSString *smzdm_id;
@property (nonatomic, copy) NSString *nick_name;
@end