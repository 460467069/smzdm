//
//  ZZHaoWuBaseCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/10/23.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit
import YYKit

@objc protocol ZZHaoWuItemDelegate: NSObjectProtocol{
    @objc optional func haoWuItemDidClick(in haoWuCell: ZZHaoWuBaseCell, subItemModel: ZZGoodsSubItemModel)
    @objc optional func haoWuHeadImageViewDidClick(in haoWuCell: ZZHaoWuBaseCell, fantasticGoodsModel: ZZFantasticGoodsModel)
}


class ZZHaoWuScrollView: UIScrollView {

    var haowuItems: [AnyObject] = []
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
        }
    }
    
    lazy var scrollView: ZZHaoWuScrollView = {
        let scrollView = ZZHaoWuScrollView()
        scrollView.width = kScreenWidth
        return scrollView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        initUI()
    }
    
    func initUI() {
        contentView.addSubview(scrollView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

