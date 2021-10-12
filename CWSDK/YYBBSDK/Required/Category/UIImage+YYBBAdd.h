//
//  UIImage+YYBBAdd.h
//  
//
//  Created by Mac on 2018/1/20.
//  Copyright © 2018年 ZeroDistance. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到下
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIImage (YYBBAdd)

+ (instancetype)yybb_stretchImageWithOriginImageStr:(NSString *)originImageStr;
- (instancetype)yybb_stretchImage;

- (UIImage *)yybb_croppedImage:(CGRect)bounds;


- (UIImage *)yybb_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                       bounds:(CGSize)bounds
                         interpolationQuality:(CGInterpolationQuality)quality;


- (UIImage *)yybb_fixOrientation;


- (UIImage *)yybb_rotatedByDegrees:(CGFloat)degrees;

//图片大小剪裁:
-(UIImage *)yybb_imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;


+ (NSData *)yybb_reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;


- (NSData *)yybb_compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size ;

/// 压缩图片到指定文件大小
/// @param size 目标大小（最大值）
/// @param completionHandler 压缩回调
- (void)yybb_compressToMaxDataSizeKBytes:(CGFloat)size completionHandler:(void(^)(NSData *resultData))completionHandler;

- (void)yybb_compressedImageFiles:(UIImage *)image
                          imageKB:(CGFloat)fImageKBytes
                       imageBlock:(void(^)(UIImage *image))block;


//按比例缩放,size 是你要把图显示到 多大区域
+ (UIImage *)yybb_imageCompressFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size;


//根据CIImage生成指定大小的UIImage
+ (UIImage *)yybb_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

+ (UIImage *)yybb_imageNamed:(NSString *)name;

// 二维码图片
+ (UIImage *)yybb_generateQRCodeWithContent:(NSString *)content;

+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;

@end
