//
//  ZZSettingSwitchTableViewCell.m
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "ZZSettingSwitchTableViewCell.h"
#import "LxDBAnything.h"

@interface ZZSettingSwitchTableViewCell()
@property (nonatomic, weak) UISwitch *switchView;
@end

@implementation ZZSettingSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initUI {
    UISwitch *switchView = [[UISwitch alloc] init];
    [switchView addTarget:self action:@selector(switchViewValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = switchView;
    self.switchView = switchView;
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.font = [UIFont systemFontOfSize:16];
}

- (void)setRowOption:(ZZSwitchRowOption *)rowOption {
    _rowOption = rowOption;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isOn = [defaults boolForKey:rowOption.boolKey];
    self.switchView.on = isOn;
    self.textLabel.text = rowOption.title;
}

- (void)switchViewValueChanged:(UISwitch *)switchView {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchView.isOn forKey:self.rowOption.boolKey];
    BOOL isSuccess = [defaults synchronize];
    LxDBAnyVar(isSuccess);
}

@end
