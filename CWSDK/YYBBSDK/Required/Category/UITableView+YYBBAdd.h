//
//  UITableView+YYBBAdd.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/3/6.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (YYBBReuseIdentifier)

+ (NSString *_Nonnull)reuseIdentifier;

@end

@interface UITableView (YYBBAdd)

- (void)registerReuseCellClass:(nullable Class)classA;

- (void)registerReuseHeaderFooterViewClass:(nullable Class)classA;

- (void)registerReuseCellNib:(nullable Class)nibClass;

- (void)registerReuseHeaderFooterViewNib:(nullable Class)nibClass;

@end

@interface UICollectionView (YYBBAdd)

- (void)registerReuseCellClass:(nullable Class)classA;

- (void)registerReuseCellNib:(nullable Class)nibClass;

- (void)registerReuseSectionHeaderViewClass:(nullable Class)classA;

- (void)registerReuseSectionHeaderViewNib:(nullable Class)nibClass;

- (void)registerReuseSectionFooterViewClass:(nullable Class)classA;

- (void)registerReuseSectionFooterViewNib:(nullable Class)nibClass;

@end
