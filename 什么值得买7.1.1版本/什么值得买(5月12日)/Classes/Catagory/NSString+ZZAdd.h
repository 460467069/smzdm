//
//  NSString+ZZAdd.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/20.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZZAdd)
- (CGSize)zz_sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)zz_sizeWithFont:(UIFont *)font;
//给出[日期格式为"20161201"], 返回对应星期
- (NSString *)zz_caculateWeek;
/** 浮点型转百分比字符串 */
+ (NSString *)zz_stringFromFloat:(CGFloat )value;


/**
 *  删除空格
 */
- (NSString *)zz_stringByTrimingWhitespace;    //去掉两端的空格
- (NSString *)zz_stringByTrimingAllWhitespace; //去掉所有的空格

// 把手机号第4-7位变成星号
- (NSString *)phoneNumToAsterisk;

// 把身份证号第5-14位变成星号
- (NSString *)zz_idCardToAsterisk;

/**
 *  校验
 *
 *  @param regex 正则表示
 *
 *  @return 结果
 */
- (BOOL)zz_isMatchsRegex:(NSString *)regex;

/**
 *  apns token
 */
- (NSString *)zz_deviceToken;

/**
 *  为图片链接拼接处理参数
 *
 *  @param expectSize 希望缩放到的尺寸
 *
 *  @return 拼接成功返回拼接后的图片链接, 否则返回原来的图片链接.
 */
- (NSString *)zz_stringByAppendingImageScaleParametersWithExpectSize:(CGSize)expectSize;

/**
 *  生成图片地址缩放参数
 *
 *  @param expectSize 期望缩放到的尺寸
 *
 *  @return `expectSize` 为 {0, 0} 时返回 `nil`, 否则返回缩放参数
 */
+ (NSString *)zz_imageScaleParametersWithExpectSize:(CGSize)expectSize;

- (NSString *)zz_sha256;
- (NSString *)zz_decrypt;
- (NSString *)zz_encrypt;

- (NSString *)zz_getPnoEncryption;

- (BOOL)zz_validLength;

// 密码必须大于等于6
- (BOOL)zz_validPasswordLength;

/**
 *  验证是否为存数字(不包括小数点)
 *
 *  @return 验证结果
 */
- (BOOL)zz_validNumber;

/**
 *  是否是数字
 *
 *  @return 结果
 */
- (BOOL)zz_validPureDigitalSetWithBlock:(BOOL (^)(NSCharacterSet *characterSet))block;

/**
 *  是否是为身份证
 *
 *  @return 结果
 */
- (BOOL)zz_validIdCardDigitalSetWithBlock:(BOOL (^)(NSCharacterSet *characterSet))block;
/**
 *  验证密码
 *
 *  @return 验证结果
 */
- (BOOL)zz_validPassword;

/**
 *  验证手机号码
 *
 *  @return 验证结果
 */
- (BOOL)zz_validPhoneNumber;

- (BOOL)zz_validVerificationCode;
- (BOOL)zz_validInvitationCode;
- (BOOL)zz_validNickname;
- (BOOL)zz_validAccount;
- (BOOL)zz_validUID;
- (BOOL)zz_validLoginPassword;
- (BOOL)zz_regionStr;
/**
 *  是否是有效的身份证号码
 *
 *  @return YES 有效, NO 无效.
 */
- (BOOL)zz_validIDNumber;
- (BOOL)zz_validTrueName;
- (BOOL)zz_validDigits;
/** 检查银行卡 */
- (BOOL)zz_validBankCardNo;

- (NSDictionary *)zz_dictionaryWithJsonString;

- (NSDictionary *)zz_stringToDictionary;

/**
 *  字符串转日期
 *
 *  @return YES 有效, NO 无效.
 */

- (NSDate *)zz_stringToDate;

- (NSString *)zz_deleteBracketstr;

+ (NSString *)zz_networkingStatesFromStatebar;
@end
