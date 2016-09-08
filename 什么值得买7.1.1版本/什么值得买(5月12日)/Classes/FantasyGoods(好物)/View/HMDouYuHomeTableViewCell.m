//
//  HMDouYuHomeTableViewCell.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/7/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDouYuHomeTableViewCell.h"

@implementation AFIndexedCollectionView



@end

@interface HMDouYuTitileView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation HMDouYuTitileView
- (IBAction)moreBtnDidClick:(id)sender {
}


@end


@interface HMDouYuHomeTableViewCell ()
/** <##> */
@property (nonatomic, strong) HMDouYuTitileView *titleView;
@end

@implementation HMDouYuHomeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 15;
    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = 0;
    CGFloat width = (kScreenW - margin * 3) / 2;
    layout.itemSize = CGSizeMake(width, 150);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[AFIndexedCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HMDouYuHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO; //禁掉collectionView的拖拽(会影响tableView的拖拽)
    [self.contentView addSubview:self.collectionView];
    
    HMDouYuTitileView *titleView = [[[NSBundle mainBundle] loadNibNamed:@"HMDouYuTitileView" owner:nil options:nil] lastObject];
    [self.contentView addSubview:titleView];
    self.titleView = titleView;
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    

    
    self.titleView.frame = CGRectMake(0, 0, self.contentView.mj_w, kHMDouYuTitileViewHeight);
    
    self.collectionView.frame = CGRectMake(0, kHMDouYuTitileViewHeight, self.contentView.mj_w, self.contentView.mj_h - kHMDouYuTitileViewHeight);
}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.indexPath = indexPath;
    [self.collectionView setContentOffset:self.collectionView.contentOffset animated:NO];
    
    [self.collectionView reloadData];
}



@end
