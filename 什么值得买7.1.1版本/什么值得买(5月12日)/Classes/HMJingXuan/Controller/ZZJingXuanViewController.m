//
//  ZZJingXuanViewController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/31.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZJingXuanViewController.h"
#import "ZZJingXuanModel.h"

static NSString *const kHMJingXuanTableViewCell = @"ZZJingXuanTableViewCell";

@interface ZZJingXuanViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ZZJingXuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kHMJingXuanTableViewCell];
    
}

- (void)loadData{
    self.dataSource = [NSMutableArray arrayWithArray:[ZZJingXuanModel models]];
    [self addElement];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)addElement{
    ZZJingXuanModel *model = [[ZZJingXuanModel alloc] init];
    model.title = @"JSPtach热修复";
    [self.dataSource addObject:model];
}

- (void)loadMoreData{
    [self.tableView.mj_footer endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHMJingXuanTableViewCell forIndexPath:indexPath];
    
    ZZJingXuanModel *model = self.dataSource[indexPath.row];
    
    cell.textLabel.text = model.title;
    
    return cell;
}

@end
