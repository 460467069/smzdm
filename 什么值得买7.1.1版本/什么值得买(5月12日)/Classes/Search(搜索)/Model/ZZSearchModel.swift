//
//  ZZSearchModel.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/3/14.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZSearchRequest: ZZBaseRequest {
    override init() {
        super.init()
        urlStr = kZDM_Search_HotTags
    }
}

class ZZSearchModel: NSObject {
    var title: String?
    var name: String?
    var type: String?
    var obviously: String?
}
