//
//  YDWebModel.m
//  
//
//  Created by Wang_Ruzhou on 10/15/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBWebModel.h"

@implementation YYBBWebModel

- (instancetype)initWithTitle:(nullable NSString *)title
                          url:(NSString *)urlStr
                       cookie:(nullable NSDictionary *)cookie
         needInterceptRequest:(BOOL)needInterceptRequest {
    
    self = [super init];
    if (self) {
        _title = [title copy];
        _urlStr = [urlStr copy];
        _cookie = [cookie copy];
        _needInterceptRequest = needInterceptRequest;
    }
    return self;
}


- (instancetype)initWithTitle:(nullable NSString *)title
                 htmlString:(NSString *)htmlString
              cookie:(nullable NSDictionary *)cookie
         needInterceptRequest:(BOOL)needInterceptRequest {
    self = [super init];
    if (self) {
        _title = [title copy];
        htmlString = [htmlString copy];
        _cookie = [cookie copy];
        _needInterceptRequest = needInterceptRequest;
    }
    return self;
}

@end
