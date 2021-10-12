//
//  YYBBLogin.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/9/6.
//

#import <Foundation/Foundation.h>
#import "YYBBUserLoginDelegate.h"
#import "YYBBPlugin.h"

@interface YYBBLogin : YYBBPlugin<YYBBUserLoginDelegate>

@property (nonatomic, assign) BOOL isLoggingAccount;             // 是否正在登录账号
@property (nonatomic, assign) BOOL isBindingAccount;             // 是否正在绑定账号
@property (nonatomic, assign) BOOL isAuthorized;                 // 标记第三方是否授权成功, 是否可以直接绑定账号
@property (nonatomic,   copy) NSString *openID;
@property (nonatomic,   copy) NSString *openName;
@property (nonatomic,   copy) NSString *accessToken;
@property (nonatomic, strong) NSDictionary *playerParams;

@end
