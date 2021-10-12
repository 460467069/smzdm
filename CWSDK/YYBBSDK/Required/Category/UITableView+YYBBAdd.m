//
//  UITableView+YYBBAdd.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/3/6.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "UITableView+YYBBAdd.h"

@implementation NSObject (YYBBReuseIdentifier)

+ (NSString *_Nonnull)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end

@implementation UITableView (YYBBAdd)

- (void)registerReuseCellClass:(nullable Class)classA {
    [self registerClass:classA forCellReuseIdentifier:NSStringFromClass(classA)];
}

- (void)registerReuseHeaderFooterViewClass:(nullable Class)class {
    [self registerClass:class forHeaderFooterViewReuseIdentifier:NSStringFromClass(class)];
}

- (void)registerReuseCellNib:(nullable Class)nibClass {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([nibClass class]) bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:NSStringFromClass(nibClass)];
}

- (void)registerReuseHeaderFooterViewNib:(nullable Class)nibClass {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([nibClass class]) bundle:nil];
    [self registerNib:nib forHeaderFooterViewReuseIdentifier:NSStringFromClass(nibClass)];
}

@end

@implementation UICollectionView (YYBBAdd)

- (void)registerReuseCellClass:(nullable Class)class {
    [self registerClass:class forCellWithReuseIdentifier:NSStringFromClass(class)];
}

- (void)registerReuseCellNib:(nullable Class)nibClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([nibClass class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([nibClass class])];
}

- (void)registerReuseSectionHeaderViewClass:(nullable Class)class {
    [self registerClass:class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(class)];
}

- (void)registerReuseSectionHeaderViewNib:(nullable Class)nibClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([nibClass class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([nibClass class])];
}

- (void)registerReuseSectionFooterViewClass:(nullable Class)class {
    [self registerClass:class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(class)];
}

- (void)registerReuseSectionFooterViewNib:(nullable Class)nibClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([nibClass class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([nibClass class])];
}

@end
