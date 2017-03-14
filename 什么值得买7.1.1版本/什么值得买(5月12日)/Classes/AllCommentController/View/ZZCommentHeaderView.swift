//
//  ZZCommentHeaderView.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit
import YYKit

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
            
            medal.size = CGSize.init(width: commentConstant.medalViewWidth, height: commentConstant.nickNameHeight)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ZZCommentHeaderView: UITableViewHeaderFooterView {

    lazy var avatarView: UIImageView = {    //头像
        let avatarView = UIImageView()
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
        nickNameLabel.left = commentConstant.parentCommentViewLeft
        return nickNameLabel
    }()
    
    lazy var medalContentView: ZZMedalContentView = {
        
        let medalContentView = ZZMedalContentView()
//        medalContentView.backgroundColor = UIColor.random()
        medalContentView.top = commentConstant.nickNameTop
        return medalContentView
    }()
    
    lazy var praiseView: ZZSupportView = {
        let praiseView = ZZSupportView()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(praiseViewDidClick))
        praiseView.addGestureRecognizer(tap)
        
        return praiseView
    }()
    
    
    lazy var floorView: UIImageView = {
        
        let floorView = UIImageView()
        floorView.contentMode = .scaleToFill
        floorView.height = commentConstant.floorHeight
        floorView.width = commentConstant.floorWidth
        floorView.left = commentConstant.parentCommentViewLeft
        floorView.image = #imageLiteral(resourceName: "level_bg_view")
        return floorView
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
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI(){
        
        floorView.addSubview(floorLabel)
        
        contentView.addSubview(avatarView)
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(medalContentView)
        contentView.addSubview(praiseView)
        contentView.addSubview(floorView)
        contentView.addSubview(timeLabel)

        
        floorView.top = nickNameLabel.bottom + commentConstant.floorTop
        
        timeLabel.left = floorView.right + commentConstant.timeLabelLeft
        timeLabel.top = floorView.top

    }

    var commentLayout: ZZAllCommentLayout? {
        
        didSet{
            //头像
            let head = commentLayout?.commentModel?.head
            avatarView.setImageWith(URL.init(string: head!),
                                    placeholder: #imageLiteral(resourceName: "5_middle_avatar"),
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
                    imageView.isHidden = false
                    imageView.left = (commentConstant.medalViewWidth + commentConstant.medalMargin) * CGFloat(key)
                    imageView.setImageWith(URL.init(string: medal.img!), options: .showNetworkActivity)
                }
                
            }
            //点赞
            praiseView.zanLabel.text = commentLayout?.commentModel?.support_count
            
            //楼层
            floorLabel.attributedText = commentLayout?.floorAttributeStr
            floorLabel.textAlignment = .center
            //时间
            timeLabel.textLayout = commentLayout?.timeLabelLayout
            
            if (commentLayout?.isHotComent)! {
                floorView.image = #imageLiteral(resourceName: "level_bg_view")
            }else{
                floorView.image = nil
            }
            
            
        }
    }

}

extension ZZCommentHeaderView{
    
    func praiseViewDidClick(){
        
    }
    
}
