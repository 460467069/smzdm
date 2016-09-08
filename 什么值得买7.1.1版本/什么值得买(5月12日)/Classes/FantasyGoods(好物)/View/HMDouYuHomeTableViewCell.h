//
//  HMDouYuHomeTableViewCell.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/7/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMDouYuHomeCollectionViewCell.h"

#define kHMDouYuTitileViewHeight 44
#define kHMDouYuHomeCollectionViewCellHeight 150

static NSString *kCollectionViewCellIdentifier = @"HMDouYuHomeCollectionViewCell";
static NSString *kHMDouYuHomeTableViewCell = @"HMDouYuHomeTableViewCell";


@interface AFIndexedCollectionView : UICollectionView
@property (nonatomic, strong) NSIndexPath *indexPath;
@end


@interface HMDouYuTitileView : UIView

@end

@interface HMDouYuHomeTableViewCell : UITableViewCell


@property (nonatomic, strong) AFIndexedCollectionView *collectionView;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

@end
