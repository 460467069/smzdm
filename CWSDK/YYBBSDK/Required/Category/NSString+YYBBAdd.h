//
//  NSString+YYBBAdd.h
//  YYBBSDKDemo
//
//  Created by Wang_Ruzhou on 2018/8/23.
//  Copyright © 2018年 Wang_Ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * YYBBQueryStringFromParameters(NSDictionary *parameters);

@interface NSString (YYBBAdd)

- (NSString *)substringFromIndexSafe:(NSUInteger)from;
- (NSString *)substringToIndexSafe:(NSUInteger)to;
- (NSString *)substringWithRangeSafe:(NSRange)range;
- (NSString *)stringByReplacingCharactersInRangeSafe:(NSRange)range withString:(NSString *)replacement;
- (NSString *)stringByAppendingStringSafe:(NSString *)aString;
- (double)doubleValueSafe;
- (float)floatValueSafe;
- (int)intValueSafe;
- (NSInteger)integerValueSafe NS_AVAILABLE(10_5, 2_0);
- (long long)longLongValueSafe NS_AVAILABLE(10_5, 2_0);
- (BOOL)boolValueSafe NS_AVAILABLE(10_5, 2_0);
- (unichar)characterAtIndexSafe:(NSUInteger)index;

- (BOOL)contains:(NSString *)string;
- (NSString *)yybb_stringByURLEncode;
// 支持完整url query转字典
- (NSDictionary *)yybb_urlStringToDictionary;
/** query转字典(query不要预先decode) */
- (NSDictionary *)yybb_queryToDictionary;
- (NSString *)uppercaseFirstString;


/// 拼接完整的URL, 适用get请求, 拼接网页URL
/// @param baseUrlString baseURL
/// @param urlString 相对路径
/// @param params query参数
+ (NSString *)baseUrlString:(NSString *)baseUrlString
               webUrlString:(NSString *)urlString
                     params:(NSDictionary *)params;

/**
 *  删除空格
 */
- (NSString *)yybb_stringByTrimingWhitespace;
- (NSString *)yybb_stringByTrimingAllWhitespace;
// 行数
- (NSUInteger)numberOfLines;

// 字符串转时间戳
- (NSString *)getTimestampStr;

// 获取当前时间戳有(以秒为单位)
+ (NSString *)getNowTimeTimestamp;
//获取当前时间戳有(以毫秒为单位)
+ (NSString *)getNowTimeTimestamp2;
// 生成指定长度的随机字符串
+ (NSString *)getRandomStringWithLength:(NSInteger)length;

@end
