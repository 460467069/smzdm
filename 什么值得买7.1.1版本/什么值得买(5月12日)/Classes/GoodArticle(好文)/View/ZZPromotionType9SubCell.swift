//
//  ZZPromotionType9SubCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/20.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZPromotionType9SubCell: UICollectionViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articlesCountLabel: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var article: ZZTopicArticleModel? {
        didSet {
            guard let model = article else { return }
            iconView.zdm_setImage(urlStr: model.pic, placeHolder: nil)
            titleLabel.text = model.title
            articlesCountLabel.text = model.article_num + "篇文章"
        }
    }
}
