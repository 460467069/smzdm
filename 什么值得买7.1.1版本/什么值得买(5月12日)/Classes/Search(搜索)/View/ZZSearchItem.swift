//
//  ZZSearchItem.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/3/14.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZSearchHeader: UICollectionReusableView {
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = kGlobalGrayColor
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        return titleLabel
    }()
    
    lazy var clearBtn: UIButton = {
        let clearBtn = UIButton()
        clearBtn.setTitleColor(kGlobalRedColor, for: .normal)
        clearBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        clearBtn.addTarget(self, action: #selector(clearBtnDidClick), for: .touchUpInside)
        clearBtn.setTitle("清除历史", for: .normal)
        return clearBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor.random()
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(titleLabel)
        addSubview(clearBtn)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.left.equalTo(self)
        }
        clearBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(self)
        }
    }
    
    func clearBtnDidClick(){
        
    }
}

class ZZSearchItem: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.backgroundColor = UIColor.zz_random()
        titleLabel.textAlignment = .center
        titleLabel.layer.cornerRadius = 3.0
        titleLabel.clipsToBounds = true
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
