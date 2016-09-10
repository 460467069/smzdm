//
//  HMDetailHeaderView.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDetailHeaderView.h"
#import "HMCycleScrollView.h"

@interface HMDetailHeaderView ()
@property (nonatomic, strong) SDCycleScrollView *scrollView;
@property (nonatomic, strong) YYLabel *headTitleLabel;
@property (nonatomic, strong) CALayer *bottomLineLayer;
@end

@implementation HMDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenW;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[SDCycleScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.width = kTopImageWidth;
        _scrollView.autoScroll = NO;
        _scrollView.pageDotColor = kGlobalGrayColor;
        _scrollView.pageDotColor = ZZColor(234, 234, 234);
        _scrollView.centerX = self.centerX;
        _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_scrollView];
        
        _headTitleLabel = [[YYLabel alloc] init];
        _headTitleLabel.width = self.width;
        [self addSubview:_headTitleLabel];
        
        _bottomLineLayer = [CALayer layer];
        [self.layer addSublayer:_bottomLineLayer];
        _bottomLineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        _bottomLineLayer.height = kSeparatorLineHeight;
        _bottomLineLayer.left = kDetailContentOffset;
        _bottomLineLayer.width = self.width - kDetailContentOffset * 2;
    }
    return self;
}

- (void)setHeaderLayout:(HMDetailHeaderLayout *)headerLayout{
    _headerLayout = headerLayout;
    
    NSMutableArray *iconArray = [NSMutableArray array];
    for (HMProductFocusPicUrl *picUrl in headerLayout.detailModel.article_product_focus_pic_url) {
//        if ([picUrl.width floatValue] > kTopImageWidth) {
//            _scrollView.contentMode = UIViewContentModeCenter;
//        }
        [iconArray addObject:picUrl.pic];
    }
    _scrollView.imageURLStringsGroup = [iconArray copy];
    self.height = headerLayout.height;
    _scrollView.height = headerLayout.imageHeight;
    
    _headTitleLabel.textLayout = headerLayout.titleTextLayout;
    _headTitleLabel.top = _scrollView.bottom;
    _headTitleLabel.height = headerLayout.textHeight;
    
    _bottomLineLayer.bottom = self.bottom - kSeparatorLineBottom;
}

@end
