//
//  ZZType30Cell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/8.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZType30Cell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mallLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var article: ZZWorthyArticle? {
        didSet {
            guard let article = article else { return }
            
            let text = NSMutableAttributedString.init(string: article.article_title!)
            text.lineSpacing = 10
            titleLabel.attributedText = text
            
            var imageUrlStr: String?
            var title: String?
            var priceStr: String?
            if article.promotion_type == .three {
                imageUrlStr = article.img
                title = article.title
                priceStr = article.vice_title
            } else {
                imageUrlStr = article.article_pic
                title = article.article_title
                priceStr = article.article_price
            }
            
            iconView.zdm_setImage(urlStr: imageUrlStr, placeHolder: nil)
            titleLabel.text = title
            priceLabel.text = priceStr
            
            
            let channelID = article.article_channel_id
            var mallStr: String?
            if channelID == 1 || channelID == 5 || channelID == 2 {
                mallStr = article.article_mall
            } else if (channelID == 11) {
                mallStr = article.article_type_name
            } else {
                mallStr = article.article_rzlx
            }
            mallLabel.text = mallStr
            var dateStr = ""
            if let formatDateStr = article.article_format_date {
                dateStr = formatDateStr
            }
            timeLabel.text = "| \(dateStr)"
            
            commentBtn.setTitle(article.article_comment, for: .normal)
            
            if channelID == 1 || channelID == 5 {
                favoriteBtn.setImage(#imageLiteral(resourceName: "icon_zhi_list"), for: .normal)
                let worthy = (Float(article.article_worthy!))!
                let unWorthy = (Float(article.article_unworthy!))!
                
                if worthy + unWorthy == 0 {
                    favoriteBtn.setTitle("0", for: .normal)
                } else {
                    let ratio = worthy / (worthy + unWorthy)
                    let ratioStr = String.zz_string(floatValue: ratio)
                    favoriteBtn.setTitle(ratioStr, for: .normal)
                }
                
            } else {
                favoriteBtn.setImage(#imageLiteral(resourceName: "icon_zan_list"), for: .normal)
                favoriteBtn.setTitle(article.article_favorite, for: .normal)
            }
            
            commentBtn.setTitle(article.article_comment, for: .normal)
        }
    }

}
