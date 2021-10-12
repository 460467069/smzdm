//
//  YYBBLoginConstants.h
//  BloothSmoking
//
//  Created by Wang_Ruzhou on 12/8/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

typedef NS_ENUM(NSUInteger, YYBBSmsCodeType) {
    YYBBSmsCodeTypeLogin               = 1,  // 手机号登录
    YYBBSmsCodeTypeChangePwd           = 2,  // 修改密码
    YYBBSmsCodeTypeRetrievePwd         = 3,  // 忘记密码找回
    YYBBSmsCodeTypeUpdateImportantInfo = 4   // 变更重要信息
};

// 选择照片类型
typedef NS_ENUM(NSUInteger, YYBBSelectedPhotoType) {
    YYBBSelectedPhotoTypeBusinessLicense,
    YYBBSelectedPhotoTypeIDCardFront,
    YYBBSelectedPhotoTypeIDCardBack
};

// 是否认证
typedef NS_ENUM(NSUInteger, YYBBUserEnterpriseStatus) {
    YYBBUserEnterpriseStatusNotAuth = 5,   // 未认证
    YYBBUserEnterpriseStatusAuthed = 3,    // 已认证
};

// 认证类型
typedef NS_ENUM(NSUInteger, YYBBUserAuthType) {
    YYBBUserAuthTypeEnterprise = 1,
    YYBBUserAuthTypePerson = 2
};

// 法人姓名
FOUNDATION_EXPORT NSString * const kValidationLegalName;
// 公司全称
FOUNDATION_EXPORT NSString * const kValidationCompanyFullName;
// 公司简称
FOUNDATION_EXPORT NSString * const kValidationCompanyShortName;
// 营业执照
FOUNDATION_EXPORT NSString * const kValidationBusinessLicense;
// 身份证号
FOUNDATION_EXPORT NSString * const kValidationIDCard;

