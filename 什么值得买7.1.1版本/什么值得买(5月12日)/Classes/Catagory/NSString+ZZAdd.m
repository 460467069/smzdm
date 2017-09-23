//
//  NSString+ZZAdd.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/20.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "NSString+ZZAdd.h"
#import "NSObject+ZZAdd.h"
#import <CommonCrypto/CommonHMAC.h>
#import <SDiPhoneVersion/SDiPhoneVersion.h>

@implementation NSString (ZZAdd)
- (CGSize)zz_sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)zz_sizeWithFont:(UIFont *)font {
    return [self zz_sizeWithFont:font maxW:MAXFLOAT];
}

- (NSString *)zz_caculateWeek{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    
    NSDate *date = [formatter dateFromString:self];
    //今天是星期四
    NSDate *nowDate = [formatter dateFromString:@"20161201"];
    //日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay;
    NSDateComponents *comoments = [calendar components:unit fromDate:nowDate toDate:date options:0];
    
    NSInteger day = comoments.day;
    NSInteger i = day % 7;
    
    switch (i) {
        case 0:
            return @"星期四";
            break;
        case 1:
        case -6:
            return @"星期五";
            break;
        case 2:
        case -5:
            return @"星期六";
            break;
        case 3:
        case -4:
            return @"星期日";
            break;
        case 4:
        case -3:
            return @"星期一";
            break;
        case 5:
        case -2:
            return @"星期二";
            break;
        case 6:
        case -1:
            return @"星期三";
            break;
        default:
            return nil;
    }
    
}

+ (NSString *)zz_stringFromFloat:(CGFloat )value {
    NSNumber *number = [NSNumber numberWithFloat:value];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    return [formatter stringFromNumber:number];
}

- (NSString *)zz_stringByTrimingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)zz_stringByTrimingAllWhitespace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

// 把手机号第4-7位变成星号
- (NSString *)zz_phoneNumToAsterisk {
    return [self stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
}

// 把身份证号第5-14位变成星号
- (NSString *)zz_idCardToAsterisk {
    return [self stringByReplacingCharactersInRange:NSMakeRange(4, 10) withString:@"**********"];
}

- (NSString *)zz_deviceToken {
    NSError *error;
    NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:@"[<> ]"
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:&error];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length])  withTemplate:@""];
}

- (NSString *)zz_stringByAppendingImageScaleParametersWithExpectSize:(CGSize)expectSize {
    NSString *imageStyle = [[self class] zz_imageScaleParametersWithExpectSize:expectSize];
    if (imageStyle) {
        return [self stringByAppendingString:imageStyle];
    }
    return self;
}

+ (NSString *)zz_imageScaleParametersWithExpectSize:(CGSize)expectSize {
    if (CGSizeEqualToSize(CGSizeZero, expectSize)) {
        return nil;
    }
    NSUInteger scale = ([SDiPhoneVersion deviceSize] == iPhone55inch) ? 3 : 2;
    NSString *imageStyle = [NSString stringWithFormat:@"@%@w_%@h", @(ceil(expectSize.width) * scale), @(ceil(expectSize.height) * scale)];
    return imageStyle;
}

- (NSString *)zz_sha256 {
    const char *str = [self UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSString *)zz_decrypt {
    NSString *key = OPTEncryptKey();
    
    if (!key) {
        return nil;
    }
    
    NSData *plainData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    NSData * kData = [base64String dataUsingEncoding:NSUTF8StringEncoding];
    
    char * k = (char *)[kData bytes];
    NSData * sData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    char * s =(char *) [sData bytes];
    
    NSInteger mLength = sData.length -kData.length;
    
    char * m =(char *) malloc((mLength)*sizeof(char));
    
    NSInteger kLength =kData.length;
    NSInteger sLength = sData.length;
    for(NSInteger i=0;i<sLength;i++)
    {
        for(int j=0;j<kLength;j++)
        {
            s[i] ^=k[j];
        }
        if(i<kLength)
        {
            s[i] -=k[i];
        }
    }
    
    NSUInteger l=kData.length;
    NSUInteger o=mLength;
    sLength = sData.length;
    int z=0,c=0;
    for (int i = 0; i < sLength; i++) {
        if(z<o&i%2!=0){
            m[z++]=s[i];
        }else if(c<l){
            c++;
        }else if(z<o){
            m[z++]=s[i];
        }
    }
    NSData *content=[NSData dataWithBytes:m length:mLength];
    free(m);
    return  [[NSString alloc] initWithData:content  encoding:NSUTF8StringEncoding];
}

- (NSString *)zz_encrypt {
    if (self==nil||[self isEqualToString:@""]) {
        return self;
    }
    NSString *key = OPTEncryptKey();
    @synchronized (self) {
        
        NSData *nsdata = [key dataUsingEncoding:NSUTF8StringEncoding];
        // Get NSString from NSData object in Base64
        NSString * baseData =[nsdata base64EncodedStringWithOptions:0];
        const char *h = [baseData UTF8String];
        const char *e = [self UTF8String];
        int a = 0, r = 0, q = 0, w = 0, y = 0 ;
        int l = (int)self.length, o = (int)baseData.length;
        Byte * s =  (Byte*)malloc(o+l);//new byte[o + l];
        
        
        for (int i = 0; i < o+l; i++) {
            if (w < o && i % 2 == 0) {
                s[i] = h[w++];
            } else if (q < l) {
                s[i] = e[q++];
            } else {
                s[i] = h[w++];
            }
        }
        for (int i = 0; i < o+l; i++) {
            if (o < l) {
                if (r < o) {
                    if (i % 2 == 0)
                        r++;
                    else
                        a++;
                } else {
                    if (a < l)
                        a++;
                }
            } else {
                if (a < l) {
                    if (i % 2 == 0)
                        r++;
                    else
                        a++;
                } else {
                    if (r < o)
                        y++;
                }
            }
        }
        
        for (int i = 0; i < o+l; i++) {
            if (i < o)
                s[i] += h[i];
            for(int j =0;j<o;j++){
                Byte b = h[j];
                s[i] = (s[i] ^ b);
            }
        }
        return  [[NSData dataWithBytes:s length:o+l] base64EncodedStringWithOptions:0];
    }
}

- (BOOL)zz_validLength {
    return self.length != 0;
}

- (BOOL)zz_validPasswordLength {
    return self.length >= 6;
}

- (BOOL)zz_validNumber {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    NSString*filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}

- (BOOL)zz_validPureDigitalSetWithBlock:(BOOL (^)(NSCharacterSet *characterSet))block {
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

- (BOOL)zz_validIdCardDigitalSetWithBlock:(BOOL (^)(NSCharacterSet *characterSet))block {
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

- (BOOL)zz_validPassword {
    return self.length < 6 ? NO : YES;
    // 移动端只需要判断用户输入的密码长度大于等于6就行，其它的交给后台去处理
    //    return [self zz_isMatchsRegex:@"^[\\S]{6,16}$"];
}

- (BOOL)zz_validPhoneNumber {
    return self.length==11 && [self hasPrefix:@"1"];
}

- (BOOL)zz_validVerificationCode {
    return self.length >= 6;
}

- (BOOL)zz_regionStr {
    return self.length > 0;
}

- (BOOL)zz_validInvitationCode {
    NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
    BOOL valid = [[self stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
    return self.length >= 6 && valid;
}

- (BOOL)zz_validNickname {
    return self.length > 0 && self.length < 12;
}

- (BOOL)zz_validAccount {
    return [self zz_isMatchsRegex:@"^[A-Za-z0-9]{6,16}+$"];
}

- (BOOL)zz_validUID {
    return self.length == 16 && [self zz_validDigits];
}

- (BOOL)zz_validIDNumber {
    return [[self uppercaseString] zz_isMatchsRegex:@"^(\\d{6})(\\d{4})(\\d{2})(\\d{2})(\\d{3})([0-9]|X)$"];
}

- (BOOL)zz_validTrueName {
    return [self zz_isMatchsRegex:@"^[\u4E00-\u9FA5]{2,7}$"];
}

- (BOOL)zz_validDigits {
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [self rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound;
}

- (BOOL)zz_validLoginPassword {
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM."] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}

//检查银行卡号

- (BOOL)zz_validBankCardNo {
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[self length];
    int lastNum = [[self substringFromIndex:cardNoLength-1] intValue];
    NSString *cardNo = [self substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

- (NSDate *)zz_stringToDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}

- (NSString *)zz_getPnoEncryption {
    NSString *encry = @"";
    for (int i=4; i<[self length]-4; i++) {
        encry = [encry stringByAppendingString:@"*"];
    }
    return encry;
}

- (NSDictionary *)zz_dictionaryWithJsonString {
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

- (NSDictionary *)zz_stringToDictionary {
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
-(NSString *)zz_deleteBracketstr {
    
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


#pragma mark - Private

- (BOOL)zz_isMatchsRegex:(NSString *)regex {
    if ([self zz_isEmpty]) {
        return NO;
    }
    NSPredicate *nicknameMatches = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    return [nicknameMatches evaluateWithObject:self];
}

+ (NSString *)zz_networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"网路未连接";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"WiFi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}


@end
