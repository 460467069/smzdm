//
//  YYBBImageUploader.m
//  
//
//  Created by Wang_Ruzhou on 10/23/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBImageUploader.h"
#import <Qiniu/QiniuSDK.h>
#import <YYCategories/YYCategoriesMacro.h>
#import "UIImage+YYBBAdd.h"
#import "NSArray+YYBBAdd.h"
#import "YYBBNetworkApiClient.h"
#import "LxDBAnything.h"
#import <YYImage/YYImage.h>

@interface YYBBQiNiuModel : NSObject<YYModel>

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *url;

@end

@implementation YYBBQiNiuModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"token" : @"qiniuUpToken", @"url": @"qiniuDomain"};
}

@end

@interface YYBBImageUploader()

@property (nonatomic, strong) YYBBQiNiuModel *qiNiuModel;
@property (nonatomic, strong) NSArray<YYBBFileUploadModel *> *images;
@property (nonatomic, assign) CGFloat imageMaxSizeWithKB;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) UploadImagesCompletionHandler imgesCompletionHandler;
@property (nonatomic, copy) UploadImageProgressHandler progressHandler;

@end

@implementation YYBBImageUploader


static YYBBImageUploader* _instance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

// 图片
- (void)uploadImages:(NSArray *)images
     progressHandler:(UploadImageProgressHandler)progressHandler
   completionHandler:(UploadImagesCompletionHandler)completionHandler {
    [self uploadImages:images imageMaxSizeWithKB:500 progressHandler:progressHandler completionHandler:completionHandler];
}

- (void)uploadImages:(NSArray *)images
  imageMaxSizeWithKB:(CGFloat)imageMaxSizeWithKB
     progressHandler:(UploadImageProgressHandler)progressHandler
   completionHandler:(UploadImagesCompletionHandler)completionHandler {
    if (images.count <= 0) {
        NSError *networkError = [NSError errorWithDomain:NSURLErrorDomain
                                                    code:NSURLErrorUnknown
                                                userInfo:@{NSLocalizedDescriptionKey: @"未传入图片"}];
        !self.imgesCompletionHandler ?: self.imgesCompletionHandler(nil, networkError);
        return;
    }
    
    if (completionHandler == nil) {
        return;
    }
    
    self.images = images;
    self.imgesCompletionHandler = completionHandler;
    self.progressHandler = progressHandler;
    self.imageMaxSizeWithKB = imageMaxSizeWithKB;
    [self uploadImageWithIndex:0];
}

- (void)uploadImageWithIndex:(NSInteger)currentIndex {
    @weakify(self)
    self.currentIndex = currentIndex;
    YYBBFileUploadModel *imageModel = [self.images objectAtIndexSafe:currentIndex];
    UIImage *image = imageModel.image;
    if ([image isKindOfClass:[NSData class]]) {
        [self uploadImageWithFormData:imageModel];
    } else if ([image isKindOfClass:[UIImage class]]) {
        [image yybb_compressToMaxDataSizeKBytes:self.imageMaxSizeWithKB completionHandler:^(NSData *resultData) {
            @strongify(self)
            imageModel.image = resultData;
            [self uploadImageWithFormData:imageModel];
        }];
    }
}

- (void)uploadImageWithFormData:(YYBBFileUploadModel *)imageModel {
    [[YYBBFormNetworkAPIClient sharedClient] yybb_uploadWithURLString:kToolUploadPhotos parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        YYImage *image = [YYImage imageWithData:imageModel.image];
        NSString *imageType = YYImageTypeGetExtension(image.animatedImageType);
        NSString *mimeType = [NSString stringWithFormat:@"image/%@", imageType];
        [formData appendPartWithFileData:imageModel.image
                                    name:@"file"
                                fileName:imageModel.imageName
                                mimeType:mimeType];
    } progress:nil onFinished:^(id  _Nullable responseObj, NSError * _Nullable error) {
        if (error) {
            NSError *networkError = [NSError errorWithDomain:NSURLErrorDomain
                                                        code:NSURLErrorUnknown
                                                    userInfo:@{NSLocalizedDescriptionKey: @"Upload Failed"}];
            !self.imgesCompletionHandler ?: self.imgesCompletionHandler(nil, networkError);
            return;
        }
        
        // 更新数据
        [imageModel yy_modelSetWithJSON:responseObj];
        if (self.currentIndex == self.images.count - 1) {
            !self.imgesCompletionHandler ?: self.imgesCompletionHandler(self.images, nil);
        } else {
            self.currentIndex += 1;
            [self uploadImageWithIndex:self.currentIndex];
        }
    }];
}


- (void)uploadImageWithQiNiu:(YYBBFileUploadModel *)imageModel {
    @weakify(self)
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        @strongify(self)
        CGFloat currentIndex = (CGFloat)self.currentIndex;
        CGFloat totalCount = (CGFloat)self.images.count;
        CGFloat actuallyPercent = currentIndex / totalCount + 1.0 / totalCount * percent;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !self.progressHandler ?: self.progressHandler(actuallyPercent);
        });
    } params:nil checkCrc:NO cancellationSignal:nil];
    
    [upManager putData:imageModel.image key:nil token:self.qiNiuModel.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        @strongify(self)
        if (info.isOK) {
            //url 后台返回域名前缀
            //            NSString *imageUrl = [NSString stringWithFormat:@"%@%@", self.qiNiuModel.url, resp[@"key"]];
            NSString *imageUrl = [NSString stringWithFormat:@"%@", resp[@"key"]];
            imageModel.origin = imageUrl;
            if (self.currentIndex == self.images.count - 1) {
                !self.imgesCompletionHandler ?: self.imgesCompletionHandler(self.images, nil);
            } else {
                self.currentIndex += 1;
                [self uploadImageWithIndex:self.currentIndex];
            }
        } else {
            NSError *networkError = [NSError errorWithDomain:NSURLErrorDomain
                                                        code:NSURLErrorUnknown
                                                    userInfo:@{NSLocalizedDescriptionKey: @"图片上传失败, 请稍后再试"}];
            !self.imgesCompletionHandler ?: self.imgesCompletionHandler(nil, networkError);
        }
    } option:uploadOption];
}

@end
