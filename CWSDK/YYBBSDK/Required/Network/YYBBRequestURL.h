//
//  YYBB_RequestURL.h
//  YYBBSDK
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#ifndef YYBBRequestURL_h
#define YYBBRequestURL_h

#pragma mark - User

// 获取用户id
static NSString * const kUserLogin                      = @"/log/user_device";
// 保存用户信息
static NSString * const kSaveProfile                    = @"/user/save_profile";
// 退出登录
static NSString * const kLogout                         = @"/user/buyer/logout/%@";
// 获取用户信息
static NSString * const kGetUserInfo                    = @"/user/get_user_info";
// 兴趣标签
static NSString * const kGetUserGetTags                 = @"/user/getTags";
// 保存用户兴趣标签
static NSString * const kSaveUserGetTags                = @"/user/saveTags";
// 图片
static NSString * const kUserPhotos                     = @"/user/view_photos";
// 视频
static NSString * const kUserVideo                      = @"/user/userVideo";
// 获取关注数量
static NSString * const kUserFollowCount                = @"/user/getFollowCount";
// 查找用户
static NSString * const kUserSearch                     = @"/user/search";
// 好友列表
static NSString * const kUserFriends                    = @"/user/get_friends";
// 关注某人
static NSString * const kUserFollow                     = @"/user/follow";
// 取消关注某人
static NSString * const kUserUnfollow                   = @"/user/unfollow";
// 用户充值流水
static NSString * const kUserIncomeRecords              = @"/user/get_income";
// 查看对方数据
static NSString * const kUserViewHome                   = @"/user/view_home";
// 卡片数据
static NSString * const kUserCards                      = @"/user/getCards";
// 用户关系操作（好友、拉黑、备注）
static NSString * const kUserRelation                   = @"/user/relation";
// 获取当前在线主播
static NSString * const kUserGetOnlineAnchor            = @"/user/getOnlineAnchor";
// 点赞
static NSString * const kUserLike                       = @"/user/like";


#pragma mark - moment
// 发布朋友圈
static NSString * const kMomentPost                     = @"/moment/post";
// 朋友圈点赞/取消点赞
static NSString * const kUserMomentLike                 = @"/moment/like";
// 发布朋友圈评论
static NSString * const kMomentComment                  = @"/moment/comment";
// 朋友圈给评论点赞/取消点赞
static NSString * const kMomentLikeComment              = @"/moment/likeComment";
// 首页moment
static NSString * const kHomeMoment                     = @"/moment/getMoment";
// 获取朋友圈评论
static NSString * const kMomentGetComment               = @"/moment/getComment";
// 获取自己审核中朋友圈数据
static NSString * const kMomentGetUnderReview           = @"/moment/getUnderReview";


#pragma mark - video
// 评论
static NSString * const kUserComment                    = @"/video/getComment";
// 打电话记录
static NSString * const kUserVideoCallRecords           = @"/video/callRecord";
// 发起视频呼叫
static NSString * const kUserVideoCall                  = @"/video/call";
// 随机匹配视频
static NSString * const kUserVideoRandomMatch           = @"/video/match";
// 视频标签
static NSString * const kVideoTag                       = @"/video/tag";
// 通话视频评论
static NSString * const kVideoComment                   = @"/video/comment";
// 视频评分
static NSString * const kVideoScore                     = @"/video/videoScore";

// 首页热门数据
static NSString * const kHomeHot                        = @"/home/hot";

#pragma mark - Gift
// 聊天礼物
static NSString * const kGiftList                       = @"/gift/list";
// chatGift
static NSString * const kChatGift                       = @"/gift/chatGift";
// 发送礼物
static NSString * const kChatGiftSend                   = @"/gift/send";

#pragma mark - fee
// 充值相关
static NSString * const kRechargeInfo                   = @"/fee/fee_type";


#pragma mark - Tool
// 从服务器获取相关配置
static NSString * const kServerToolConfig               = @"/tool/config";
// 上传图片/音频
static NSString * const kToolUploadPhotos               = @"/tool/upload_photos";
// 获取聊天主题
static NSString * const kToolChatTopic                  = @"/tool/getTopic";
// 获取声网rtc token
static NSString * const kToolGetAgroaRtcToken           = @"/tool/get_agora_rtc_token";
// 举报
static NSString * const kToolReport                     = @"/tool/report";


#pragma mark - log
static NSString * const kLogFeedback                    = @"/log/feedback";
// log发送消息日志
static NSString * const kLogChat                        = @"/log/chat";
// adjust原始数据
static NSString * const kLogAdjustData                  = @"/log/adjustData";

#pragma mark - statistic
// 在线人数
static NSString * const kTotalOnline                    = @"/statistic/total_online";

#pragma mark - pay
// 生成支付单
static NSString * const kPayCreateOrder                 = @"/pay/create";
// 支付校验
static NSString * const kPayValidate                    = @"/pay.apple_pay/notice";


#pragma mark - anchor
// 主播信息
static NSString * const kAnchorInfo                     = @"/anchor/anchorInfo";
// 主播今日收入
static NSString * const kAnchorToday                    = @"/anchor/today";
// 主播今日收入2
static NSString * const kAnchorToday2                   = @"/anchor/today2";
// 主播所有统计
static NSString * const kAnchorStats                    = @"/anchor/stats";
// 主播每日收益
static NSString * const kAnchorStatsList                = @"/anchor/statsList";
// 主播每天收益列表
static NSString * const kAnchorStatsListNew             = @"/anchor/statsListNew";
// 主播切换工作模式，进入队列
static NSString * const kAnchorWorkPattern              = @"/anchor/workPattern";
// 判断是否可以进入工作模式
static NSString * const kAnchorWorkPagePre              = @"/anchor/workPagePre";
//  开启、关闭工作页面，统计在工作页面时间
static NSString * const kAnchorWorkPage                 = @"/anchor/workPage";
// 在工作页面的时间
static NSString * const kAnchorWorkPageTimes            = @"/anchor/workPageTimes";
// 主播金豆提现信息
static NSString * const kAnchorWithdrawInfo             = @"/anchor/withdrawInfo";
// 主播金豆提现申请
static NSString * const kAnchorWithdrawApply            = @"/anchor/withdrawApply";
// 主播金豆提现记录
static NSString * const kAnchorWithdrawHistory          = @"/anchor/withdrawHistory";

#endif /* YYBBRequestURL_h */
