//
//  ZZBaiCaiJingXuanModel.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/23.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

@objcMembers
class ZZBaiCaiJingXuanModel: NSObject {
    var top_list: [ZZWorthyArticle]?
    
    var jingxuan: [ZZWorthyArticle]?
    
    var redirect_data: ZZRedirectData?
    
    
    class func modelContainerPropertyGenericClass()->[String : AnyObject]{

        return ["top_list" : ZZWorthyArticle.self,
                "jingxuan" : ZZWorthyArticle.self]
    }
}
