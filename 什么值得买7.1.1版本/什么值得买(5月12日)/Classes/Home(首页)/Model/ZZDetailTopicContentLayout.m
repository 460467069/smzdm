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
    container.truncationType = YYTextTruncationTypeEnd;
    _userInfoLayout = [YYTextLayout layoutWithContainer:container text:userInfo];
    
    _starLayout = [self starLayoutWithCount:_detailTopicModel.pro_score];

    
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
        [attributes setObject:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName];
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
    CGFloat titleWidth = kScreenW - kDetailTopicProPicWH - kDetailTopicMarginX * 2 - kDetailTopicContentOffsetX;
    container = [YYTextContainer containerWithSize:CGSizeMake(titleWidth, kDetailTopicProPicWH) insets:UIEdgeInsetsMake(0, kDetailTopicTitleLeftMargin, 0, kDetailTopicContentOffsetX)];
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
    [descText setLineSpacing:15 range:NSMakeRange(0, 1)];
    container = [YYTextContainer containerWithSize:CGSizeMake(kDetailTopicDescWidth, kDetailTopicDescHeight) insets:UIEdgeInsetsMake(kDetailTopicDescTopMargin, kDetailTopicContentOffsetX, 0, kDetailTopicContentOffsetX)];
    container.truncationType = YYTextTruncationTypeEnd;
    _descriptionLayout = [YYTextLayout layoutWithContainer:container text:descText];
    
    if (_descriptionLayout.textBoundingSize.height > kDetailTopicDescHeight) {
        _descriptionHeight = _descriptionLayout.textBoundingSize.height;
    }else{
        _descriptionHeight = kDetailTopicDescHeight;
    }
    
    
    //用户上传图片数
    NSInteger picListCount = _detailTopicModel.comment_pic_list.count;
    if (picListCount) {
        _picCountLayout = [self layoutWithImage:[UIImage imageNamed:@"my_article_pinglun"] title:[NSString stringWithFormat:@" %@", @(picListCount)] alignment:YYTextVerticalAlignmentCenter];
    }
    //评论数
    _commentCountLayout = [self layoutWithImage:[UIImage imageNamed:@"my_article_pinglun"] title:[NSString stringWithFormat:@" %@", _detailTopicModel.review_num] alignment:YYTextVerticalAlignmentCenter];
    

    NSMutableAttributedString *useTime = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:12];
    {   //使用时长
        NSString *title = [NSString stringWithFormat:@"使用时长: %@", _detailTopicModel.use_time];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalGrayColor forKey:NSForegroundColorAttributeName];
        [useTime appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
    }
    
    useTime.font = font;
    container = [YYTextContainer containerWithSize:CGSizeMake(kDetailTopicUseTimeWidth, kDetailTopicUseTimeHeight) insets:UIEdgeInsetsMake(kDetailTopicUseTimeY, 0, kDetailTopicUseTimeY, 0)];
    _useTimeLayout = [YYTextLayout layoutWithContainer:container text:useTime];
    
    _supportLayout = [self layoutWithImage:[UIImage imageNamed:@"ico_zan"] title:[NSString stringWithFormat:@" %@", _detailTopicModel.support_num] alignment:YYTextVerticalAlignmentBottom];
}

- (void)caculateHeight{
    
    _height = 0;
    _height += kDetailTopicContentOffsetY;
    _height += kDetailTopicUserInfoHeight;
    _height += kDetailTopicProPicWH;
    _height += _descriptionHeight;
    _height += kDetailTopicUseTimeHeight;
    _height += kDetailTopicMarginY;
    
}

-(YYTextLayout *)layoutWithImage:(UIImage *)image title:(NSString *)title alignment:(YYTextVerticalAlignment)alignment{
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:12];
    {
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:alignment];
        [text appendAttributedString:attachText];
    }
    
    {
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalGrayColor forKey:NSForegroundColorAttributeName];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
    }

    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kDetailTopicSmallBtnWidth, kDetailTopicUseTimeHeight)];
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:text];
    
    return textLayout;
}


- (YYTextLayout *)starLayoutWithCount:(NSInteger)count{
    
    if (count == 0) {
        return nil;
    }
    

    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    [self attributedString:text appendStarImage:[UIImage imageNamed:@"star_red"] starCount:count];
    [self attributedString:text appendStarImage:[UIImage imageNamed:@"star_gray"] starCount:kDetailTopicTotalStars - count];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kDetailTopicStarLabelWidth, kDetailTopicUserInfoHeight)];
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:text];
    
    return textLayout;
}

- (void)attributedString:(NSMutableAttributedString *)text appendStarImage:(UIImage *)starImage starCount:(NSInteger)starcount{

    UIFont *font = [UIFont systemFontOfSize:12];
    for (NSInteger i = 0; i < starcount; i++) {
        {
            NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:starImage contentMode:UIViewContentModeCenter attachmentSize:starImage.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [text appendAttributedString:attachText];
        }
        {
            CALayer *whiteLayer = [CALayer layer];
            whiteLayer.backgroundColor = [UIColor whiteColor].CGColor;
            NSMutableAttributedString *marginText = [NSMutableAttributedString attachmentStringWithContent:whiteLayer contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(kDetailTopicStarMargin, kDetailTopicStarHeight) alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [text appendAttributedString:marginText];
        }
    }
    
}
@end
