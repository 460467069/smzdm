//
//  ZZChoicenessListCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/2.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//  cell_type 5, 17

import UIKit

class ZZChoicenessListCell: UICollectionViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!

    var article: ZZWorthyArticle? {
        didSet {
            guard let model = article else { return }
            if let title = model.article_title {
                contentLabel.attributedText = NSAttributedString.commonAttributedText(title: title)
            }
            iconView.zdm_setImage(urlStr: model.article_pic, placeHolder: nil)
            avatarView.zdm_setAavatarImage(urlStr: model.article_avatar)
            nickNameLabel.text = model.article_referrals
            commentBtn.setTitle(model.article_comment, for: .normal)
            favoriteBtn.setTitle(model.article_collection, for: .normal)
            timeLabel.text = model.article_format_date
            tagLabel.text = model.tag_category
        }
    }
}
