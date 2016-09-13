//
//  ZZDouYuHomeCell.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/7/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZDouYuHomeCollectionViewCell.h"
#import "UIImageView+CornerRadius.h"

@interface ZZDouYuHomeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *watchCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;

@end

@implementation ZZDouYuHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.iconView zy_cornerRadiusAdvance:5 rectCornerType:UIRectCornerAllCorners];
    
    
}

- (void)setListModel:(ZZDouYURoom_List *)listModel{
    _listModel = listModel;
    
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:listModel.room_src] placeholderImage:[UIImage imageNamed:@"placeholder_dropbox"]];
    
    self.titleLabel.text = listModel.nickname;
    
    self.roomLabel.text = listModel.room_name;
    
    
}
@end
