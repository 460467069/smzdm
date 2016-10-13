//
//  ZZGoodsHeaderCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 16/10/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit


class ZZGoodsHeaderCell: UICollectionViewCell {
    
    let iconView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var goodsHeaderModel: ZZGoodsHeaderModel?{
        
        didSet {
            
            titleLabel.text = goodsHeaderModel?.name
            
            iconView.setImageWith(NSURL.init(string: (goodsHeaderModel?.picture)!) as URL?, placeholder: UIImage.init(named: "icon_profile_avatar_around"))
            
        }
    }
    
}


extension ZZGoodsHeaderCell{
    
    func setupUI(){
        addSubview(iconView)
        addSubview(titleLabel)
        
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 13)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconViewHeight: CGFloat = 40
        
        iconView.frame = CGRect(x: 0, y: 0, width: self.width, height: iconViewHeight)
        
        titleLabel.frame = CGRect(x: 0, y: iconViewHeight, width: self.width, height: self.height - iconViewHeight);
    }
}
