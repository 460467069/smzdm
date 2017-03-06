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

@implementation UITableView (ZZAdd)

- (void)registerReuseCellClass:(nullable Class)class {
    [self registerClass:[class class] forCellReuseIdentifier:NSStringFromClass([class class])];
}

- (void)registerReuseHeaderFooterViewClass:(nullable Class)class {
    [self registerClass:[class class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([class class])];
}

- (void)registerReuseCellNib:(nullable Class)nibClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([nibClass class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([nibClass class])];
}

- (void)registerReuseHeaderFooterViewNib:(nullable Class)nibClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([nibClass class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([nibClass class])];
}

@end
