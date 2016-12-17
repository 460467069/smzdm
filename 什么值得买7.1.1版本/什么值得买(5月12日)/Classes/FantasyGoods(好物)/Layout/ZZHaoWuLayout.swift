//
//  ZZHaoWuLayout.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/10/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

enum HaoWuItemType {
    case one
    case three
}

struct ZZHaoWuConstant {
    

    let rightTitleMargin: CGFloat = 15.0
    let headTitleHeight:CGFloat = 48.0
    let headTitleFont = UIFont.systemFont(ofSize: 15)
    let headTitleColor = UIColor.black
    let headTitleLeft: CGFloat = 20.0
    
    let allBtnRight: CGFloat = 15.0
    
    let imageWidth: CGFloat = 130.0
    var imageHeight3: CGFloat
    
    var imageHeight1: CGFloat = 110.0
    let imageTopMargin: CGFloat = 10.0
    
    
    let subTitleFont = UIFont.systemFont(ofSize: 13)
    let subTitleColor = UIColor.darkGray
    var subTitleHeight: CGFloat
    let subtitleTop: CGFloat = 15.0
    let subtitleBottom: CGFloat = 11.0
    let subTitleLeft: CGFloat = 15.0
    
    
    let tagLabelFont = UIFont.systemFont(ofSize: 12)
    let tagLabelColor = UIColor.lightGray
    var tagLabelHeight: CGFloat
    let tagLabelTop: CGFloat = 6.0
    let tagLabelBottom: CGFloat = 11.0
    let tagLabelLeft: CGFloat = 15.0
    
    let priceLabelTop: CGFloat = 13.0
    let priceLabelBottom: CGFloat = 8.0
    let priceLabelLeft: CGFloat = 12.0
    var priceLabelHeight: CGFloat
    let priceLabelColor = UIColor.red
    let priceLabelFont = UIFont.systemFont(ofSize: 14)

    let allBtnColor = UIColor.red
    let allBtnFont = UIFont.systemFont(ofSize: 13)
    let allBtnWidth:CGFloat = 100.0
    
    
    let itemMargin: CGFloat = 13.0
    let itemWidth: CGFloat = 130.0
    let itemHeight1: CGFloat = 205.0
    let cellHeight1: CGFloat = 252.0 + 5.0
    let maxCount = 30
    
    
    let cellHeight3: CGFloat = 115.0
    var itemHeight3: CGFloat = 0
    
    init() {
        
        imageHeight3 = 98.0/188.0 * imageWidth
        itemHeight3 = imageHeight3
        
        let title: NSString = "在家也要吃爆米花"
        subTitleHeight = title.height(for: subTitleFont, width: CGFloat(MAXFLOAT))
        priceLabelHeight = title.height(for: priceLabelFont, width: CGFloat(MAXFLOAT))
        tagLabelHeight = title.height(for: tagLabelFont, width: CGFloat(MAXFLOAT))

    }
    
}

 let haoWuConstant = ZZHaoWuConstant()

class ZZHaoWuLayout: NSObject {
    
    var rowHeight: CGFloat?
    var scrollViewContentSize: CGSize?
    var itemType: HaoWuItemType?
    
    var fantasicGoodsModel: ZZFantasticGoodsModel?
    
    init(fantasicGoodsModel: ZZFantasticGoodsModel) {
        
        self.fantasicGoodsModel = fantasicGoodsModel

        super.init()
        
        layout()
        
    }
    
    func layout() {

        if let type = fantasicGoodsModel?.type {
            var itemheight: CGFloat = 0
            
            if type == "3" {
                itemType = .three
                rowHeight = haoWuConstant.cellHeight3
                itemheight = haoWuConstant.itemHeight3
                
            }else if type == "1" || type == "2" {
                itemType = .one
                rowHeight = haoWuConstant.cellHeight1
                itemheight = haoWuConstant.itemHeight1
            }
            if let itemModels = fantasicGoodsModel?.data {
                
                let items = itemModels.count
                
                scrollViewContentSize = CGSize(width: CGFloat(items) * haoWuConstant.itemWidth + CGFloat(items + 1) * (haoWuConstant.itemMargin), height: itemheight)
            }
        }
    }

}
