//
//  YYBBAudioDownloader.m
//  
//
//  Created by Wang_Ruzhou on 10/23/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBAudioDownloader.h"
#import <YYCategories/YYCategoriesMacro.h>
#import <YYBBSDK/YYBBNetworkApiClient.h>
#import "NSArray+YYBBAdd.h"
#import "LxDBAnything.h"

@interface YYBBAudioDownloader()

@property (nonatomic, strong) NSArray *audios;
@property (nonatomic, strong) NSMutableArray *downloadFilePaths;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) DownloadAudiosCompletionHandler completionHandler;
@property (nonatomic, copy) DownloadAudioProgressHandler progressHandler;

@end

@implementation YYBBAudioDownloader


static YYBBAudioDownloader* _instance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)downloadAudios:(NSArray *)audios
       progressHandler:(DownloadAudioProgressHandler)progressHandler
     completionHandler:(DownloadAudiosCompletionHandler)completionHandler {
    if (audios.count <= 0 || completionHandler == nil) {
        return;
    }
    self.downloadFilePaths = [NSMutableArray array];
    self.audios = audios;
    self.completionHandler = completionHandler;
    self.progressHandler = progressHandler;
    [self downloadAudioWithIndex:0];
}

- (void)downloadAudioWithIndex:(NSInteger)currentIndex {
    @weakify(self)
    self.currentIndex = currentIndex;
    YYBBFileUploadModel *audioModel = [self.audios objectAtIndexSafe:currentIndex];
    [self downloadAudioWithAudioModel:audioModel];
}

- (void)downloadAudioWithAudioModel:(YYBBFileUploadModel *)audioModel {
    @weakify(self)
    NSURL *url = [NSURL URLWithString:audioModel.audioUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [[YYBBAPPBaseAPIClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",[NSString stringWithFormat:@"%.2lldkB/%.2lldkB %.2f%%",downloadProgress.completedUnitCount/1024,downloadProgress.totalUnitCount/1024,(float)downloadProgress.completedUnitCount/downloadProgress.totalUnitCount*100.0]);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fileName = [response.suggestedFilename stringByReplacingOccurrencesOfString:@"mpeg" withString:@"m4a"];
        NSString *path = [NSString stringWithFormat:@"file://%@", audioModel.audioPath];
        NSURL *url = [[NSURL URLWithString:path] URLByAppendingPathComponent:fileName];
        NSLog(@"%@", url.absoluteString);
        return url;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"filePath:%@\nerror:%@\n",[filePath absoluteString], error);
        if (error) {
            NSError *networkError = [NSError errorWithDomain:NSURLErrorDomain
                                                        code:NSURLErrorUnknown
                                                    userInfo:@{NSLocalizedDescriptionKey: @"download failed"}];
            !self.completionHandler ?: self.completionHandler(nil, networkError);
            return;
        }
        [self.downloadFilePaths addObject:filePath.relativePath];
        if (self.currentIndex == self.audios.count - 1) {
            !self.completionHandler ?: self.completionHandler(self.downloadFilePaths, nil);
        } else {
            self.currentIndex += 1;
            [self downloadAudioWithIndex:self.currentIndex];
        }
    }];
    [task resume];
}

@end
