//
//  UITableView+ZZAdd.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/3/6.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableViewCell (ZZAdd)

+ (NSString *_Nonnull)reuseIdentifier;

@end

@interface UITableView (ZZAdd)

- (void)registerReuseCellClass:(nullable Class)class;

- (void)registerReuseHeaderFooterViewClass:(nullable Class)class;

- (void)registerReuseCellNib:(nullable Class)nibClass;

- (void)registerReuseHeaderFooterViewNib:(nullable Class)nibClass;

@end

