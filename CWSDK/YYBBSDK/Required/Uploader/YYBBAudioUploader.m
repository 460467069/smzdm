//
//  YYBBAudioUploader.m
//  
//
//  Created by Wang_Ruzhou on 10/23/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBAudioUploader.h"
#import <YYCategories/YYCategoriesMacro.h>
#import "NSArray+YYBBAdd.h"
#import "YYBBNetworkApiClient.h"
#import "LxDBAnything.h"
#import "NSFileManager+YYBBAdd.h"


@interface YYBBAudioUploader()

@property (nonatomic, strong) NSArray<YYBBFileUploadModel *> *images;
@property (nonatomic, assign) CGFloat imageMaxSizeWithKB;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) UploadAudiosCompletionHandler completionHandler;
@property (nonatomic, copy) UploadAudioProgressHandler progressHandler;

@end

@implementation YYBBAudioUploader


static YYBBAudioUploader* _instance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (void)uploadAudios:(NSArray<YYBBFileUploadModel *> *)images
     progressHandler:(UploadAudioProgressHandler)progressHandler
   completionHandler:(UploadAudiosCompletionHandler)completionHandler {
    if (images.count <= 0) {
        NSError *networkError = [NSError errorWithDomain:NSURLErrorDomain
                                                    code:NSURLErrorUnknown
                                                userInfo:@{NSLocalizedDescriptionKey: @"No Audios"}];
        !self.completionHandler ?: self.completionHandler(nil, networkError);
        return;
    }
    
    if (completionHandler == nil) {
        return;
    }
    
    self.images = images;
    self.completionHandler = completionHandler;
    self.progressHandler = progressHandler;
    [self uploadImageWithIndex:0];
}


- (void)uploadImageWithIndex:(NSInteger)currentIndex {
    @weakify(self)
    self.currentIndex = currentIndex;
    YYBBFileUploadModel *imageModel = [self.images objectAtIndexSafe:currentIndex];
    [self uploadImageWithFormData:imageModel];
}

- (void)uploadImageWithFormData:(YYBBFileUploadModel *)imageModel {
    [[YYBBFormNetworkAPIClient sharedClient] yybb_uploadWithURLString:kToolUploadPhotos parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:imageModel.audioPath];
        NSString *mimeType = [[NSFileManager defaultManager] mimeTypeForFileAtPath:imageModel.audioPath];
        [formData appendPartWithFileData:data
                                    name:@"file"
                                fileName:imageModel.audioName
                                mimeType:@"mpeg"];
    } progress:nil onFinished:^(id  _Nullable responseObj, NSError * _Nullable error) {
        if (error) {
            NSError *networkError = [NSError errorWithDomain:NSURLErrorDomain
                                                        code:NSURLErrorUnknown
                                                    userInfo:@{NSLocalizedDescriptionKey: @"Upload Failed"}];
            !self.completionHandler ?: self.completionHandler(nil, networkError);
            return;
        }
        // 更新数据
        [imageModel yy_modelSetWithJSON:responseObj];
        if (self.currentIndex == self.images.count - 1) {
            !self.completionHandler ?: self.completionHandler(self.images, nil);
        } else {
            self.currentIndex += 1;
            [self uploadImageWithIndex:self.currentIndex];
        }
    }];
}


@end
