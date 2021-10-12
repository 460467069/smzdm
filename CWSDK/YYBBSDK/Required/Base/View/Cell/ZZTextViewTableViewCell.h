//
//  ZZTextViewTableViewCell.h
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "YYBBPlaceholderTextView.h"
#import "YYBBBaseTableViewCell.h"

@interface ZZTextViewTableViewCell : YYBBBaseTableViewCell

@property (nonatomic, strong, readonly) YYBBPlaceholderTextView *textView;
@property (nonatomic, copy, readonly) NSArray *textViewConstraints;

@end
