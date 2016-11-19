//
//  ZZHaoJiaHeaderLayout.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/3.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZHaoJiaHeaderLayout: NSObject {

    var height: CGFloat?
    
    var haoJiaHeaderModel: ZZContentHeader?
    
    init(haoJiaHeaderModel: ZZContentHeader) {
        
        self.haoJiaHeaderModel = haoJiaHeaderModel
        
        super.init()
    }
}
