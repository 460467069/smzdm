//
//  UIImage+YYBBAdd.h
//  
//
//  Created by Mac on 2018/1/20.
//  Copyright © 2018年 ZeroDistance. All rights reserved.
//

#import "UIImage+YYBBAdd.h"
#import "YYBBUtilsMacro.h"
#import <YYCategories/YYCGUtilities.h>

@implementation UIImage (YYBBAdd)

+ (instancetype)yybb_stretchImageWithOriginImageStr:(NSString *)originImageStr {
    UIImage *image = YYBBImageNamed(originImageStr);
    return [image yybb_stretchImage];
}

- (instancetype)yybb_stretchImage {
    CGFloat top    = self.size.height * 0.5 - 1;
    CGFloat left   = self.size.width * 0.5 - 1;
    CGFloat bottom = self.size.height * 0.5;
    CGFloat right  = self.size.width * 0.5;
    UIImage *stretchImage = [self resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)
                                                 resizingMode:UIImageResizingModeTile];
    return stretchImage;
}

- (UIImage *)yybb_croppedImage:(CGRect)rect
{
    double (^rad)(double) = ^(double deg) {
        return deg / 180.0 * M_PI;
    };
    
    CGAffineTransform rectTransform;
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(rad(90)), 0, -self.size.height);
            break;
        case UIImageOrientationRight:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(rad(-90)), -self.size.width, 0);
            break;
        case UIImageOrientationDown:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(rad(-180)), -self.size.width, -self.size.height);
            break;
        default:
            rectTransform = CGAffineTransformIdentity;
    };
    rectTransform = CGAffineTransformScale(rectTransform, self.scale, self.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], CGRectApplyAffineTransform(rect, rectTransform));
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    return result;
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter

- (UIImage *)yybb_resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    CGAffineTransform transform = CGAffineTransformIdentity;
    // In iOS 5 the image is already correctly rotated. See Eran Sandler's
    // addition here: http://eran.sandler.co.il/2011/11/07/uiimage-in-ios-5-orientation-and-resize/
    if([[[UIDevice currentDevice]systemVersion]floatValue] >= 5.0) {
        drawTransposed = YES;
    }
    else {
        switch(self.imageOrientation) {
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                drawTransposed = YES;
                break;
            default:
                drawTransposed = NO;
        }
        
        transform = [self yybb_transformForOrientation:newSize];
    }
    transform = [self yybb_transformForOrientation:newSize];
    
    
    return [self yybb_resizedImage:newSize transform:transform drawTransposed:drawTransposed interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)yybb_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                       bounds:(CGSize)bounds
                         interpolationQuality:(CGInterpolationQuality)quality {
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio;
    
    switch(contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %ld", (long)contentMode];
    }
    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    return [self yybb_resizedImage:newSize interpolationQuality:quality];
}

- (UIImage *)yybb_rotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)yybb_resizedImage:(CGSize)newSize
                     transform:(CGAffineTransform)transform
                drawTransposed:(BOOL)transpose
          interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Fix for a colorspace / transparency issue that affects some types of
    // images. See here: http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/comment-page-2/#comment-39951
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                8,
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                kCGImageAlphaNoneSkipLast);
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    return newImage;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)yybb_transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch(self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch(self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    return transform;
}

#pragma mark - fix orientation
- (UIImage *)yybb_fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


-(UIImage *)yybb_imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)yybb_reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize
{
    
    if (maxSize <= 0.0) maxSize = 1024.0;
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;
    
    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.05;
    }
    
    //    //调整大小
    //    NSData *imageData = UIImagePNGRepresentation(newImage);
    //    CGFloat sizeOriginKB = imageData.length / 1024.0;
    //
    //    while (sizeOriginKB >= maxSize) {
    //        imageData = UIImagePNGRepresentation(newImage);
    //        sizeOriginKB = imageData.length / 1024.0;
    //    }
    
    return imageData;
}


/**
 *  压缩图片到指定文件大小
 *
 *  @param image 目标图片
 *  @param size  目标大小（最大值）
 *
 *  @return 返回的图片文件
 */
- (NSData *)yybb_compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size {
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}


/// 压缩图片到指定文件大小
/// @param maxSize 目标大小（最大值）
/// @param completionHandler 压缩回调
- (void)yybb_compressToMaxDataSizeKBytes:(CGFloat)maxSize completionHandler:(void(^)(NSData *resultData))completionHandler {
    if (maxSize <= 0) {
        NSData *imageData = UIImageJPEGRepresentation(self,1.0);
        !completionHandler ?: completionHandler(imageData);
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //调整大小
        NSData *imageData = UIImageJPEGRepresentation(self,1.0);
        CGFloat sizeOriginKB = imageData.length / 1024.0;
        
        CGFloat resizeRate = 0.9;
        while (sizeOriginKB > maxSize && resizeRate > 0.1) {
            imageData = UIImageJPEGRepresentation(self,resizeRate);
            sizeOriginKB = imageData.length / 1024.0;
            resizeRate -= 0.1;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            !completionHandler ?: completionHandler(imageData);
        });
    });
}

/**
 *  压缩图片
 *
 *   image       需要压缩的图片
 *   FImageBytes 希望压缩后的大小(以KB为单位)
 *
 *   压缩后的图片
 */
- (void)yybb_compressedImageFiles:(UIImage *)image
                          imageKB:(CGFloat)fImageKBytes
                       imageBlock:(void(^)(UIImage *image))block {
    
    __block UIImage *imageCope = image;
    CGFloat fImageBytes = fImageKBytes * 1024;//需要压缩的字节Byte
    
    __block NSData *uploadImageData = nil;
    
    uploadImageData = UIImagePNGRepresentation(imageCope);
    NSLog(@"图片压前缩成 %fKB",uploadImageData.length/1024.0);
    CGSize size = imageCope.size;
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    
    if (uploadImageData.length > fImageBytes && fImageBytes >0) {
        
        dispatch_async(dispatch_queue_create("CompressedImage", DISPATCH_QUEUE_SERIAL), ^{
            
            /* 宽高的比例 **/
            CGFloat ratioOfWH = imageWidth/imageHeight;
            /* 压缩率 **/
            CGFloat compressionRatio = fImageBytes/uploadImageData.length;
            /* 宽度或者高度的压缩率 **/
            CGFloat widthOrHeightCompressionRatio = sqrt(compressionRatio);
            
            CGFloat dWidth   = imageWidth *widthOrHeightCompressionRatio;
            CGFloat dHeight  = imageHeight*widthOrHeightCompressionRatio;
            if (ratioOfWH >0) { /* 宽 > 高,说明宽度的压缩相对来说更大些 **/
                dHeight = dWidth/ratioOfWH;
            }else {
                dWidth  = dHeight*ratioOfWH;
            }
            
            imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
            uploadImageData = UIImagePNGRepresentation(imageCope);
            
            NSLog(@"当前的图片已经压缩成 %fKB",uploadImageData.length/1024.0);
            //微调
            NSInteger compressCount = 0;
            /* 控制在 1M 以内**/
            while (fabs(uploadImageData.length - fImageBytes) > 1024) {
                /* 再次压缩的比例**/
                CGFloat nextCompressionRatio = 0.9;
                
                if (uploadImageData.length > fImageBytes) {
                    dWidth = dWidth*nextCompressionRatio;
                    dHeight= dHeight*nextCompressionRatio;
                }else {
                    dWidth = dWidth/nextCompressionRatio;
                    dHeight= dHeight/nextCompressionRatio;
                }
                
                imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
                uploadImageData = UIImagePNGRepresentation(imageCope);
                
                /*防止进入死循环**/
                compressCount ++;
                if (compressCount == 10) {
                    break;
                }
                
            }
            NSLog(@"图片已经压缩成 %fKB",uploadImageData.length/1024.0);
            imageCope = [[UIImage alloc] initWithData:uploadImageData];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                block(imageCope);
            });
        });
    }
    else
    {
        block(imageCope);
    }
}
/* 根据 dWidth dHeight 返回一个新的image**/
- (UIImage *)drawWithWithImage:(UIImage *)imageCope width:(CGFloat)dWidth height:(CGFloat)dHeight{
    
    UIGraphicsBeginImageContext(CGSizeMake(dWidth, dHeight));
    [imageCope drawInRect:CGRectMake(0, 0, dWidth, dHeight)];
    imageCope = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCope;
    
}


//按比例缩放,size 是你要把图显示到 多大区域
+ (UIImage *)yybb_imageCompressFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)yybb_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage *)yybb_imageNamed:(NSString *)name {
    if (![name yybb_isNotEmpty]) {
        return nil;
    }
    return [self imageNamed:name];
}

// 二维码图片
+ (UIImage *)yybb_generateQRCodeWithContent:(NSString *)content {
    NSParameterAssert(content);
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:1.
                                   orientation:UIImageOrientationUp];
    CGImageRelease(cgImage);
    CGFloat rate = kScreenWidth / MAX(image.size.width, image.size.height);
    CGFloat width = image.size.width * rate;
    CGFloat height = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef cgContext = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(cgContext, kCGInterpolationNone);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}

+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case GradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case GradientTypeUprightToLowleft:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context,
                                gradient,
                                start,
                                end,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end
