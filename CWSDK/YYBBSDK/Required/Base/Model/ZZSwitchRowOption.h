//
//  ZZSwitchRowOption.h
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "ZZTableViewRowOption.h"

@interface ZZSwitchRowOption : ZZTableViewRowOption

@property (nonatomic, assign) BOOL isAppGroup;
@property (nonatomic, copy) NSString *boolKey;
@property (nonatomic, copy) void (^valuesChangedCompletionBlock)(BOOL isOn);

@end
