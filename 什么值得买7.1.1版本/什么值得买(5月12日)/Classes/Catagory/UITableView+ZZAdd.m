//
//  UITableView+ZZAdd.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/3/6.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "UITableView+ZZAdd.h"

@implementation UITableViewCell (ZZAdd)
+ (NSString *_Nonnull)reuseIdentifier {
    return NSStringFromClass([self class]);
}
@end

@implementation UICollectionViewCell (ZZAdd)
+ (NSString *_Nonnull)reuseIdentifier {
    return NSStringFromClass([self class]);
}
@end

@implementation UITableView (ZZAdd)

- (void)registerReuseCellClass:(nullable Class)class {
    [self registerClass:[class class] forCellReuseIdentifier:NSStringFromClass([class class])];
}

- (void)registerReuseHeaderFooterViewClass:(nullable Class)class {
    [self registerClass:[class class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([class class])];
}

- (void)registerReuseCellNib:(nullable Class)nibClass {
    [self registerNib:[UINib nibWithNibName:ZZStringFromClass([nibClass class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([nibClass class])];
}

- (void)registerReuseHeaderFooterViewNib:(nullable Class)nibClass {
    [self registerNib:[UINib nibWithNibName:ZZStringFromClass([nibClass class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([nibClass class])];
}

+ (void)load {
    swizzleMethod([self class], @selector(initWithFrame:style:), @selector(zz_initWithFrame:style:));
    swizzleMethod([self class], @selector(initWithCoder:), @selector(zz_initWithCoder:));
}

- (instancetype)zz_initWithCoder:(NSCoder *)aDecoder {
    UITableView *tableView = [self zz_initWithCoder:aDecoder];
    [self adapterIOS11];
    return tableView;
}

- (instancetype)zz_initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    UITableView *tableView = [self zz_initWithFrame:frame style:style];
    [self adapterIOS11];
    return tableView;
}

- (void)adapterIOS11 {
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
}
@end

@implementation UICollectionView (ZZAdd)

- (void)registerReuseCellClass:(nullable Class)class {
    [self registerClass:[class class] forCellWithReuseIdentifier:NSStringFromClass([class class])];
}

- (void)registerReuseCellNib:(nullable Class)nibClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([nibClass class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([nibClass class])];
}

- (void)registerReuseSectionHeaderViewClass:(nullable Class)class {
    [self registerClass:[class class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([class class])];
}

- (void)registerReuseSectionHeaderViewNib:(nullable Class)nibClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([nibClass class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([nibClass class])];
}

- (void)registerReuseSectionFooterViewClass:(nullable Class)class {
    [self registerClass:[class class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([class class])];
}

- (void)registerReuseSectionFooterViewNib:(nullable Class)nibClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([nibClass class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([nibClass class])];
}

+ (void)load {
    swizzleMethod([self class], @selector(initWithFrame:collectionViewLayout:), @selector(zz_initWithFrame:collectionViewLayout:));
}

- (instancetype)zz_initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    UICollectionView *collectionView = [self zz_initWithFrame:frame collectionViewLayout:layout];
    if (@available(iOS 11.0, *)) {
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return collectionView;
}

@end
