//
//  ZZLittleBannerCell.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZLittleBannerCell.h"

@interface ZZLittleBannerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ZZLittleBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setLittleBanner:(ZZLittleBanner *)littleBanner{
    
    _littleBanner = littleBanner;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:littleBanner.img] placeholderImage:[UIImage imageNamed:@"placeholder_dropbox"]];
    
    self.nameLabel.text = littleBanner.title;
    
    self.nameLabel.textColor = [UIColor colorWithHexString:self.littleBannerOptions.color_card];
    
}

@end
