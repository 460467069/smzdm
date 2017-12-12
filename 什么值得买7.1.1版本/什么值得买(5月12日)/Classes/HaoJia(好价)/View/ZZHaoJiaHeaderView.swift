//
//  ZZHaoJiaHeaderView.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/3.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit


@objcMembers class ZZHaoJiaHeaderView: UIView {

    
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet weak var cycleScrollView: ZZCycleScrollView!
    
    weak var delegate: ZZActionDelegate?
    
    @objc var contentHeader: ZZContentHeader? {
        didSet {
            var picArray = [Any]()
            guard let contentHeader = contentHeader else { return }
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for (index, imageView) in imageViews.enumerated(){
            imageView.isUserInteractionEnabled = true
            imageView.tag = index
            
            let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(imageViewDidTap(tap:)))
            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
        
        
    }
    
    
    @objc fileprivate func imageViewDidTap(tap: UITapGestureRecognizer){
        let tag = tap.view?.tag
        let littleBanner = contentHeader?.little_banner[tag!]
        if let redirectData = littleBanner?.redirectData {
            delegate?.itemDidClick(redirectData: redirectData)
        }

    }
    
    
}
