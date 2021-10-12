//
//  YYBBBaseTableView.h
//  
//
//  Created by Wang_ruzhou on 2019/6/3.
//  Copyright © 2019 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBBBaseTableView : UITableView

@property (nonatomic, strong) NSMutableSet<NSString *> *registeredCellIdentifiers;
@property (nonatomic, strong) NSMutableSet<NSString *> *registeredNibNames;
@property (nonatomic, strong) NSMutableSet<NSString *> *registeredHeaderFooterViewIdentifiers;
@property (nonatomic, strong) NSMutableSet<NSString *> *registeredHeaderFooterViewNibNames;

- (nullable __kindof UITableViewCell *)yybb_dequeueReusableCellClass:(nullable Class)ClassA;
- (nullable __kindof UITableViewCell *)yybb_dequeueReusableCellNibClass:(nullable Class)nibClass;
- (nullable __kindof UITableViewHeaderFooterView *)yybb_dequeueReusableHeaderFooterViewClass:(nullable Class)classA;
- (nullable __kindof UITableViewHeaderFooterView *)yybb_dequeueReusablHeaderFooterViewNibClass:(nullable Class)nibClass;

@end

NS_ASSUME_NONNULL_END
