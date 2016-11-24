//
//  ZZBaiCaiTableheaderView.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/23.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZBaiCaiItemOne: UIView {
    
    lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        
        iconView.width = baiCaiConstant.imageWH1
        iconView.height = baiCaiConstant.imageWH1
        iconView.top = baiCaiConstant.imageInset1
        iconView.left = baiCaiConstant.imageInset1
        iconView.contentMode = .scaleAspectFit
        return iconView
    }()
    
    lazy var titleLabel: YYLabel = {
        let titleLabel = YYLabel()
        titleLabel.font = baiCaiConstant.titleLabelFont1
        titleLabel.numberOfLines = 2
        titleLabel.textColor = baiCaiConstant.titleLabelColor1
        titleLabel.width = baiCaiConstant.imageWH1
        titleLabel.left = baiCaiConstant.imageInset1
        titleLabel.height = baiCaiConstant.titleLabelHeight1
        return titleLabel
    }()
    
    lazy var priceLabel: YYLabel = {
        let priceLabel = YYLabel()
        priceLabel.font = baiCaiConstant.priceLabelFont1
        priceLabel.textColor = baiCaiConstant.priceLabelColor1
        priceLabel.width = baiCaiConstant.imageWH1
        priceLabel.left = baiCaiConstant.imageInset1
        priceLabel.height = baiCaiConstant.priceLabelHeight1
        return priceLabel
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        
        titleLabel.top = iconView.bottom + baiCaiConstant.titleLabelTop1
        priceLabel.top = titleLabel.bottom + baiCaiConstant.priceLabelTop1
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var worthyArticle: ZZWorthyArticle? {
        didSet {
            if let worthyArticle = worthyArticle {
                iconView.zdm_setImage(urlStr: worthyArticle.article_pic!, placeHolder: nil)
                titleLabel.text = worthyArticle.article_title!
                priceLabel.text = worthyArticle.subtitle!
            }
            
        }
    }
}

class baiCaiView: UIView {
    
}

class ZZBaiCaiJingXuanView: UIView {
    
    lazy var baiCaiBannerView: ZZBaiCaiBannerView = {
        let baiCaiBannerView = Bundle.main.loadNibNamed("ZZBaiCaiBannerView", owner: nil, options: nil)?.last as! ZZBaiCaiBannerView

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
            
        }
    }
    
    var worthyArticles: [ZZWorthyArticle]? {
        
        didSet{
            
            if let worthyArticles = worthyArticles {
                
                let actualCount = worthyArticles.count
   
                for i in 0..<baiCaiConstant.itemMaxCount {
                    
                    let baicaiItemOne = scrollView.haowuItems[i] as! ZZBaiCaiItemOne
                    
                    if i < actualCount {
                        baicaiItemOne.isHidden = false
                        baicaiItemOne.worthyArticle = worthyArticles[i]
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
            
            if let baiCaiJingXuanModel = baiCaiLayout?.baiCaiModel {
                if let jingxuanList = baiCaiJingXuanModel.jingxuan {
                    jingXuanView.baiCaiBannerView.titleLabel.text = "每日精选"
                    jingXuanView.baiCaiBannerView.accessoryBtn.setTitle("查看更多", for: .normal)
                    
                    jingXuanView.worthyArticles = jingxuanList
                    jingXuanView.scrollView.contentSize = (baiCaiLayout?.jingXuanScrollViewContentSize)!
                    
                }
                
                if let topList = baiCaiJingXuanModel.top_list {
                    
                    touTiaoView.top = jingXuanView.bottom
                    touTiaoView.baiCaiBannerView.titleLabel.text = "白菜头条"
                    touTiaoView.baiCaiBannerView.accessoryBtn.setTitle("", for: .normal)
                    touTiaoView.worthyArticles = topList
                    touTiaoView.scrollView.contentSize = (baiCaiLayout?.touTiaoScrollViewContentSize)!
                    
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


