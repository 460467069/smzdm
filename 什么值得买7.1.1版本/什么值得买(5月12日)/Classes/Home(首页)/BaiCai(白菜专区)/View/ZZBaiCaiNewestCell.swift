//
//  ZZBaiCaiNewestCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/29.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZBaiCaiNewestCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var mallLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    
    var worthyArticle: ZZWorthyArticle? {
        
        didSet{
            
            if let worthyArticle = worthyArticle {
                
                iconView.zdm_setImage(urlStr: worthyArticle.article_pic!, placeHolder: nil)
                titleLabel.text = worthyArticle.article_title
                subTitleLabel.text = worthyArticle.article_price
                mallLabel.text = worthyArticle.article_mall
                commentBtn.setTitle(worthyArticle.article_comment, for: .normal)
            }
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        layer.cornerRadius = 3.0
        layer.masksToBounds = true
    }

}
