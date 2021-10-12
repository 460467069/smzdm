//
//  UILabel+YYBBAdd.h
//
//
//  Created by apple on 15/12/2.
//
//

#import <Foundation/Foundation.h>

@interface UILabel(YYBBAdd)


//  * 前缀
@property (nonatomic, assign) IBInspectable BOOL requirePrefix;

//  * 后缀
@property (nonatomic, assign) IBInspectable BOOL requireSuffix;

/**
 *  创建label
 *
 *  @param frame        位置
 *  @param text        内容
 *  @param textAliType 对齐
 *  @param font         字体
 *  @param color       字体颜色
 *  @param lines       行数
 *
 *  @return label对象
 */
+ (UILabel *)yybb_createLable:(CGRect)frame
                         text:(NSString *)text
                  textAliType:(NSTextAlignment)textAliType
                         font:(UIFont *)font
                        color:(UIColor *)color
                        lines:(NSInteger)lines;

+ (UILabel *)initWithFrame:(CGRect)frame
                      text:(NSString *)text
                  fontSize:(CGFloat)fontSize
                     color:(UIColor *)color
                 alignment:(NSTextAlignment)alignment
                     lines:(NSInteger)lines;

+ (UILabel *)initWithFrame:(CGRect)frame
                      text:(NSString *)text
                  fontSize:(CGFloat)fontSize
                     color:(UIColor *)color
                 alignment:(NSTextAlignment)alignment
                     lines:(NSInteger)lines
               shadowColor:(UIColor *)txtShadowColor;

+ (UILabel *)initWithType:(NSInteger )type
                    frame:(CGRect)frame
                     text:(NSString *)text
                 fontSize:(CGFloat)fontSize
                    color:(UIColor *)color
                alignment:(NSTextAlignment)alignment
                    lines:(NSInteger)lines;

+ (UILabel *)initWithTypeStr:(NSString *)typeStr
                       frame:(CGRect)frame
                        text:(NSString *)text
                    fontSize:(CGFloat)fontSize
                       color:(UIColor *)color
                   alignment:(NSTextAlignment)alignment
                       lines:(NSInteger)lines;

/**
 设置文本,并指定行间距

 @param text 文本内容
 @param lineSpacing 行间距
 */
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end
