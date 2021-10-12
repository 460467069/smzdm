//
//  YDWebModel.h
//  
//
//  Created by Wang_Ruzhou on 10/15/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBBWebModel : NSObject

@property(nonatomic,   copy) NSString *title;
@property(nonatomic,   copy) NSString *htmlString;
@property(nonatomic,   copy) NSString *urlStr;
@property(nonatomic,   copy) NSDictionary *cookie;
@property(nonatomic, assign) BOOL needInterceptRequest;

- (instancetype)initWithTitle:(nullable NSString *)title
                          url:(NSString *)urlStr
                       cookie:(nullable NSDictionary *)cookie
         needInterceptRequest:(BOOL)needInterceptRequest;

- (instancetype)initWithTitle:(nullable NSString *)title
                 htmlString:(NSString *)htmlString
              cookie:(nullable NSDictionary *)cookie
needInterceptRequest:(BOOL)needInterceptRequest;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
