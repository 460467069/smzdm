//
//  HMDetailTopicHeaderView.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/11.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDetailTopicHeaderView.h"

@interface HMDetailTopicHeaderView ()
@property (nonatomic, strong) UIImageView *focusPicView;
@property (nonatomic, strong) YYLabel *headTitleLabel;
@property (nonatomic, strong) YYLabel *headContentLabel;
@property (nonatomic, strong) UIButton *markBtn;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) UIButton *hotBtn;
@end

@implementation HMDetailTopicHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenW;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _focusPicView = [[UIImageView alloc] init];
        _focusPicView.contentMode = UIViewContentModeScaleAspectFit;
        _focusPicView.width = self.width;
        _focusPicView.hidden = YES;
        [self addSubview:_focusPicView];
        
        _headTitleLabel = [[YYLabel alloc] init];
        _headTitleLabel.width = self.width;
        [self addSubview:_headTitleLabel];
        
        _headContentLabel = [[YYLabel alloc] init];
        _headContentLabel.width = self.width;
        [self addSubview:_headContentLabel];
        
        _timeBtn = [self initialBtnTitle:@"按时间"];
        _timeBtn.right = self.width - kDetailContentOffset;
        
        _hotBtn = [self initialBtnTitle:@"按热度"];
        _hotBtn.right = _timeBtn.left - kDetailTopicBtnMargin;
        
    }
    return self;
}

- (UIButton *)initialBtnTitle:(NSString *)title{
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitle:title forState:UIControlStateSelected];
    [btn setTitleColor:kGlobalRedColor forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    btn.size = CGSizeMake(kDetailTopicBtnWidth, kDetailTopicBtnHeight);
    btn.layer.cornerRadius = kDetailTopicBtnHeight * 0.5;
    btn.layer.masksToBounds = YES;
    [btn setBackgroundImage:[UIImage imageNamed:@"tagBgNormal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"originalBtnTagBG"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    
    return btn;
}

- (void)setTopicHeaderLayout:(HMDetailTopicHeaderLayout *)topicHeaderLayout{
    
    _topicHeaderLayout = topicHeaderLayout;
    
    self.height = topicHeaderLayout.height;
    
    _focusPicView.height = topicHeaderLayout.imageHeight;
    if (topicHeaderLayout.imageHeight) {
        _focusPicView.hidden = NO;
        [_focusPicView sd_setImageWithURL:[NSURL URLWithString:topicHeaderLayout.detailTopicModel.focus_pic] placeholderImage:[UIImage imageNamed:@"placeholder_dropbox"]];
    }
    
    _headTitleLabel.textLayout = topicHeaderLayout.articleLayout;
    _headTitleLabel.height = topicHeaderLayout.articleHeight;
    _headTitleLabel.top = _focusPicView.bottom;
    
    _timeBtn.top = _headTitleLabel.bottom + kDetailTopicBtnBottom;
    _hotBtn.top = _timeBtn.top;
    
    //默认选中"热度"按钮
    _hotBtn.selected = YES;
    
}

- (void)btnDidClick:(UIButton *)sender {
    if ([sender isEqual:self.markBtn]) {
        return;
    }
    
    self.markBtn.selected = NO;
    sender.selected = YES;
    self.markBtn = sender;
    
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickOrderBtn:)]) {
        
        [self.delegate headerViewDidClickOrderBtn:self];
    }
    
}

@end
