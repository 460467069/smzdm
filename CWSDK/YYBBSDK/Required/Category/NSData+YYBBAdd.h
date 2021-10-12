//
//  NSData+YYBBAdd.h
//  DaDongMen
//
//  Created by WangRuzhou on 3/23/15.
//  Copyright (c) 2015 Optimus Prime Information Technology Co., Ltd. All rights reserved.
//


@interface NSData (YYBBAdd)

- (NSData *)AES128EncryptedDataWithKey:(NSString *)key;
- (NSData *)AES128DecryptedDataWithKey:(NSString *)key;
- (NSData *)AES128EncryptedDataWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128DecryptedDataWithKey:(NSString *)key iv:(NSString *)iv;

@end
