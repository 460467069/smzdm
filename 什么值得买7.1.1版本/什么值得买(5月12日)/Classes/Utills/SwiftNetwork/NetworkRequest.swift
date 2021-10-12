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
let DebugURLString3        = "https://homepage-api.smzdm.com"
let DebugURLString4        = "https://homepage-api.smzdm.com"


let ReleaseURLString1      = "https://api.smzdm.com"
let ReleaseURLString2      = "https://post-api.smzdm.com"
let ReleaseURLString3      = "https://homepage-api.smzdm.com"
let ReleaseURLString4      = "https://homepage-api.smzdm.com"

class RequestURL: NSObject {
    #if DEBUG
    let BaseURLString1 = DebugURLString1
    let BaseURLString2 = DebugURLString2
    let BaseURLString3 = DebugURLString3
    let BaseURLString4 = DebugURLString4
    #else
    let BaseURLString1 = ReleaseURLString1
    let BaseURLString2 = ReleaseURLString2
    let BaseURLString3 = ReleaseURLString3
    let BaseURLString4 = ReleaseURLString4
    #endif
    
    static let shareInstance = RequestURL()
    private override init() {
        super.init()
    }
}
