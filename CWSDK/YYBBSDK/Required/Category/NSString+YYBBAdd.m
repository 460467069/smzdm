//
//  NSString+YYBBAdd.m
//  YYBBSDKDemo
//
//  Created by Wang_Ruzhou on 2018/8/23.
//  Copyright © 2018年 Wang_Ruzhou. All rights reserved.
//

#import "NSString+YYBBAdd.h"
#import "YYBBDateFormatterFactory.h"

/**
 Returns a percent-escaped string following RFC 3986 for a query string key or value.
 RFC 3986 states that the following characters are "reserved" characters.
    - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
    - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="

 In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
 query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
 should be percent-escaped in the query string.
    - parameter string: The string to be percent-escaped.
    - returns: The percent-escaped string.
 */
NSString * YYBBPercentEscapedStringFromString(NSString *string) {
    static NSString * const kYYBBCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const kYYBBCharactersSubDelimitersToEncode = @"!$&'()*+,;=";

    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kYYBBCharactersGeneralDelimitersToEncode stringByAppendingString:kYYBBCharactersSubDelimitersToEncode]];

    // FIXME: https://github.com/AFNetworking/AFNetworking/pull/3028
    // return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];

    static NSUInteger const batchSize = 50;

    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;

    while (index < string.length) {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wgnu"
        NSUInteger length = MIN(string.length - index, batchSize);
#pragma GCC diagnostic pop
        NSRange range = NSMakeRange(index, length);

        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [string rangeOfComposedCharacterSequencesForRange:range];

        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];

        index += range.length;
    }

    return escaped;
}

#pragma mark -

@interface YYBBQueryStringPair : NSObject
@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (instancetype)initWithField:(id)field value:(id)value;

- (NSString *)URLEncodedStringValue;
@end

@implementation YYBBQueryStringPair

- (instancetype)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.field = field;
    self.value = value;

    return self;
}

- (NSString *)URLEncodedStringValue {
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return YYBBPercentEscapedStringFromString([self.field description]);
    } else {
        return [NSString stringWithFormat:@"%@=%@", YYBBPercentEscapedStringFromString([self.field description]), YYBBPercentEscapedStringFromString([self.value description])];
    }
}

@end

#pragma mark -

FOUNDATION_EXPORT NSArray * YYBBQueryStringPairsFromDictionary(NSDictionary *dictionary);
FOUNDATION_EXPORT NSArray * YYBBQueryStringPairsFromKeyAndValue(NSString *key, id value);

NSString * YYBBQueryStringFromParameters(NSDictionary *parameters) {
    NSMutableArray *mutablePairs = [NSMutableArray array];
    for (YYBBQueryStringPair *pair in YYBBQueryStringPairsFromDictionary(parameters)) {
        [mutablePairs addObject:[pair URLEncodedStringValue]];
    }

    return [mutablePairs componentsJoinedByString:@"&"];
}

NSArray * YYBBQueryStringPairsFromDictionary(NSDictionary *dictionary) {
    return YYBBQueryStringPairsFromKeyAndValue(nil, dictionary);
}

NSArray * YYBBQueryStringPairsFromKeyAndValue(NSString *key, id value) {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];

    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];

    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        // Sort dictionary keys to ensure consistent ordering in query string, which is important when deserializing potentially ambiguous sequences, such as an array of dictionaries
        for (id nestedKey in [dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            id nestedValue = dictionary[nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:YYBBQueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue)];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        for (id nestedValue in array) {
            [mutableQueryStringComponents addObjectsFromArray:YYBBQueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@[]", key], nestedValue)];
        }
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in [set sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            [mutableQueryStringComponents addObjectsFromArray:YYBBQueryStringPairsFromKeyAndValue(key, obj)];
        }
    } else {
        [mutableQueryStringComponents addObject:[[YYBBQueryStringPair alloc] initWithField:key value:value]];
    }

    return mutableQueryStringComponents;
}

@implementation NSString (YYBBAdd)

- (NSString *)substringFromIndexSafe:(NSUInteger)from {
    NSInteger start = from;
    if (start < 0) {
        return [self copy];
    }
    if (start > self.length) {
        return nil;
    }
    return [self substringFromIndex:from];
}

- (NSString *)substringToIndexSafe:(NSUInteger)to {
    NSInteger end = to;
    if (end < 0) {
        return nil;
    }
    if (end >= self.length) {
        return [self copy];
    }
    return [self substringToIndex:to];
}

- (NSString *)substringWithRangeSafe:(NSRange)range {
#if DEBUG
    if (range.length == 0) { //这种情况对API合法，但是开发中一般不可能使用
        NSLog(@"NSString substringWithRangeSafe subRange length 0 of out of range (%d,%lu),string=%@", 0, (unsigned long)self.length, self);
    }
#endif

    if (range.location > self.length) {
        return nil;
    }
    if (range.location + range.length > self.length) {
        return [self substringWithRange:NSMakeRange(range.location, self.length - range.location)];
    }
    return [self substringWithRange:range];
}

- (NSString *)stringByReplacingCharactersInRangeSafe:(NSRange)range withString:(NSString *)replacement {
#if DEBUG
    if (range.length == 0) { //这种情况对API合法，但是开发中一般不可能使用
        NSLog(@"NSString substringWithRangeSafe subRange length 0 of out of "
              @"range (%d,%lu),string=%@",
              0, (unsigned long)self.length, self);
    }
#endif
    if (range.location > self.length) {
        NSLog(@"NSString stringByReplacingCharactersInRangeSafe range out "
              @"of bounds,rang (%lu,%lu) out of range (%d,%lu),string=%@",
              (unsigned long)range.location, (unsigned long)range.length, 0,
              (unsigned long)self.length, self);
        return nil;
    }
    if (range.location + range.length > self.length) {
        NSLog(@"NSString stringByReplacingCharactersInRangeSafe range out "
              @"of bounds,rang (%lu,%lu) out of range (%d,%lu),string=%@",
              (unsigned long)range.location, (unsigned long)range.length, 0,
              (unsigned long)self.length, self);
        return [self stringByReplacingCharactersInRange:NSMakeRange(range.location,self.length - range.location) withString:replacement];
    }
    return [self stringByReplacingCharactersInRange:range withString:replacement];
}

- (NSString *)stringByAppendingStringSafe:(NSString *)aString {
    if (!aString) {
        NSLog(@"NSString stringByAppendingStringSafe append nil，string=%@", self);
        return [self copy];
    }
    return [self stringByAppendingString:aString];
}

- (BOOL)contains:(NSString *)string {
    return ( [self rangeOfString:string].location != NSNotFound );
}

- (double)doubleValueSafe {
    if (self && [self respondsToSelector:@selector(doubleValue)]) {
        return [self doubleValue];
    }
    return 0.0f;
}

- (float)floatValueSafe {
    if (self && [self respondsToSelector:@selector(floatValue)]) {
        return [self floatValue];
    }
    return 0.0f;
}

- (int)intValueSafe {
    if (self && [self respondsToSelector:@selector(intValue)]) {
        return [self intValue];
    }
    return 0;
}

- (NSInteger)integerValueSafe NS_AVAILABLE(10_5, 2_0) {
    if (self && [self respondsToSelector:@selector(integerValue)]) {
        return [self integerValue];
    }
    return 0;
}

- (long long)longLongValueSafe NS_AVAILABLE(10_5, 2_0) {
    if (self && [self respondsToSelector:@selector(longLongValue)]) {
        return [self longLongValue];
    }
    return 0L;
}

- (BOOL)boolValueSafe NS_AVAILABLE(10_5, 2_0) {
    if (self && [self respondsToSelector:@selector(boolValue)]) {
        return [self boolValue];
    }
    return false;
}

- (unichar)characterAtIndexSafe:(NSUInteger)index {
    if (self && [self respondsToSelector:@selector(characterAtIndexSafe:)]) {
        if (self.length > index) {
            return [self characterAtIndex:index];
        }
    }
    return 0;
}

- (NSString *)yybb_stringByURLEncode {
    NSString *original = self;
    NSString *decoded = [original stringByRemovingPercentEncoding];
    if ([original isEqualToString:decoded]) {
        // The URL was not encoded yet
        NSString *encodedUrlString=[original stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return encodedUrlString;
    } else {
        // The URL was already encoded
        return self;
    }
}

- (NSDictionary *)yybb_urlStringToDictionary {
    NSString *queryString = nil;
    if ([self containsString:@"?"]) {
        NSArray *components = [self componentsSeparatedByString:@"?"];
        if(components.count > 1) {
            queryString = components[1];
            return [queryString yybb_queryToDictionary];
        }
    }
    return nil;
}

- (NSDictionary *)yybb_queryToDictionary {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSArray *array = [self componentsSeparatedByString:@"&"];
    if (array && array.count > 0) {
        for (int i = 0; i < [array count]; i++) {
            NSString *string = array[i];
            NSArray *keyValueArray = [string componentsSeparatedByString:@"="];
            if (keyValueArray.count == 2) {
                NSString *key = keyValueArray[0];
                NSString *value = keyValueArray[1];
                NSString *newValue = [value stringByRemovingPercentEncoding];
                if (newValue) {
                    value = newValue;
                }
                dic[key] = value;
            }
        }
    }
    return dic;
}

- (NSString *)uppercaseFirstString {
    NSString *first = [self substringToIndexSafe:1];
    NSString *other = [self substringFromIndexSafe:1];
    return [NSString stringWithFormat:@"%@%@", [first uppercaseString], other];
}

+ (NSString *)baseUrlString:(NSString *)baseUrlString
               webUrlString:(NSString *)urlString
                     params:(NSDictionary *)params {
    NSURL *baseURL = [NSURL URLWithString:baseUrlString];
    NSURL *URL = [NSURL URLWithString:urlString relativeToURL:baseURL];
    NSString *query = YYBBQueryStringFromParameters(params);
    if (!query) {
        query = @"";
    }
    NSString *resultString = [URL.absoluteString stringByAppendingFormat:URL.query ? @"&%@" : @"?%@", query];
    return resultString;
}

- (NSString *)yybb_stringByTrimingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)yybb_stringByTrimingAllWhitespace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSUInteger)numberOfLines {
    return [[self componentsSeparatedByString:@"\n"] count] + 1;
}

// 字符串转时间戳
- (NSString *)getTimestampStr {
    NSDateFormatter *dateFormatter = [[YYBBDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *tempDate = [dateFormatter dateFromString:self];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}


// 获取当前时间戳有(以秒为单位)
+ (NSString *)getNowTimeTimestamp
{
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

// 获取当前时间戳有(以毫秒为单位)
+ (NSString *)getNowTimeTimestamp2
{
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970] * 1000)];
    return timeSp;
}

// 生成指定长度的随机字符串
+ (NSString *)getRandomStringWithLength:(NSInteger)length {
    NSString *sourceString = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *resultString = [NSMutableString string];
    for (NSInteger i = 0; i < length; i++) {
        [resultString appendString:[sourceString substringWithRange:NSMakeRange(arc4random() % (sourceString.length), 1)]];
    }
    return resultString.copy;
}


@end
