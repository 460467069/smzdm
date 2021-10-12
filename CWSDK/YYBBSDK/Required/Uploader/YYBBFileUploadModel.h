//
//  YYBBFileUploadModel.h
//  YYBBSDK
//
//  Created by WangRuzhou on 2021/8/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBBFileUploadModel : NSObject

@property (nonatomic, strong) NSString *audioUrl;
@property (nonatomic, strong) NSString *audioPath;
@property (nonatomic, strong) NSString *audioName;

// 支持NSData & UIImage
@property (nonatomic, strong) id image;
@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) NSString * baseUrl;
@property (nonatomic, assign) NSInteger fileType;
@property (nonatomic, strong) NSString * origin;


@end

NS_ASSUME_NONNULL_END
