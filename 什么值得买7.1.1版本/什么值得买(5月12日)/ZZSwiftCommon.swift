//
//  ZZSwiftCommon.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 16/10/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import Foundation
import YYKit


let kScreenBounds = UIScreen.main.bounds
let kScreenWidth  = YYScreenSize().width
let kScreenHeight = YYScreenSize().height
let kScreenScale  = YYScreenScale()

let kStatusHeight = 20
let kNavHeight    = 44.0
let kNabBarHeight = 49.0

let kGlobalGrayColor      = UIColor.init(hexString: "#666666")
let kGlobalRedColor       = UIColor.init(hexString: "#F04848")
let kGlobalBlueColor      = UIColor.init(hexString: "#1F2F6C")
let kGlobalLightGrayColor = UIColor.init(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)

let kLineSpacing: CGFloat = 5
let kZDMPadding: CGFloat = 10


@objc protocol ZZActionDelegate: NSObjectProtocol{
    @objc func itemDidClick(redirectData: ZZRedirectData)
}









		
