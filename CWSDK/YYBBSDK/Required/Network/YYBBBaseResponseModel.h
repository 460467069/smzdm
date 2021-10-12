//
//  YYBBBaseResponseModel.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 8/6/19.
//

#import <Foundation/Foundation.h>
#import "YYBBNetworkDelegate.h"

typedef NS_ENUM(NSUInteger, YYBBServerResponseType) {
    YYBBServerResponseTypeOK          = 1
};

@interface YYBBBaseResponseModel: NSObject<YYBBResponseDelegate>

@property (nonatomic, assign) YYBBServerResponseType state;

@end
