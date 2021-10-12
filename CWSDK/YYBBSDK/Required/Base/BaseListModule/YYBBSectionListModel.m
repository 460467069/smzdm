//
//  YYBBSectionModel.m
//  
//
//  Created by Wang_Ruzhou on 9/17/19.
//  Copyright © 2019 Wang_ruzhou. All rights reserved.
//

#import "YYBBSectionListModel.h"

@implementation YYBBSectionListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellNibLoad = YES;
        _headerViewNibLoad = YES;
        _footerViewNibLoad = YES;
    }
    return self;
}

- (instancetype)initWithSubItmes:(nullable NSArray *)subItems
               sectionController:(IGListSectionController *)sectionController {
    if (self = [super init]) {
        self.subItems = subItems;
        self.sectionController = sectionController;
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
