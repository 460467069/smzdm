//
//  ZZGoodArticleModel.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/4.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit


class ZZGoodArticleListRequest: ZZBaseRequest {
    var refresh_time: Int
    var size: Int
    
    override init () {
        refresh_time = 1
        size = 5
        super.init()
        urlStr = kZDM_HaoWen
    }
}

class ZZGoodArticleBannerRequest: ZZHomeBannerRequest {
    override init() {
        super.init()
        type = "shequ"
    }
}

class ZZGoodArticleModel: NSObject {
    

}
