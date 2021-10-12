//
//  YYBBBaseTableView.h
//  
//
//  Created by Wang_ruzhou on 2019/6/3.
//  Copyright © 2019 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBBProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBBBaseTableViewCell : UITableViewCell<YYBBLayoutDelegate>

+(instancetype)yybb_baseCellWithTableView:(UITableView *)tableView;
/**
 * @discussion 隐藏最后一个Cell 的线条
 * rows 数据源条数
 * indexPath
 */
- (instancetype)yybb_hiddenLastSparatorLineWithList:(NSInteger)rows indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
