//
//  ZZSearchViewController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/26.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(cancelBtnDidClick))
        // Do any additional setup after loading the view.
        
        let textFiled = UITextField()
        textFiled.placeholder = "家用电器"
        let scopeView = UIImageView.init(image: #imageLiteral(resourceName: "homePage_searchIcon"))
        textFiled.leftView = scopeView
        
        textFiled.snp.makeConstraints { (make) in
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
}


extension ZZSearchViewController{
    
    func cancelBtnDidClick() {
        
        dismiss(animated: false, completion: nil)
    }
    
}
