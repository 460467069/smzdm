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
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ZZJingXuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self tableViewInitial];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kHMJingXuanTableViewCell];
}

/** 初始化tableView */
- (void)tableViewInitial {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollsToTop = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHMJingXuanTableViewCell forIndexPath:indexPath];
    
    ZZJingXuanModel *model = self.dataArray[indexPath.row];
    
    cell.textLabel.text = model.title;
    
    return cell;
}


#pragma mark - getter && setter

- (NSArray *)dataArray {
	if(_dataArray == nil) {
		_dataArray = [ZZJingXuanModel models];
	}
	return _dataArray;
}

@end
