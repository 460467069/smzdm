//
//  BaseLoginViewController.swift
//  ShopingFeel
//
//  Created by Wang_ruzhou on 2017/12/18.
//  Copyright © 2017年 Clavis. All rights reserved.
//

import Foundation
import MBProgressHUD
import Bugly

class BaseLoginViewController: UIViewController {
    
    var cancelCompletionHandler: (() ->())?
    var loginSuccessCompletionHandler: (() ->())?
    var loginSuccessDefaultCompletionHandler: (() ->())?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension BaseLoginViewController {
    @IBAction func wechatBtnDidClick(_ sender: UIButton) {
       
    }
    
    
    @IBAction func cancelBtnDidClick(_ sender: UIBarButtonItem) {

        cancelCompletionHandler?()
        dismiss(animated: true, completion: nil)
    }
}
