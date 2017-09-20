//
//  ZZPromotionType6Cell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/9/20.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZPromotionType6Cell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var followBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        followBtn.layer.cornerRadius = 3
        followBtn.layer.borderColor = UIColor.red.cgColor
        followBtn.layer.borderWidth = 0.5
    }
    var choicenessModel: ZZChoicenessListModel? {
        didSet {
            guard let model = choicenessModel else { return }
            titleLabel.text = model.title
            contentLabel.text = model.intro
        }
    }
}

extension ZZPromotionType6Cell {
    @IBAction func followBtnDidClick(_ sender: Any) {
        
    }
}
