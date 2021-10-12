//
//  ZZDetailTopicCell.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZDetailTopicCell.h"
#import <YYText/YYText.h>
#import "ZZCyclePicHelper.h"
#import "LEOStarView.h"

@interface ZZDetailContentView ()

@property (nonatomic, strong) YYLabel *userInfoLabel;
@property (nonatomic, strong) UIImageView *figureView;
@property (nonatomic, strong) YYLabel *titleLabel;
@property (nonatomic, strong) YYLabel *descLabel;
@property (nonatomic, strong) YYLabel *picCountLabel;
@property (nonatomic, strong) YYLabel *commentCountLabel;
@property (nonatomic, strong) YYLabel *useTimeLabel;
@property (nonatomic, strong) YYLabel *supportLabel;
@property (nonatomic, strong) UIButton *supportBtn;
@property (nonatomic, strong) YYLabel *starLabel;       /**< 星星 */
@end

@implementation ZZDetailContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth - 2 * kDetailTopicMarginX;
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.left = kDetailTopicMarginX;
        self.top = kDetailTopicMarginY;
        self.backgroundColor = kGlobalLightGrayColor;
        
        _userInfoLabel = [[YYLabel alloc] init];
        //        _userInfoLabel.backgroundColor = [UIColor randomColor];
        [self addSubview:_userInfoLabel];
        _userInfoLabel.height = kDetailTopicUserInfoHeight;
        
        _starLabel = [[YYLabel alloc] init];
        [self addSubview:_starLabel];
        _starLabel.size = CGSizeMake(kDetailTopicStarLabelWidth, kDetailTopicUserInfoHeight);
        _starLabel.right = self.width - kDetailTopicContentOffsetX;;
        _starLabel.centerY = _userInfoLabel.centerY;
        _starLabel.hidden = YES;
        //        _starLabel.backgroundColor = [UIColor randomColor];
        
        
        
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
        _picCountLabel.hidden = YES;
        _picCountLabel.size = CGSizeMake(kDetailTopicSmallBtnWidth, kDetailTopicUseTimeHeight);
        
        _commentCountLabel = [[YYLabel alloc] init];
        [self addSubview:_commentCountLabel];
        _commentCountLabel.size = _picCountLabel.size;
        
        
        _useTimeLabel = [[YYLabel alloc] init];
        [self addSubview:_useTimeLabel];
        _useTimeLabel.size = CGSizeMake(kDetailTopicUseTimeWidth, kDetailTopicUseTimeHeight);
        
        
        _supportLabel = [[YYLabel alloc] init];
        [self addSubview:_supportLabel];
        _supportLabel.size = CGSizeMake(60, kDetailTopicUseTimeHeight);
        _supportLabel.right = self.width - kDetailTopicContentOffsetX;
        //        _supportLabel.backgroundColor = [UIColor randomColor];
        
        
        _supportBtn = [[UIButton alloc] init];
        _supportBtn.backgroundColor = [UIColor zz_randomColor];
        //        [self addSubview:_supportBtn];
        [_supportBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_supportBtn setImage:[UIImage imageNamed:@"ico_zan"] forState:UIControlStateNormal];
        [_supportBtn setImage:[UIImage imageNamed:@"community_like_icon"] forState:UIControlStateSelected];
        _supportBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _supportBtn.size = CGSizeMake(60, kDetailTopicUseTimeHeight);
        _supportBtn.right = self.width - kDetailTopicContentOffsetX;
        
    }
    return self;
}

- (void)setLayout:(ZZDetailTopicContentLayout *)layout{
    _layout = layout;
    
    _userInfoLabel.textLayout = layout.userInfoLayout;
    
    _starLabel.hidden = layout.starLayout ? NO : YES;
    _starLabel.textLayout = layout.starLayout;
    
    _figureView.top = _userInfoLabel.bottom;
    [_figureView sd_setImageWithURL:[NSURL URLWithString:layout.detailTopicModel.pro_pic] placeholderImage:[UIImage imageNamed:@"061"]];
    
    _titleLabel.textLayout = layout.titleLayout;
    _titleLabel.centerY = _figureView.centerY;
    
    _descLabel.textLayout = layout.descriptionLayout;
    _descLabel.top = _figureView.bottom;
    
    _commentCountLabel.textLayout = layout.commentCountLayout;
    _commentCountLabel.top = _descLabel.bottom;
    
    if (layout.picCountLayout) {
        _picCountLabel.hidden = NO;
        _picCountLabel.textLayout = layout.picCountLayout;
        _picCountLabel.top = _descLabel.bottom;
        _picCountLabel.left =  kDetailTopicContentOffsetX;
        _commentCountLabel.left = _picCountLabel.right + kDetailTopicSmallBtnMargin;
    } else {
        _picCountLabel.hidden = YES;
        _commentCountLabel.left = kDetailTopicContentOffsetX;
    }
    
    _useTimeLabel.textLayout = layout.useTimeLayout;
    _useTimeLabel.left = _commentCountLabel.right + kDetailTopicSmallBtnMargin;
    _useTimeLabel.centerY = _commentCountLabel.centerY;
    _useTimeLabel.width = layout.useTimeLayout.textBoundingSize.width;
    
    _supportBtn.centerY = _commentCountLabel.centerY;
    [_supportBtn setTitle:layout.detailTopicModel.support_num forState:UIControlStateNormal];
    
    _supportLabel.centerY = _commentCountLabel.centerY;
    _supportLabel.textLayout = layout.supportLayout;
    _supportLabel.textAlignment = NSTextAlignmentCenter;
    
}

@end


@interface ZZDetailTopicCell ()

@property (nonatomic, strong) UIImageView *avatarView;

@property (nonatomic, strong) ZZDetailContentView *detailContentView;

@end


@implementation ZZDetailTopicCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _avatarView = [[UIImageView alloc] init];
        _avatarView.size = CGSizeMake(kDetailTopicContentAvartarWH, kDetailTopicContentAvartarWH);
        _avatarView.left = kDetailTopicContentOffsetX + 4;
        [self.contentView addSubview:_avatarView];
        
        _detailContentView = [[ZZDetailContentView alloc] init];
        [self.contentView addSubview:_detailContentView];
        _detailContentView.detailTopicCell = self;
        _detailContentView.userInfoLabel.left = _avatarView.right - kDetailTopicMarginX + kDetailTopicUserInfoMarginX; //注意这里需要-kDetailTopicMarginX
        _detailContentView.userInfoLabel.width = _detailContentView.starLabel.left - _detailContentView.userInfoLabel.left;
        [self.contentView bringSubviewToFront:_avatarView];
        
    }
    
    return self;
}

- (void)setLayout:(ZZDetailTopicContentLayout *)layout{
    
    _layout = layout;
    
    [_avatarView yy_setImageWithURL:[NSURL URLWithString:layout.detailTopicModel.user_pic] //profileImageURL
                        placeholder:[UIImage imageNamed:@"5_middle_avatar"]
                            options:kNilOptions
                            manager:[ZZCyclePicHelper avatarImageManager] //< 圆角头像manager，内置圆角处理
                           progress:nil
                          transform:nil
                         completion:nil];
    
    self.height = layout.height;
    _detailContentView.layout = layout;
    _detailContentView.height = layout.height - 2 * kDetailTopicMarginY;
}

@end
