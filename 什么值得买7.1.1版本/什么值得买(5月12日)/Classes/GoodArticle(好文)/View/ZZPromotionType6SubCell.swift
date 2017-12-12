//
//  ZZPromotionSubCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/20.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZPromotionType6SubCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconView.layer.cornerRadius = 20
    }

    var article: ZZWorthyArticle? {
        didSet {
            guard let model = article else { return }
            if let title = model.article_title {
                let text = NSMutableAttributedString.init(string: title)
                text.lineSpacing = 5
                text.lineBreakMode = .byTruncatingTail
                text.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
                titleLabel.attributedText = text
            }
            iconView.zdm_setImage(urlStr: model.article_pic, placeHolder: nil)
        }
    }
}
