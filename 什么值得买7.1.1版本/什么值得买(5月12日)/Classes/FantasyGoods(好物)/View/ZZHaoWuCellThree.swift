//
//  ZZHaoWuCellThree.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/10/23.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit


class ZZHaoWuItemThree: UIView {
    
 var subItemModel: ZZGoodsSubItemModel? {
        didSet {
            iconView.zdm_setImage(urlStr: subItemModel?.pro_pic, placeHolder: "haowu_tou")
        }
    }
    
    
    lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.top = haoWuConstant.itemMargin
        iconView.width = haoWuConstant.imageWidth3
        iconView.height = haoWuConstant.imageHeight3
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        return iconView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 3.0
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        clipsToBounds = true
        addSubview(iconView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ZZHaoWuCellThree: ZZHaoWuBaseCell {

    
    override var haowuLayout: ZZHaoWuLayout? {
        didSet{
            if let haowuLayout = haowuLayout {
                let items = haowuLayout.fantasicGoodsModel?.data
                let totalCount = items?.count
                
                for index in 0..<haoWuConstant.maxCount {
                    
                    let haowuItemThree = scrollView.haowuItems[index] as! ZZHaoWuItemThree
                    
                    if index < totalCount! {
                        haowuItemThree.isHidden = false
                        haowuItemThree.subItemModel = items![index]
                    } else {
                        haowuItemThree.isHidden = true
                    }
                }
            }
        }
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let responsder = super.hitTest(point, with: event)
        
        if responsder == contentView { //点击右边那张图片还是无法响应事件...            
            return scrollView
        }
        
        return responsder
    }

}

extension ZZHaoWuCellThree {
    
    override func initUI(){
        
        super.initUI()
        
        scrollView.height = haoWuConstant.itemHeight3
        scrollView.width = kScreenWidth - haoWuConstant.itemRightMargin - haoWuConstant.itemMargin
        scrollView.clipsToBounds = false
        
        for index in 0..<haoWuConstant.maxCount {
            
            let haoWuItemThree = ZZHaoWuItemThree()
            haoWuItemThree.isHidden = true
            haoWuItemThree.width = haoWuConstant.imageWidth3
            haoWuItemThree.height = haoWuConstant.itemHeight3
            haoWuItemThree.left = CGFloat(index) * (haoWuConstant.imageWidth3 + haoWuConstant.itemMargin) + haoWuConstant.itemMargin
            scrollView.addSubview(haoWuItemThree)
            scrollView.haowuItems.append(haoWuItemThree)
            
            let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(haowuItemDidClick(tap:)))
            
            haoWuItemThree.addGestureRecognizer(tapGestureRecognizer)
            
        }
    }
}

extension ZZHaoWuCellThree{
    @objc fileprivate func haowuItemDidClick(tap: UITapGestureRecognizer){
        
        let haoWuItemThree = tap.view as? ZZHaoWuItemThree
        
        if let subItemModel = haoWuItemThree?.subItemModel {
            delegate?.haoWuItemDidClick!(in: self, subItemModel: subItemModel)
        }
    }
}

