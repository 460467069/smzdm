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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconView.layer.cornerRadius = 3
        iconView.layer.masksToBounds = true
    }
    
    var article: ZZWorthyArticle? {
        didSet {
            guard let model = article else { return }
            
            titleLabel.text = model.article_title
            iconView.zdm_setImage(urlStr: model.article_pic, placeHolder: nil)
            headerView.zdm_setAavatarImage(urlStr: model.article_avatar)
            nicknameLabel.text = model.article_referrals
            commentBtn.setTitle(model.article_comment, for: .normal)
            favoriteBtn.setTitle(model.article_collection, for: .normal)
        }
    }
}
