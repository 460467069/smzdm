//
//  ZZDetailHeaderView.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZDetailHeaderView.h"
#import "ZZCycleScrollView.h"
#import "ZZCyclePicHelper.h"

@interface ZZDetailHeaderView ()
@property (nonatomic, strong) SDCycleScrollView *scrollView;
@property (nonatomic, strong) YYLabel *headTitleLabel;
@property (nonatomic, strong) CALayer *bottomLineLayer;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) YYLabel *referralLabel;
@end

@implementation ZZDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenW;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[SDCycleScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor randomColor];
        _scrollView.width = self.width;
        _scrollView.autoScroll = NO;
        _scrollView.pageDotColor = kGlobalGrayColor;
        _scrollView.pageDotColor = kGlobalLightGrayColor;
        _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_scrollView];
        
        _headTitleLabel = [[YYLabel alloc] init];
        _headTitleLabel.width = self.width;
        [self addSubview:_headTitleLabel];
        
        _avatarView = [[UIImageView alloc] init];
        _avatarView.size = CGSizeMake(30, 30);
        _avatarView.left = kDetailContentOffset;
        _avatarView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_avatarView];
        _avatarView.hidden = YES;
        
        _referralLabel = [[YYLabel alloc] init];
        [self addSubview:_referralLabel];
        _referralLabel.hidden = YES;
        _referralLabel.left = _avatarView.right + 15;
        _referralLabel.width = kDetailReferralLabelWidth;
        _referralLabel.height = kDetailReferralLabelHeight;
        
        _bottomLineLayer = [CALayer layer];
        [self.layer addSublayer:_bottomLineLayer];
        _bottomLineLayer.backgroundColor = kGlobalLightGrayColor.CGColor;
        _bottomLineLayer.height = kSeparatorLineHeight;
        _bottomLineLayer.left = kDetailContentOffset;
        _bottomLineLayer.width = self.width - kDetailContentOffset * 2;

    }
    return self;
}

- (void)setHeaderLayout:(ZZDetailHeaderLayout *)headerLayout{
    _headerLayout = headerLayout;
    
    NSMutableArray *iconArray = [NSMutableArray array];
    
    if (headerLayout.detailModel.article_product_focus_pic_url.count) {
        for (ZZProductFocusPicUrl *picUrl in headerLayout.detailModel.article_product_focus_pic_url) {
            [iconArray addObject:picUrl.pic];
        }
        _scrollView.imageURLStringsGroup = [iconArray copy];
    }else if (headerLayout.detailModel.article_pic){
        _scrollView.imageURLStringsGroup = @[headerLayout.detailModel.article_pic];
    }


    self.height = headerLayout.height;
    _scrollView.height = headerLayout.imageHeight;
    
    _headTitleLabel.textLayout = headerLayout.titleTextLayout;
    _headTitleLabel.top = _scrollView.bottom;
    _headTitleLabel.height = headerLayout.textHeight;
    
    _bottomLineLayer.bottom = self.bottom - kSeparatorLineBottom;
    
    if (headerLayout.detailModel.article_avatar.length) {
        _bottomLineLayer.hidden = YES;
        _avatarView.hidden = NO;
        _referralLabel.hidden = NO;
        
        _avatarView.top = _headTitleLabel.bottom + kTitleLineSpacing;
        [_avatarView setImageWithURL:[NSURL URLWithString:headerLayout.detailModel.article_avatar] //profileImageURL
                                     placeholder:nil
                                         options:kNilOptions
                                         manager:[ZZCyclePicHelper avatarImageManager] //< 圆角头像manager，内置圆角处理
                                        progress:nil
                                       transform:nil
                                      completion:nil];
        
        _referralLabel.textLayout = headerLayout.referralTextLayout;
        _referralLabel.centerY = _avatarView.centerY;
    }
}

@end
