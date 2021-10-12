//
//  YYBBBaseTableView.m
//  
//
//  Created by Wang_ruzhou on 2019/6/3.
//  Copyright © 2019 Wang_ruzhou. All rights reserved.
//

#import "YYBBBaseTableView.h"
#import "../../Category/UITableView+YYBBAdd.h"

@implementation YYBBBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self yybb_setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self yybb_setup];
    }
    return self;
}

- (void)yybb_setup {
//    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _registeredCellIdentifiers = [NSMutableSet new];
    _registeredNibNames = [NSMutableSet new];
    _registeredHeaderFooterViewIdentifiers = [NSMutableSet new];
    _registeredHeaderFooterViewNibNames = [NSMutableSet new];
    if (@available(iOS 15.0, *)) {
        self.sectionHeaderTopPadding = 0;
    }
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    } else {
        // Fallback on earlier versions
    }
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (nullable __kindof UITableViewCell *)yybb_dequeueReusableCellClass:(nullable Class)classA {
    NSString *reuseIdentifier = NSStringFromClass(classA);
    if (![self.registeredCellIdentifiers containsObject:reuseIdentifier]) {
        [self.registeredCellIdentifiers addObject:reuseIdentifier];
        [self registerReuseCellClass:classA];
    }
    return [self dequeueReusableCellWithIdentifier:reuseIdentifier];
}

- (nullable __kindof UITableViewCell *)yybb_dequeueReusableCellNibClass:(nullable Class)nibClass {
    NSString *reuseIdentifier = NSStringFromClass(nibClass);
    if (![self.registeredCellIdentifiers containsObject:reuseIdentifier]) {
        [self.registeredCellIdentifiers addObject:reuseIdentifier];
        [self registerReuseCellNib:nibClass];
    }
    return [self dequeueReusableCellWithIdentifier:reuseIdentifier];
}

- (nullable __kindof UITableViewHeaderFooterView *)yybb_dequeueReusableHeaderFooterViewClass:(nullable Class)classA {
    NSString *reuseIdentifier = NSStringFromClass(classA);
    if (![self.registeredHeaderFooterViewIdentifiers containsObject:reuseIdentifier]) {
        [self.registeredHeaderFooterViewIdentifiers addObject:reuseIdentifier];
        [self registerReuseHeaderFooterViewClass:classA];
    }
    return [self dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
}

- (nullable __kindof UITableViewHeaderFooterView *)yybb_dequeueReusablHeaderFooterViewNibClass:(nullable Class)nibClass {
    NSString *reuseIdentifier = NSStringFromClass(nibClass);
    if (![self.registeredHeaderFooterViewNibNames containsObject:reuseIdentifier]) {
        [self.registeredHeaderFooterViewNibNames addObject:reuseIdentifier];
        [self registerReuseHeaderFooterViewNib:nibClass];
    }
    return [self dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
}

@end
