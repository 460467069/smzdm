//
//  NSString+ZZBound.m
//  什么值得买(5月7日)
//
//  Created by Wang_ruzhou on 16/5/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "NSString+ZZBound.h"


@implementation NSString (ZZBound)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

- (NSString *)caculateWeek{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    
    NSDate *date = [formatter dateFromString:self];
    //今天是星期四
    NSDate *nowDate = [formatter dateFromString:@"20161201"];
    //日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay;
    NSDateComponents *comoments = [calendar components:unit fromDate:nowDate toDate:date options:0];
    
    NSInteger day = comoments.day;
    NSInteger i = day % 7;
    
    switch (i) {
        case 0:
            return @"星期四";
            break;
        case 1:
        case -6:
            return @"星期五";
            break;
        case 2:
        case -5:
            return @"星期六";
            break;
        case 3:
        case -4:
            return @"星期日";
            break;
        case 4:
        case -3:
            return @"星期一";
            break;
        case 5:
        case -2:
            return @"星期二";
            break;
        case 6:
        case -1:
            return @"星期三";
            break;
        default:
            return nil;
    }
    
}

@end
