//
//  ZZEmoticonInputView.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/16.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WBStatusComposeEmoticonViewDelegate <NSObject>
@optional
- (void)emoticonInputDidTapText:(NSString *)text;
- (void)emoticonInputDidTapBackspace;
@end

// 表情输入键盘
@interface ZZEmoticonInputView : UIView

@property (nonatomic, weak) id<WBStatusComposeEmoticonViewDelegate> delegate;
+ (instancetype)sharedView;

@end
