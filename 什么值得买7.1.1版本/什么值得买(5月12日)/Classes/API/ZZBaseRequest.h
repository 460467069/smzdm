//
//  ZZBaseRequest.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/2/24.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZBaseRequest : NSObject

@property (nonatomic, copy) NSString *f;        /**< 平台 */
@property (nonatomic, copy) NSString *v;        /**< 版本号 */
@property (nonatomic, copy) NSString *weixin;   /**< 是否微信, 1:是, 0:否 */
@property (nonatomic, copy) NSString *urlStr;

@end

/** 表格数据请求 */
@interface ZZBaseTableRequest : ZZBaseRequest
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *time_sort;
@end
