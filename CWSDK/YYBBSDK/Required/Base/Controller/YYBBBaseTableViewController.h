//
//  YYBBBaseTableViewController.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//  二级主界面带tableView的控制器--->YYBBSecondBaseViewController

#import "YYBBBaseViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "YYBBBaseTableView.h"
#import "YYBBNetworkApiClient.h"
#import "YYBBRefreshProtocol.h"

@interface YYBBBaseTableViewController : YYBBBaseViewController<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, YYBBRefreshDelegate>

@property (nonatomic, strong  ) YYBBBaseTableView  *tableView;
@property (nonatomic, strong  ) UIColor          *tableViewColor;
@property (nonatomic, readonly) UITableViewStyle style;

- (YYBBBaseTableView *)yybb_customTableView;
- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
