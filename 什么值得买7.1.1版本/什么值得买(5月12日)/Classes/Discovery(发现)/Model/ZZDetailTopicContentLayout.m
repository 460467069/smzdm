//
//  ZZDetailTopicContentLayout.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZDetailTopicContentLayout.h"

@implementation ZZDetailTopicContentLayout


- (instancetype)initWithContentDetailModel:(ZZDetailTopicModel *)detailTopicModel {
    if (!detailTopicModel) {
        return nil;
    }
    
    if (self = [super init]) {
        _detailTopicModel = detailTopicModel;
        [self layout];
        [self caculateHeight];
    }
    return self;
}


- (void)layout {
    _avatarViewHeight = 70;
    
    NSMutableAttributedString *userInfo = [NSMutableAttributedString new];
    {
        NSString *title = _detailTopicModel.user_name;
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
        [userInfo appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
    }
    {
        NSString *title = [NSString stringWithFormat:@" 于%@", _detailTopicModel.publish_date];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:[UIColor lightGrayColor] forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
        [userInfo appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
    }
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kDetailTopicUserInfoWidth, 30) insets:UIEdgeInsetsMake(kDetailTopicUserInfoMarginY, kDetailTopicUserInfoMarginX, kDetailTopicUserInfoMarginY, kDetailTopicUserInfoMarginX)];
    _userInfoLayout = [YYTextLayout layoutWithContainer:container text:userInfo];
    _userInfoHeight = _userInfoLayout.textBoundingSize.height;
    
    NSMutableAttributedString *articleTitle = [NSMutableAttributedString new];
    {
        NSString *title = [NSString stringWithFormat:@"%@", _detailTopicModel.pro_name];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalGrayColor forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
        [articleTitle appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
        [articleTitle appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    
    {
        NSString *title = @"￥";
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalRedColor forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
        [articleTitle appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
    }
    
    {
        NSString *title = [NSString stringWithFormat:@"%@", _detailTopicModel.pro_price];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalRedColor forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
        [articleTitle appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
    }
    
    {
        NSString *title = @"起";
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalRedColor forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
        [articleTitle appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
    }
    articleTitle.lineSpacing = 5;
    container = [YYTextContainer containerWithSize:CGSizeMake(kDetailTopicProPicWH, kDetailTopicProPicWH) insets:UIEdgeInsetsMake(0, kDetailTopicTitleLeftMargin, 0, kDetailTopicContentOffsetX)];
    _titleLayout = [YYTextLayout layoutWithContainer:container text:articleTitle];
    
    NSMutableAttributedString *descText = [NSMutableAttributedString new];
    {
        NSString *title = [NSString stringWithFormat:@"%@", _detailTopicModel.summary_content];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalGrayColor forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName];
        [descText appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
        [descText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    
    {
        NSString *title = [NSString stringWithFormat:@"%@", _detailTopicModel.reason_content];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalGrayColor forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
        [descText appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
    }
    descText.lineSpacing = 10;
    container = [YYTextContainer containerWithSize:CGSizeMake(kDetailTopicDescWidth, kDetailTopicDescHeight) insets:UIEdgeInsetsMake(kDetailTopicDescTopMargin, kDetailTopicContentOffsetX, 0, kDetailTopicContentOffsetX)];
    _descriptionLayout = [YYTextLayout layoutWithContainer:container text:descText];
    _descriptionHeight = _titleLayout.textBoundingSize.height;
    
    //用户上传图片数
    NSInteger picListCount = _detailTopicModel.comment_pic_list.count;
    if (picListCount) {
        _commentCountLayout = [self layoutWithImage:[UIImage imageNamed:@"my_article_pinglun"] title:[NSString stringWithFormat:@"%@", @(picListCount)]];
    }
    //评论数
    _picCountLayout = [self layoutWithImage:[UIImage imageNamed:@"my_article_pinglun"] title:_detailTopicModel.review_num];
    

    NSMutableAttributedString *useTime = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:12];
    {   //使用时长
        NSString *title = [NSString stringWithFormat:@"使用时长: %@", _detailTopicModel.use_time];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalGrayColor forKey:NSForegroundColorAttributeName];
        [useTime appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
    }
    
    useTime.font = font;
    container = [YYTextContainer containerWithSize:CGSizeMake(120, 100)];
    _useTimeLayout = [YYTextLayout layoutWithContainer:container text:useTime];
    _useTimeHeight = _useTimeLayout.textBoundingRect.size.height;
    
}

- (void)caculateHeight{
    
    _height = 0;
    _height += kDetailTopicContentOffsetY;
    _height += _userInfoHeight;
    _height += kDetailTopicProPicWH;
    _height += kDetailTopicDescTopMargin;
    _height += _descriptionHeight;
    _height += kDetailTopicUseTimeY;
    _height += _useTimeHeight;
    _height += kDetailTopicUseTimeY;
    
}

-(YYTextLayout *)layoutWithImage:(UIImage *)image title:(NSString *)title{
    NSMutableAttributedString *extraInfo = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:12];
    NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    [extraInfo appendAttributedString:attachText];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:kGlobalGrayColor forKey:NSForegroundColorAttributeName];
    [extraInfo appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(50, 30)];
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:extraInfo];
    
    return textLayout;
}

@end
