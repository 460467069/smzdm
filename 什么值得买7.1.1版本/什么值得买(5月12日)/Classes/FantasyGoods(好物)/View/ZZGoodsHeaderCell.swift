//
//  ZZGoodsHeaderCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 16/10/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit


class ZZGoodsHeaderCell: UICollectionViewCell {
    
    lazy var iconView = UIImageView()
    lazy var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        initUI()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var goodsHeaderModel: ZZGoodsHeaderModel?{
        didSet {
            titleLabel.text = goodsHeaderModel?.name
            iconView.zdm_setImage(urlStr: goodsHeaderModel?.picture, placeHolder: nil)
        }
    }
}


extension ZZGoodsHeaderCell{
    
    func initUI(){
        addSubview(iconView)
        addSubview(titleLabel)
        
        iconView.contentMode = .scaleAspectFit
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 13)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let iconViewHeight: CGFloat = 45
        iconView.frame = CGRect(x: 0, y: 0, width: self.width, height: iconViewHeight)
        titleLabel.width = self.width
        titleLabel.height = self.height - iconViewHeight - 6
        titleLabel.bottom = self.height
    }
}
