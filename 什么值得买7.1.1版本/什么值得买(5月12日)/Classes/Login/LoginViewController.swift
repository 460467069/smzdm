//
//  LoginViewController.swift
//  ShopingFeel
//
//  Created by Wang_ruzhou on 2017/9/27.
//  Copyright © 2017年 Clavis. All rights reserved.
//

import UIKit
import MBProgressHUD
import RxSwift
import Bugly

class LoginViewController: BaseLoginViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var thirdLoginContentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func initUI() {

    }
    
    //原生账号密码登录
    func loginWithAccountAndPwd(phone: String, pwd: String) {

    }
}

extension LoginViewController {
    @IBAction func registerBtnDidClick(_ sender: UIBarButtonItem) {

    }
    
    @IBAction func loginBtnDidClick(_ sender: Any) {

    }
}
