//
//  HMDiscoveryView.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/6/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDiscoveryView.h"

@interface HMDiscoveryView ()


/** switchBtn */
@property (weak, nonatomic) UISwitch *switchBtn;

/** <##> */
@property (nonatomic, assign)CGFloat offsetY;


@property (nonatomic, strong) NSMutableArray *animatableConstraints;
@property (nonatomic, assign) int padding;
@property (nonatomic, assign) BOOL animating;

@end
@implementation HMDiscoveryView



- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setupAnimation];
}

- (void)setupAnimation {
    
    
//    UISwitch *switchBtn = [[UISwitch alloc] init];
//    [self addSubview:switchBtn];
//    self.switchBtn = switchBtn;
//    
//    //    [self.view layoutIfNeeded];
//    self.offsetY = -50;
    
    UIView *greenView = UIView.new;
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.borderColor = UIColor.blackColor.CGColor;
    greenView.layer.borderWidth = 2;
    [self addSubview:greenView];
    
    UIView *redView = UIView.new;
    redView.backgroundColor = UIColor.redColor;
    redView.layer.borderColor = UIColor.blackColor.CGColor;
    redView.layer.borderWidth = 2;
    [self addSubview:redView];
    
    UIView *blueView = UIView.new;
    blueView.backgroundColor = UIColor.blueColor;
    blueView.layer.borderColor = UIColor.blackColor.CGColor;
    blueView.layer.borderWidth = 2;
    [self addSubview:blueView];
    
    UIView *superview = self;
    int padding = self.padding = 10;
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding);
    
    self.animatableConstraints = NSMutableArray.new;
    
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.animatableConstraints addObjectsFromArray:@[
                                                          make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),
                                                          make.bottom.equalTo(blueView.mas_top).offset(-padding),
                                                          ]];
        
        make.size.equalTo(redView);
        make.height.equalTo(blueView.mas_height);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.animatableConstraints addObjectsFromArray:@[
                                                          make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),
                                                          make.left.equalTo(greenView.mas_right).offset(padding),
                                                          make.bottom.equalTo(blueView.mas_top).offset(-padding),
                                                          ]];
        
        make.size.equalTo(greenView);
        make.height.equalTo(blueView.mas_height);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.animatableConstraints addObjectsFromArray:@[
                                                          make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),
                                                          ]];
        
        make.height.equalTo(greenView.mas_height);
        make.height.equalTo(redView.mas_height);
    }];

}

- (void)didMoveToWindow {
    [self layoutIfNeeded];
    
    if (self.window) {
        self.animating = YES;
        [self animateWithInvertedInsets:NO];
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    
    LxDBAnyVar(newWindow);
    self.animating = newWindow != nil;
}

- (void)animateWithInvertedInsets:(BOOL)invertedInsets {
    if (!self.animating) return;
    
    int padding = invertedInsets ? 100 : self.padding;
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    for (MASConstraint *constraint in self.animatableConstraints) {
        constraint.insets = paddingInsets;
    }
    
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        //repeat!
        [self animateWithInvertedInsets:!invertedInsets];
    }];
}



@end
