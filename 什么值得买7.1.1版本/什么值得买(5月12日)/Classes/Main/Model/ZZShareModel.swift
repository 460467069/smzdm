//
//  ZZShareModel.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/18.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZShareModel: NSObject {
    
    var title: String?
    var icon: String?
    var iconPress: String?
    var platformType: String?      ///分享平台类型, 参考shareSDK中的枚举值 SSDKTypeDefine
    
    
    class func models() ->[ZZShareModel]?{

        if let mutableArray = self.mj_objectArray(withFilename: "Share.plist") {
            
            let array = NSArray.init(array: mutableArray)
            
            return array as? [ZZShareModel]
            
        }
        return nil
    }
    
    
    var type: SSDKPlatformType {
        get {
            
            switch Int(platformType!)!{
            case 1:
                return .typeSinaWeibo
            case 22:
                return .subTypeWechatSession
            case 23:
                return .subTypeWechatTimeline
            case 24:
                return .subTypeQQFriend
            case 6:
                return .subTypeQZone
            case 21:
                return .typeCopy
            default:
                return .typeSinaWeibo
            }
        }
    }
}
