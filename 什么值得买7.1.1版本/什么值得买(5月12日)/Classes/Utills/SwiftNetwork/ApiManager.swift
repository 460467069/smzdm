//
//  ApiManager.swift
//  什么值得买
//
//  Created by Wang_Ruzhou on 2018/5/29.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

import Foundation
import Moya


enum ApiManager {
    case haowenHome
}


extension ApiManager: TargetType {
    
    var headers: [String : String]? {
        return nil
    }
    var base: String { return RequestURL.shareInstance.BaseURLString2 }
    var baseURL: URL { return URL(string: base)! }
    
    var method: Moya.Method {
        switch self {
        case .haowenHome:
            return .get
        }
    }

    var path: String {
        switch self {
        case .haowenHome:
            return "v1/sns/home"
        }
    }
    
    var task: Task {
        let encoding: ParameterEncoding
        switch method {
        case .post:
            encoding = JSONEncoding.default
        default:
            encoding = URLEncoding.default
        }
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: encoding)
        }
        return .requestPlain
    }

    var parameters: [String: Any]? {
        switch self {
        case .haowenHome:
            return nil;
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
}
