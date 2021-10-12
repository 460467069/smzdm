//
//  YYBBFileUploadModel.m
//  YYBBSDK
//
//  Created by WangRuzhou on 2021/8/2.
//

#import "YYBBFileUploadModel.h"

@implementation YYBBFileUploadModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"baseUrl"]          = @"base_url";
    dictM[@"fileType"]         = @"file_type";
    dictM[@"origin"]           = @"origin";
    return dictM.copy;
}

@end
