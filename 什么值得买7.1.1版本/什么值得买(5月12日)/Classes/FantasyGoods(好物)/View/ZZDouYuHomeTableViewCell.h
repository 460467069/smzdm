//
//  ZZDouYuHomeTableViewCell.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/7/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZDouYuHomeCollectionViewCell.h"

#define kHMDouYuTitileViewHeight 44
#define kHMDouYuHomeCollectionViewCellHeight 150

static NSString *kCollectionViewCellIdentifier = @"ZZDouYuHomeCollectionViewCell";
static NSString *kHMDouYuHomeTableViewCell = @"ZZDouYuHomeTableViewCell";


@interface AFIndexedCollectionView : UICollectionView
@property (nonatomic, strong) NSIndexPath *indexPath;
@end


@interface ZZDouYuTitileView : UIView

@end

@interface ZZDouYuHomeTableViewCell : UITableViewCell


@property (nonatomic, strong) AFIndexedCollectionView *collectionView;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

@end
