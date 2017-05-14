//
//  ZZFantasticGoodsMOdel.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/19.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZFantasticGoodsRequest: ZZBaseRequest {
    var limit: Int
    var offset: Int
    
     override init () {
        limit = 20
        offset = 0
        super.init()
        urlStr = kZDM_HaoWu_TopicList 
    }
}

class ZZFantasticGoodsModel: NSObject {

    
    var id: String?

    var data: [ZZGoodsSubItemModel]?

    var name: String?

    var type: String?
    
    var focus_pic: String?
    
    var count: Int?
    
    var redirect_data: ZZRedirectData?
    
    class func modelContainerPropertyGenericClass()->[String : AnyObject]{        
        return ["data" : ZZGoodsSubItemModel.self]
    }
    
}

class ZZGoodsSubItemModel: NSObject {

    var id: String?

    var title: String?

    var pro_pic: String?

    var url: String?
    
    var type: String?

    var redirect_data: ZZRedirectData?
    
    //type == 1
    var name: String?
    
    var pro_subtitle: String?
    
    var is_spu: String?
    
    var pro_price: String?
    
    var tag_info: [ZZTagInfo]?
    
    class func modelContainerPropertyGenericClass()->[String : AnyObject]{
        return ["tag_info" : ZZTagInfo.self]
    }

}

class ZZTagInfo: NSObject {
    
    var tag_name: String?
    
}



