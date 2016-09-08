//
//  HMDouYuBannerCell.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/7/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDouYuBannerCell.h"
#import "UIImageView+CornerRadius.h"



@interface HMDouYuBannerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation HMDouYuBannerCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.iconView zy_cornerRadiusRoundingRect];
}

- (void)setBannelModel:(HMDouYuHomeModel *)bannelModel{
    
    _bannelModel = bannelModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:bannelModel.icon_url] placeholderImage:[UIImage imageNamed:@"placeholder_dropbox"]];
    
    self.titleLabel.text = bannelModel.tag_name;
    
}

@end
