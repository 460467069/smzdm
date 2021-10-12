//
//  UILabel+YYBBAdd.m
//
//
//  Created by apple on 15/12/2.
//  
//

#import "UILabel+YYBBAdd.h"
#import "YYBBUtilsMacro.h"

@implementation UILabel(YYBBAdd)

- (void)setRequirePrefix:(BOOL)requirePrefix {
    self.attributedText = YYBBRequiredContent(self.text, requirePrefix, YES);
}

- (void)setRequireSuffix:(BOOL)requireSuffix {
    self.attributedText = YYBBRequiredContent(self.text, requireSuffix, NO);
}

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
                        lines:(NSInteger)lines {
    UILabel *label = [self yybb_createLable:frame
                                       text:text
                                textAliType:textAliType
                                       font:font
                                      color:color
                                  backColor:nil
                                      lines:lines
                  adjustsFontSizeToFitWidth:NO];
    return label;
}

+ (UILabel *)yybb_createLable:(CGRect)frame
                         text:(NSString *)text
                  textAliType:(NSTextAlignment)textAliType
                         font:(UIFont *)font
                        color:(UIColor *)color
                    backColor:(UIColor *)backColor
                        lines:(NSInteger)lines {
    UILabel *label = [self yybb_createLable:frame
                                       text:text
                                textAliType:textAliType
                                       font:font
                                      color:color
                                  backColor:backColor
                                      lines:lines
                  adjustsFontSizeToFitWidth:NO];
    return label;
}

+ (UILabel *)yybb_createLable:(CGRect)frame
                         text:(NSString *)text
                  textAliType:(NSTextAlignment)textAliType
                         font:(UIFont *)font
                        color:(UIColor *)color
                    backColor:(UIColor *)backColor
                        lines:(NSInteger)lines
    adjustsFontSizeToFitWidth:(BOOL)adjust {
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setBackgroundColor:(backColor ? backColor:[UIColor clearColor])];
    [label setText:text];
    [label setTextAlignment:textAliType];
    if (font) {
        label.font = font;
    }
    if (color) {
        [label setTextColor:color];
    }
    label.numberOfLines = lines;
    label.adjustsFontSizeToFitWidth = adjust;  //设置字体大小是否适应label宽度
    
    return label;
}

+ (UILabel *)initWithFrame:(CGRect)frame
                      text:(NSString *)text
                  fontSize:(CGFloat)fontSize
                     color:(UIColor *)color
                 alignment:(NSTextAlignment)alignment
                     lines:(NSInteger)lines {
        return [UILabel initWithFrame:frame text:text fontSize:fontSize color:color alignment:alignment lines:lines shadowColor:[UIColor clearColor]];
}

+ (UILabel *)initWithFrame:(CGRect)frame
                      text:(NSString *)text
                  fontSize:(CGFloat)fontSize
                     color:(UIColor *)color
                 alignment:(NSTextAlignment)alignment
                     lines:(NSInteger)lines
               shadowColor:(UIColor *)txtShadowColor {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = lines;

    label.font = [UIFont boldSystemFontOfSize:fontSize];
    
    label.text = text;
    if (color)
    {
        label.textColor = color;
    }
    if (txtShadowColor)
    {
        label.shadowColor = txtShadowColor;
    }
    label.textAlignment = alignment;
    
    return label;
}

+ (UILabel *)initWithType:(NSInteger )type
                    frame:(CGRect)frame
                     text:(NSString *)text
                 fontSize:(CGFloat)fontSize
                    color:(UIColor *)color
                alignment:(NSTextAlignment)alignment
                    lines:(NSInteger)lines {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    if (type == 1) {
         label.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
    }else if(type == 2){
        label.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    }else if(type == 3){
        label.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightBold];
    }else{
        label.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
    }
    label.numberOfLines = lines;
    label.text = text;
    label.textAlignment = alignment;
    return label;
}

+ (UILabel *)initWithTypeStr:(NSString *)typeStr
                       frame:(CGRect)frame
                        text:(NSString *)text
                    fontSize:(CGFloat)fontSize
                       color:(UIColor *)color
                   alignment:(NSTextAlignment)alignment
                       lines:(NSInteger)lines {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.font = [UIFont fontWithName:typeStr size:fontSize];
    label.numberOfLines = lines;
    label.text = text;
    label.textAlignment = alignment;
    return label;
}

-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];        //设置行间距
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}

@end
