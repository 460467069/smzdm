//
//  UIViewController+YYBBAdd.m
//  
//
//  Created by Mac on 2018/1/20.
//  Copyright © 2018年 ZeroDistance. All rights reserved.
//

#import "NSFileManager+YYBBAdd.h"
#import <SDWebImage/SDImageCache.h>
#import <WebKit/WebKit.h>
#import <CoreServices/CoreServices.h>

@implementation NSFileManager (YYBBAdd)

// 单个文件的大小
- (long long)fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

// 遍历文件夹获得文件夹大小
- (long long)folderSizeAtPath:(NSString*) folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    
    return folderSize;
    
}

// 计算缓存
- (NSString *)cacheSize {
    CGFloat totalSize = 0;
    
    NSString * yyPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"com.ibireme.yykit"];
    totalSize += [self folderSizeAtPath:yyPath];
    
    NSString * sdPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"default"];
    totalSize += [self folderSizeAtPath:sdPath];
    
    totalSize += [self folderSizeAtPath:[self yyGuideVideoPath]];
    
    totalSize += [self folderSizeAtPath:[self placeOrderPath]];
    
    totalSize += [self folderSizeAtPath:[self walletBillPath]];
    
    totalSize += [[SDImageCache sharedImageCache] totalDiskSize];
    if (totalSize < 1024.0) {
        return  [NSString stringWithFormat:@"%.2fB",totalSize * 1.0];
    } else if (totalSize >= 1024.0 && totalSize < (1024.0*1024.0)){
        return  [NSString stringWithFormat:@"%.2fK",totalSize/1024.0];
    } if (totalSize >= (1024.0*1024.0) && totalSize < (1024.0*1024.0*1024.0)) {
        return [NSString stringWithFormat:@"%.2fM", totalSize/(1024.0*1024.0)];
    } else{
        return [NSString stringWithFormat:@"%.2fGB", totalSize/(1024.0*1024.0*1024.0)];
    }
}

- (void)clearCacheOnCompletion:(void (^)(void))clearCompletion {
    [self cleanCacheAndCookie:^{
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [[NSFileManager defaultManager] removeItemAtPath:[self yyGuideVideoPath] error:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[self walletBillPath] error:nil];
            !clearCompletion ?: clearCompletion();
        }];
    }];
}

/**清除缓存和cookie*/
- (void)cleanCacheAndCookie:(void (^)(void))clearCompletion {
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    
    //清除WebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        !clearCompletion ?: clearCompletion();
    }];
}

- (NSString *)yyGuideVideoPath {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *videoPath = [cachePath stringByAppendingPathComponent:@"YYGuideVideo"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:videoPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:videoPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return videoPath;
}

- (NSString *)placeOrderPath {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *videoPath = [cachePath stringByAppendingPathComponent:@"placeOrderCache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:videoPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:videoPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return videoPath;
}

- (NSString *)walletBillPath {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *videoPath = [cachePath stringByAppendingPathComponent:@"walletBillCache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:videoPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:videoPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return videoPath;
}

/*
 * 说明：
 * 1、知道了这个函数是如何使用的之后我们可以进行相关改造，使其更方便的使用。
 * 2、这里传入文件的路径会自动截取,并且添加了相关的过滤条件，这里的参数和方式一中的相同。
 */
// 方法实现
- (NSString *)mimeTypeForFileAtPath:(NSString *)path
{
    // 这里使用文件管理者的相关方法判断文件路径是否有后缀名
    if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
        return nil;
    }
    // [path pathExtension] 获得文件的后缀名 MIME类型字符串转化为UTI字符串
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    // UTI字符串转化为后缀扩展名
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    // application/octet-stream，此参数表示通用的二进制类型。
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)(MIMEType);
}

@end
