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
        parentCommentLabel.width = commentConstant.mainCommentLableWidth
        parentCommentLabel.left = commentConstant.parentCommentViewLeft
        return parentCommentLabel
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
                parentCommentLabel.textLayout = commentLayout
                parentCommentLabel.height = commentLayout.textBoundingSize.height
            }


        }
        
    }
    

}



extension ZZCommentCell{

    func setupUI(){
        
        contentView.addSubview(parentCommentLabel)
    }
    


}

/// 事件监听
extension ZZCommentCell {
    
    func praiseViewDidClick(){
        
        
    }
}

