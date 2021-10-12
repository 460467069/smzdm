//
//  YYBBBaseTableView.m
//  
//
//  Created by Wang_ruzhou on 2019/6/3.
//  Copyright © 2019 Wang_ruzhou. All rights reserved.
//

#import "YYBBBaseTableViewCell.h"


@implementation YYBBBaseTableViewCell

+(instancetype)yybb_baseCellWithTableView:(UITableView *)tableView
{
    YYBBBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (nil == cell) {
        cell = [[YYBBBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([self respondsToSelector:@selector(initUI)]) {
            [self initUI];
        }
    }
    return self;
}




- (instancetype)yybb_hiddenLastSparatorLineWithList:(NSInteger)rows indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == rows - 1) {
        self.separatorInset = UIEdgeInsetsMake(0, ([UIScreen mainScreen].bounds.size.width), 0, 0);
    }
    return self;
}

@end
