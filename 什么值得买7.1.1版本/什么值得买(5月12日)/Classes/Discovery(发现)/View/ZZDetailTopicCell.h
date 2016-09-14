//
//  ZZDetailTopicCell.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZDetailTopicContentLayout.h"

@interface ZZDetailTopicCell : UITableViewCell

@property (nonatomic, strong) ZZDetailTopicContentLayout *layout;

@end

@interface ZZDetailContentView : UIView

@property (nonatomic, strong) ZZDetailTopicCell *detailTopicCell;

@property (nonatomic, strong) ZZDetailTopicContentLayout *layout;

@end