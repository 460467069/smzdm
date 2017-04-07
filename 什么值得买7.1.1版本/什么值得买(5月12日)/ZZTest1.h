//
//  ZZTest1.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/3/20.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Data,Progerss,Level,Casetype;
@interface ZZTest1 : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) Data *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface Data : NSObject

@property (nonatomic, copy) NSString *finishPlace;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) Casetype *caseType;

@property (nonatomic, copy) NSString *proxyFee;

@property (nonatomic, strong) Progerss *progerss;

@property (nonatomic, copy) NSString *appealTime;

@property (nonatomic, copy) NSString *openPlace;

@property (nonatomic, copy) NSString *filingPlace;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *ruleTime;

@property (nonatomic, strong) Level *level;

@property (nonatomic, copy) NSString *appealPlace;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *tell;

@property (nonatomic, copy) NSString *openTime;

@property (nonatomic, copy) NSString *reason;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *finishTime;

@property (nonatomic, copy) NSString *filingTime;

@property (nonatomic, copy) NSString *logo;

@property (nonatomic, copy) NSString *description;

@end

@interface Progerss : NSObject

@property (nonatomic, copy) NSString *value;

@property (nonatomic, assign) NSInteger code;

@end

@interface Level : NSObject

@property (nonatomic, copy) NSString *value;

@property (nonatomic, assign) NSInteger code;

@end

@interface Casetype : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@end

