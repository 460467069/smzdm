//
//  ZZKeyboardToolBar.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/16.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZKeyboardToolBar.h"
#import <YYText/YYText.h>

@interface ZZKeyboardToolBar ()<YYTextViewDelegate>

@property (nonatomic, strong) YYTextView *preSendTextView;
@property (nonatomic, strong)UIButton *emotionBtn;//表情按钮

@end

@implementation ZZKeyboardToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = 56;
    }
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)emotionBtnDidClicked: (UIButton *)emotionBtn{
    [self.preSendTextView resignFirstResponder];
    if (emotionBtn.selected) {
        self.preSendTextView.inputView = nil;
        [self.preSendTextView becomeFirstResponder];
        
    } else {
//        WBEmoticonInputView *inputView = [WBEmoticonInputView sharedView];
//        
//        inputView.delegate = self;
//        self.preSendTextView.inputView = inputView;
        [self.preSendTextView becomeFirstResponder];
    }
    
    emotionBtn.selected = !emotionBtn.selected;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.preSendTextView becomeFirstResponder];
    });
    
}


#pragma mark - setter && getter
- (YYTextView *)preSendTextView{
    if (!_preSendTextView) {
        _preSendTextView = [[YYTextView alloc] init];
        _preSendTextView.font = [UIFont systemFontOfSize:16];
        _preSendTextView.delegate = self;
        _preSendTextView.showsVerticalScrollIndicator = YES;
        _preSendTextView.showsHorizontalScrollIndicator = NO;
        _preSendTextView.placeholderText = kPlaceHolderStr1;
        YYTextSimpleEmoticonParser *simpleParser = [[YYTextSimpleEmoticonParser alloc] init];
        
//        ZQEmoticonGroup *group = [[ZQEmoticonGroup emoticonGroups] firstObject];
//        simpleParser.emoticonMapper = group.emoticonMapper;
//        _preSendTextView.textParser = simpleParser;
        
    }
    
    return _preSendTextView;
}

-(UIButton *)emotionBtn{
    if (_emotionBtn == nil) {
        _emotionBtn = [[UIButton alloc]init];
        [_emotionBtn setImage:[UIImage imageNamed:@"emotionBtn_no"] forState:UIControlStateNormal];
        [_emotionBtn setImage:[UIImage imageNamed:@"emotionBtn_se"] forState:UIControlStateSelected];
        [_emotionBtn addTarget:self action:@selector(emotionBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _emotionBtn;
}


@end
