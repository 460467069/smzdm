//
//  YYBBSectionModel.h
//  
//
//  Created by Wang_Ruzhou on 9/17/19.
//  Copyright © 2019 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBBSectionListModel : NSObject<IGListDiffable>

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *sectionControllerStr;
@property (nonatomic, strong) NSString *contentViewController;
@property (nonatomic,   copy) NSString *tableRequest;
// 列数
@property (nonatomic, assign) NSInteger columns;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat sectionHeaderHeight;
@property (nonatomic, assign) CGFloat sectionFooterHeight;
@property (nonatomic, strong) NSArray *subItems;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) UIEdgeInsets inset;
@property (nonatomic, strong) NSString *cellClass;
@property (nonatomic, assign) BOOL cellNibLoad;
@property (nonatomic, strong) NSString *supplementaryHeaderViewClass;
@property (nonatomic, assign) BOOL headerViewNibLoad;
@property (nonatomic, strong) NSString *supplementaryFooterViewClass;
@property (nonatomic, assign) BOOL footerViewNibLoad;
@property (nonatomic, strong) NSArray<NSString *> *supportedElementKinds;
@property (nonatomic, assign) CGSize supplementaryViewSize;
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@property(nonatomic, strong) IGListSectionController *sectionController;
@property(nonatomic, strong) YYBBSectionListModel *subSectionListModel;
@property (nonatomic, copy) void (^itemClickBlock)(id itemModel);

- (instancetype)initWithSubItmes:(nullable NSArray *)subItems
               sectionController:(IGListSectionController *)sectionController;

@end

NS_ASSUME_NONNULL_END
