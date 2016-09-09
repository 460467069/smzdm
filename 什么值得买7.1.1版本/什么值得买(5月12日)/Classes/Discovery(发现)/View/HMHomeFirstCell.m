//
//  HMHomenFirstCell.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMHomeFirstCell.h"
#import "HMCyclePicHelper.h"

@implementation HMHomeFirstCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleView = [HMTitleView new];
        [self.contentView addSubview:_titleView];
        
        _cycleScrollView = [HMCycleScrollView new];
        _cycleScrollView.width = kScreenW;
        _cycleScrollView.left = 0;
        [self.contentView addSubview:_cycleScrollView];
        
        _fourPicView = [HMFourPicView new];
        [self.contentView addSubview:_fourPicView];
    
        _horizontalScrollView = [HMHorizontalScrollView new];
        [self.contentView addSubview:_horizontalScrollView];
        
        _separatorView = [HMSeparatorView new];
        [self.contentView addSubview:_separatorView];
        
        self.contentView.backgroundColor = kHomeFirstCellLineColor;
    }
    
    return self;
}

- (void)setLayout:(HMHomeFirstLayout *)layout{
    _layout = layout;
    
    CGFloat top = 0;
    
    [self _setTitleViewWithTop:top];
    top += kHomeFirstCellHeadTitleHeight;
    
    [self _setBannerCycleScrollViewWithTop:top];
    top += layout.picBannerHeight;
    
    [self _setFourPicsWithTop:top];
    top += layout.picFragmentHeight;
    
    [self _setHorizontalScrollViewWithTop:top];
    top += layout.horizontalScrollViewH;
    
    [self _setSeparatorBottomViewWithTop:top];
    top += layout.bottomSeparatorHeight;

    self.height = layout.height;
    self.contentView.height = layout.height;
}

- (void)_setTitleViewWithTop:(CGFloat)top{
    
    _titleView.titleLabel.textLayout = _layout.titleTextLayout;
    [_titleView.bgView.layer setImageURL:[NSURL URLWithString:_layout.firstModel.floor_head_pic_url]];
    
}

/** 轮播图片 */
- (void)_setBannerCycleScrollViewWithTop:(CGFloat)top{
    if (_layout.picBannerHeight > 0) {
        
        NSMutableArray *imageURLStringsGroup = [NSMutableArray array];
        [_layout.firstModel.floor_multi enumerateObjectsUsingBlock:^(HMFloorMulti * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [imageURLStringsGroup addObject:obj.pic_url];
        }];
        _cycleScrollView.hidden = NO;
        _cycleScrollView.imageURLStringsGroup = imageURLStringsGroup.copy;
        _cycleScrollView.top = top;
        
    }else{
        _cycleScrollView.hidden = YES;
        
    }
    
    _cycleScrollView.height = _layout.picBannerHeight;
}

/** 四张图片 */
- (void)_setFourPicsWithTop:(CGFloat)top{
    
    _fourPicView.top = top;
    _fourPicView.height = _layout.picFragmentHeight;
//    _fourPicView.backgroundColor = [UIColor greenColor];
    
    if (_layout.picFragmentHeight > 0) {
        
        _fourPicView.hidden = NO;
        [_fourPicView.fourPics  enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull imageView, NSUInteger idx, BOOL * _Nonnull stop) {
            
            imageView.frame = [_layout.fourRectArray[idx] CGRectValue];
            imageView.contentMode = UIViewContentModeScaleToFill;
            HMFloorSingle *floorSingle = _layout.firstModel.floor_single[idx];
            [imageView.layer setImageWithURL:[NSURL URLWithString:floorSingle.pic_url] placeholder:nil];
        }];
    }else{
        _fourPicView.hidden = YES;
    }

}

/** 水平滚动的scrollView */
- (void)_setHorizontalScrollViewWithTop:(CGFloat)top {
    NSArray *floor_yuanchuang_master = _layout.firstModel.floor_yuanchuang_master;
    NSInteger totalCount = floor_yuanchuang_master.count;
    if (_layout.horizontalScrollViewH > 0) {
        _horizontalScrollView.hidden = NO;
        _horizontalScrollView.talentShow.hidden = NO;
        for (NSInteger i = 0 ; i < kHomeHorizontalScrollItemCount; i++) {
            
            HMHorizontalScrollItem *item = _horizontalScrollView.pics[i];
            if (i < totalCount) {
                item.hidden = NO;
                HMFloorYuanchuangMaster *master = floor_yuanchuang_master[i];
                [item.avatarView setImageWithURL:[NSURL URLWithString:master.avatar] //profileImageURL
                                             placeholder:[UIImage imageNamed:@"icon_profile_avatar_around"]
                                                 options:kNilOptions
                                                 manager:[HMCyclePicHelper avatarImageManager] //< 圆角头像manager，内置圆角处理
                                                progress:nil
                                               transform:nil
                                              completion:nil];
                item.contentLabel.textLayout = _layout.ycTextLayouts[i];
//                item.contentLabel.attributedText = _layout.attributedStrings[i]; //也可以这么做
                item.contentLabel.textAlignment = NSTextAlignmentCenter; //必须加这句
                
                
            }else{
                item.hidden = YES;
                item.contentLabel.textLayout = nil;
            }
            
        }
        
    }else{
        _horizontalScrollView.hidden = YES;
        _horizontalScrollView.talentShow.hidden = YES;
    }
    _horizontalScrollView.contentSize = _layout.horizontalScrollViewContentSize;
    if (totalCount > 0) {
        top += kHomeFirstCellPicPadding;
    }
    _horizontalScrollView.top = top;
    _horizontalScrollView.height = _layout.horizontalScrollViewH;
}

- (void)_setSeparatorBottomViewWithTop:(CGFloat)top{
    if (_layout.isLastOne) {
        _separatorView.hidden = NO;
        _separatorView.top = top;

    }else{
        _separatorView.hidden = YES;
        _separatorView.top = 0;
    }

    _separatorView.height = _layout.bottomSeparatorHeight;
}

- (void)hideImageViews{
    
}


@end


@implementation HMTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenW;
        frame.size.height = kHomeFirstCellHeadTitleHeight;
    }
    self = [super initWithFrame:frame];
    if (self) {
        _bgView = [UIImageView new];
        _bgView.size = self.size;
        [self addSubview:_bgView];
        
        _titleLabel = [YYLabel new];
        [_bgView addSubview:_titleLabel];
        _titleLabel.height = frame.size.height;
        _titleLabel.left = kHomeFirstCellTitleLabelLeft;
        _titleLabel.width = self.width - kHomeFirstCellTitleLabelLeft;
    }
    return self;
}


@end


@implementation HMFourPicView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self.frame.size.width == 0 && self.frame.size.height == 0) {
        frame.size.width = kScreenW;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor redColor];
        _firstImageView = [UIImageView new];
        _secondImageView = [UIImageView new];
        _thirdImageView = [UIImageView new];
        _fourthImageView = [UIImageView new];
        
        [self addSubview:_firstImageView];
        [self addSubview:_secondImageView];
        [self addSubview:_thirdImageView];
        [self addSubview:_fourthImageView];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObject:_firstImageView];
        [tempArray addObject:_secondImageView];
        [tempArray addObject:_thirdImageView];
        [tempArray addObject:_fourthImageView];
        
        _fourPics = [tempArray copy];
    }
    return self;
}

@end

@implementation HMSeparatorView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self.frame.size.width == 0 && self.frame.size.height == 0) {
        frame.size.width = kScreenW;
        frame.size.height = kHomeFirstCellBottomSeparatorH;
    }
    self = [super initWithFrame:frame];
    if (self) {
        YYLabel *label = [YYLabel new];
        label.size = self.size;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor darkGrayColor];
        label.text = @" 编辑精选 ";
        [self addSubview:label];
        
        CALayer *line1 = [CALayer layer];
        [self.layer addSublayer:line1];
        line1.backgroundColor = kGlobalRedColor.CGColor;
        line1.left = kHomeFirstCellBottomSeparatorPadding;
        line1.centerY = self.height * 0.5;
        line1.width = kHomeFirstCellBottomSeparatorLineW;
        line1.height = kHomeFirstCellBottomSeparatorLineH;
        
        CALayer *line2 = [CALayer layer];
        [self.layer addSublayer:line2];
        line2.width = kHomeFirstCellBottomSeparatorLineW;
        line2.left = self.width - kHomeFirstCellBottomSeparatorPadding - line2.width;
        line2.centerY = line1.centerY;
        line2.height = line1.height;
        line2.backgroundColor = line1.backgroundColor;
    }
    
    self.backgroundColor = kHomeSeparatorColor;
    return self;
}

@end


@implementation HMHorizontalScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self.frame.size.width == 0 && self.frame.size.height == 0) {
        frame.size.width = kScreenW;
        frame.size.height = kHomeFirstCellScrollItemHeight;
    }
    self = [super initWithFrame:frame];
    

    
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        NSMutableArray *pics = [NSMutableArray array];
//        homePage_talentShow
        _talentShow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homePage_talentShow"]];
        [self addSubview:_talentShow];
        _talentShow.size = CGSizeMake(kHomeFirstCellScrollItemWidth, kHomeFirstCellScrollItemHeight);
        _talentShow.hidden = YES;
        for (NSInteger i = 0; i < kHomeHorizontalScrollItemCount; i++) {
            HMHorizontalScrollItem *item = [HMHorizontalScrollItem new];
            [self addSubview:item];
            item.left = kHomeFirstCellScrollItemWidth * (i + 1);
            item.hidden = YES;
            item.size = _talentShow.size;
            [self addSubview:item];
            [pics addObject:item];
        }
        _pics = [pics copy];
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

@end

@implementation HMHorizontalScrollItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kHomeFirstCellScrollItemWidth;
        frame.size.height = kHomeFirstCellScrollItemHeight;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        _avatarView = [UIImageView new];
        [self addSubview:_avatarView];
        _avatarView.size = CGSizeMake(kHomeFirstCellScrollItemPicWH, kHomeFirstCellScrollItemPicWH);
        _avatarView.centerX = self.centerX;
        _avatarView.top = kHomeHorizontalScrollItemPicTop;
        
        _contentLabel = [YYLabel new];
        [self addSubview:_contentLabel];
//        _contentLabel.backgroundColor = [self randomColor];
        _contentLabel.top = _avatarView.bottom + kHomeHorizontalScrollItemLabelTop;
        _contentLabel.left = 0;
        _contentLabel.height = self.height - _contentLabel.top;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
        _contentLabel.width = self.width;
//        self.backgroundColor = [self randomColor];
    }
    return self;
}


- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
