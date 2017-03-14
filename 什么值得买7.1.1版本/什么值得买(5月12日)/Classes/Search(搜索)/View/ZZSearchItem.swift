//
//  ZZSearchItem.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/3/14.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZSearchItem: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.backgroundColor = UIColor.white
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var searchModel: ZZSearchModel? {
        didSet {
            if let searchModel = searchModel {
                titleLabel.text = searchModel.title
                titleLabel.textColor = searchModel.obviously == "1" ? kGlobalRedColor : kGlobalGrayColor
            }
        }
    }
    
}
