//
//  ZZChooseTextFieldTableViewCell.h
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <IQDropDownTextField/IQDropDownTextField.h>
#import "ZZBaseTextFieldTableViewCell.h"

@class ZZChooseTextFieldTableViewCell;

@protocol ZZChooseTextFieldTableViewCellDelegate <NSObject>
@optional
- (void)chooseTextFieldTableViewCellDidSelecItem:(ZZChooseTextFieldTableViewCell *)chooseCell;
@end


@interface ZZChooseTextFieldTableViewCell : ZZBaseTextFieldTableViewCell

@property (weak, nonatomic) id<ZZChooseTextFieldTableViewCellDelegate> delegate;

@end
