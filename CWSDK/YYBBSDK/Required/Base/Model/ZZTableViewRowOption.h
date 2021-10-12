//
//  ZZTableViewRowOption.h
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYBBBaseModel.h"

typedef NS_ENUM(NSUInteger, YYBBTableViewCellAccessoryType) {
    YYBBTableViewCellAccessoryTypeNone,
    YYBBTableViewCellAccessoryTypeDisclosureIndicator,
    YYBBTableViewCellAccessoryTypeSwitch,
    YYBBTableViewCellAccessoryTypeCustomImageView,
};

@interface ZZTableViewRowOption : YYBBBaseModel

@property (nonatomic, strong, nullable) NSIndexPath *indexPath;
@property (nonatomic,   copy, nullable) NSString *reuseIdentifier;
@property (nonatomic, strong, nullable) NSMutableArray<ZZTableViewRowOption *> *subRowOptions;
@property (nonatomic, strong, nullable) UIImage *placeHolderImage;
@property (nonatomic, strong, nullable) id image;
@property (nonatomic, strong, nullable) id model;
@property (nonatomic,   copy, nullable) NSString *title;
@property (nonatomic, strong, nullable) NSString *titleColorStr;
@property (nonatomic,   copy, nullable) NSAttributedString *titleAttributedString;
@property (nonatomic,   copy, nullable) NSString *identifier;
@property (nonatomic,   copy, nullable) NSString *subTitle;
@property (nonatomic, strong, nullable) NSString *subTitleColorStr;
@property (nonatomic,   copy, nullable) NSAttributedString *subtitleAttributedString;
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) YYBBTableViewCellAccessoryType accessoryType;
@property (nonatomic, assign) BOOL userInteractionEnabled;
@property (nonatomic, assign) BOOL disabled;
@property (nonatomic, assign) UIEdgeInsets separatorInset;
@property (nonatomic, assign) BOOL hiddenLastSeparator;
// 用于UISwitch
@property (nonatomic, assign) BOOL isOn;
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic,   copy, nullable) void(^optionBlock)( ZZTableViewRowOption * _Nonnull rowOption);

+ (_Nonnull instancetype)optionWithImage:(id _Nullable)image title:(NSString *_Nullable)title;
+ (_Nonnull instancetype)optionWithImage:(id _Nullable)image title:(NSString *_Nullable)title subTitle:(NSString *_Nullable)subTitle;

@end
