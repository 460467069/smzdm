//
//  ZZYuanChuangCell.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/16.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZYuanChuangCell.h"
#import "ZZCyclePicHelper.h"

@interface ZZYuanChuangCell ()
@property (weak, nonatomic) IBOutlet UIImageView *themeIconView;    /**< 主题图片 */
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;       /**< 头像 */
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;        /**< 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;            /**< 时间 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;           /**< 主题 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;         /**< 内容 */
@property (weak, nonatomic) IBOutlet UILabel *markLabel;            /**< 标签 */
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;            /**< 回复 */
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;           /**< 点赞 */
@property (weak, nonatomic) IBOutlet UIButton *tagBtn;              /**< 图片标签 */
@property (weak, nonatomic) IBOutlet UIView *coverView;


@end

@implementation ZZYuanChuangCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setArticle:(ZZWorthyArticle *)article{
    _article = article;
    
    [self.themeIconView sd_setImageWithURL:[NSURL URLWithString:article.article_pic]];
    self.titleLabel.text = article.article_title;
    
    [self.avatarView setImageWithURL:[NSURL URLWithString:article.article_avatar] //profileImageURL
                         placeholder:[UIImage imageNamed:@"icon_profile_avatar_around"]
                             options:kNilOptions
                             manager:[ZZCyclePicHelper avatarImageManager] //< 圆角头像manager，内置圆角处理
                            progress:nil
                           transform:nil
                          completion:nil];
    
    if ([article.article_channel_id isEqualToString:@"14"]) {
        self.coverView.hidden = YES;
        self.contentLabel.text = article.article_brief;
        NSString *totalStr = [NSString stringWithFormat:@"共 %@ 篇", article.article_product_count];
        
        self.markLabel.text = [NSString stringWithFormat:@"%@ | %@", totalStr, article.article_format_date];
        self.avatarView.hidden = YES;
        self.replyBtn.hidden = YES;
        self.praiseBtn.hidden = YES;
    }else{
        self.coverView.hidden = NO;
        self.contentLabel.text = article.article_filter_content;
        self.nickNameLabel.text = article.article_referrals;
        self.timeLabel.text = article.article_format_date;
        self.markLabel.text = article.tag_category;
        
        self.replyBtn.hidden = NO;
        self.praiseBtn.hidden = NO;
        [self.replyBtn setTitle:article.article_comment forState:UIControlStateNormal];
        [self.praiseBtn setTitle:article.article_collection forState:UIControlStateNormal];
    }
    
    UIImage *tagImage;
    switch ([article.article_channel_id integerValue]) {
        case 1: //国内
            tagImage = [UIImage imageNamed:@"homePage_channelGuoNei"];
            break;
        case 5: //海淘
            tagImage = [UIImage imageNamed:@"homePage_channelHaiTao"];
            break;
        case 6: //资讯
            tagImage = [UIImage imageNamed:@"homePage_channelZiXun"];
            break;
        case 8: //众测
            tagImage = [UIImage imageNamed:@"homePage_channelZhongCe"];
            break;
        case 11: //原创
            tagImage = [UIImage imageNamed:@"homePage_channelYuanChuang"];
            break;
        case 14: //话题
            tagImage = [UIImage imageNamed:@"homePage_channelHuaTi"];
            break;
            
        default:
            break;
    }
    
    [self.tagBtn setImage:tagImage forState:UIControlStateNormal];
    
    

}


@end
