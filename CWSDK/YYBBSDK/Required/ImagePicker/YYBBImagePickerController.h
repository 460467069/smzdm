//
//  YYBBImagePickerController.h
//  ZeroDistanceSeller
//
//  Created by Wang_ruzhou on 2017/8/25.
//  Copyright © 2017年 ZeroDistance. All rights reserved.
//  代码需进一步优化

#import <Foundation/Foundation.h>
#import "YYBBImageUploader.h"
#import <TZImagePickerController/TZImagePickerController.h>

typedef NS_ENUM(NSUInteger, YYBBImagePickerControllerType) {
    YYBBImagePickerControllerTypeCamera,
    YYBBImagePickerControllerTypeAlbum,
    YYBBImagePickerControllerTypeCameraAndAlbum
};

@class YYBBImagePickerController;

@protocol YYBBImagePickerControllerDelegate <NSObject>
@optional

// 相机选择回调
- (void)yybb_imagePickerController:(YYBBImagePickerController *)picker
             didFinishPickingPhoto:(UIImage *)image
                       sourceAsset:(id)asset
                              info:(NSDictionary *)info;

// 相册选择回调(方法回调选其一就好)
- (void)yybb_imagePickerController:(YYBBImagePickerController *)picker
            didFinishPickingPhotos:(NSArray *)photos
                      sourceAssets:(NSArray *)assets;

- (void)yyaa_imagePickerController:(UINavigationController *)imagePicker
            didFinishPickingPhotos:(NSArray *)photos
                      sourceAssets:(NSArray *)assets;

@end

@interface YYBBImagePickerController : NSObject

@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, assign) NSInteger maxImagesCount;
@property (nonatomic, assign) BOOL isAutoDismiss;

// 不自动上传
- (instancetype)initWithPickerType:(YYBBImagePickerControllerType)type delegate:(UIViewController <YYBBImagePickerControllerDelegate> *)sourceController;


// 选择图片后自动上传
- (instancetype)initWithSourceController:(UIViewController <YYBBImagePickerControllerDelegate> *)sourceController
                         progressHandler:(UploadImageProgressHandler)progressHandler
                       completionHandler:(UploadImagesCompletionHandler)completionHandler;

- (void)show;

@end

@interface TZImagePickerController (YYBBAdd)

- (void)yybb_globalConfig;

@end

// 图片预览
@interface YYCCImagePickerController : TZImagePickerController
 
 @end
