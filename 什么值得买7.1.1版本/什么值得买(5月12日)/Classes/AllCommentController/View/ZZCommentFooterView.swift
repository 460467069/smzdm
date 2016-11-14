//
//  ZZCommentFooterView.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZCommentFooterView: UITableViewHeaderFooterView {

    lazy var mainCommentLabel: YYLabel = {
        let mainCommentLabel = YYLabel()
        mainCommentLabel.textColor = commentConstant.mainCommentLabelTextColor
        mainCommentLabel.width = commentConstant.mainCommentLableWidth
        mainCommentLabel.left = commentConstant.parentCommentViewLeft
        return mainCommentLabel
    }()
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI(){
        
        addSubview(mainCommentLabel)
        
    }
    
    var commentLayout: ZZAllCommentLayout? {
        
        didSet{
            
            mainCommentLabel.textLayout = commentLayout?.mainCommentLayout
            mainCommentLabel.height = (commentLayout?.mainCommentHeight)!
            
        }
        
    }
    
    
}

