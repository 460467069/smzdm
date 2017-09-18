//
//  ZZTopicListCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/8/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//  cell_type 11, 18

import UIKit

class ZZTopicListCell: UICollectionViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
        
    var article: ZZWorthyArticle? {
        didSet {
            guard let model = article else { return }
            
            let text = NSMutableAttributedString.init(string: model.article_title!)
            text.lineSpacing = 10
            titleLabel.attributedText = text
            
            iconView.zdm_setImage(urlStr: model.article_pic, placeHolder: nil)
            headerView.zdm_setAavatarImage(urlStr: model.article_avatar)
            nicknameLabel.text = model.article_referrals
            commentBtn.setTitle(model.article_comment, for: .normal)
            favoriteBtn.setTitle(model.article_collection, for: .normal)
        }
    }
}
