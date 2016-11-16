//
//  ZZKeyboardToolBar.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/16.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPlaceHolderStr1 @"写评论"
#define kPlaceHolderStr2 @"客观评论, 更具参考性"

@class ZZKeyboardToolBar;
@protocol ZZKeyboardToolBarDelegate <NSObject>
@optional

- (void)keyboardToolBarDidClickSendBtn:(ZZKeyboardToolBar *)keyboardToolBar;

@end

@interface ZZKeyboardToolBar : UIView

@property (nonatomic, weak) id<ZZKeyboardToolBarDelegate> delegate;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSMutableDictionary *commentCache;    /**< 内容简单缓存 */

- (void)zz_becomeFirstResponder;
- (BOOL)zz_isFirstResponder;
- (void)zz_resetStatus;

@end
