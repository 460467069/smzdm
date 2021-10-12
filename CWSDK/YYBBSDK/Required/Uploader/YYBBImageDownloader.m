//
//  YYBBImageDownloader.m
//  
//
//  Created by Wang_Ruzhou on 10/23/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBImageDownloader.h"
#import <YYCategories/YYCategoriesMacro.h>
#import "UIImage+YYBBAdd.h"
#import "NSArray+YYBBAdd.h"
#import <SDWebImage/SDWebImageManager.h>
#import "LxDBAnything.h"

@interface YYBBImageDownloader()

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) DownloadImagesCompletionHandler imgesCompletionHandler;
@property (nonatomic, copy) DownloadImageProgressHandler progressHandler;

@end

@implementation YYBBImageDownloader


static YYBBImageDownloader* _instance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

// 批量下载图片(支持NSString, NSURL)
- (void)downloadImages:(NSArray *)images
       progressHandler:(DownloadImageProgressHandler)progressHandler
     completionHandler:(DownloadImagesCompletionHandler)completionHandler {
    if (images.count <= 0 || completionHandler == nil) {
        return;
    }
    
    self.images = images;
    self.imgesCompletionHandler = completionHandler;
    self.progressHandler = progressHandler;
    [self downloadImageWithIndex:0];
}


- (void)downloadImageWithIndex:(NSInteger)currentIndex {
    @weakify(self)
    self.currentIndex = currentIndex;
    NSString *imageStr = [self.images objectAtIndexSafe:currentIndex];
    if ([imageStr isKindOfClass:[NSString class]]) {
        NSURL *url = [NSURL URLWithString:imageStr];
        [self downloadImageWithData:url];
    } else if ([imageStr isKindOfClass:[NSURL class]]) {
        [self downloadImageWithData:(NSURL *)imageStr];
    } else {
        NSError *error = [NSError errorWithDomain:NSURLErrorDomain
                                             code:NSURLErrorUnknown
                                         userInfo:@{NSLocalizedDescriptionKey: @"图片不支持"}];
        !self.imgesCompletionHandler ?: self.imgesCompletionHandler(error);
    }
}

- (void)downloadImageWithData:(NSURL *)imageURL {
    @weakify(self)
    [[SDWebImageManager sharedManager] loadImageWithURL:imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        @strongify(self)
        CGFloat percent = ((CGFloat)receivedSize) / ((CGFloat)expectedSize);
        CGFloat currentIndex = (CGFloat)self.currentIndex;
        CGFloat totalCount = (CGFloat)self.images.count;
        CGFloat actuallyPercent = currentIndex / totalCount + (totalCount - currentIndex) / totalCount * percent;
        !self.progressHandler ?: self.progressHandler(actuallyPercent);
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        @strongify(self)
        if (error) {
            NSError *networkError = [NSError errorWithDomain:NSURLErrorDomain
                                                        code:NSURLErrorUnknown
                                                    userInfo:@{NSLocalizedDescriptionKey: @"图片下载失败, 请稍后再试"}];
            !self.imgesCompletionHandler ?: self.imgesCompletionHandler(networkError);
            return;
        }
        
        if (finished) {
            if (self.currentIndex == self.images.count - 1) {
                !self.imgesCompletionHandler ?: self.imgesCompletionHandler(nil);
            } else {
                self.currentIndex += 1;
                [self downloadImageWithIndex:self.currentIndex];
            }
        }
    }];
}

@end
