//
//  ZZDetailTopicCell.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZDetailTopicCell.h"

@interface ZZDetailContentView ()

@property (nonatomic, strong) YYLabel *userInfoLabel;
@property (nonatomic, strong) UIImageView *figureView;
@property (nonatomic, strong) YYLabel *titleLabel;
@property (nonatomic, strong) YYLabel *descLabel;
@property (nonatomic, strong) YYLabel *picCountLabel;
@property (nonatomic, strong) YYLabel *commentCountLabel;
@property (nonatomic, strong) YYLabel *useTimeLabel;
@property (nonatomic, strong) UIButton *supportBtn;
@end

@implementation ZZDetailContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenW - 2 * kDetailTopicMarginX;
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.left = kDetailTopicMarginX;
        self.top = kDetailTopicMarginY;
        self.backgroundColor = kGlobalLightGrayColor;
        
        _userInfoLabel = [[YYLabel alloc] init];
        [self addSubview:_userInfoLabel];
        _userInfoLabel.width = kDetailTopicUserInfoWidth;
        
        _figureView = [[UIImageView alloc] init];
        [self addSubview:_figureView];
        _figureView.size = CGSizeMake(kDetailTopicProPicWH, kDetailTopicProPicWH);
        _figureView.left = kDetailTopicContentOffsetX;
        
        
        _titleLabel = [[YYLabel alloc] init];
        [self addSubview:_titleLabel];
        _titleLabel.left = _figureView.right;
        _titleLabel.width = self.width - _figureView.right;
        _titleLabel.height = kDetailTopicProPicWH;
        
        _descLabel = [[YYLabel alloc] init];
        [self addSubview:_descLabel];
        _descLabel.size = CGSizeMake(self.width, kDetailTopicDescHeight);
        
        
        _picCountLabel = [[YYLabel alloc] init];
        [self addSubview:_picCountLabel];
        _picCountLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _picCountLabel.hidden = YES;
        _picCountLabel.width = kDetailTopicSmallBtnWidth;
        
        
        _commentCountLabel = [[YYLabel alloc] init];
        [self addSubview:_userInfoLabel];
        _commentCountLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _commentCountLabel.width = kDetailTopicSmallBtnWidth;
        
        _useTimeLabel = [[YYLabel alloc] init];
        [self addSubview:_useTimeLabel];
        
        _supportBtn = [[UIButton alloc] init];
        [self addSubview:_supportBtn];
        [_supportBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];     
        [_supportBtn setImage:[UIImage imageNamed:@"ico_zan"] forState:UIControlStateNormal];
        [_supportBtn setImage:[UIImage imageNamed:@"community_like_icon"] forState:UIControlStateSelected];
        _supportBtn.size = CGSizeMake(60, 32);
        _supportBtn.right = self.width - kDetailTopicContentOffsetX;
        
    }
    return self;
}

- (void)setLayout:(ZZDetailTopicContentLayout *)layout{
    _layout = layout;
    
    _userInfoLabel.textLayout = layout.userInfoLayout;
    _userInfoLabel.height = layout.userInfoHeight;
    
    _figureView.top = _userInfoLabel.bottom;
    [_figureView sd_setImageWithURL:[NSURL URLWithString:layout.detailTopicModel.pro_pic] placeholderImage:[UIImage imageNamed:@"061"]];
    
    _titleLabel.textLayout = layout.titleLayout;
    _titleLabel.centerY = _figureView.centerY;
    
    _descLabel.textLayout = layout.descriptionLayout;
    _descLabel.top = _figureView.bottom;
    
    _commentCountLabel.textLayout = layout.commentCountLayout;
    _commentCountLabel.height = layout.useTimeHeight;
    _commentCountLabel.top = _descLabel.bottom + kDetailTopicUseTimeY;
    
    if (layout.picCountLayout) {
        _picCountLabel.hidden = NO;
        _picCountLabel.textLayout = layout.picCountLayout;
        _picCountLabel.top = _descLabel.bottom + kDetailTopicUseTimeY;
        _picCountLabel.height = layout.useTimeHeight;
        _picCountLabel.left =  kDetailTopicContentOffsetX;
        
        _commentCountLabel.left = _picCountLabel.right + kDetailTopicSmallBtnMargin;
        

    }else{
        _picCountLabel.hidden = YES;
        _commentCountLabel.left = kDetailTopicContentOffsetX;
    }

    _useTimeLabel.textLayout = layout.useTimeLayout;
    _useTimeLabel.height = layout.useTimeHeight;
    _useTimeLabel.left = _commentCountLabel.right + kDetailTopicSmallBtnMargin;
    _useTimeLabel.centerY = _commentCountLabel.centerY;
    _useTimeLabel.width = layout.useTimeLayout.textBoundingSize.width;
    
    _supportBtn.centerY = _commentCountLabel.centerY;
    
    
}

@end


@interface ZZDetailTopicCell ()

@property (nonatomic, strong) UIImageView *avartarView;

@property (nonatomic, strong) ZZDetailContentView *detailContentView;

@end


@implementation ZZDetailTopicCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _avartarView = [[UIImageView alloc] init];
        _avartarView.size = CGSizeMake(kDetailTopicContentAvartarWH, kDetailTopicContentAvartarWH);
        _avartarView.left = kDetailTopicContentOffsetX + 2;
        [self.contentView addSubview:_avartarView];
        
        _detailContentView = [[ZZDetailContentView alloc] init];
        [self.contentView addSubview:_detailContentView];
        _detailContentView.detailTopicCell = self;
        _detailContentView.userInfoLabel.left = _avartarView.right;
        
    }
    
    return self;
}

- (void)setLayout:(ZZDetailTopicContentLayout *)layout{
    
    _layout = layout;
    
    
    self.height = layout.height;
    _detailContentView.layout = layout;
    _detailContentView.height = layout.height - 2 * kDetailTopicMarginY;
}

@end
