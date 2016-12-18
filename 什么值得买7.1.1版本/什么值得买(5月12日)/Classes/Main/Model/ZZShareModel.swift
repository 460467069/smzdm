//
//  ZZShareModel.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/18.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZShareModel: NSObject {
    
    var title: String?
    var icon: String?
    var iconPress: String?

    class func models() ->[ZZShareModel]?{

        if let mutableArray = self.mj_objectArray(withFilename: "Share.plist") {
            
            let array = NSArray.init(array: mutableArray)
            
            return array as? [ZZShareModel]
            
        }
        
        return nil
        
    }

}
