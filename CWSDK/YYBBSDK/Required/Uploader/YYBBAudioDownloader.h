//
//  YYBBAudioDownloader.h
//  
//
//  Created by Wang_Ruzhou on 10/23/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

typedef void(^ _Nullable DownloadAudiosCompletionHandler)(NSArray *filePaths, NSError * _Nullable error);
typedef void(^ _Nullable DownloadAudioProgressHandler)(CGFloat progress);

#import <Foundation/Foundation.h>
#import "YYBBFileUploadModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBBAudioDownloader : NSObject

+ (instancetype)sharedInstance;

// 批量下载图片(支持NSString, NSURL)
- (void)downloadAudios:(NSArray *)audios
       progressHandler:(DownloadAudioProgressHandler)progressHandler
     completionHandler:(DownloadAudiosCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
