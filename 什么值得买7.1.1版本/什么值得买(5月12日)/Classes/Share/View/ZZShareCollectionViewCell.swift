//
//  ZZShareCollectionViewCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/19.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

@objc protocol ZZCellActionDelegate: NSObjectProtocol {
    @objc func cellDidClick(shareCell: ZZShareCollectionViewCell)
}

class ZZShareCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var circleBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var delegate: ZZCellActionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var shareModel: ZZShareModel? {
        
        didSet{
            
            circleBtn.setImage(UIImage.init(named: (shareModel?.icon)!), for: .normal)
            circleBtn.setImage(UIImage.init(named: (shareModel?.iconPress)!), for: .highlighted)
        
            titleLabel.text = shareModel?.title
        }
    }

    @IBAction func btnDidClick(_ sender: UIButton) {
        
        delegate?.cellDidClick(shareCell: self)
    }
}
