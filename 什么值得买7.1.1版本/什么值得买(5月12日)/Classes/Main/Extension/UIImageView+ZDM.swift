//
//  UIImageView+ZDM.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/10/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit
import YYWebImage
import SDWebImage


extension UIImageView{
    
    convenience init(zdm_imageNamed: String) {
        self.init()
        self.image = UIImage.init(named: zdm_imageNamed)
    }
    
    func zdm_setImage(urlStr: String?, placeHolder: String?) {
        guard let urlStr = urlStr else { return }
        let imageURL = URL.init(string: urlStr)
        var placeHolderImageStr = "placeholder_dropbox"
        if let placeHolder = placeHolder {
            placeHolderImageStr = placeHolder;
        }
        sd_setImage(with: imageURL, placeholderImage: UIImage.init(named: placeHolderImageStr))
    }
    
    func zdm_setAavatarImage(urlStr: String?) {
        guard let urlStr = urlStr else { return }
        let imageURL = URL.init(string: urlStr)
        zdm_setImage(placeholder: #imageLiteral(resourceName: "5_middle_avatar"),
                     imageURL: imageURL,
                     manager: ZZCyclePicHelper.avatarImageManager())
    }
    
    
    private func zdm_setImage(placeholder: UIImage?, imageURL: URL?, manager: YYWebImageManager?) {
        yy_setImage(with: imageURL,
                    placeholder: placeholder,
                    options: .showNetworkActivity,
                    manager: manager,
                    progress: nil,
                    transform: nil,
                    completion: nil)
    }
}
