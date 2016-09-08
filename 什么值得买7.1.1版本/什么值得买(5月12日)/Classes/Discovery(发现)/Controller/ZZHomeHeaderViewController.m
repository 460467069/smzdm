//
//  ZZHomeHeaderViewController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/7.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZHomeHeaderViewController.h"
#import "SDCycleScrollView.h"
#import "HMHeadLine.h"
#import "HMHomeHeadModel.h"
#import "HMLittleBannerCell.h"

#define kCycleTextContentViewColor [UIColor colorWithWhite:1.0 alpha:0.8]
NSString *const kLittleBannerViewReuseIdentifier = @"HMLittleBannerCell";

@interface ZZHomeHeaderViewController ()<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) SDCycleScrollView *cycleImageView;
@property (nonatomic, weak) SDCycleScrollView *cycleTextView;
@property (nonatomic, strong) NSArray *litterBannerArray;
@property (nonatomic, strong) UICollectionView *littleBannerView;
@end

@implementation ZZHomeHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGFloat imageHeight = 180;
    CGRect cycleScrollViewF = CGRectMake(0, 0, kScreenW, imageHeight);
    SDCycleScrollView *cycleImageView = [SDCycleScrollView cycleScrollViewWithFrame:cycleScrollViewF delegate:self placeholderImage:nil];
    cycleImageView.autoScrollTimeInterval = 5.0;
    cycleImageView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleImageView.pageDotColor = [UIColor whiteColor];
    cycleImageView.currentPageDotColor = [UIColor redColor];
    [self.view addSubview:cycleImageView];
    self.cycleImageView = cycleImageView;
    
    CGFloat cycleTextH = 34;
    CGFloat cycleTextY = CGRectGetMaxY(cycleScrollViewF) - cycleTextH;
    CGRect cycleTextF = CGRectMake(0, cycleTextY, kScreenW, cycleTextH);
    
    CGFloat cycleTextContentViewH = 34;
    CGFloat cycleTextContentViewX = 0;
    CGFloat cycleTextContentViewY = CGRectGetMaxY(cycleScrollViewF) - cycleTextH;
    CGFloat cycleTextContentViewW = kScreenW;
    UIView *cycleTextContentView = [[UIView alloc] initWithFrame:cycleTextF];
    cycleTextContentView.frame = CGRectMake(cycleTextContentViewX, cycleTextContentViewY, cycleTextContentViewW, cycleTextContentViewH);
    cycleTextContentView.backgroundColor = kCycleTextContentViewColor;
    [self.view addSubview:cycleTextContentView];

    
    CGFloat headlineViewX = 0;
    CGFloat headlineViewY = 0;
    CGFloat headlineViewW = 99;
    CGFloat headlineViewH = cycleTextContentViewH;
    UIImageView *headlineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homePage_headline"]];
    [cycleTextContentView addSubview:headlineView];
    headlineView.frame = CGRectMake(headlineViewX, headlineViewY, headlineViewW, headlineViewH);
    
    CGFloat cycleTextViewX = headlineViewW;
    CGFloat cycleTextViewY = 0;
    CGFloat cycleTextViewW = cycleTextContentViewW - cycleTextViewX;
    CGFloat cycleTextViewH = cycleTextContentViewH;
    SDCycleScrollView *cycleTextView = [SDCycleScrollView cycleScrollViewWithFrame:cycleTextF delegate:nil placeholderImage:nil];
    cycleTextView.frame = CGRectMake(cycleTextViewX, cycleTextViewY, cycleTextViewW, cycleTextViewH);
    cycleTextView.scrollDirection = UICollectionViewScrollDirectionVertical;    //设置垂直滚动放向
    cycleTextView.userInteractionEnabled = NO;
    cycleTextView.onlyDisplayText = YES;    //仅显示文字
    cycleTextView.autoScrollTimeInterval = 3.0;
    cycleTextView.titleLabelTextColor = [UIColor darkGrayColor];
    cycleTextView.backgroundColor = kCycleTextContentViewColor;
    cycleTextView.titleLabelBackgroundColor = [UIColor clearColor];
    [cycleTextContentView addSubview:cycleTextView];
    self.cycleTextView = cycleTextView;

    //littleBanner
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    NSInteger count = 5;
    CGFloat itemWidth = kScreenW / count;
    CGFloat littleBannerViewH = 180;
     CGFloat inset = 15;
    CGFloat itemHeight = (littleBannerViewH - inset * 2) * 0.5;
   
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    UICollectionView *littleBannerView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleScrollViewF), kScreenW, littleBannerViewH) collectionViewLayout:layout];
    [self.view addSubview:littleBannerView];
    littleBannerView.delegate = self;
    littleBannerView.dataSource = self;
    littleBannerView.backgroundColor = [UIColor whiteColor];
    littleBannerView.contentInset = UIEdgeInsetsMake(inset, 0, inset, 0);
    self.littleBannerView = littleBannerView;
    [littleBannerView registerNib:[UINib nibWithNibName:kLittleBannerViewReuseIdentifier bundle:nil] forCellWithReuseIdentifier:kLittleBannerViewReuseIdentifier];
    LxDBAnyVar(littleBannerView.frame);
    
    NSString *urlStr = @"http://api.smzdm.com/v2/util/banner?f=iphone&is_login=1&type=menhu&v=7.1&weixin=1";
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.securityPolicy.validatesDomainName = NO;
    
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        HMHomeHeadModel *headModel = [HMHomeHeadModel modelWithDictionary:responseObject[@"data"]];
        
        NSMutableArray *imageArrayM = [NSMutableArray array];
        NSMutableArray *textArrayM = [NSMutableArray array];
        [headModel.rows enumerateObjectsUsingBlock:^(HMHeadLine * _Nonnull headline, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [imageArrayM addObject:headline.img];
        }];
        [headModel.headlines enumerateObjectsUsingBlock:^(HMHeadLine * _Nonnull headline, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [textArrayM addObject:headline.title];
        }];
        
        self.litterBannerArray = headModel.littleBanner;
        [self.littleBannerView reloadData];
        
        cycleTextView.titlesGroup = [textArrayM copy];
        cycleImageView.imageURLStringsGroup = [imageArrayM copy];
        [cycleImageView layoutIfNeeded];    //强制更新布局
        //轮播视图的pageControl是设置完图片数组后创建的,所以只有在这里才能拿到pageControl 才能更改其frame
        for (UIView *subView in cycleImageView.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UIPageControl")]) {
                subView.bottom = cycleImageView.height - cycleTextContentView.height;
                break;
            }
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.litterBannerArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HMLittleBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLittleBannerViewReuseIdentifier forIndexPath:indexPath];
    HMLittleBanner *littleBanner = self.litterBannerArray[indexPath.item];
    cell.littleBanner = littleBanner;
    return cell;
}


#pragma mark - getter && setter
- (NSArray *)litterBannerArray
{
	if (!_litterBannerArray){
        _litterBannerArray = [NSArray array];
	}
	return _litterBannerArray;
}






@end
