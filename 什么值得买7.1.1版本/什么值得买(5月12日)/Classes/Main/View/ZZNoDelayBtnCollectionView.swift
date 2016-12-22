//
//  ZZNoDelayBtnCollectionView.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/22.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZNoDelayBtnCollectionView: UICollectionView {
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        delaysContentTouches = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesShouldCancel(in view: UIView) -> Bool {
        
        if view.isKind(of: UIButton.self) {
            
            return true
        }
        
        return super.touchesShouldCancel(in: view)
    }

}
