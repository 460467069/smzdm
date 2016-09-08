//
//  HMTabBarModel.h
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTabBarModel : NSObject

/** tabBarItem的文字 */
@property (nonatomic, copy) NSString *title;
/** sb名字 */
@property (nonatomic, copy) NSString *nibName;
/** 普通状态下的图片 */
@property (nonatomic, copy) NSString *normalImage;
/** 选中装下的图片 */
@property (nonatomic, copy) NSString *selectedImage;


+ (NSArray *)tabBarModels;

@end
