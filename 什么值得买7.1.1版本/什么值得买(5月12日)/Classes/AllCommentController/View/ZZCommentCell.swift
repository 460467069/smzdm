//
//  ZZCommentCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit


class ZZCommentCell: UITableViewCell {


    lazy var parentCommentLabel: YYLabel = {
        let parentCommentLabel = YYLabel()
        parentCommentLabel.width = commentConstant.parentCommentViewWidth
        parentCommentLabel.left = commentConstant.parentCommentViewLeft
        return parentCommentLabel
    }()
    
    lazy var separatorLine: UIImageView = {
        
        let separatorLine = UIImageView.init(image: #imageLiteral(resourceName: "line_640x1"))
        separatorLine.width = commentConstant.parentCommentViewWidth
        separatorLine.left = commentConstant.parentCommentViewLeft
        separatorLine.alpha = 0.3
        return separatorLine
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    var commentLayout: ZZParentCommentLayout? {
        
        didSet{

            if let commentLayout = commentLayout {
                parentCommentLabel.textLayout = commentLayout.textLayout
                parentCommentLabel.height = commentLayout.height!
                separatorLine.bottom = parentCommentLabel.bottom
 
                parentCommentLabel.backgroundColor = commentLayout.bgColor
            }
 
        }
        
    }
    

}



extension ZZCommentCell{

    func setupUI(){
        
        contentView.addSubview(parentCommentLabel)
        contentView.addSubview(separatorLine)
        
    }
    


}

/// 事件监听
extension ZZCommentCell {
    
    func praiseViewDidClick(){
        
        
    }
}

