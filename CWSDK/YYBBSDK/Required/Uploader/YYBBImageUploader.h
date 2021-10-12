//
//  YYBBImageUploader.h
//  
//
//  Created by Wang_Ruzhou on 10/23/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "YYBBFileUploadModel.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^ _Nullable UploadImagesCompletionHandler)(NSArray <YYBBFileUploadModel *> * _Nullable urlStrs, NSError * _Nullable error);
typedef void(^ _Nullable UploadImageProgressHandler)(CGFloat progress);



@interface YYBBImageUploader : NSObject

+ (instancetype)sharedInstance;

- (void)uploadImages:(NSArray<YYBBFileUploadModel *> *)images
     progressHandler:(UploadImageProgressHandler)progressHandler
   completionHandler:(UploadImagesCompletionHandler)completionHandler;

- (void)uploadImages:(NSArray<YYBBFileUploadModel *> *)images
  imageMaxSizeWithKB:(CGFloat)imageMaxSizeWithKB
     progressHandler:(UploadImageProgressHandler)progressHandler
   completionHandler:(UploadImagesCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
