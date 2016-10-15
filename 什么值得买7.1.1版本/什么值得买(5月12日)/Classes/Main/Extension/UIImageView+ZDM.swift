//
//  UIImageView+ZDM.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/10/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

extension UIImageView{
    
    convenience init(zdm_imageNamed: String) {
        self.init()
        
        self.image = UIImage.init(named: zdm_imageNamed)
        
        
    
    }
    
    func zdm_setImage(urlStr: String, placeHolder: String?) {
        
        let imageURL = URL.init(string: urlStr)
        
        if let placeHolder = placeHolder {
            self.setImageWith(imageURL, placeholder: UIImage.init(named: placeHolder))
        }else{
            self.setImageWith(imageURL, placeholder: UIImage.init(named: "placeholder_dropbox"))
        }
        
    }
    
    
}
