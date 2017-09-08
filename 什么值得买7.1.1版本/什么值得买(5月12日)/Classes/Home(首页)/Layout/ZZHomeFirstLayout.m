//
//  ZZHomeFirstLayout.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZHomeFirstLayout.h"

@implementation ZZHomeFirstLayout

- (instancetype)initWithFirstModel:(ZZHomeFirstModel *)firstModel isLastOne:(BOOL)isLastOne;{
    if (!firstModel) {
        return nil;
    }
    self = [super init];
    if (self) {
        _firstModel = firstModel;
        _isLastOne = isLastOne;
        [self layout];
    }
    return self;
}

- (void)layout {
    [self _layout];
    _height = 0;
    _height += _titleHeight;
    _height += _picBannerHeight;
    _height += _picFragmentHeight;
    _height += _horizontalScrollViewH;
    _height += _bottomSeparatorHeight;
}

- (void)_layout {
    [self _layoutTitle];
    [self _layoutBanner];
    [self _layoutFourPic];
    [self _layoutScroll];
    [self _layoutSeparatorBottomView];
}

- (void)_layoutTitle {
    ZZHomeFirstModel *firstModel = self.firstModel;
    NSString *title = firstModel.floor_title;
    if (title.length == 0 || [firstModel.cell_type isEqualToString:@"21"]) {
        _titleTextLayout = nil;
        _titleHeight = 0;
        return;
    }
    NSMutableAttributedString *titleText = [[NSMutableAttributedString alloc] initWithString:title];
    
    titleText.font = [UIFont systemFontOfSize:kHomeTitleFont];
    titleText.color = [UIColor colorWithHexString:firstModel.floor_title_color];
    titleText.lineBreakMode = NSLineBreakByCharWrapping;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, 9999)];
    container.maximumNumberOfRows = 1;
    _titleTextLayout = [YYTextLayout layoutWithContainer:container text:titleText];
    _titleHeight = kHomeFirstCellHeadTitleHeight;
}

- (void)_layoutBanner {
    if (self.firstModel.floor_multi.count == 0) {
        _picBannerHeight = 0;
        return;
    }
    
    _picBannerHeight = kHomeFirstCellBannerPicHeight;
}

- (void)_layoutSeparatorBottomView {
    if (self.isLastOne) {
        _bottomSeparatorHeight = kHomeFirstCellBottomSeparatorH;
    }else{
        _bottomSeparatorLayout = nil;
        _bottomSeparatorHeight = 0;
    }
}

- (void)_layoutFourPic {
    NSInteger totalCount = self.firstModel.floor_single.count;
    if (totalCount == 0) {
        _picFragmentHeight = 0;
        return;
    }
    //    根据floor_model_id 来判断
    //    1   四种小图片(大小统一)
    //    6   图片轮播 + 四种小图片 + 水平滚动的scrollView(如原创达人榜)
    //    10  四种图片(大小不一. 如值友福利)
    //    4   轮播图片
    
    NSMutableArray *temArray = [NSMutableArray array];
    if (![self.firstModel.floor_model_id isEqualToString:@"10"]) {
        CGFloat firstImageX = 0;
        CGFloat firstImageY = 0;
        CGFloat firstImageW = kHomeFirstCellPicWidth1;
        CGFloat firstImageH = kHomeFirstCellPicHeight1;
        CGRect firstImageF = CGRectMake(firstImageX, firstImageY, firstImageW, firstImageH);
        NSValue *value1 = [NSValue valueWithCGRect:firstImageF];
        
        CGFloat secondImageY = 0;
        CGFloat secondImageW = kHomeFirstCellPicWidth2;
        CGFloat secondImageH = kHomeFirstCellPicHeight2;
        CGFloat secondImageX = kScreenWidth - secondImageW;
        CGRect secondImageF = CGRectMake(secondImageX, secondImageY, secondImageW, secondImageH);
        NSValue *value2 = [NSValue valueWithCGRect:secondImageF];
        
        CGFloat thirdImageX = secondImageX;
        CGFloat thirdImageY = CGRectGetMaxY(secondImageF) + kHomeFirstCellPicPadding;
        CGFloat thirdImageW = kHomeFirstCellPicWidth3;
        CGFloat thirdImageH = kHomeFirstCellPicHeight3;
        CGRect thirdImageF = CGRectMake(thirdImageX, thirdImageY, thirdImageW, thirdImageH);
        NSValue *value3 = [NSValue valueWithCGRect:thirdImageF];
        
        CGFloat fourthImageX = CGRectGetMaxX(thirdImageF) + kHomeFirstCellPicPadding;
        CGFloat fourthImageY = thirdImageY;
        CGFloat fourthImageW = thirdImageW;
        CGFloat fourthImageH = thirdImageH;
        CGRect fourthImageF = CGRectMake(fourthImageX, fourthImageY, fourthImageW, fourthImageH);
        NSValue *value4 = [NSValue valueWithCGRect:fourthImageF];
        
        [temArray addObject:value1];
        [temArray addObject:value2];
        [temArray addObject:value3];
        [temArray addObject:value4];
        
        _picFragmentHeight = kHomeFirstCellPicHeight1;
        
        if (totalCount == kHomeFragmentMaxCount) {  //额外处理8张图片的布局
            for (NSInteger i = 0; i < 4; i++) {
                CGFloat imageViewX = (kHomeFirstCellPicPadding + kHomeFirstCellBottomPicW) * i;
                CGFloat imageViewY = firstImageH + 1;
                CGFloat imageViewW = kHomeFirstCellBottomPicW;
                CGFloat imageViewH = kHomeFirstCellBottomPicH;
                CGRect imageViewF = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
                NSValue *rectValue = [NSValue valueWithCGRect:imageViewF];
                [temArray addObject:rectValue];
            }
            
            _picFragmentHeight = kHomeFirstCellPicHeight1 + kHomeFirstCellBottomPicH + 1;
        }
        
    } else {
        for (NSInteger i = 0; i < totalCount; i++) {
            CGFloat imageViewX = (kHomeFirstCellPicPadding + kHomeFirstCellBottomPicW) * i;
            CGFloat imageViewY = 0;
            CGFloat imageViewW = kHomeFirstCellBottomPicW;
            CGFloat imageViewH = kHomeFirstCellBottomPicH;
            CGRect imageViewF = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
            NSValue *rectValue = [NSValue valueWithCGRect:imageViewF];
            [temArray addObject:rectValue];
        }
        
        _picFragmentHeight = kHomeFirstCellBottomPicH;
        
    }
    
    _fourRectArray = [temArray copy];
}

- (void)_layoutScroll {
    NSInteger totalCount = self.firstModel.floor_yuanchuang_master.count;
    if (totalCount == 0) {
        _horizontalScrollViewH = 0;
        return;
    }
    
    NSMutableArray *temArrayM = [NSMutableArray array];
    NSMutableArray *widths = [NSMutableArray array];
    NSMutableArray *attributedStrings = [NSMutableArray array];
    for (ZZFloorYuanchuangMaster *master in self.firstModel.floor_yuanchuang_master) {
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        
        {
            //戏画
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:master.nickname];
            one.font = [UIFont systemFontOfSize:15];
            one.color = [UIColor blackColor];
            
            [text appendAttributedString:one];
            [text appendAttributedString:[self padding]];
        }
        
        {
            //119人关注
            NSString *title = [NSString stringWithFormat:@"%@人关注", master.fans_num];
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:title];
            one.font = [UIFont systemFontOfSize:13];
            one.color = [UIColor lightGrayColor];
            
            [text appendAttributedString:one];
            [text appendAttributedString:[self padding]];
            [text appendAttributedString:[self padding]];
        }
        
        {
            //去关注
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"去关注"];
            one.color = [UIColor whiteColor];
            one.font = [UIFont systemFontOfSize:16];
            
            YYTextBorder *border = [YYTextBorder new];
            border.fillColor = [UIColor redColor];
            border.strokeColor = one.color;
            border.strokeWidth = 1;
            border.cornerRadius = 50;
            border.insets = UIEdgeInsetsMake(-5, -20, -5, -20);
            one.textBackgroundBorder = border;
            
            [text appendAttributedString:one];
            [text appendAttributedString:[self padding]];
        }
        
        [attributedStrings addObject:text];
        
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kHomeFirstCellScrollItemWidth, kHomeFirstCellScrollItemHeight)];
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
        CGFloat width = CGFloatPixelRound(layout.textBoundingRect.size.width);
        
        [widths addObject:[NSNumber numberWithFloat:width]];
        [temArrayM addObject:layout];
        
    }
    
    _ycTextLayouts = [temArrayM copy];
    _widths = [widths copy];
    _attributedStrings = [attributedStrings copy];
    _horizontalScrollViewH = kHomeFirstCellScrollItemHeight + kHomeFirstCellPicPadding;
    _horizontalScrollViewContentSize = CGSizeMake((totalCount + 1) * kHomeFirstCellScrollItemWidth, 0);
    
}

- (NSAttributedString *)padding {
    NSMutableAttributedString *padding = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    padding.font = [UIFont systemFontOfSize:4];
    return padding;
}

@end
