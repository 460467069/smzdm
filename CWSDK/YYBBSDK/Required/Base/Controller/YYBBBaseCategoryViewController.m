//
//  BaseViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/9.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "YYBBBaseCategoryViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "YYBBFullScreenGestureScrollView.h"

@interface YYBBBaseCategoryViewController ()

@end

@implementation YYBBBaseCategoryViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listContainerView.frame = CGRectMake(0,
                                              [self preferredCategoryViewHeight],
                                              self.view.bounds.size.width,
                                              self.view.bounds.size.height - [self preferredCategoryViewHeight]);
}

- (void)_initUI {
    [self.view addSubview:self.listContainerView];
    self.categoryView.frame = CGRectMake(0, 0, self.view.bounds.size.width, [self preferredCategoryViewHeight]);
    self.categoryView.listContainer = self.listContainerView;
    self.categoryView.delegate = self;
    [self.view addSubview:self.categoryView];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    id<JXCategoryListContentViewDelegate> vc = self.contentViewControllers[index];
    if ([vc respondsToSelector:@selector(listView)]) {
        return vc;
    }
    return nil;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

- (Class)scrollViewClassInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return [YYBBFullScreenGestureScrollView class];
}

#pragma mark - Getter && Setter

- (NSMutableArray *)contentViewControllers {
    if (!_contentViewControllers) {
        _contentViewControllers = [NSMutableArray array];
    }
    return _contentViewControllers;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryBaseView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 44;
}

- (JXCategoryBaseView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [self preferredCategoryView];
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView == nil) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView
                                                                      delegate:self];
    }
    return _listContainerView;
}

@end
