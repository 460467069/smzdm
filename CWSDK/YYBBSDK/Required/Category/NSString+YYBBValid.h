//
//  NSString+YYBBValid.h
//  DaDongMen
//
//  Created by WangRuzhou on 3/14/15.
//  Copyright (c) 2015 Optimus Prime Information Technology Co., Ltd. All rights reserved.
//


@interface NSString (YYBBValid)

- (NSString *)yybb_phoneNumToAsterisk;

// 手机号码格式化:131 1234 1234
- (NSString *)yybb_formatPhoneStr;
/**
 *  校验
 *
 *  @param regex 正则表示
 *
 *  @return 结果
 */
- (BOOL)yybb_isMatchsRegex:(NSString *)regex;

/**
 *  apns token
 */
- (NSString *)yybb_deviceToken;

/**
 *  为图片链接拼接处理参数
 *
 *  @param expectSize 希望缩放到的尺寸
 *
 *  @return 拼接成功返回拼接后的图片链接, 否则返回原来的图片链接.
 */
- (NSString *)yybb_stringByAppendingImageScaleParametersWithExpectSize:(CGSize)expectSize;

/**
 *  生成图片地址缩放参数
 *
 *  @param expectSize 期望缩放到的尺寸
 *
 *  @return `expectSize` 为 {0, 0} 时返回 `nil`, 否则返回缩放参数
 */
+ (NSString *)yybb_imageScaleParametersWithExpectSize:(CGSize)expectSize;

/**
 *  验证是否为存数字(不包括小数点)
 *
 *  @return 验证结果
 */
- (BOOL)yybb_validNumber;

- (BOOL)validateMoney;

/**
 *  是否是数字
 *
 *  @return 结果
 */
- (BOOL)yybb_validPureDigitalSetWithBlock:(BOOL (^)(NSCharacterSet *characterSet))block;

/**
 *  是否是为身份证
 *
 *  @return 结果
 */
- (BOOL)yybb_validIdCardDigitalSetWithBlock:(BOOL (^)(NSCharacterSet *characterSet))block;

- (BOOL)yybb_validLength;

/**
 *  验证手机号码
 *
 *  @return 验证结果
 */
- (BOOL)yybb_validPhoneNumber;
// 身份证
- (BOOL)yybb_validIDCardNumber;
// 客服电话
- (BOOL)yybb_validServerPhone;
- (BOOL)yybb_validRecommendID;
- (BOOL)yybb_validVerificationCode;
- (BOOL)yybb_validInvitationCode;
- (BOOL)yybb_validNickname;
- (BOOL)yybb_validAccount;
- (BOOL)yybb_validUID;
- (BOOL)yybb_validLoginPassword;
- (BOOL)yybb_regionStr;
- (BOOL)yybb_validPayPassword;
- (BOOL)yybb_validRegitNumber;
/**
 *  是否是有效的身份证号码
 *
 *  @return YES 有效, NO 无效.
 */
- (BOOL)yybb_validIDNumber;
- (BOOL)yybb_validTrueName;
- (BOOL)yybb_validDigits;

- (NSDictionary *)yybb_dictionaryWithJsonString;

- (NSDictionary *)yybb_stringToDictionary;

/**
 *  字符串转日期
 *
 *  @return YES 有效, NO 无效.
 */

- (NSDate *)yybb_stringToDate;

- (NSString *)deleteBracketstr;

//根据逗号分割获取获取数组
- (NSArray *)componentsWithComma;

//获取字符串长度, 中文代表一个字, 两个英文代表一个字
-(NSUInteger)unicodeLength;

// 带有换行符的文字高度计算
- (CGFloat)heightForFont:(UIFont *)font
                   width:(CGFloat)width
       horizontalSpacing:(CGFloat)horizontalSpacing
         verticalSpacing:(CGFloat)verticalSpacing
        newlineCharacter:(NSString *)newlineCharacter
             lineSpacing:(CGFloat)lineSpacing;
@end
