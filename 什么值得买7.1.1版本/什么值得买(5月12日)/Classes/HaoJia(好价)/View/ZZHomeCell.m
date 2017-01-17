//
//  ZZHomeCell.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZHomeCell.h"



@implementation ZZHomeCell


- (void)setContentController:(ZZContentViewController *)contentController{
    
    _contentController = contentController;
    
    
    [self.contentView removeAllSubviews]; //必须移除掉原先所有的子控件, 不然会重复添加
    
    [self.contentView addSubview:contentController.tableView];
    
//    LxDBAnyVar(contentController.tableView.frame);
    //
    self.contentController.tableView.frame = self.contentView.bounds;
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //这句代码放这里tableView的frame就会有问题
//    self.contentController.tableView.frame = self.contentView.bounds;
    
}


@end
