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
    let headTitleHeight:CGFloat
    let headTitleFont = UIFont.systemFont(ofSize: 17)
    let headTitleColor = UIColor.black
    let headTitleTop: CGFloat = 15.0
    let headTitleBottom: CGFloat = 18.0
    let headTitleLeft: CGFloat = 15.0
    
    let allBtnRight: CGFloat = 15.0
    
    let imageWidth: CGFloat = 140.0
    var imageHeight3: CGFloat
    var imageHeight1: CGFloat = 100.0
    
    let imageTopMargin: CGFloat = 5.0
    let imageHeight: CGFloat = 120.0
    let imageBottomMargin: CGFloat = 3.0
    
    let subTitleFont = UIFont.systemFont(ofSize: 15)
    let subTitleColor = UIColor.darkGray
    var subTitleHeight: CGFloat
    let subtitleTop: CGFloat = 3.0
    let subtitleBottom: CGFloat = 3.0
    let subTitleLeft: CGFloat = 15.0
    
    
    
    
    let priceLabelTop: CGFloat = 25.0
    let priceLabelBottom: CGFloat = 8.0
    let priceLabelLeft: CGFloat = 12.0
    var priceLabelHeight: CGFloat
    let priceLabelColor = UIColor.red
    let priceLabelFont = UIFont.systemFont(ofSize: 16)

    let allBtnColor = UIColor.red
    let allBtnFont = UIFont.systemFont(ofSize: 15)
    let allBtnWidth:CGFloat = 100.0
    
    
    let itemMargin: CGFloat = 13.0
    let itemWidth: CGFloat
    
    let itemHeight1: CGFloat
    let itemHeight3: CGFloat
    let maxCount = 15
    
    let cellHeight1: CGFloat
    let cellHeight3: CGFloat
    
    init() {
        
        imageHeight3 = 98.0/188.0 * imageWidth
        
        let title: NSString = "在家也要吃爆米花"
        subTitleHeight = title.height(for: subTitleFont, width: CGFloat(MAXFLOAT))
        headTitleHeight = title.height(for: headTitleFont, width: CGFloat(MAXFLOAT))
        priceLabelHeight = title.height(for: priceLabelFont, width: CGFloat(MAXFLOAT))
        
        itemWidth = imageWidth
        itemHeight1 = imageTopMargin + imageHeight1 + subtitleTop + subTitleHeight + subtitleBottom + priceLabelTop + priceLabelHeight + priceLabelBottom
        itemHeight3 = imageHeight3
        
        cellHeight1 = headTitleTop + headTitleHeight + headTitleBottom + itemHeight1
        cellHeight3 = headTitleTop + headTitleHeight + headTitleBottom + itemHeight3
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
