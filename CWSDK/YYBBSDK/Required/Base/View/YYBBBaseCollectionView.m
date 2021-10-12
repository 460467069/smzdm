//
//  YYBBBaseCollectionView.m
//  
//
//  Created by Wang_ruzhou on 2019/7/16.
//  Copyright © 2019 Wang_ruzhou. All rights reserved.
//

#import "YYBBBaseCollectionView.h"

@implementation YYBBBaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self yybb_setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self yybb_setup];
}

- (void)yybb_setup {
    self.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
}

@end
