//
//  UILabel+ZZAdd.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "UILabel+ZZAdd.h"

@implementation UILabel(ZZAdd)

- (CGSize)contentSize {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    CGSize contentSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize;
}

+ (UILabel *)yj_createLable:(CGRect)frame
                       text:(NSString *)aText
                textAliType:(NSTextAlignment)aTextAliType
                       font:(UIFont *)font
                      color:(UIColor *)aColor
                  backColor:(UIColor *)bColor {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setBackgroundColor:(bColor ? bColor:[UIColor clearColor])];
    [label setText:aText];
    [label setTextAlignment:aTextAliType];
    if (font) {
        label.font = font;
    }
    if (aColor) {
        [label setTextColor:aColor];
    }
    label.adjustsFontSizeToFitWidth = YES;  //设置字体大小是否适应label宽度
    
    return label;
}

+ (UILabel *)yj_createLable:(CGRect)frame
                       text:(NSString *)aText
                textAliType:(NSTextAlignment)aTextAliType
                       font:(UIFont *)font
                      color:(UIColor *)aColor
                  backColor:(UIColor *)bColor
  adjustsFontSizeToFitWidth:(BOOL)bAdjust {
    UILabel *label = [self yj_createLable:frame
                                     text:aText
                              textAliType:aTextAliType
                                     font:font
                                    color:aColor
                                backColor:bColor];
    label.adjustsFontSizeToFitWidth = bAdjust;  //设置字体大小是否适应label宽度
    
    return label;
}

@end
