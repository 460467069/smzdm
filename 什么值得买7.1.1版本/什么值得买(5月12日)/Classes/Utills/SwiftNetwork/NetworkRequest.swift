//
//  NetworkRequest.swift
//  什么值得买
//
//  Created by Wang_Ruzhou on 2018/5/29.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

import Foundation

let DebugURLString1        = "https://api.smzdm.com"
let DebugURLString2        = "https://post-api.smzdm.com"

let ReleaseURLString1      = "https://api.smzdm.com"
let ReleaseURLString2      = "https://post-api.smzdm.com"

class RequestURL: NSObject {
    #if DEBUG
    let BaseURLString1 = DebugURLString1
    let BaseURLString2 = DebugURLString2
    #else
    let BaseURLString1 = ReleaseURLString1
    let BaseURLString2 = ReleaseURLString2
    #endif
    
    static let shareInstance = RequestURL()
    private override init() {
        super.init()
    }
}
