//
//  NSDictionary+AES.h
//  MeLive
//
//  Created by WangRuzhou on 2021/9/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (AES)

// base64(aes)
- (NSString *)encryptionWithIv:(NSString *)iv;
// 解密
+ (NSDictionary *)decryptWithBase64Str:(NSString *)str iv:(NSString *)iv;
// 解密
+ (NSDictionary *)decryptWithEncryBodyData:(NSData *)encryBodyData iv:(NSString *)iv;

@end

NS_ASSUME_NONNULL_END
