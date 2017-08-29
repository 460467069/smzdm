//
//  ZZTuiGuangCell.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/17.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZTuiGuangCell.h"

@interface ZZTuiGuangCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end

@implementation ZZTuiGuangCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
}

- (void)setArticle:(ZZWorthyArticle *)article{
    _article = article;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:article.img]];
    self.titleLabel.text = article.title;
    self.tagLabel.text = article.tag;
}

@end
