//
//  BaseViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/9.
//  Copyright © 2018年 jiaxin. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import "YYBBBaseViewController.h"
#import <JXCategoryView/JXCategoryView.h>
#import <JXCategoryView/JXCategoryListContainerView.h>

@interface YYBBBaseCategoryViewController : YYBBBaseViewController<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSMutableArray *contentViewControllers;

@property (nonatomic, strong) JXCategoryBaseView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

- (JXCategoryBaseView *)preferredCategoryView;

- (CGFloat)preferredCategoryViewHeight;

@end
