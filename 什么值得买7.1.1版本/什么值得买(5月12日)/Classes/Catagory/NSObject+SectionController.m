//
//  NSObject+SectionController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/5.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "NSObject+SectionController.h"
#import <objc/runtime.h>

@implementation NSObject (SectionController)

- (void)setSectionController:(IGListSectionController *)sectionController {
    return objc_setAssociatedObject(self, @selector(sectionController), sectionController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (IGListSectionController *)sectionController {
    return objc_getAssociatedObject(self, @selector(sectionController));
}

@end
