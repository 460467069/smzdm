//
//  ZZListModel.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/6.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "ZZListModel.h"

@implementation ZZListModel

- (instancetype)initWithSubItems:(NSArray *)subItems sectionController:(IGListSectionController *)sectionController {
    if (self = [super init]) {
        _subItems = [NSMutableArray arrayWithArray:subItems];
        _sectionController = sectionController;
    }
    return self;
}

- (id<NSObject>)diffIdentifier {
    return self;
}

- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object {
    return [self isEqual:object];
}

@end
