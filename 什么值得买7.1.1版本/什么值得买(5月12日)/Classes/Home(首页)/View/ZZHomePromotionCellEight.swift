//
//  ZZHomePromotionCellEight.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/3/9.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZHomePromotionItemEight: UIView {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.zz_random()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = kGlobalGrayColor
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(titleLabel.snp.top)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ZZHomePromotionCollectionCellEight: UICollectionViewCell {
    
    var littleBanener: ZZLittleBanner? {
        didSet {
            if let littleBanener = littleBanener {
                homePromotionItemEight.imageView.zdm_setImage(urlStr: littleBanener.pic, placeHolder: nil)
                homePromotionItemEight.titleLabel.text = littleBanener.title
            }
        }
    }
    
    lazy var homePromotionItemEight: ZZHomePromotionItemEight = {
        let homePromotionItemEight = ZZHomePromotionItemEight()
        return homePromotionItemEight
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(homePromotionItemEight)
        homePromotionItemEight.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objcMembers class ZZHomePromotionCellEight: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = kGlobalGrayColor
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        return titleLabel
    }()
    
    lazy var lineLabel: UILabel = {
        let lineLabel = UILabel()
        lineLabel.backgroundColor = kGlobalLightGrayColor
        return lineLabel
    }()

    lazy var collectionView: UICollectionView = {

        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: ZZGoodsHeaderLayout())
        
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.contentInset = UIEdgeInsets.init(top: collectionViewTop, left: collectionViewLeft, bottom: collectionViewBottom, right: collectionViewRight)
        collectionView.registerReuseCellClass(ZZHomePromotionCollectionCellEight.self)
        return collectionView
    }()
    
    var dataSource: [ZZLittleBanner] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var article: ZZWorthyArticle? {
        didSet {
            if let article = article  {
                titleLabel.text = article.title
                if let rows = article.rows {
                    dataSource = rows
                    collectionView.reloadData()
                }
            }
        }
    }
    
    func initUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(lineLabel)
        contentView.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.contentView).offset(15)
        }
        lineLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self.contentView)
            make.height.equalTo(0.5)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(lineLabel.snp.bottom)
            make.left.right.bottom.equalTo(self.contentView)
        }
    }

}

extension ZZHomePromotionCellEight: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZZHomePromotionCollectionCellEight.self), for: indexPath) as! ZZHomePromotionCollectionCellEight
        collectionViewCell.littleBanener = dataSource[indexPath.item]
        return collectionViewCell
    }
}

extension ZZHomePromotionCellEight: UICollectionViewDelegate {
    
}

