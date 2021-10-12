//
//  ZZHomenFirstCell.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZHomeFirstCell.h"
#import "ZZCyclePicHelper.h"
#import <YYWebImage/CALayer+YYWebImage.h>

@interface ZZHomeFirstCell ()<SDCycleScrollViewDelegate, ZZFourPicViewDelegate>

@end

@implementation ZZHomeFirstCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleView = [ZZTitleView new];
        [self.contentView addSubview:_titleView];
        
        _cycleScrollView = [ZZCycleScrollView new];
        _cycleScrollView.width = kScreenWidth;
        _cycleScrollView.left = 0;
        _cycleScrollView.delegate = self;
        [self.contentView addSubview:_cycleScrollView];
        
        _fourPicView = [ZZFourPicView new];
        _fourPicView.delegate = self;
        [self.contentView addSubview:_fourPicView];
    
        _horizontalScrollView = [ZZHorizontalScrollView new];
        [self.contentView addSubview:_horizontalScrollView];
        
        _separatorView = [ZZSeparatorView new];
        [self.contentView addSubview:_separatorView];
        
        self.contentView.backgroundColor = kGlobalLightGrayColor;
    }
    
    return self;
}

- (void)setLayout:(ZZHomeFirstLayout *)layout {
    _layout = layout;
    
    CGFloat top = 0;
    
    [self _setTitleViewWithTop:top];
    top += layout.titleHeight;
    
    [self _setBannerCycleScrollViewWithTop:top];
    top += layout.picBannerHeight;
    
    [self _setFourPicsWithTop:top];
    top += layout.picFragmentHeight;
    
    [self _setHorizontalScrollViewWithTop:top];
    top += layout.horizontalScrollViewH;
    
    [self _setSeparatorBottomViewWithTop:top];
    top += layout.bottomSeparatorHeight;

//    self.height = layout.height;
//    self.contentView.height = layout.height;
}

- (void)_setTitleViewWithTop:(CGFloat)top {
    if (!_layout.titleTextLayout) {
        return;
    }
    _titleView.titleLabel.textLayout = _layout.titleTextLayout;
    [_titleView.bgView.layer yy_setImageWithURL:[NSURL URLWithString:_layout.firstModel.floor_head_pic_url] placeholder:nil];
}

/** 轮播图片 */
- (void)_setBannerCycleScrollViewWithTop:(CGFloat)top {
    if (_layout.picBannerHeight > 0) {
        
        NSMutableArray *imageURLStringsGroup = [NSMutableArray array];
        [_layout.firstModel.floor_multi enumerateObjectsUsingBlock:^(ZZFloorMulti * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [imageURLStringsGroup addObject:obj.pic_url];
        }];
        _cycleScrollView.hidden = NO;
        _cycleScrollView.imageURLStringsGroup = imageURLStringsGroup.copy;
        _cycleScrollView.top = top;
        
    } else {
        _cycleScrollView.hidden = YES;
        
    }
    _cycleScrollView.height = _layout.picBannerHeight;
}

/** 四张图片 */
- (void)_setFourPicsWithTop:(CGFloat)top {
    _fourPicView.top = top;
    _fourPicView.height = _layout.picFragmentHeight;
//    _fourPicView.backgroundColor = [UIColor greenColor];
    
    if (_layout.picFragmentHeight > 0) {
        _fourPicView.hidden = NO;
        NSInteger actualFragmentCount = _layout.firstModel.floor_single.count;
        for (NSInteger i = 0; i < kHomeFragmentMaxCount ; i++) {
            
            UIImageView *imageView = _fourPicView.fourPics[i];
            if (i < actualFragmentCount) {
                imageView.hidden = NO;
                ZZFloorSingle *floorSingle = _layout.firstModel.floor_single[i];
                [imageView.layer yy_setImageWithURL:[NSURL URLWithString:floorSingle.pic_url] placeholder:nil];
                imageView.frame = [_layout.fourRectArray[i] CGRectValue];
            } else {
                imageView.hidden = YES;
            }
        }
        return;
    }
    _fourPicView.hidden = YES;
}

/** 水平滚动的scrollView */
- (void)_setHorizontalScrollViewWithTop:(CGFloat)top {
    NSArray *floor_yuanchuang_master = _layout.firstModel.floor_yuanchuang_master;
    NSInteger totalCount = floor_yuanchuang_master.count;
    if (_layout.horizontalScrollViewH > 0) {
        _horizontalScrollView.hidden = NO;
        _horizontalScrollView.talentShow.hidden = NO;
        for (NSInteger i = 0 ; i < kHomeHorizontalScrollItemCount; i++) {
            
            ZZHorizontalScrollItem *item = _horizontalScrollView.pics[i];
            if (i < totalCount) {
                item.hidden = NO;
                ZZFloorYuanchuangMaster *master = floor_yuanchuang_master[i];
                [item.avatarView yy_setImageWithURL:[NSURL URLWithString:master.avatar] //profileImageURL
                                             placeholder:[UIImage imageNamed:@"icon_profile_avatar_around"]
                                                 options:kNilOptions
                                                 manager:[ZZCyclePicHelper avatarImageManager] //< 圆角头像manager，内置圆角处理
                                                progress:nil
                                               transform:nil
                                              completion:nil];
                item.contentLabel.textLayout = _layout.ycTextLayouts[i];
//                item.contentLabel.attributedText = _layout.attributedStrings[i]; //也可以这么做
                item.contentLabel.textAlignment = NSTextAlignmentCenter; //必须加这句
                
            } else {
                item.hidden = YES;
                item.contentLabel.textLayout = nil;
            }
            
        }
        
    } else {
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

- (void)_setSeparatorBottomViewWithTop:(CGFloat)top {
    if (_layout.isLastOne) {
        _separatorView.hidden = NO;
        _separatorView.top = top;

    } else {
        _separatorView.hidden = YES;
        _separatorView.top = 0;
    }

    _separatorView.height = _layout.bottomSeparatorHeight;
}

- (void)hideImageViews{
    
}

#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(cellDidClickCycleScrollView:atIndex:)]) {
        [self.delegate cellDidClickCycleScrollView:self atIndex:index];
    }
}

#pragma mark - ZZFourPicViewDelegate

- (void)fourPicView:(ZZFourPicView *)fourPicView didSelectItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(cellDidClickFuliItem:atIndex:)]) {
        [self.delegate cellDidClickOneOfFourPic:self atIndex:index];
    }
}

@end


@implementation ZZTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
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
        _titleLabel.hidden = YES;
    }
    return self;
}


@end


@implementation ZZFourPicView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self.frame.size.width == 0 && self.frame.size.height == 0) {
        frame.size.width = kScreenWidth;
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        NSMutableArray *tempArray = [NSMutableArray array];
        //11月19日更改, 原app出现有8张图片的情况
        for (NSInteger i = 0; i < kHomeFragmentMaxCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            [tempArray addObject:imageView];
            
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap:)];
            [imageView addGestureRecognizer:tap];
        }
        _fourPics = [tempArray copy];
    }
    return self;
}

- (void)imageViewDidTap:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    NSInteger index = [_fourPics indexOfObject:imageView];
    if ([self.delegate respondsToSelector:@selector(fourPicView:didSelectItemAtIndex:)]) {
        [self.delegate fourPicView:self didSelectItemAtIndex:index];
    }
}

@end

@implementation ZZSeparatorView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self.frame.size.width == 0 && self.frame.size.height == 0) {
        frame.size.width = kScreenWidth;
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
    
    self.backgroundColor = kGlobalLightGrayColor;
    return self;
}

@end


@implementation ZZHorizontalScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self.frame.size.width == 0 && self.frame.size.height == 0) {
        frame.size.width = kScreenWidth;
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
            ZZHorizontalScrollItem *item = [ZZHorizontalScrollItem new];
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

@implementation ZZHorizontalScrollItem

- (instancetype)initWithFrame:(CGRect)frame {
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


@end
