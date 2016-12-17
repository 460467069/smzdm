//
//  ZZShareViewController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/16.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "懂得分享的人最美"
        
        let cloesBtn = UIButton.init()
        
        cloesBtn.frame = CGRect.init(x: 20, y: 20, width: 60, height: 40)
        cloesBtn.setImage(#imageLiteral(resourceName: "ico_close"), for: .normal)
        cloesBtn.setImage(#imageLiteral(resourceName: "ico_close_press"), for: .highlighted)
        view.addSubview(cloesBtn)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
