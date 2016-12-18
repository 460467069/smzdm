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
        setupUI()

        
    }

    
    func setupUI(){
        
        view.backgroundColor = UIColor.white
        
        let cloesBtn = UIButton()
        
        cloesBtn.frame = CGRect.init(x: 10, y: 10, width: 60, height: 40)
        cloesBtn.setImage(#imageLiteral(resourceName: "ico_close"), for: .normal)
        cloesBtn.setImage(#imageLiteral(resourceName: "ico_close_press"), for: .highlighted)
        view.addSubview(cloesBtn)
        cloesBtn.addTarget(self, action: #selector(closBtnDidClick), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "懂得分享的人最美"
        titleLabel.textColor = UIColor.black
        titleLabel.sizeToFit()
        titleLabel.centerX = kScreenWidth * 0.5
        titleLabel.centerY = cloesBtn.centerY
        view.addSubview(titleLabel)
        
    }
    
    
    func closBtnDidClick(){
        
        self.dismiss(animated: true, completion: nil)
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
