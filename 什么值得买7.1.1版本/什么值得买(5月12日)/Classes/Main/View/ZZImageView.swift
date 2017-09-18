//
//  ZZImageView.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/8.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = 3
        layer.masksToBounds = true
    }
    

}
