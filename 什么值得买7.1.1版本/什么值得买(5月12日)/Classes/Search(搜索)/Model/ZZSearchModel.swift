//
//  ZZSearchModel.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/3/14.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

@objcMembers
class ZZSearchRequest: ZZBaseRequest {
    var channelName: String?
    var keyword: String?
    let limit: Int = 20
    var offset: Int
    var order: String?
    var type: String?
    var localtype: String?
    
    override init() {
        offset = 0
        super.init()
        urlStr = kZDM_Search
    }
}

@objcMembers
class ZZSearchHotTagRequest: ZZBaseRequest {
    override init() {
        super.init()
        urlStr = kZDM_Search_HotTags
    }
}

@objcMembers
class ZZSearchModel: NSObject {
    var title: String?
    var name: String?
    var type: String?
    var obviously: String?
}


@objcMembers
class ZZSearchResultModel: NSObject {
    var category: [ZZCategory]?
    
    var channel: ZZChannel?
    
    var total_num: String?
    
    var mall: ZZMall?
    
    var recommend_users: [ZZRecommend_Users]?
    
    var rows: [ZZWorthyArticle]?
    
    var users_more: Bool = false
}

class Data: NSObject {



}

@objcMembers
class ZZChannel: NSObject {

    var second_hand: String?

    var news: String?

    var yuanchuang: String?

    var wiki: String?

    var faxian: String?

    var haitao: String?

    var faxian_jingxuan: String?

    var zhongce: String?

    var youhui: String?

    var haowu: String?

    var coupon: String?

    var home: String?

    var shai: String?

    var quan: String?

    var pingce: String?

    var zhongce_product: String?

    var user: String?

}

@objcMembers
class ZZMall: NSObject {

    var haiwai: [ZZResultCount]?

    var guonei: [ZZResultCount]?

    var kuajing: [ZZResultCount]?

}

@objcMembers
class ZZResultCount: NSObject {

    var id: String?

    var name: String?

    var count: String?

}

@objcMembers
class ZZRecommend_Users: NSObject {

    var prestige: String?

    var avatar: String?

    var nickname: String?

    var smzdm_id: String?

    var level: String?

    var fans_num: String?

    var yuanchuang_count: String?

    var super_shj: String?

    var follower_num: String?

    var baoliao_count: String?

    var shj: String?

}

@objcMembers
class ZZCategory: NSObject {

    var id: String?

    var count: String?

    var name: String?

}
