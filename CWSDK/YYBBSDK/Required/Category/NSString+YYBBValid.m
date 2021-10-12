//
//  NSString+YYBBValid.m
//  DaDongMen
//
//  Created by WangRuzhou on 3/14/15.
//  Copyright (c) 2015 Optimus Prime Information Technology Co., Ltd. All rights reserved.
//

#import "NSString+YYBBValid.h"
#import "NSString+YYBBAdd.h"
#import "NSObject+YYBBAdd.h"
#import <CommonCrypto/CommonHMAC.h>
#import <YYCategories/NSString+YYAdd.h>

static NSString *const kPhoneCharactersString = @"0123456789";
static NSString *const kBlankStr  = @" ";
static NSString *const kEmptyStr  = @"";

@implementation NSString (YYBBValid)


- (NSString *)yybb_phoneNumToAsterisk {
    NSString *prefix = [self substringToIndex:3];
    NSString *suffix = [self substringFromIndex:8];
    return [NSString stringWithFormat:@"%@ **** %@", prefix, suffix];
}

- (NSString *)yybb_formatPhoneStr {
    NSString *text = self;
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:kPhoneCharactersString];
    NSString *newString = kEmptyStr;
    NSString *subString = [text substringToIndexSafe:MIN(text.length, 3)];
    newString = [newString stringByAppendingString:subString];
    if (subString.length == 3) {
        newString = [newString stringByAppendingString:kBlankStr];
    }
    text = [text substringFromIndexSafe:MIN(text.length, 3)];
    if (text.length > 0) {
        NSString *subString2 = [text substringToIndexSafe:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString2];
        if (subString2.length == 4) {
            newString = [newString stringByAppendingString:kBlankStr];
            
        }
        NSString *subString3 = [text substringFromIndexSafe:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString3];
    }
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    return newString;
}

- (NSString *)yybb_deviceToken {
    NSError *error;
    NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:@"[<> ]"
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:&error];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length])  withTemplate:@""];
}

- (NSString *)yybb_stringByAppendingImageScaleParametersWithExpectSize:(CGSize)expectSize {
    NSString *imageStyle = [[self class] yybb_imageScaleParametersWithExpectSize:expectSize];
    if (imageStyle) {
        return [self stringByAppendingString:imageStyle];
    }
    return self;
}

+ (NSString *)yybb_imageScaleParametersWithExpectSize:(CGSize)expectSize {
    if (CGSizeEqualToSize(CGSizeZero, expectSize)) {
        return nil;
    }
    NSUInteger scale = 3;
    NSString *imageStyle = [NSString stringWithFormat:@"@%@w_%@h", @(ceil(expectSize.width) * scale), @(ceil(expectSize.height) * scale)];
    return imageStyle;
}

- (BOOL)yybb_validNumber {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    NSString*filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}

- (BOOL)yybb_validPureDigitalSetWithBlock:(BOOL (^)(NSCharacterSet *characterSet))block {
    static NSCharacterSet *characterSet = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        characterSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    });
    if (block) {
        return block(characterSet);
    }
    return YES;
}

- (BOOL)yybb_validIdCardDigitalSetWithBlock:(BOOL (^)(NSCharacterSet *characterSet))block {
    static NSCharacterSet *characterSet = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        characterSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890xX"];
    });
    if (block) {
        return block(characterSet);
    }
    return YES;
}

- (BOOL)yybb_validLoginPassword {
    return self.length >= 6 && self.length <= 18;
    // 移动端只需要判断用户输入的密码长度大于等于6就行，其它的交给后台去处理
    //    return [self yybb_isMatchsRegex:@"^[\\S]{6,16}$"];
}

- (BOOL)yybb_validLength {
    return self.length != 0;
}

- (BOOL)yybb_validPhoneNumber {
    return self.length == 11 && [self hasPrefix:@"1"];
}

- (BOOL)yybb_validIDCardNumber {
    return self.length == 15 || self.length == 18;
}

// 客服电话
- (BOOL)yybb_validServerPhone {
    return self.length <= 12 && self.length > 0;
}

- (BOOL)yybb_validRecommendID {
    return [self yybb_isMatchsRegex:@"^[0-9]*$"];
}

- (BOOL)yybb_validVerificationCode {
    return self.length == 4;
}

- (BOOL)yybb_regionStr {
    return self.length > 0;
}

- (BOOL)yybb_validPayPassword {
    return self.length == 6;
}

#if 0
- (BOOL)yybb_validPayPassword {
    if (![self yybb_validContinuousAsec] &&
        ![self yybb_validContinuousDesc] &&
        ![self yybb_validRepeat]) {
        return YES;
    }
    return NO;
}
#endif

//判断升序
- (BOOL)yybb_validContinuousAsec {
    int firstValue = [[self substringWithRange:NSMakeRange(0, 1)] intValue];   //如123456
    for(int i = 0; i < self.length; i++) {
        int num = [[self substringWithRange:NSMakeRange(i, 1)] intValue];
        if (firstValue != num) {
            return NO;
        }
        firstValue += 1;
    }
    return YES;
}

//判断降序
- (BOOL)yybb_validContinuousDesc {
    int firstValue = [[self substringWithRange:NSMakeRange(0, 1)] intValue];   //如654321
    for(int i = 0; i < self.length; i++) {
        int num = [[self substringWithRange:NSMakeRange(i, 1)] intValue];
        if (firstValue != num) {
            return NO;
        }
        firstValue -= 1;
    }
    return YES;
}

//判断重复
- (BOOL)yybb_validRepeat {
    int firstValue0 = [[self substringWithRange:NSMakeRange(0, 1)] intValue];   //判断是否全同一个数字
    for(int i = 0; i < self.length; i++) {
        int num = [[self substringWithRange:NSMakeRange(i, 1)] intValue];
        if (firstValue0 != num) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)yybb_validInvitationCode {
    NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
    BOOL valid = [[self stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
    return self.length == 6 && valid;
}

- (BOOL)yybb_validNickname {
    return self.length > 0 && self.length <= 30;
}

- (BOOL)yybb_validAccount {
    return [self yybb_isMatchsRegex:@"^[A-Za-z0-9]{6,16}+$"];
}

- (BOOL)yybb_validUID {
    return self.length == 16 && [self yybb_validDigits];
}

- (BOOL)yybb_validIDNumber {
    return self.length >= 1 && self.length <= 18;
}

- (BOOL)yybb_validRegitNumber {
    return [self yybb_isMatchsRegex:@"^[A-Za-z0-9]+$"];
}

- (BOOL)yybb_validTrueName {
    return [self yybb_isMatchsRegex:@"^[\u4E00-\u9FA5]{2,16}$"];
}

- (BOOL)yybb_validDigits {
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [self rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound;
}

- (NSDate *)yybb_stringToDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}

- (NSString *)getPnoEncryption {
    NSString *encry = @"";
    for (int i=4; i<[self length]-4; i++) {
        encry = [encry stringByAppendingString:@"*"];
    }
    return encry;
}

- (NSDictionary *)yybb_dictionaryWithJsonString {
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSDictionary *)yybb_stringToDictionary {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSArray *array = [self componentsSeparatedByString:@"&"];
    if (array && array.count>0) {
        for (int i=0; i<[array count]; i++) {
            NSString *string = array[i];
            NSArray *curArray = [string componentsSeparatedByString:@"="];
            if (curArray.count>1) {
                dic[curArray[0]] = curArray[1];
            }
        }
    }
    return dic;
}


//去除字符串中用括号括住的位置
-(NSString *)deleteBracketstr {
    
    NSMutableString * muStr = [NSMutableString stringWithString:self];
    while (1) {
        NSRange range = [muStr rangeOfString:@"("];
        NSRange range1 = [muStr rangeOfString:@")"];
        if (range.location != NSNotFound) {
            NSInteger loc = range.location;
            NSInteger len = range1.location - range.location;
            [muStr deleteCharactersInRange:NSMakeRange(loc, len + 1)];
        }else{
            break;
        }
    }
    
    return muStr;
}

//金钱匹配
- (BOOL)validateMoney {
    return ![self yybb_isMatchsRegex:@"^[0][0-9]+$"] && [self yybb_isMatchsRegex:@"^(([1-9]{1}[0-9]*|[0]).?[0-9]{0,2})$"];
}

#pragma mark - Private

- (BOOL)yybb_isMatchsRegex:(NSString *)regex {
    if (![self yybb_isNotEmpty]) {
        return NO;
    }
    NSPredicate *nicknameMatches = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    return [nicknameMatches evaluateWithObject:self];
}


- (NSArray *)componentsWithComma {
    NSArray *array = [self componentsSeparatedByString:@","];
    NSMutableArray *temArray = [NSMutableArray array];
    for (NSString *urlStr in array) {
        if ([urlStr hasPrefix:@"http"]) {
            [temArray addObject:urlStr];
        }
    }
    return [temArray copy];
}

//获取字符串长度, 中文代表一个字, 两个英文代表一个字
- (NSUInteger)unicodeLength {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++)
    {  unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2) {
        unicodeLength++;
    }
    return unicodeLength;
}


- (CGFloat)heightForFont:(UIFont *)font
                   width:(CGFloat)width
       horizontalSpacing:(CGFloat)horizontalSpacing
         verticalSpacing:(CGFloat)verticalSpacing
        newlineCharacter:(NSString *)newlineCharacter
             lineSpacing:(CGFloat)lineSpacing {
    CGFloat maxW = width - horizontalSpacing * 2;
    // 计算高度, 因字符串中包含 \r\n, 计算高度特殊点
    NSArray *strArray = [self componentsSeparatedByString:@"\r\n"];
    NSInteger rows = 0;
    CGFloat lineH = [@"test" heightForFont:font width:maxW];
    CGFloat ceilLineH = ceil(lineH);
    for (NSString *str in strArray) {
        CGFloat caculateH = [str heightForFont:font width:maxW];
        CGFloat yushu = caculateH;
        while (yushu > 0) {
            rows += 1;
            yushu -= lineH;
        }
    }
    CGFloat height = verticalSpacing * 2.0 + ceilLineH * rows + (rows - 1) * lineSpacing;
    return height;
}

@end
