//
//  ZZCommentCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

///点赞
class ZZSupportView: UIView {
    
    let imageView = UIImageView.init(image: #imageLiteral(resourceName: "icon_zan_list"))
    lazy var zanLabel: UILabel = {
        
        let zanLabel = UILabel()
        zanLabel.font = commentConstant.supportLabelFont
        zanLabel.textColor = commentConstant.supportTextColor
        zanLabel.text = "1000"
        zanLabel.textAlignment = .right
        zanLabel.width = commentConstant.supportLabelWidth
        zanLabel.height = commentConstant.nickNameHeight
        return zanLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        width = commentConstant.supportViewWidth
        height = commentConstant.nickNameHeight
        right = kScreenWidth - commentConstant.supportViewRight
        top = commentConstant.nickNameTop
        
        isUserInteractionEnabled = true
        
        addSubview(zanLabel)
        addSubview(imageView)
        
        imageView.right = width - 10
        imageView.centerY = height * 0.5
        zanLabel.right = imageView.left - 3
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


///奖章
class ZZMedalContentView: UIView {
    
    var medals = [UIImageView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        width = commentConstant.meadlContentWidth
        height = commentConstant.nickNameHeight
        top = commentConstant.nickNameTop
        
        for i in 0..<commentConstant.maxMedals {
            let medal = UIImageView()
            medal.tag = i
            medal.isHidden = true
            medals.append(medal)
            
            addSubview(medal)
            medal.left = (commentConstant.medalViewWidth + commentConstant.medalMargin) * CGFloat(i)
            medal.size = CGSize.init(width: commentConstant.medalViewWidth, height: commentConstant.nickNameHeight)
        }
   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

///父评论
class ZZParentCommentView: UIView {
    
    var verticalLines = [UIImageView]()
    var singleContentLabels = [YYLabel]()
    
    var stretchCommentBtn: UIButton { //展开隐藏评论
        let stretchCommentBtn = UIButton()
        
        stretchCommentBtn.width = commentConstant.commentViewWidth
        stretchCommentBtn.height = commentConstant.hideCommentHeight
        stretchCommentBtn.isHidden = true
        stretchCommentBtn.setTitle("展开隐藏评论", for: .normal)
        stretchCommentBtn.setTitleColor(UIColor.blue, for: .normal)
        
        return stretchCommentBtn
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        width = commentConstant.commentViewWidth
        backgroundColor = kGlobalGrayColor
        
        let horizonalLine = UIImageView.init(image: #imageLiteral(resourceName: "line_640x1"))
        horizonalLine.width = width
        addSubview(horizonalLine)
        
        for i in 0..<2 {
            let verticalLine = UIImageView.init(image: #imageLiteral(resourceName: "line_1x320"))
            addSubview(verticalLine)
            verticalLines.append(verticalLine)
            if i == 1 {
                verticalLine.right = width - verticalLine.width
            }
        }
        
        
        for _ in 0..<20 {
            
            let singleContentLabel = YYLabel()
//            singleContentLabel.backgroundColor = UIColor.random()
            addSubview(singleContentLabel)
            singleContentLabel.isHidden = true
            singleContentLabel.width = width
            singleContentLabels.append(singleContentLabel)
        }
        
        addSubview(stretchCommentBtn)
   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ZZCommentCell: UITableViewCell {

    lazy var avatarView: UIImageView = {    //头像
        let avatarView = UIImageView()
//        avatarView.backgroundColor = UIColor.random()
        avatarView.size = CGSize.init(width: commentConstant.avatarWH, height: commentConstant.avatarWH)
        avatarView.top = commentConstant.nickNameTop
        avatarView.left = commentConstant.nickNameLeft
        return avatarView
    }()
    
    lazy var nickNameLabel: YYLabel = {     //昵称
        let nickNameLabel = YYLabel()
        nickNameLabel.font = commentConstant.nameLabelFont
        nickNameLabel.textColor = commentConstant.nameLabelTextColor
        nickNameLabel.top = commentConstant.nickNameTop
        nickNameLabel.height = commentConstant.nickNameHeight
        
        return nickNameLabel
    }()
    
    lazy var medalContentView: ZZMedalContentView = {
        
        let medalContentView = ZZMedalContentView()
        medalContentView.backgroundColor = UIColor.random()
        medalContentView.top = commentConstant.nickNameTop
        return medalContentView
    }()
    
    lazy var praiseView: ZZSupportView = {
        let praiseView = ZZSupportView()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(praiseViewDidClick))
        praiseView.addGestureRecognizer(tap)
        
        return praiseView
    }()
    
    lazy var floorLabel: YYLabel = {
        let floorLabel = YYLabel()
        floorLabel.height = commentConstant.floorHeight
        floorLabel.width = commentConstant.floorWidth
        return floorLabel
    }()
    
    lazy var timeLabel: YYLabel = {
        let timeLabel = YYLabel()
        
        timeLabel.textColor = commentConstant.supportTextColor
        timeLabel.width = commentConstant.timeLabelWidth
        timeLabel.height = commentConstant.floorHeight
        
        return timeLabel
    }()
    
    lazy var parentCommentView: ZZParentCommentView = {
        let parentCommentView = ZZParentCommentView()
        parentCommentView.isHidden = true
        return parentCommentView
    }()
    
    lazy var mainCommentLabel: YYLabel = {
        let mainCommentLabel = YYLabel()
//        mainCommentLabel.backgroundColor = UIColor.random()
        mainCommentLabel.textColor = commentConstant.mainCommentLabelTextColor
        mainCommentLabel.width = commentConstant.mainCommentLableWidth
        return mainCommentLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    var commentLayout: ZZAllCommentLayout? {
        
        didSet{
            
            //头像
            let head = commentLayout?.commentModel?.head
            avatarView.setImageWith(URL.init(string: head!),
                                    placeholder: #imageLiteral(resourceName: "icon_profile_avatar_around"),
                                    options: .showNetworkActivity,
                                    manager: ZZCyclePicHelper.avatarImageManager(),
                                    progress: nil,
                                    transform: nil,
                                    completion: nil)
            //昵称
            nickNameLabel.textLayout = commentLayout?.nickNameLayout
            nickNameLabel.width = (commentLayout?.nickNameLayout?.textBoundingSize.width)!
            
            //奖牌
            medalContentView.left = nickNameLabel.right + commentConstant.medalViewLeft
            for i in 0..<commentConstant.maxMedals {
                
                medalContentView.medals[i].isHidden = true
                
            }
            
            if let medals = commentLayout?.commentModel?.medals {
                
                for (key, medal) in medals.enumerated() {
                    
                    let imageView = medalContentView.medals[key]
                    imageView.isHidden = true
                    imageView.setImageWith(URL.init(string: medal.img!), options: .showNetworkActivity)
                }
                
            }
            //点赞
            praiseView.zanLabel.text = commentLayout?.commentModel?.support_count
            
            //楼层
            floorLabel.attributedText = commentLayout?.floorAttributeStr

            //时间
            timeLabel.textLayout = commentLayout?.timeLabelLayout
            
            
            //父评论
            if let textLayouts = commentLayout?.parentCommentLayouts {
            
                parentCommentView.isHidden = false
                parentCommentView.top = floorLabel.bottom
                
                let singleContentLabels = parentCommentView.singleContentLabels
                let labelCount = singleContentLabels.count
                let textLayoutCount = textLayouts.count

                var singleLabelTop: CGFloat = 0
                
                for i in 0..<labelCount {
                    let singleLabel = singleContentLabels[i]
                    if i < textLayoutCount {
                        singleLabel.isHidden = false
                        singleLabel.textLayout = textLayouts[i]
                        if (commentLayout?.isShouldHidden)! {
                            parentCommentView.stretchCommentBtn.isHidden = true
                            singleLabel.height = textLayouts[i].textBoundingSize.height
                            singleLabel.top = singleLabelTop
                            singleLabelTop += singleLabel.height
                            print(singleLabel.height)
                        }else{  //需要显示"隐藏按钮"
                            parentCommentView.stretchCommentBtn.isHidden = false
                            if i < 2 {
                                singleLabel.height = textLayouts[i].textBoundingSize.height
                                singleLabel.top = singleLabelTop
                                singleLabelTop += singleLabel.height
                            }
                            
                            if i == 1 {
                                
                                parentCommentView.stretchCommentBtn.top = singleLabel.bottom
                            }
                            
                            if i == 2 {
                                singleLabel.height = textLayouts[i].textBoundingSize.height
                                singleLabel.top = singleLabelTop
                            }
                            
                        }
                        
                    }else{
                        singleLabel.isHidden = true
                    }
                }
            }else{
                parentCommentView.isHidden = true
            }

            //主评论
            mainCommentLabel.textLayout = commentLayout?.mainCommentLayout
            mainCommentLabel.height = (commentLayout?.mainCommentHeight)!
            mainCommentLabel.bottom = (commentLayout?.rowHeight)! - commentConstant.cellBottomHeight
        }
        
    }
    

}




extension ZZCommentCell{

    func setupUI(){
        
//        contentView.backgroundColor = UIColor.random()
        
        contentView.addSubview(avatarView)
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(medalContentView)
        contentView.addSubview(praiseView)
        contentView.addSubview(floorLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(parentCommentView)
        contentView.addSubview(mainCommentLabel)
        
        
        nickNameLabel.left = commentConstant.commentViewLeft
        
        floorLabel.left = nickNameLabel.left
        floorLabel.top = nickNameLabel.bottom + commentConstant.floorTop
        
        timeLabel.left = floorLabel.right + commentConstant.timeLabelLeft
        timeLabel.top = floorLabel.top
        
        mainCommentLabel.left = nickNameLabel.left
        parentCommentView.left = nickNameLabel.left
    }
    


}

/// 事件监听
extension ZZCommentCell {
    
    func praiseViewDidClick(){
        
        
    }
}

