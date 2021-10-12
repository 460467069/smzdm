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
    case homePage
    case haowenHome
}


extension ApiManager: TargetType {
    
    var headers: [String : String]? {
        return ["Cookie" : "device_id=u2n7E7g8GN614PhgRRMTDF9mLo7nKcI%2F2MZzQ5N8TCijPn9NXBbmkw%3D%3D"]
    }
    
    var base: String {
        switch self {
        case .homePage:
            return RequestURL.shareInstance.BaseURLString3
        default:
            return RequestURL.shareInstance.BaseURLString2
        }
    }
    var baseURL: URL {
        return URL(string: base)!
    }
    
    var method: Moya.Method {
        switch self {
        case .haowenHome:
            return .get
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .homePage:
            return "v1/home"
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
        case .homePage:
            return nil;
        case .haowenHome:
            return nil;
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
}


struct HomePageRequestModel:Codable {
    
}
