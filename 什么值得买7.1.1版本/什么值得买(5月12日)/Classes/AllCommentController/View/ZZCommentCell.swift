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
        return parentCommentLabel
    }()
    
    lazy var parentCommentView: UIImageView = {
        
        let parentCommentView = UIImageView()
        parentCommentView.width = commentConstant.parentCommentViewWidth
        parentCommentView.left = commentConstant.parentCommentViewLeft
        parentCommentView.image = #imageLiteral(resourceName: "bg_grey_press")
        return parentCommentView
    }()
    
    lazy var separatorLine: UIImageView = {
        
        let separatorLine = UIImageView.init(image: #imageLiteral(resourceName: "line_640x1"))
        separatorLine.width = commentConstant.parentCommentViewWidth
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

    
    var commentLayout: YYTextLayout? {
        
        didSet{
            
            if let commentLayout = commentLayout {
                
                parentCommentView.height = commentLayout.textBoundingSize.height
                parentCommentLabel.textLayout = commentLayout
                parentCommentLabel.height = commentLayout.textBoundingSize.height
                
                separatorLine.bottom = parentCommentLabel.bottom
            }

            
        }
        
    }
    

}



extension ZZCommentCell{

    func setupUI(){
        
        parentCommentView.addSubview(parentCommentLabel)
        
        parentCommentView.addSubview(separatorLine)
        
        contentView.addSubview(parentCommentView)
        
        
        
    }
    


}

/// 事件监听
extension ZZCommentCell {
    
    func praiseViewDidClick(){
        
        
    }
}

