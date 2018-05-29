//
//  ZZType41Cell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/8.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZType2103Cell: UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    var choicenessModel: ZZChoicenessListModel? {
        didSet {
            guard let model = choicenessModel else { return }
            
            tagLabel.text = model.tag
            iconView.zdm_setImage(urlStr: model.img, placeHolder: nil)
            contentLabel.text = choicenessModel?.title
        }
    }
    
}
