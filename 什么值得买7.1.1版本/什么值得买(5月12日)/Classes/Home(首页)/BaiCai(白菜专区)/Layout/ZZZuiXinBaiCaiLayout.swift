//
//  ZZZuiXinBaiCaiLayout.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/22.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit
import YYKit

struct ZZBaiCaiConstant {

    let itemMargin: CGFloat = 6
    let itemBottom: CGFloat = 14
    let itemMaxCount = 10
    let bannerViewheight: CGFloat = 35
    
/**-------------------------白菜头条/每日精选--------------------------------------*/
    var rowHeight1: CGFloat = 0
    
    let itemWidth1: CGFloat = 130
    var itemHeight1: CGFloat = 0

    var imageWH1: CGFloat = 0     //图片宽高
    let imageInset1: CGFloat = 5   //图片
    
    var titleLabelTop1: CGFloat = 5
    let titleLabelColor1 = kGlobalGrayColor     //标题
    var titleLabelHeight1: CGFloat = 38
    let titleLabelLimitHeight1: CGFloat = 40
    let titleLabelFont1 = UIFont.systemFont(ofSize: 14)
    
    

    let priceLabelTop1: CGFloat = 15            //价格
    let priceLabelColor1 = kGlobalRedColor
    let priceLabelFont1 = UIFont.systemFont(ofSize: 14)
    var priceLabelHeight1: CGFloat = 15
    let priceLabelLimitHeight1: CGFloat = 25

    
    
    
/**-------------------------最新白菜--------------------------------------*/
    let rowCount: NSInteger = 2
    var itemWidth2: CGFloat = 0
    var itemHeight2: CGFloat = 0
    let itemMaxCount2 = 10
    
    var imageWH2: CGFloat = 0     //图片宽高
    let imageInset2: CGFloat = 10   //图片
    
    let allTitleHeight: CGFloat = 107
    
    
    var titleLabelTop2: CGFloat = 15
    let titleLabelColor2 = UIColor.black     //标题
    var titleLabelHeight2: CGFloat = 38
    let titleLabelFont2 = UIFont.systemFont(ofSize: 16)
    
    let priceLabelTop2: CGFloat = 5            //价格
    let priceLabelColor2 = kGlobalRedColor
    let priceLabelFont2 = UIFont.systemFont(ofSize: 16)
    var priceLabelHeight2: CGFloat = 0
    
    let mallLabelTop2: CGFloat = 6            //门店
    let mallLabelColor2 = kGlobalGrayColor
    let mallLabelFont2 = UIFont.systemFont(ofSize: 13)
    var mallLabelWidth2: CGFloat = 140
    var mallLabelHeight2: CGFloat = 0
    
    
    
    
    init() {
        
        imageWH1 = itemWidth1 - 2 * imageInset1
        itemHeight1 = imageInset1 + imageWH1 + titleLabelTop1 + titleLabelHeight1 + priceLabelTop1 + priceLabelHeight1 + itemBottom
        
        
        rowHeight1 = bannerViewheight + itemHeight1
    
        /**-------------------------华丽的分割线--------------------------------------*/
        itemWidth2 = (kScreenWidth - CGFloat(rowCount + 1) * itemMargin) / CGFloat(rowCount)
        imageWH2 = itemWidth2 - 2 * imageInset2
        
        itemHeight2 = imageInset2 + imageWH2 + allTitleHeight
        
    }
    
    func caculateTextHeight(font: UIFont, str: String, lineSpacing: CGFloat, textMaxWidth: CGFloat) ->CGFloat{
        let text = NSMutableAttributedString()
        var attributes = [String: Any]()
        attributes[NSFontAttributeName] = font
        text.append(NSAttributedString.init(string: str, attributes: attributes))
        
        
        text.lineSpacing = lineSpacing
        let container = YYTextContainer.init(size: CGSize.init(width: textMaxWidth, height: titleLabelLimitHeight1), insets: UIEdgeInsets.zero)
        let layout = YYTextLayout.init(container: container, text: text)
    
        return (layout?.textBoundingSize.height)!
    }
}

let baiCaiConstant = ZZBaiCaiConstant()


class ZZBaiCaiItemLayout: NSObject {
    
    var worthyArticle: ZZWorthyArticle?
    
    var titleLayout: YYTextLayout?
    
    var subTitleLayout: YYTextLayout?
    
    var titleHeight: CGFloat?
    
    init(worthyArticle: ZZWorthyArticle) {
        
        self.worthyArticle = worthyArticle
        super.init()
        
        layout()
    }
    func layout() {
        
        if let worthyArticle = worthyArticle {

            if let articleTitle = worthyArticle.article_title {
                let text = NSMutableAttributedString()
                var attributes = [String: Any]()
                attributes[NSFontAttributeName] = baiCaiConstant.titleLabelFont1
                attributes[NSForegroundColorAttributeName] = baiCaiConstant.titleLabelColor1
                text.append(NSAttributedString.init(string: articleTitle, attributes: attributes))
                
                text.lineSpacing = 5.0
                
                let container = YYTextContainer.init(size: CGSize.init(width: baiCaiConstant.imageWH1, height:999), insets: UIEdgeInsets.zero)
                container.maximumNumberOfRows = 2
                titleLayout = YYTextLayout.init(container: container, text: text)
            }
            
            if let subtitle = worthyArticle.subtitle {
                let text = NSMutableAttributedString()
                var attributes = [String: Any]()
                attributes[NSFontAttributeName] = baiCaiConstant.priceLabelFont1
                attributes[NSForegroundColorAttributeName] = baiCaiConstant.priceLabelColor1
                
                text.append(NSAttributedString.init(string: subtitle, attributes: attributes))
                
                let container = YYTextContainer.init(size: CGSize.init(width: baiCaiConstant.imageWH1, height: 999), insets: UIEdgeInsets.zero)
                container.maximumNumberOfRows = 1
                subTitleLayout = YYTextLayout.init(container: container, text: text)
            }

        }
    }
    
}

class ZZZuiXinBaiCaiLayout: NSObject {
    
    var rowHeight: CGFloat?
    var jingXuanScrollViewContentSize: CGSize?
    var touTiaoScrollViewContentSize: CGSize?
    var scrollViewContentSize: CGSize?
    var baiCaiModel: ZZBaiCaiJingXuanModel?
    
    var jingXuanTextLayouts = [ZZBaiCaiItemLayout]()
    var touTiaoTextLayouts = [ZZBaiCaiItemLayout]()
    
    init(jingXuanModel: ZZBaiCaiJingXuanModel) {
        
        self.baiCaiModel = jingXuanModel
        
        super.init()
        
        layout()
        
    }
    
    
    func layout() {
        
        
        var count: Int = 0
        
        if let baiCaiModel = baiCaiModel {
            
            if let jingXuans = baiCaiModel.jingxuan {
                
                count += 1
                let jingXuanWidth = CGFloat(jingXuans.count) * (baiCaiConstant.itemWidth1 + baiCaiConstant.itemMargin) + baiCaiConstant.itemMargin
                jingXuanScrollViewContentSize = CGSize.init(width: jingXuanWidth, height: baiCaiConstant.itemHeight1)
                
                for worthyArticle in jingXuans {
                    
                    let baiCaiItemLayout = ZZBaiCaiItemLayout.init(worthyArticle: worthyArticle)
                    
                    
                    jingXuanTextLayouts.append(baiCaiItemLayout)
                }

            }
            
            
            
            if let topList = baiCaiModel.top_list {
                count += 1
                
                let touTiaoWidth = CGFloat(topList.count) * (baiCaiConstant.itemWidth1 + baiCaiConstant.itemMargin) + baiCaiConstant.itemMargin
                touTiaoScrollViewContentSize = CGSize.init(width: touTiaoWidth, height: baiCaiConstant.itemHeight1)
                
                for worthyArticle in topList {
                    
                    let baiCaiItemLayout = ZZBaiCaiItemLayout.init(worthyArticle: worthyArticle)
                    
                    touTiaoTextLayouts.append(baiCaiItemLayout)
                }
            }
            
            
            rowHeight = baiCaiConstant.rowHeight1 * CGFloat(count)
        }
        
    }
    
    func configureTextLayout(worthyArticle: ZZWorthyArticle) ->YYTextLayout{
        
        let text = NSMutableAttributedString()
        var attributes = [String: Any]()
        
        if let articleTitle = worthyArticle.article_title {
            
            attributes[NSFontAttributeName] = baiCaiConstant.titleLabelFont1
            attributes[NSForegroundColorAttributeName] = baiCaiConstant.titleLabelColor1
            text.append(NSAttributedString.init(string: articleTitle, attributes: attributes))
        }
        
        text.lineSpacing = 5.0

        let container = YYTextContainer.init(size: CGSize.init(width: baiCaiConstant.imageWH1, height: baiCaiConstant.titleLabelLimitHeight1), insets: UIEdgeInsets.zero)
        
        let textLayout = YYTextLayout.init(container: container, text: text)
        
        let height = textLayout?.textBoundingSize.height
        
        print(height!)
        return  textLayout!
 
    }

}
