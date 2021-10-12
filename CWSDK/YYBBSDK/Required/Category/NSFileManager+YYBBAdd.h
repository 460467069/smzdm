//
//  UIViewController+YYBBAdd.h
//  
//
//  Created by Mac on 2018/1/20.
//  Copyright © 2018年 ZeroDistance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSFileManager (YYBBAdd)

// 单个文件的大小
- (long long)fileSizeAtPath:(NSString*) filePath;
// 遍历文件夹获得文件夹大小
- (long long)folderSizeAtPath:(NSString*) folderPath;
// 缓存
- (NSString *)cacheSize;
// 清除缓存
- (void)clearCacheOnCompletion:(void (^)(void))clearCompletion;
// 下单引导视频路径
- (NSString *)yyGuideVideoPath;
// 下单数据缓存
- (NSString *)placeOrderPath;
// 钱包消费流水缓存
- (NSString *)walletBillPath;

/*
 * 说明：
 * 1、知道了这个函数是如何使用的之后我们可以进行相关改造，使其更方便的使用。
 * 2、这里传入文件的路径会自动截取,并且添加了相关的过滤条件，这里的参数和方式一中的相同。
 */
// 方法实现
- (NSString *)mimeTypeForFileAtPath:(NSString *)path;

@end
