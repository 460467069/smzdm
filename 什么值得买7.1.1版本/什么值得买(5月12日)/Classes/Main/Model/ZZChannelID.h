//
//  ZZChannelID.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/1.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//
/**
 *  0901, 可以根据拿到的channelID, 去模型数组中直接拿出对应的模型, 目前有2个用途作为首页图片水印的处理, 和点击cell详情页面, URL逻辑处理
 */

#import <Foundation/Foundation.h>

@interface ZZChannelID : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *URLString;
@property (nonatomic, copy) NSString *needChannelID;
@property (nonatomic, copy) NSString *waterImageName;

+ (instancetype)channelWithID:(NSInteger)index;
@end
