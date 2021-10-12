//
//  YYBBCycleScrollView.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 8/23/17.
//  Copyright © 2017 Wang_ruzhou. All rights reserved.
//

#import "YYBBCycleScrollView.h"
#import "YYBBKit.h"

@interface YYBBCycleScrollView () 


@end

@implementation YYBBCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}

- (void)initUI {
    self.backgroundColor = UIColorHex(EDEEF1);
    self.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.autoScrollTimeInterval = 5;
    self.pageDotColor = [UIColor yybb_colorWithRed:120 green:120 blue:120 alpha:0.5];
    self.currentPageDotColor = [UIColor yybb_colorWithRed:120 green:120 blue:120 alpha:1];
}

- (int)yybb_currentIndex
{
    UICollectionView *mainView = [self valueForKey:@"mainView"];
    UICollectionViewFlowLayout *flowLayout = [self valueForKey:@"flowLayout"];
    if (mainView.width == 0 || mainView.height == 0) {
        return 0;
    }
    int index = 0;
    if (flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (mainView.contentOffset.x + flowLayout.itemSize.width * 0.5) / flowLayout.itemSize.width;
    } else {
        index = (mainView.contentOffset.y + flowLayout.itemSize.height * 0.5) / flowLayout.itemSize.height;
    }
    
    return MAX(0, index);
}

@end
