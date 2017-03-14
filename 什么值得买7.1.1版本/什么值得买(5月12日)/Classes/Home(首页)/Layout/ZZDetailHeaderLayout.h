//
//  ZZDetailHeaderLayout.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZDetailModel.h"

#define kDetailHeaderContentOffset 20     //文字内容偏移(分割线左间距)
#define kTitleLineSpacing 15        //文字行间距
#define kTopImageHeight 200         //图片高度(若有)
#define kTopImageWidth 200         //图片高度(若有)
#define kSeparatorLineTop 15        //分割线顶部留白
#define kSeparatorLineBottom 20     //分割线底部留白
#define kSeparatorLineHeight 0.5    //分割线高度
#define kDetailAvartarHeight 40
#define kDetailReferralLabelHeight 30
#define kDetailReferralLabelWidth 100

@interface ZZDetailHeaderLayout : NSObject

@property (nonatomic, strong) YYTextLayout *titleTextLayout; // 标题栏
@property (nonatomic, strong) YYTextLayout *referralTextLayout;
@property (nonatomic, strong) ZZDetailModel *detailModel;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, assign) CGFloat textHeight;
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithHeaderDetailModel:(ZZDetailModel *)detailModel;
//计算布局
- (void)layout;
@end


