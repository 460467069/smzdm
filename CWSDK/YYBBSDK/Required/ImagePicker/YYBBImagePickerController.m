//
//  YYBBImagePickerController.m
//  ZeroDistanceSeller
//
//  Created by Wang_ruzhou on 2017/8/25.
//  Copyright © 2017年 ZeroDistance. All rights reserved.
//

#import "YYBBImagePickerController.h"
#import <TZImagePickerController/TZImageManager.h>
#import <YYCategories/YYCategoriesMacro.h>
#import <YYCategories/YYCGUtilities.h>
#import <YYCategories/UIColor+YYAdd.h>
#import <YYCategories/UIView+YYAdd.h>
#import <YYCategories/UIImage+YYAdd.h>
#import <YYBBSDK/UIColor+YYBBAdd.h>
#import <YYBBSDK/YYBBUtilsMacro.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSObject+YYBBAdd.h"
#import "UIView+YYBBAdd.h"
#import "UIImage+YYBBAdd.h"

@interface YYBBImagePickerController ()<TZImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic,   weak) UIViewController <YYBBImagePickerControllerDelegate> *sourceController;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, assign) id<YYBBImagePickerControllerDelegate> delegate;
@property (nonatomic, assign, getter=isAutoUpload) BOOL autoUpload;
@property (nonatomic, assign) YYBBImagePickerControllerType pickerType;

// 上传
@property (nonatomic, copy) UploadImageProgressHandler progressHandler;
@property (nonatomic, copy) UploadImagesCompletionHandler completionHandler;

@end

@implementation YYBBImagePickerController

// 相册选择
- (instancetype)initWithPickerType:(YYBBImagePickerControllerType)type delegate:(UIViewController <YYBBImagePickerControllerDelegate> *)sourceController {
    if (self = [super init]) {
        _sourceController  = sourceController;
        _delegate = sourceController;
        _autoUpload = NO;
        _isAutoDismiss = YES;
        _pickerType = type;
    }
    return self;
}

// 选择图片后自动上传
- (instancetype)initWithSourceController:(UIViewController <YYBBImagePickerControllerDelegate> *)sourceController
                         progressHandler:(UploadImageProgressHandler)progressHandler
                       completionHandler:(UploadImagesCompletionHandler)completionHandler {
    if (self = [super init]) {
        _sourceController  = sourceController;
        _delegate = nil;
        _autoUpload = YES;
        _progressHandler = [progressHandler copy];
        _completionHandler = [completionHandler copy];
    }
    return self;
}

- (void)show {
    if (self.pickerType == YYBBImagePickerControllerTypeCamera) {
        [self takePhoto];
    } if (self.pickerType == YYBBImagePickerControllerTypeAlbum) {
        [self pushTZImagePickerController];
    } else if (self.pickerType == YYBBImagePickerControllerTypeCameraAndAlbum) {
        [self pushTZImagePickerController];
    }
}

- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc]
                                              initWithMaxImagesCount:self.maxImagesCount
                                              columnNumber:4
                                              delegate:self
                                              pushPhotoPickerVc:YES];
    imagePickerVc.autoDismiss = self.isAutoDismiss;
    [imagePickerVc yybb_globalConfig];
    if (self.pickerType == YYBBImagePickerControllerTypeCamera) {
        imagePickerVc.allowTakePicture = YES;
    } if (self.pickerType == YYBBImagePickerControllerTypeAlbum) {
        imagePickerVc.allowTakePicture = NO;
    } else if (self.pickerType == YYBBImagePickerControllerTypeCameraAndAlbum) {
        imagePickerVc.allowTakePicture = YES;
    }
    imagePickerVc.selectedAssets = self.selectedAssets;
    [self.sourceController presentViewController:imagePickerVc animated:YES completion:nil];
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    @weakify(self)
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        @strongify(self)
        self.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        @strongify(self)
        self.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        self.imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.sourceController presentViewController:self.imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机"
                                                                                 message:@"请在iPhone的""设置-隐私-相机""中允许访问相机"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Setting" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [self.sourceController presentViewController:alertController animated:YES completion:nil];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相册"
                                                                                 message:@"请在iPhone的""设置-隐私-相册""中允许访问相册"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Setting" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [self.sourceController presentViewController:alertController animated:YES completion:nil];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSDictionary *meta = [info objectForKey:UIImagePickerControllerMediaMetadata];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image meta:meta location:self.location completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                UIImage *newImage = [image yybb_fixOrientation];
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                if (self.isAutoUpload) {
                    [self uploadImages:@[newImage]];
                } else {
                    if ([self.delegate respondsToSelector:@selector(yybb_imagePickerController:didFinishPickingPhoto:sourceAsset:info:)]) {
                        [self.delegate yybb_imagePickerController:self didFinishPickingPhoto:newImage sourceAsset:assetModel.asset info:info];
                    }
                }
            }
        }];
    }
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray *)photos
                 sourceAssets:(NSArray *)assets
        isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    if (self.isAutoUpload) {
        [self uploadImages:photos];
    } else {
        if ([self.delegate respondsToSelector:@selector(yybb_imagePickerController:didFinishPickingPhotos:sourceAssets:)]) {
            [self.delegate yybb_imagePickerController:self didFinishPickingPhotos:photos sourceAssets:assets];
        }
        if ([self.delegate respondsToSelector:@selector(yyaa_imagePickerController:didFinishPickingPhotos:sourceAssets:)]) {
            [self.delegate yyaa_imagePickerController:picker didFinishPickingPhotos:photos sourceAssets:assets];
        }
    }
}

#pragma mark - 自动上传图片
- (void)uploadImages:(NSArray *)selectedImages {
    if (![selectedImages yybb_isNotEmpty]) {
        return;
    }
    [SVProgressHUD showWithStatus:@"Uploading..."];
    @weakify(self)
    [[YYBBImageUploader sharedInstance] uploadImages:selectedImages progressHandler:self.progressHandler completionHandler:^(NSArray<NSString *> * _Nullable urlStrs, NSError * _Nullable error) {
        @strongify(self)
        [SVProgressHUD dismiss];
        !self.completionHandler ?: self.completionHandler(urlStrs, error);
    }];
}


#pragma mark - getter && setter
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        _imagePickerVc.navigationBar.barTintColor = self.sourceController.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.sourceController.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
        BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (void)dealloc {
    
}

@end

@implementation TZImagePickerController(YYBBAdd)

- (void)yybb_globalConfig {
    TZImagePickerConfig *config = [TZImagePickerConfig sharedInstance];
    config.languageBundle = [NSBundle mainBundle];
    self.statusBarStyle = UIStatusBarStyleDefault;
    self.allowTakePicture = NO;
    self.allowPickingVideo = NO;
    self.allowPickingImage = YES;
    self.allowPickingOriginalPhoto = NO;
    self.allowPickingGif = YES;
    self.sortAscendingByModificationDate = YES;
    self.showSelectedIndex = YES;
    self.needShowStatusBar = YES;
//    self.naviBgColor = [UIColor whiteColor];
//    self.naviTitleColor = [UIColor yybb_blackColor];
    self.naviTitleFont = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.photoNumberIconImage = [UIImage imageNamed:@"photo_number_icon_image"];
    self.photoDefImage = [UIImage imageNamed:@"photo_def_image"];
    self.photoSelImage = [UIImage imageNamed:@"photo_number_icon_image"];
//    self.navLeftBarButtonSettingBlock = ^(UIButton *leftButton) {
//        [leftButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//        leftButton.frame = CGRectMake(0, 0, 40, 40);
//        leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    };
    self.photoPickerPageUIConfigBlock = ^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        previewButton.hidden = YES;
        [previewButton removeFromSuperview];
        originalPhotoButton.hidden = YES;
        [originalPhotoButton removeFromSuperview];
        originalPhotoLabel.hidden = YES;
        [originalPhotoLabel removeFromSuperview];
        numberImageView.hidden = YES;
        [numberImageView removeFromSuperview];
        numberLabel.hidden = YES;
        [numberLabel removeFromSuperview];
        divideLine.hidden = YES;
        [divideLine removeFromSuperview];
        
        [doneButton setBackgroundImage:[UIImage imageWithColor:[UIColor yybb_themeColor]] forState:UIControlStateNormal];
        [doneButton setBackgroundImage:[UIImage imageWithColor:[[UIColor yybb_themeColor] colorWithAlphaComponent:0.3]] forState:UIControlStateDisabled];
        doneButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
        [doneButton setTitle:@"Confirm" forState:UIControlStateNormal];
        [doneButton setTitle:@"Confirm" forState:UIControlStateDisabled];
        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    };
    self.photoPreviewPageUIConfigBlock = ^(UICollectionView *collectionView, UIView *naviBar, UIButton *backButton, UIButton *selectButton, UILabel *indexLabel, UIView *toolBar, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel) {
        collectionView.backgroundColor = [UIColor yybb_grayScaleBgColor];
//        toolBar.backgroundColor = [UIColor whiteColor];
//        naviBar.backgroundColor = [UIColor whiteColor];
        doneButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [doneButton setTitle:@"Confirm" forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        doneButton.backgroundColor = [UIColor yybb_themeColor];
        numberImageView.hidden = YES;
        [numberImageView removeFromSuperview];
        numberLabel.hidden = YES;
        [numberLabel removeFromSuperview];
    };
    self.photoPreviewPageDidLayoutSubviewsBlock = ^(UICollectionView *collectionView, UIView *naviBar, UIButton *backButton, UIButton *selectButton, UILabel *indexLabel, UIView *toolBar, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel) {
        backButton.bottom = naviBar.height;
        selectButton.centerY = backButton.centerY;
        indexLabel.centerY = backButton.centerY;
        
        toolBar.height = YYBBTabBarHeight();
        toolBar.bottom = kScreenHeight;
        
        CGFloat doneButtonH = 29;
        doneButton.top = 10;
        doneButton.size = CGSizeMake(72, doneButtonH);
        doneButton.right = toolBar.width - YYBBDefaultPadding;
        doneButton.cornerRadius = doneButtonH * 0.5;
    };
    self.photoPickerPageDidLayoutSubviewsBlock = ^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        doneButton.frame = CGRectMake(0, 0, bottomToolBar.width, bottomToolBar.height - YYBBBottomHeight());
    };
    // You can get the photos by block, the same as by delegate.
    self.modalPresentationStyle = UIModalPresentationFullScreen;
}

@end


@implementation YYCCImagePickerController

// 图片预览
- (instancetype )initWithSelectedAssets:(NSMutableArray *)selectedAssets selectedPhotos:(NSMutableArray *)selectedPhotos index:(NSInteger)index {
    self = [super initWithSelectedAssets:selectedAssets selectedPhotos:selectedPhotos index:index];
    if (self) {
        [self yybb_globalConfig];
    }
    return self;
}

@end
