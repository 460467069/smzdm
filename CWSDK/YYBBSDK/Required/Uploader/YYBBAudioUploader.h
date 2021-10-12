//
//  YYBBAudioUploader.h
//  
//
//  Created by Wang_Ruzhou on 10/23/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "YYBBFileUploadModel.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^ _Nullable UploadAudiosCompletionHandler)(NSArray <YYBBFileUploadModel *> * _Nullable urlStrs, NSError * _Nullable error);
typedef void(^ _Nullable UploadAudioProgressHandler)(CGFloat progress);

@interface YYBBAudioUploader : NSObject

+ (instancetype)sharedInstance;

- (void)uploadAudios:(NSArray<YYBBFileUploadModel *> *)images
     progressHandler:(UploadAudioProgressHandler)progressHandler
   completionHandler:(UploadAudiosCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
