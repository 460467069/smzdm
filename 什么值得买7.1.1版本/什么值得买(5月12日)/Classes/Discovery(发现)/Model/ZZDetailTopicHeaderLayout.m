//
//  ZZDetailTopicHeaderLayout.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/11.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZDetailTopicHeaderLayout.h"
#import "ZZTextLinePositionModifier.h"

@implementation ZZDetailTopicHeaderLayout


- (instancetype)initWithHeaderDetailModel:(ZZDetailTopicHeaderModel *)detailTopicHeaderModel {
    if (!detailTopicHeaderModel) {
        return nil;
    }
    
    if (self = [super init]) {
        _detailTopicHeaderModel = detailTopicHeaderModel;
        [self layout];
        
        _height = 0;
        _height += _imageHeight;
        _height += _articleHeight;
        _height += kDetailTopicBtnTop;
        _height += kDetailTopicBtnHeight;
        _height += kDetailTopicBtnBottom;
        
    }
    return self;
    
}

- (void)layout {
    
    if (_detailTopicHeaderModel.focus_pic.length) {
        _imageHeight = kDetailTopicImageHeight;
    }
    
    NSMutableAttributedString *articleText = [NSMutableAttributedString new];
    {
        NSString *title = [NSString stringWithFormat:@"%@", _detailTopicHeaderModel.title];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalGrayColor forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName];
        [articleText appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
        [articleText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    
    {
        NSString *title = [NSString stringWithFormat:@"%@", _detailTopicHeaderModel.brief];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalGrayColor forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
        [articleText appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
        [articleText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    
    articleText.lineSpacing = 10;
    ZZTextLinePositionModifier *modifier = [[ZZTextLinePositionModifier alloc] init];
    modifier.font = [UIFont systemFontOfSize:20];
    modifier.paddingTop = kDetailContentOffset;
    modifier.paddingBottom = kDetailContentOffset;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenW, HUGE) insets:UIEdgeInsetsMake(20, kDetailContentOffset, kDetailContentOffset, kDetailContentOffset)];
    _articleLayout = [YYTextLayout layoutWithContainer:container text:articleText];
    _articleHeight = [modifier heightForLineCount:_articleLayout.lines.count];
    
}
@end
