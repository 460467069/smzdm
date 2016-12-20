//
//  ZZShareCollectionViewCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/19.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZShareCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var shareModel: ZZShareModel? {
        
        didSet{
            
            iconView.image = UIImage.init(named: (shareModel?.icon)!)
            
            titleLabel.text = shareModel?.title
        }
    }

}
