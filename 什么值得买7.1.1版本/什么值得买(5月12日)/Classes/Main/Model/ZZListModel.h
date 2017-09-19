//
//  ZZListModel.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/6.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>

@interface ZZListModel : NSObject<IGListDiffable>

@property (nonatomic, strong) NSMutableArray *subItems;
@property (nonatomic, strong) IGListSectionController *sectionController;

- (instancetype)initWithSubItems:(NSArray *)subItems sectionController:(IGListSectionController *)sectionController;

@end
