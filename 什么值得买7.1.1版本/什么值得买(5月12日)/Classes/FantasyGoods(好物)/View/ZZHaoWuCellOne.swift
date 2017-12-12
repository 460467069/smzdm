//
//  ZZHaoWuCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/10/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit
import YYKit

class ZZHaoWuItemOne: UIView {
    
    lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.width = haoWuConstant.imageWidth
        iconView.height = haoWuConstant.imageHeight1
        iconView.top = haoWuConstant.imageTopMargin
        iconView.contentMode = .scaleAspectFit
        return iconView
    }()
    
    lazy var titleLabel: YYLabel = {
        let titleLabel = YYLabel()
        titleLabel.font = haoWuConstant.subTitleFont
        titleLabel.textColor = haoWuConstant.subTitleColor
        titleLabel.width = haoWuConstant.imageWidth
        titleLabel.left = haoWuConstant.subTitleLeft
        titleLabel.height = haoWuConstant.subTitleHeight
        //        titleLabel.backgroundColor = UIColor.random()
        return titleLabel
    }()
    
    lazy var priceLabel: YYLabel = {
        let priceLabel = YYLabel()
        priceLabel.font = haoWuConstant.priceLabelFont
        priceLabel.textColor = haoWuConstant.priceLabelColor
        priceLabel.width = haoWuConstant.imageWidth
        priceLabel.left = haoWuConstant.priceLabelLeft
        priceLabel.height = haoWuConstant.priceLabelHeight
        //        priceLabel.backgroundColor = UIColor.random()
        return priceLabel
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = 3.0
        
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        
        titleLabel.top = iconView.bottom + haoWuConstant.subtitleTop
        priceLabel.top = titleLabel.bottom + haoWuConstant.priceLabelTop
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var subItemModel: ZZGoodsSubItemModel? {
        didSet {
            guard let subItemModel = subItemModel else { return }
            iconView.zdm_setImage(urlStr: subItemModel.pro_pic, placeHolder: "haowu_goods")
            titleLabel.text = subItemModel.name!
            priceLabel.text = "¥ \(subItemModel.pro_price!)起"
        }
    }
}


class ZZHaoWuCellOne: ZZHaoWuBaseCell {
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView.init()
        headImageView.top = haoWuConstant.headImageViewTop
        headImageView.height = haoWuConstant.headImageViewHeight
        headImageView.width = kScreenWidth
        headImageView.isUserInteractionEnabled = true
        return headImageView
    }()
    
    override func initUI() {
        super.initUI()
        contentView.addSubview(headImageView)
        scrollView.top = headImageView.bottom
        scrollView.height = haoWuConstant.itemHeight1
        for index in 0..<haoWuConstant.maxCount {
            
            let haoWuItemOne = ZZHaoWuItemOne()
            haoWuItemOne.isHidden = true
            haoWuItemOne.tag = index
            scrollView.addSubview(haoWuItemOne)
            scrollView.haowuItems.append(haoWuItemOne)
            haoWuItemOne.width = haoWuConstant.itemWidth
            haoWuItemOne.height = haoWuConstant.itemHeight1
            haoWuItemOne.left = CGFloat(index) * haoWuConstant.itemWidth
            let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(haowuItemDidClick(tap:)))
            haoWuItemOne.addGestureRecognizer(tapGestureRecognizer)
        }
        
        let headImageViewTap = UITapGestureRecognizer.init(target: self, action: #selector(headImageViewDidClick(tap:)))
        headImageView.addGestureRecognizer(headImageViewTap)
    }
    
    override var haowuLayout: ZZHaoWuLayout? {
        didSet {
            guard let fantasicGoodsModel = haowuLayout?.fantasicGoodsModel else { return }
            let items = fantasicGoodsModel.data
            let totalCount = items?.count
            headImageView.zdm_setImage(urlStr: fantasicGoodsModel.focus_pic, placeHolder: "haowu_banner")
            
            for index in 0..<haoWuConstant.maxCount {
                let haowuItemOne = scrollView.haowuItems[index] as! ZZHaoWuItemOne
                if index < totalCount! {
                    haowuItemOne.isHidden = false
                    haowuItemOne.subItemModel = items![index]
                } else {
                    haowuItemOne.isHidden = true
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = kGlobalLightGrayColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension ZZHaoWuCellOne{
    @objc fileprivate func haowuItemDidClick(tap: UITapGestureRecognizer) {
        
        let haoWuItemOne = tap.view as? ZZHaoWuItemOne
        
        if let subItemModel = haoWuItemOne?.subItemModel {
            delegate?.haoWuItemDidClick!(in: self, subItemModel: subItemModel)
        }
    }
    
    @objc fileprivate func headImageViewDidClick(tap: UITapGestureRecognizer) {
        if let fantasicGoodsModel = haowuLayout?.fantasicGoodsModel {
            delegate?.haoWuHeadImageViewDidClick!(in: self, fantasticGoodsModel: fantasicGoodsModel)
        }
        
    }
}

