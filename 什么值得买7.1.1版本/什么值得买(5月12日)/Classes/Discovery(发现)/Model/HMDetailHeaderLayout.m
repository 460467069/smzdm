//
//  HMDetailHeaderLayout.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDetailHeaderLayout.h"
#import "HMTextLinePositionModifier.h"


@implementation HMDetailHeaderLayout


- (instancetype)initWithHeaderDetailModel:(HMDetailModel *)detailModel {
	
    if (!detailModel) {
        return nil;
    }
    if (self = [super init]) {
        
        _detailModel = detailModel;
    }
    
    [self layout];
    _height = 0;
    _height += _imageHeight;
    _height += _textHeight;
    if (detailModel.article_avatar.length) {   //暂根据是否有头像字段来判断
        _height += kTitleLineSpacing;
        _height += kDetailAvartarHeight;
    }else{  //若为原创, 要除去分割线高度和分割线以下留白高度
        _height += kSeparatorLineHeight;
        _height += kSeparatorLineBottom;
    }
    _height += kSeparatorLineTop;

    return self;
 
}

- (void)layout{

    NSArray <HMProductFocusPicUrl *> *article_product_focus_pic_url = _detailModel.article_product_focus_pic_url;

    if (article_product_focus_pic_url.count != 0 || _detailModel.article_pic) {
        _imageHeight = kTopImageHeight;
    }else{
        _imageHeight = 0;
    }
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont boldSystemFontOfSize:20];
    {
        NSString *firstTitle = _detailModel.article_rzlx.length ? _detailModel.article_rzlx : _detailModel.article_mall;
        
        NSString *title = [NSString stringWithFormat:@"%@ | %@", firstTitle, _detailModel.article_format_date];
        if (_detailModel.article_bl_author_info[0]) {
            title = [NSString stringWithFormat:@"%@ | 爆料人: %@", title, _detailModel.article_bl_author_info[0].nick_name];
        }
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:[UIColor lightGrayColor] forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    {
        NSString *title = [NSString stringWithFormat:@"%@", _detailModel.article_title];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalGrayColor forKey:NSForegroundColorAttributeName];
        [attributes setObject:font forKey:NSFontAttributeName];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    
    if (_detailModel.article_price.length) {
        NSString *title = [NSString stringWithFormat:@"%@", _detailModel.article_price];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalRedColor forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
    }
    
    text.lineSpacing = kTitleLineSpacing;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenW, HUGE) insets:UIEdgeInsetsMake(kDetailContentOffset, kDetailContentOffset, 0, kDetailContentOffset)];
    
    _titleTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (!_titleTextLayout) return;
    _textHeight = _titleTextLayout.textBoundingSize.height;
    
    //原创作者
    if (_detailModel.article_avatar.length){
        
        NSString *title = [NSString stringWithFormat:@"%@", _detailModel.article_referrals];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalGrayColor forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
        NSAttributedString *text = [[NSAttributedString alloc] initWithString:title attributes:attributes];
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenW, 50)];
        _referralTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    }
    
}

@end
