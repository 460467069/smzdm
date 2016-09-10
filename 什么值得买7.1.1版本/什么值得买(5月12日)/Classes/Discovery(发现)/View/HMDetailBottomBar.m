//
//  HMDetailBottomBar.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/9.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDetailBottomBar.h"

@interface HMDetailBottomBar ()
@property (nonatomic, assign) DetailBottomBarStyle style;
@property (nonatomic, weak) CALayer *topLineLayer;
@end

@implementation HMDetailBottomBar

+ (instancetype)barWithStyle:(DetailBottomBarStyle)style{
    
    HMDetailBottomBar *bottomBar = [[HMDetailBottomBar alloc] init];
    bottomBar.style = style;
    return bottomBar;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenW;
        frame.size.height = 49;
    }
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CALayer *topLineLayer = [CALayer layer];
        topLineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        [self.layer addSublayer:topLineLayer];
        topLineLayer.height = 0.5;
        topLineLayer.width = self.width;
        
        NSInteger items = 4;
        CGFloat rightBtnW = 120;
        
        CGFloat labelW = (kScreenW - rightBtnW) / items;
        
        for (NSInteger i = 0; i < items; i++) {
            NSMutableAttributedString *text = [NSMutableAttributedString new];
            UIFont *font = [UIFont systemFontOfSize:10];

            UIImage *image = [UIImage imageNamed:@"IMG_BKDetail_Zhi"];
            NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentBottom];
            [text appendAttributedString:attachText];
            
            NSString *title = @" 76%";
            [text appendString:title];
            
            YYLabel *label = [YYLabel new];
            label.attributedText = text;
            label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
            label.textAlignment = NSTextAlignmentCenter;
            label.left = labelW * i;
            label.height = self.height;
            label.centerY = self.height * 0.5;
            label.width = labelW;
            [self addSubview:label];
        }
        
        
        UIButton *rightBtn = [[UIButton alloc] init];
        rightBtn.width = rightBtnW;
        rightBtn.right = self.right;
        rightBtn.height = self.height;
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"IMG_YHDetail_zdlj"] forState:UIControlStateNormal];
        [self addSubview:rightBtn];
        
        
    }
    return self;
}

@end

