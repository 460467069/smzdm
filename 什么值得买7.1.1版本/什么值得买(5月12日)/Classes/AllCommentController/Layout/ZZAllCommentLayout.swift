//
//  ZZAllCommentLayout.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/7.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit
import YYKit

struct ZZCommentConstant {
    
    let footerBottomHeight: CGFloat = 15
    
    
    //昵称一行相同属性
    let nickNameHeight: CGFloat = 20    //这一行所有控件的高度
    let nickNameTop: CGFloat = 15
    let nickNameLeft: CGFloat = 15
    
    var parentCommentViewLeft: CGFloat
    let parentCommentViewTop: CGFloat = 12
    
    var headerViewHeight: CGFloat = 0
    
    
    //头像左上间距, 包括昵称等顶部间距
    let avatarTop: CGFloat = 15
    let avatarBottom: CGFloat = 15
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
    let supportLabelWidth: CGFloat = 30
    
    
    //楼层
    let floorWidth: CGFloat = 45
    let floorHeight: CGFloat = 16
    let floorTop: CGFloat = 4
    
    //时间
    let timeLabelLeft: CGFloat = 10
    let timeLabelWidth: CGFloat = 80
    let timeLabelFont = UIFont.systemFont(ofSize: 11)
    
    
    //主评论内容
    let mainCommentLabelTop: CGFloat = 10
    let mainCommentLabelRight: CGFloat = 12
    var mainCommentLableWidth: CGFloat = 0
    let mainCommentLabelTextColor = kGlobalGrayColor
    let mainCommentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    
    //父评论
    let parentCommentViewlTop: CGFloat = 12
    let parentCommentViewRight: CGFloat = 10
    var parentCommentViewWidth: CGFloat = 0
    let parentLabelTextColor = kGlobalGrayColor
    let parentLabelBgColor = UIColor.init(hexString: "#FAFAFA")
    
    let maxParentCommentCount = 20
    
    //限制有隐藏评论情况下的, 展示条数
    let limitHiddenCommentCount = 3
    
    
    //展开隐藏评论
    let hideStr = "展开隐藏评论"
    let hideCommentH: CGFloat = 40
    var hideCommentHeight: CGFloat = 0
    var hideCommentWidth: CGFloat = 0
    let hideLabelTextColor = kGlobalBlueColor
    let hideLabelFont = UIFont.systemFont(ofSize: 15)
    let hideLabelBgColor = UIColor.init(hexString: "#F4F4F4")
    
    var hideLabelInset = UIEdgeInsets.zero
    var hideLabelLayout: YYTextLayout?
    
    
    let parentLabelInset = UIEdgeInsets.init(top: 12, left: 10, bottom: 15, right: 15)
    
    //线宽/高
    let lineImageWH: CGFloat = 1
    
    
    init() {

        
        headerViewHeight = avatarTop + avatarWH + avatarBottom
        // 用户所获取的勋章
        meadlContentWidth = (medalViewWidth + medalMargin) * CGFloat(maxMedals)
        
        YYScreenSize()
        //父评论部分
        parentCommentViewLeft = avatarLeft + avatarWH + nickNameLeft
        parentCommentViewWidth = kScreenWidth - parentCommentViewLeft - parentCommentViewRight
        
        //主评论内容宽
        mainCommentLableWidth = kScreenWidth - parentCommentViewLeft - mainCommentLabelRight
        
        //隐藏栏
        hideCommentHeight = hideStr.height(for: hideLabelFont, width: CGFloat(MAXFLOAT))
        hideCommentWidth = hideStr.width(for: hideLabelFont)
        let topInset = (hideCommentH - hideCommentHeight) * 0.5
        let leftInset = (parentCommentViewWidth - hideCommentWidth) * 0.5
        hideLabelInset = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: topInset, right: leftInset)
        
        var attributes = [String: Any]()
        attributes[NSFontAttributeName] = hideLabelFont
        attributes[NSForegroundColorAttributeName] = hideLabelTextColor
        let text = (NSAttributedString.init(string: hideStr, attributes: attributes))
        let container = YYTextContainer.init(size: CGSize.init(width: mainCommentLableWidth, height: hideCommentH), insets: hideLabelInset)
        
        hideLabelLayout = YYTextLayout.init(container: container, text: text)
    }
}

let commentConstant = ZZCommentConstant()


class ZZParentCommentLayout: NSObject { //父评论布局
    
    var textLayout: YYTextLayout?
    var height: CGFloat?
    var bgColor: UIColor?
}

class ZZAllCommentLayout: NSObject {
    
    var commentModel: ZZCommentModel?
    
    var nickNameLayout: YYTextLayout?
    var floorAttributeStr: NSAttributedString?
    var timeLabelLayout: YYTextLayout?
    

    var isShouldHidden: Bool = false    //默认情况下, "展开隐藏评论的"隐藏状态
    var isHotComent:Bool = false        //标记为是否是热门评论(如果是热门评论, 楼层文字属性不一样, 背景图片也有差别)
    
    var allCommentLayouts:[ZZParentCommentLayout]?  //父评论单条评论布局数组
    var mainCommentLayout: YYTextLayout?        //主评论
    var mainCommentViewHeight: CGFloat = 0
    var mainCommentLabelHeight: CGFloat = 0
    var mainCommentLabelTop: CGFloat = 0
    
    var limitCommentLayouts:[ZZParentCommentLayout]?  //父评论单条评论布局数组
    
    var isUserClickHide: Bool = false

    init(commentModel: ZZCommentModel, isHotComment: Bool) {
        
        self.commentModel = commentModel
        self.isHotComent = isHotComment
        super.init()
        
        layout()
    }

    
    func layout(){
        
        
        //父评论逻辑: 如果大于三条, 第二条和第三条之间嵌入一个"展开隐藏"的按钮, 小于等于三条完整显示
        
        if let commentModel = self.commentModel
        {
            //昵称
            if let commentAuthor = commentModel.comment_author
            {
                var attributes = [String: Any]()
                attributes[NSForegroundColorAttributeName] = UIColor.black
                attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 14)
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
                    font = UIFont.systemFont(ofSize: 15)
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
                let parentDataCount = parentData.count
                
                var layouts = [ZZParentCommentLayout]()
                
                var limitLayouts = [ZZParentCommentLayout]()
         
                for (key, value) in parentData.enumerated()
                {
                    let textLayout = configureParentTextLayout(comment: value)
                    let parentCommentLayout = configureParentCommentTextlayout(textLayout: textLayout, bgColor: commentConstant.parentLabelBgColor!)
                    layouts.append(parentCommentLayout)
                    //计算总条数大于3时, 取3条的高度
                    if parentDataCount > 3
                    {
                        isShouldHidden = false
                        if key < 2
                        {//前两条
                            limitLayouts.append(parentCommentLayout)
                        }else if key == parentDataCount - 1
                        {//最后一条
                            let hideLabelLayout = configureParentCommentTextlayout(textLayout: commentConstant.hideLabelLayout!, bgColor: commentConstant.hideLabelBgColor!)
                            
                            limitLayouts.append(hideLabelLayout)
                            limitLayouts.append(parentCommentLayout)
                        }
                    }else{
                        limitLayouts.append(parentCommentLayout)
                    }
                }
                
                allCommentLayouts = layouts
                limitCommentLayouts = limitLayouts
               
                isShouldHidden = parentDataCount <= 3

                mainCommentViewHeight += commentConstant.mainCommentLabelTop
                
                mainCommentLabelTop = commentConstant.mainCommentLabelTop
            }
        
            // 主评论
            if let commentContent = commentModel.comment_content
            {
                let text = NSMutableAttributedString()
                let attributeStr = configureTextAttributes(content: commentContent)
                text.append(attributeStr)
                text.lineSpacing = kLineSpacing
                
                let container = YYTextContainer.init(size: CGSize.init(width: commentConstant.mainCommentLableWidth, height: 999.0), insets: commentConstant.mainCommentInset)
                
                mainCommentLayout = YYTextLayout.init(container: container, text: text)
                mainCommentLabelHeight = (mainCommentLayout?.textBoundingSize.height)!
                mainCommentViewHeight += (mainCommentLabelHeight + commentConstant.footerBottomHeight)
                
            }
            

        }

    }
    
    func configureParentCommentTextlayout(textLayout: YYTextLayout, bgColor: UIColor) ->ZZParentCommentLayout{
        
        let parentComment = ZZParentCommentLayout()
        parentComment.textLayout = textLayout
        parentComment.height = textLayout.textBoundingSize.height
        parentComment.bgColor = bgColor
        
        return parentComment
        
    }
    
    
    func configureParentTextLayout(comment: ZZCommentModel) ->(YYTextLayout)
    {
        
        let text = NSMutableAttributedString()
        
        if var userName = comment.comment_author  {
            
            userName = "\(userName): "
            
            var attributes = [String: Any]()
            attributes[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 14)
            attributes[NSForegroundColorAttributeName] = UIColor.darkGray
            text.append(NSAttributedString.init(string: userName, attributes: attributes))
        }
       
        if let commentContent = comment.comment_content {
            
            text.append(configureTextAttributes(content: commentContent))

        }
  
        text.lineSpacing = kLineSpacing
        let container = YYTextContainer.init(size: CGSize.init(width: commentConstant.parentCommentViewWidth, height: 999), insets: commentConstant.parentLabelInset)

        let layout = YYTextLayout.init(container: container, text: text)
        
        return layout!

    }
    
    
    func configureTextAttributes(content: String) ->(NSAttributedString){
        
        var attributes = [String: Any]()
        
        attributes[NSForegroundColorAttributeName] = kGlobalGrayColor
        
        attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 14)
        
        return  NSAttributedString.init(string: content, attributes: attributes)
        
    }
    
    
}
