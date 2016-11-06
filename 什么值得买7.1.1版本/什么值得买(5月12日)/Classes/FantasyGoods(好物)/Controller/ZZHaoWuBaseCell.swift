//
//  ZZHaoWuBaseCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/10/23.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

@objc protocol ZZHaoWuItemDelegate: NSObjectProtocol{
    @objc optional func haoWuItemDidClick(in haoWuCell: ZZHaoWuBaseCell, subItemModel: ZZGoodsSubItemModel)
}


class ZZHaoWuScrollView: UIScrollView {

    var haowuItems: [AnyObject] = []
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
//        backgroundColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ZZHaoWuBaseCell: UITableViewCell {

    weak var delegate: ZZHaoWuItemDelegate?
    
    var indexPathRow: NSInteger?
    
    
    var haowuLayout: ZZHaoWuLayout? {
        
        didSet {
            
            scrollView.contentSize = (haowuLayout?.scrollViewContentSize)!
            scrollView.contentOffset = CGPoint.zero
            if let fantasicGoodsModel = haowuLayout?.fantasicGoodsModel {
                
                headLabel.text = fantasicGoodsModel.name
            }
        }
    }
    
    lazy var scrollView: ZZHaoWuScrollView = {
        let scrollView = ZZHaoWuScrollView()
        scrollView.width = screenWidth
        
        return scrollView
    }()
    
    lazy var headLabel: YYLabel = {
        let headLabel = YYLabel()
        headLabel.textColor = haoWuConstant.headTitleColor
        headLabel.font = haoWuConstant.headTitleFont
        headLabel.width = screenWidth - 100
        headLabel.height = haoWuConstant.headTitleHeight
        headLabel.left = haoWuConstant.headTitleLeft
        headLabel.top = haoWuConstant.headTitleTop
        return headLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.init(colorLiteralRed: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension ZZHaoWuBaseCell {
    
    func setupUI() {
        contentView.addSubview(headLabel)
        contentView.addSubview(scrollView)
        scrollView.top = headLabel.bottom + haoWuConstant.headTitleBottom
    }
    
    
}
