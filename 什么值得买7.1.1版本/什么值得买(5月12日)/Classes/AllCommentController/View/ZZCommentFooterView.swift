//
//  ZZCommentFooterView.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit
import YYText

class ZZCommentFooterView: UITableViewHeaderFooterView {

    lazy var mainCommentLabel: YYLabel = {
        let mainCommentLabel = YYLabel()
        mainCommentLabel.textColor = commentConstant.mainCommentLabelTextColor
        mainCommentLabel.width = commentConstant.mainCommentLableWidth
        mainCommentLabel.left = commentConstant.parentCommentViewLeft
        return mainCommentLabel
    }()
    lazy var separatorLine: UIImageView = {
        
        let separatorLine = UIImageView.init(image: #imageLiteral(resourceName: "line_640x1"))
        separatorLine.width = kScreenWidth
        separatorLine.height = 0.3
        return separatorLine
    }()
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        self.initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initUI() {
        contentView.addSubview(mainCommentLabel)
        contentView.addSubview(separatorLine)
    }
    
    var commentLayout: ZZAllCommentLayout? {
        didSet {
            if let commentLayout = commentLayout {
                mainCommentLabel.textLayout = commentLayout.mainCommentLayout
                mainCommentLabel.height = commentLayout.mainCommentLabelHeight
                mainCommentLabel.top = commentLayout.mainCommentLabelTop
                
                separatorLine.bottom = mainCommentLabel.bottom + commentConstant.footerBottomHeight
            }
        }
    }
    
    
}

