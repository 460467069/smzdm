//
//  YYBBBaseListSectionController.h
//  
//
//  Created by Wang_Ruzhou on 9/17/19.
//  Copyright © 2019 Wang_ruzhou. All rights reserved.
//

#import "YYBBSectionListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBBBaseListSectionController : IGListSectionController<IGListSupplementaryViewSource>

@property(nonatomic, strong) YYBBSectionListModel *listModel;

@end

NS_ASSUME_NONNULL_END
