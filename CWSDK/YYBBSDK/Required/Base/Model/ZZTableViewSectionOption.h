//
//  ZZTableViewSectionOption.h
//  BloothSmoking
//
//  Created by Wang_Ruzhou on 11/1/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZTableViewRowOption.h"
#import "YYBBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZTableViewSectionOption : YYBBBaseModel

@property (nonatomic,   copy, nullable) NSString *reuseIdentifier;
@property (nonatomic,   copy, nullable) NSString *imageStr;
@property (nonatomic,   copy, nullable) NSString *title;
@property (nonatomic, strong, nullable) UIColor *titleColor;
@property (nonatomic,   copy, nullable) NSString *subTitle;
@property (nonatomic, strong, nullable) UIColor *subTitleColor;
// 组头
@property (nonatomic, assign) CGFloat sectionHeight;
@property (nonatomic, assign) CGFloat sectionHeaderHeight;
@property (nonatomic,   copy, nullable) NSString *headerReuseIdentifier;

// 组wei
@property (nonatomic, assign) CGFloat sectionFooterHeight;
@property (nonatomic,   copy, nullable) NSString *footerReuseIdentifier;
@property (nonatomic,   copy, nullable) void(^optionBlock)( ZZTableViewSectionOption * _Nonnull sectionOption);
@property (nonatomic, strong) NSMutableArray<ZZTableViewRowOption *> *rowOptions;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, assign) BOOL unfold;
@property (nonatomic, assign) BOOL unfoldEnabled;

@end

NS_ASSUME_NONNULL_END
