//
//  NetworkResponse.swift
//  什么值得买
//
//  Created by Wang_Ruzhou on 2018/5/29.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

import Foundation

struct ResponseKey {
    static let errorCode = "error_code"
    static let errorMsg  = "error_msg"
    static let smzdmId = "smzdm_id"
    static let s = "s"
    static let data = "data"
}

enum ResponseCode: Int {
    case success = 0
}
