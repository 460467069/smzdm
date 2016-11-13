//
//  ZZAllCommentLayout.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/7.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

struct ZZCommentConstant {
    
    let cellBottomHeight: CGFloat = 12
    
    
    //昵称一行相同属性
    let nickNameHeight: CGFloat = 20    //这一行所有控件的高度
    let nickNameTop: CGFloat = 15
    let nickNameLeft: CGFloat = 15
    
    var commentViewLeft: CGFloat
    let commentViewTop: CGFloat = 12
    
    //头像左上间距, 包括昵称等顶部间距
    let avatarWH: CGFloat = 38
    let avatarLeft: CGFloat = 15
    
    //昵称: 昵称顶部和头像平齐
    let nameLabelMaxWidth: CGFloat = 150
    let nameLabelFont = UIFont.systemFont(ofSize: 13)
    let nameLabelTextColor = UIColor.darkGray
    
    //奖牌控件容器
    var meadlContentWidth: CGFloat = 0
    
    //奖牌🎖
    let medalViewLeft: CGFloat = 10
    let medalViewWidth: CGFloat = 20
    let medalMargin: CGFloat = 2    //奖牌之间的间隙
    let maxMedals: Int = 5

    //点赞
    let supportViewWidth: CGFloat = 50
    let supportViewRight: CGFloat = 25
    let supportTextColor = UIColor.lightGray
    let supportLabelFont = UIFont.systemFont(ofSize: 13)
    let supportLabelWidth: CGFloat = 20
    
    
    //楼层
    let floorWidth: CGFloat = 37
    let floorHeight: CGFloat = 16
    let floorTop: CGFloat = 4
    
    //时间
    let timeLabelLeft: CGFloat = 10
    let timeLabelWidth: CGFloat = 80
    let timeLabelFont = UIFont.systemFont(ofSize: 13)
    
    
    //主评论内容
    let mainCommentLabelTop: CGFloat = 10
    let mainCommentLabelRight: CGFloat = 12
    var mainCommentLableWidth: CGFloat = 0
    let mainCommentLabelTextColor = kGlobalGrayColor
    let mainCommentInset = UIEdgeInsets.init(top: 12, left: 0, bottom: 0, right: 0)
    
    //父评论
    let parentLabelTop: CGFloat = 12
    let parentLabelRight: CGFloat = 10
    let parentLabelTextColor = kGlobalGrayColor
    
    
    let maxParentCommentCount = 20
    
    //限制有隐藏评论情况下的, 展示条数
    let limitHiddenCommentCount = 3
    
    
    //展开隐藏评论
    let hideCommentHeight: CGFloat = 40
    let hideLabelTextColor = UIColor.blue
    let hideLabelFont = UIFont.systemFont(ofSize: 17)
    
    
    let parentLabelInset = UIEdgeInsets.init(top: 12, left: 10, bottom: 0, right: 15)
    
    //整个commentView(包括所有评论内容, 和下划线)
    let commentViewRight: CGFloat = 16
    var commentViewWidth: CGFloat = 0
    
    //线宽/高
    let lineImageWH: CGFloat = 1
    
    
    init() {
        
        // 用户所获取的勋章
        meadlContentWidth = (medalViewWidth + medalMargin) * CGFloat(maxMedals)
        
        //父评论部分
        commentViewLeft = avatarLeft + avatarWH + nickNameLeft
        commentViewWidth = kScreenWidth - commentViewLeft - commentViewRight
        
        //主评论内容宽
        mainCommentLableWidth = kScreenWidth - commentViewLeft - mainCommentLabelRight
    }
}

let commentConstant = ZZCommentConstant()


class ZZAllCommentLayout: NSObject {
    
    var commentModel: ZZCommentModel?
    
    var nickNameLayout: YYTextLayout?
    var floorAttributeStr: NSAttributedString?
    var timeLabelLayout: YYTextLayout?
    
    var rowHeight: CGFloat = 0
    var rowHeight1: CGFloat = 0         //评论有隐藏下的高
    var rowHeight2: CGFloat = 0         //评论无隐藏下的高
    var isShouldHidden: Bool = false    //默认情况下, "展开隐藏评论的"隐藏状态
    var isHotComent:Bool = false        //标记为是否是热门评论(如果是热门评论, 楼层文字属性不一样, 背景图片也有差别)
    
    var parentCommentLayouts:[YYTextLayout]?  //父评论单条评论布局数组
    var mainCommentLayout: YYTextLayout?        //主评论
    var mainCommentHeight: CGFloat = 0
    
    
    init(commentModel: ZZCommentModel, isHotComment: Bool) {
        
        self.commentModel = commentModel
        self.isHotComent = isHotComment
        super.init()
        
        layout()
    }

    
    func layout(){
        
        
        rowHeight += commentConstant.nickNameTop
        rowHeight += commentConstant.nickNameHeight
        rowHeight += commentConstant.floorTop
        rowHeight += commentConstant.floorHeight
        
        rowHeight2 = rowHeight
        rowHeight1 = rowHeight
        
        //父评论逻辑: 如果大于三条, 第二条和第三条之间嵌入一个"展开隐藏"的按钮, 小于等于三条完整显示
        
        if let commentModel = self.commentModel
        {
            //昵称
            if let commentAuthor = commentModel.comment_author
            {
                var attributes = [String: Any]()
                attributes[NSForegroundColorAttributeName] = UIColor.black
                attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 16)
                let text = NSAttributedString.init(string: commentAuthor, attributes: attributes)
                
                let container = YYTextContainer.init(size: CGSize.init(width: commentConstant.nameLabelMaxWidth, height: commentConstant.nickNameHeight), insets: UIEdgeInsets.zero)
                nickNameLayout = YYTextLayout.init(container: container, text: text)
            }
            

            //楼层
            if let floor = commentModel.floor
            {
                
                var attributes = [String: Any]()
                var color = UIColor.lightGray
                var font = commentConstant.timeLabelFont
                if isHotComent
                {
                    color = UIColor.white
                    font = UIFont.systemFont(ofSize: 16)
                }
                attributes[NSForegroundColorAttributeName] = color
                attributes[NSFontAttributeName] = font
                
                floorAttributeStr = NSAttributedString.init(string: floor, attributes: attributes)
            }
            
            //时间
            if let formatDate = commentModel.format_date
            {
                var attributes = [String: Any]()
                attributes[NSForegroundColorAttributeName] = UIColor.lightGray
                attributes[NSFontAttributeName] = commentConstant.timeLabelFont
                let text = NSAttributedString.init(string: formatDate, attributes: attributes)
                
                let container = YYTextContainer.init(size: CGSize.init(width: commentConstant.timeLabelWidth, height: commentConstant.nickNameHeight), insets: UIEdgeInsets.zero)
                timeLabelLayout = YYTextLayout.init(container: container, text: text)
            }
            
            //父评论
            if let parentData = commentModel.parent_data
            {
                
//                rowHeight += commentConstant.commentViewTop
                let parentDataCount = parentData.count
                
                var layouts = [YYTextLayout]()
                
                for (key, value) in parentData.enumerated()
                {
                    let textLayout = configureParentTextLayout(comment: value)
                    let height = textLayout.textBoundingSize.height
                    layouts.append(textLayout)
                    
                    rowHeight2 += height

                    if parentDataCount > 3 && key < 3
                    {     //计算总条数大于3时, 前3条的高度
                        isShouldHidden = false
                        rowHeight1 = rowHeight2
                        rowHeight1 += commentConstant.hideCommentHeight
                        
                        rowHeight += height
                        rowHeight += commentConstant.hideCommentHeight
                    }else{
                        rowHeight += height
                    }
                }
                
                parentCommentLayouts = layouts
                
                isShouldHidden = parentDataCount <= 3
                
            }
            
            
            // 主评论
            if let commentContent = commentModel.comment_content
            {
                
                let attributeStr = configureTextAttributes(content: commentContent)
                
                let container = YYTextContainer.init(size: CGSize.init(width: commentConstant.mainCommentLableWidth, height: 999.0), insets: commentConstant.mainCommentInset)
                
                mainCommentLayout = YYTextLayout.init(container: container, text: attributeStr)
                
                
                mainCommentHeight = (mainCommentLayout?.textBoundingSize.height)!
                
//                print(mainCommentHeight)
                
                rowHeight1 += mainCommentHeight
                rowHeight2 += mainCommentHeight
                
                rowHeight += mainCommentHeight
 
            }
            
            
            rowHeight2 += commentConstant.cellBottomHeight
            rowHeight1 += commentConstant.cellBottomHeight
            
            rowHeight += commentConstant.cellBottomHeight

        }

    }
    
    
    func configureParentTextLayout(comment: ZZCommentModel) ->(YYTextLayout)
    {
        
        let text = NSMutableAttributedString()
        
        let font = UIFont.systemFont(ofSize: 16)
        
        
        if var userName = comment.comment_author  {
            
            userName = "\(userName): "
            
            var attributes = [String: Any]()
            attributes[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 16)
            attributes[NSForegroundColorAttributeName] = UIColor.black
            text.append(NSAttributedString.init(string: userName, attributes: attributes))
        }
       
        if let commentContent = comment.comment_content {
            
            text.append(configureTextAttributes(content: commentContent))
            text.append(NSAttributedString.init(string: "\n", attributes: nil))
        }
        
        let horizonalLineImage = #imageLiteral(resourceName: "line_640x1")
        let horizonalLineAttachText = NSMutableAttributedString.attachmentString(withContent: horizonalLineImage, contentMode: .scaleToFill, attachmentSize: CGSize.init(width: commentConstant.commentViewWidth, height: 1), alignTo: font, alignment: .bottom)
        
        text.append(horizonalLineAttachText)
        
        text.setParagraphSpacing(14.0, range: NSMakeRange(1, 1))
   
        let container = YYTextContainer.init(size: CGSize.init(width: commentConstant.commentViewWidth, height: 999), insets: commentConstant.parentLabelInset)
        
    
        let layout = YYTextLayout.init(container: container, text: text)
        
        return layout!

    }
    
    
    func configureTextAttributes(content: String) ->(NSAttributedString){
        
        var attributes = [String: Any]()
        
        attributes[NSForegroundColorAttributeName] = kGlobalGrayColor
        
        attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 16)
        
        return  NSAttributedString.init(string: content, attributes: attributes)
        
    }
    
    
}
