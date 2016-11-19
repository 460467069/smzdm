//
//  ZZListCell.h
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZWorthyArticle.h"
#import "ZZHomeChannel.h"

@interface ZZListCell : UITableViewCell

/** 模型 */
@property (nonatomic, strong) ZZWorthyArticle *article;


/** 传入homeChannel模型, 可用作判断是否需要隐藏水印图片 */
@property (nonatomic, strong) ZZHomeChannel *homeChannel;
/**
 *  传入type, 可用作判断是否需要隐藏水印图片
 *  type为 kHaojiaJingXuan
 */
@property (nonatomic, copy) NSString *type;

@end
