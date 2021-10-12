//
//  NSDictionary+AES.m
//  MeLive
//
//  Created by WangRuzhou on 2021/9/1.
//

#import "NSDictionary+AES.h"
#import <YYBBSDK/NSData+YYBBAdd.h>

static NSString * const kAESEncryptedKey = @"OBZdrjA0C15t7cOU";

@implementation NSDictionary (AES)

// base64(aes)
- (NSString *)encryptionWithIv:(NSString *)iv {
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    NSString *result = [[NSString alloc] initWithData:bodyData encoding:NSUTF8StringEncoding];
    NSData *encryBodyData = [bodyData AES128EncryptedDataWithKey:kAESEncryptedKey iv:iv];
    NSString *base64Str = [encryBodyData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64Str;
}

// 解密
+ (NSDictionary *)decryptWithBase64Str:(NSString *)str iv:(NSString *)iv {
    NSData *encryBodyData = [[NSData alloc] initWithBase64EncodedString:str options:0];
    return [self decryptWithEncryBodyData:encryBodyData iv:iv];
}

// 解密
+ (NSDictionary *)decryptWithEncryBodyData:(NSData *)orginalData iv:(NSString *)iv {
    // 返回的是base64 data
    NSString *result = [[NSString alloc] initWithData:orginalData encoding:NSUTF8StringEncoding];
    //去掉空格和换行
    result = [result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    //base64解密
    NSData *encryBodyData = [[NSData alloc] initWithBase64EncodedString:result options:0];
    // 再解密
    NSData *decryptedData = [encryBodyData AES128DecryptedDataWithKey:kAESEncryptedKey iv:iv];
    NSError *error = nil;
    
    result = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:decryptedData options:0 error:&error];
    return dict;
}

@end
