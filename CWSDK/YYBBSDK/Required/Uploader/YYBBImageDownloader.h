//
//  YYBBImageDownloader.h
//  
//
//  Created by Wang_Ruzhou on 10/23/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

typedef void(^ _Nullable DownloadImagesCompletionHandler)(NSError * _Nullable error);
typedef void(^ _Nullable DownloadImageProgressHandler)(CGFloat progress);

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBBImageDownloader : NSObject

+ (instancetype)sharedInstance;

// 批量下载图片(支持NSString, NSURL)
- (void)downloadImages:(NSArray *)images
       progressHandler:(DownloadImageProgressHandler)progressHandler
     completionHandler:(DownloadImagesCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
