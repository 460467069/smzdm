//
//  ZZBaiCaiTableheaderView.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/23.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZBaiCaiItemOne: UIView { //每日精选和白菜头条
    
    lazy var iconView: UIImageView = { //图片
        let iconView = UIImageView()
        
        iconView.width = baiCaiConstant.imageWH1
        iconView.height = baiCaiConstant.imageWH1
        iconView.top = baiCaiConstant.imageInset1
        iconView.left = baiCaiConstant.imageInset1
        iconView.contentMode = .scaleAspectFit
        return iconView
    }()
    
    lazy var titleLabel: YYLabel = { //标题
        let titleLabel = YYLabel()
        titleLabel.numberOfLines = 2
        titleLabel.width = baiCaiConstant.imageWH1
        titleLabel.left = baiCaiConstant.imageInset1
        titleLabel.height = baiCaiConstant.titleLabelHeight1
        titleLabel.textVerticalAlignment = .bottom
        return titleLabel
    }()
    
    lazy var subTitleLabel: YYLabel = { //子标题(可能为时间, 可能为价格)
        let subTitleLabel = YYLabel()
        subTitleLabel.numberOfLines = 1
        subTitleLabel.width = baiCaiConstant.imageWH1
        subTitleLabel.left = baiCaiConstant.imageInset1
        subTitleLabel.height = baiCaiConstant.priceLabelHeight1
        subTitleLabel.textVerticalAlignment = .top
        return subTitleLabel
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.white
        isUserInteractionEnabled = true
        layer.cornerRadius = 3.0
        
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        titleLabel.top = iconView.bottom + baiCaiConstant.titleLabelTop1
        subTitleLabel.top = titleLabel.bottom + baiCaiConstant.priceLabelTop1
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var baiCaiItemLayout: ZZBaiCaiItemLayout? {
        didSet {
            if let baiCaiItemLayout = baiCaiItemLayout {
                
                if let worthyArticle = baiCaiItemLayout.worthyArticle {
                    iconView.zdm_setImage(urlStr: worthyArticle.article_pic!, placeHolder: nil)
                }
                
                titleLabel.textLayout = baiCaiItemLayout.titleLayout
                subTitleLabel.textLayout = baiCaiItemLayout.subTitleLayout
                
                titleLabel.lineBreakMode = .byTruncatingTail
                subTitleLabel.lineBreakMode = .byTruncatingTail
            }
            
        }
    }
}

class ZZBaiCaiJingXuanView: UIView {
    
    lazy var baiCaiBannerView: ZZBaiCaiBannerView = {
        let baiCaiBannerView = Bundle.main.loadNibNamed("ZZBaiCaiBannerView", owner: nil, options: nil)?.last as! ZZBaiCaiBannerView
        baiCaiBannerView.backgroundColor = UIColor.clear
        return baiCaiBannerView
    }()
    
    lazy var scrollView: ZZHaoWuScrollView = {
        
        let scrollView = ZZHaoWuScrollView()
        
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        width = kScreenWidth
        height = baiCaiConstant.rowHeight1
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        addSubview(baiCaiBannerView)
        addSubview(scrollView)
        
        baiCaiBannerView.width = width
        baiCaiBannerView.height = baiCaiConstant.bannerViewheight
        
        scrollView.top = baiCaiBannerView.bottom
        scrollView.height = baiCaiConstant.itemHeight1
        scrollView.width = width
        
        for i in 0..<baiCaiConstant.itemMaxCount {
            
            let baiCaiItemOne = ZZBaiCaiItemOne()
            baiCaiItemOne.width = baiCaiConstant.itemWidth1
            baiCaiItemOne.height = baiCaiConstant.itemHeight1
            baiCaiItemOne.left = baiCaiConstant.itemMargin + (baiCaiConstant.itemMargin + baiCaiConstant.itemWidth1) * CGFloat(i)
            scrollView.addSubview(baiCaiItemOne)
            scrollView.haowuItems.append(baiCaiItemOne)
            
        
            let tapGestureRecongnizer = UITapGestureRecognizer.init(target: self, action: #selector(itemDidClick(tap:)))
            baiCaiItemOne.addGestureRecognizer(tapGestureRecongnizer)
            
        }
    }
    
    func itemDidClick(tap:UITapGestureRecognizer){
        
        let baiCaiItemOne = tap.view as! ZZBaiCaiItemOne
        
    }
    
    
    var jingXuanTextLayouts: [ZZBaiCaiItemLayout]? {
        
        didSet{
            
            if let jingXuanTextLayouts = jingXuanTextLayouts {
                
                let actualCount = jingXuanTextLayouts.count
   
                for i in 0..<baiCaiConstant.itemMaxCount {
                    
                    let baicaiItemOne = scrollView.haowuItems[i] as! ZZBaiCaiItemOne
                    
                    if i < actualCount {
                        baicaiItemOne.isHidden = false
                        baicaiItemOne.baiCaiItemLayout = jingXuanTextLayouts[i]
                    }else{
                        baicaiItemOne.isHidden = true
                    }
                    
                }
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print(baiCaiBannerView)
    }
    
}


class ZZBaiCaiTableHeaderView: UIView {
    
    lazy var jingXuanView: ZZBaiCaiJingXuanView = {
        
        let jingXuanView = ZZBaiCaiJingXuanView()
        return jingXuanView
    }()

    lazy var touTiaoView: ZZBaiCaiJingXuanView = {
        
        let touTiaoView = ZZBaiCaiJingXuanView()
        return touTiaoView
    }()
    
    var baiCaiLayout: ZZZuiXinBaiCaiLayout?{
        
        didSet{
            
            height = (baiCaiLayout?.rowHeight)!
            
            if let baiCaiLayout = baiCaiLayout {
                if baiCaiLayout.jingXuanTextLayouts.count > 0 {
                    jingXuanView.baiCaiBannerView.titleLabel.text = "每日精选"
                    jingXuanView.baiCaiBannerView.accessoryBtn.setTitle("查看更多", for: .normal)
                    
                    jingXuanView.jingXuanTextLayouts = baiCaiLayout.jingXuanTextLayouts
                    jingXuanView.scrollView.contentSize = (baiCaiLayout.jingXuanScrollViewContentSize)!
                    
                }
                
                if baiCaiLayout.touTiaoTextLayouts.count > 0 {
                    
                    touTiaoView.top = jingXuanView.bottom
                    touTiaoView.baiCaiBannerView.titleLabel.text = "白菜头条"
                    touTiaoView.baiCaiBannerView.accessoryBtn.setTitle("", for: .normal)
                    touTiaoView.jingXuanTextLayouts = baiCaiLayout.touTiaoTextLayouts
                    touTiaoView.scrollView.contentSize = (baiCaiLayout.touTiaoScrollViewContentSize)!
                    
                }
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = UIColor.random()
        width = kScreenWidth
        
        setupUI()
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        
        addSubview(jingXuanView)
        addSubview(touTiaoView)
        
        touTiaoView.top = jingXuanView.bottom
        
    }

}


