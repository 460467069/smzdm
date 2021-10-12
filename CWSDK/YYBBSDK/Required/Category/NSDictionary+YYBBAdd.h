//
//  NSDictionary+YYBBAdd.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/8/3.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YYBBAdd)

- (NSDictionary *)signParameters;
- (NSDictionary *)encrpyParameters;
+ (NSDictionary *)yybb_dictionaryWithJSON:(id)json;

@end
