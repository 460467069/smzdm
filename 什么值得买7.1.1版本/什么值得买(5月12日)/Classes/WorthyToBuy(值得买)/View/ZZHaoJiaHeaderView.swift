//
//  ZZHaoJiaHeaderView.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/3.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit


class ZZHaoJiaHeaderView: UIView {

    
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet weak var cycleScrollView: ZZCycleScrollView!
    
    @objc var contentHeader: ZZContentHeader? {
        
        didSet {

            var picArray = [Any]()
            
            if let contentHeader = contentHeader {
                for headLine in contentHeader.rows {
                    
                    picArray.append(headLine.img)
                }
                cycleScrollView.imageURLStringsGroup = picArray
                
                
                for (key1, littleBanner) in contentHeader.little_banner.enumerated() {
                    
                    for (key2, imageView) in imageViews.enumerated() {
                        if key1 == key2 {
                            
                            imageView.setImageWith(URL.init(string: littleBanner.img), options: .showNetworkActivity)
                        }
                    }
                }
            }
            
            
        }
    }
}
