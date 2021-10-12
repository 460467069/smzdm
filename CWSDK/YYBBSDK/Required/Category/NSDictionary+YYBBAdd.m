//
//  NSDictionary+YYBBAdd.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/8/3.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

#import "NSDictionary+YYBBAdd.h"
#import <YYCategories/NSString+YYAdd.h>
#import "YYBBSDK.h"
#import "YYBBUtilities.h"
#import "NSData+YYBBAdd.h"
#import "NSString+YYBBAdd.h"

@implementation NSDictionary (YYBBAdd)

- (NSDictionary *)signParameters
{
    NSMutableArray *keyValuePairs = [NSMutableArray array];
    NSArray *sortedKeys = [self.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    [sortedKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        NSString *kvPair = [NSString stringWithFormat:@"%@=%@", key, self[key]];
        [keyValuePairs addObject:kvPair];
    }];
    
    NSString *salt = [YYBBSDK sharedInstance].config.appSecret;
    NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:self];
    NSString *stringValue = [NSString stringWithFormat:@"%@%@", [keyValuePairs componentsJoinedByString:@""], salt];
    newParameters[@"sign"] = [stringValue md5String];
    
    return newParameters;
}

+ (NSDictionary *)yybb_dictionaryWithJSON:(id)json {
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}

- (NSDictionary *)encrpyParameters {
    NSMutableDictionary *bodyParams = [NSMutableDictionary dictionary];
    bodyParams[@"timestamp"] = [NSString getNowTimeTimestamp];
    bodyParams[@"onceid"] = [NSString stringWithFormat:@"%@%@", YYBBInInInAccessKey, [NSString getNowTimeTimestamp2]];
    bodyParams[@"data"] = self;
    // 数据包AES加密
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:bodyParams options:0 error:nil];
    NSString *result = [[NSString alloc] initWithData:bodyData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", result);

    NSData *encryBodyData = [bodyData AES128EncryptedDataWithKey:YYBBInInInSecretKey];
    NSString *base64Str = [encryBodyData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSMutableDictionary *encryParams = [NSMutableDictionary dictionary];
    encryParams[@"data"] = base64Str;
    return encryParams.copy;
}

@end
