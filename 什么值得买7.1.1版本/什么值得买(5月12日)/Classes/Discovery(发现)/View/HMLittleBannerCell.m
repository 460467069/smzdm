//
//  HMLittleBannerCell.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMLittleBannerCell.h"

@interface HMLittleBannerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation HMLittleBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setLittleBanner:(HMLittleBanner *)littleBanner{
    
    _littleBanner = littleBanner;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:littleBanner.img] placeholderImage:[UIImage imageNamed:@"placeholder_dropbox"]];
    
    self.nameLabel.text = littleBanner.title;
    
}

@end
