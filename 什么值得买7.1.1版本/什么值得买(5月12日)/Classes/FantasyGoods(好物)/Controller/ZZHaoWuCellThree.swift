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
            if let subItemModel = subItemModel {
                iconView.zdm_setImage(urlStr: subItemModel.pro_pic!, placeHolder: nil)
            }
            
        }
    }
    
    
    lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.width = haoWuConstant.imageWidth
        iconView.height = haoWuConstant.imageHeight3
        iconView.contentMode = .scaleAspectFit
        return iconView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
                    }else{
                        haowuItemThree.isHidden = true
                    }
                    
                }
            }
            

            
        }
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ZZHaoWuCellThree {
    
    override func setupUI(){
        
        super.setupUI()
        
        scrollView.height = haoWuConstant.itemHeight3
        
        for index in 0..<haoWuConstant.maxCount {
            
            let haoWuItemThree = ZZHaoWuItemThree()
            haoWuItemThree.isHidden = true
            haoWuItemThree.width = haoWuConstant.itemWidth
            haoWuItemThree.height = haoWuConstant.itemHeight3
            haoWuItemThree.left = CGFloat(index) * (haoWuConstant.itemWidth + haoWuConstant.itemMargin) + haoWuConstant.itemMargin
            scrollView.addSubview(haoWuItemThree)
            scrollView.haowuItems.append(haoWuItemThree)
            
            let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(haowuItemDidClick(tap:)))
            
            haoWuItemThree.addGestureRecognizer(tapGestureRecognizer)
            
        }
    }
}

extension ZZHaoWuCellThree{
    @objc fileprivate func haowuItemDidClick(tap: UITapGestureRecognizer){
        
        let haoWuItemThree = tap.view as! ZZHaoWuItemThree
        
        delegate?.haoWuItemDidClick!(in: self, subItemModel: haoWuItemThree.subItemModel!)
        
    }
}

