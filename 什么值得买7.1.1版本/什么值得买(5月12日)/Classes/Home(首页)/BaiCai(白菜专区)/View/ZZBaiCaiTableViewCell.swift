//
//  ZZBaiCaiTableViewCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/29.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit


class ZZBaiCaiTableViewCell: UITableViewCell {
    
    lazy var baiCaiCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = baiCaiConstant.itemMargin
        flowLayout.minimumInteritemSpacing = baiCaiConstant.itemMargin
        flowLayout.itemSize = CGSize.init(width: baiCaiConstant.itemWidth2, height: baiCaiConstant.itemHeight2)
        let baiCaiCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        baiCaiCollectionView.backgroundColor = kGlobalLightGrayColor
        baiCaiCollectionView.delegate = self
        baiCaiCollectionView.dataSource = self
        baiCaiCollectionView.register(UINib.init(nibName: "ZZBaiCaiNewestCell", bundle: nil), forCellWithReuseIdentifier: "ZZBaiCaiNewestCell")
        baiCaiCollectionView.isScrollEnabled = false
        return baiCaiCollectionView
    }()

    var dataSource:NSMutableArray?{
        
        didSet{
            
            if let dataSource = dataSource {
                
                let count1 = dataSource.count / baiCaiConstant.rowCount
                let count2 = dataSource.count % baiCaiConstant.rowCount
                let count = count1 + count2
                baiCaiCollectionView.height = baiCaiConstant.itemMargin + (baiCaiConstant.itemMargin + baiCaiConstant.itemHeight2) * CGFloat(count)
                baiCaiCollectionView.reloadData()
            }
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(baiCaiCollectionView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        baiCaiCollectionView.width = width
    }
    
}


extension ZZBaiCaiTableViewCell: UICollectionViewDelegate{
    
}


extension ZZBaiCaiTableViewCell: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let dataSource = dataSource {
            
            return dataSource.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZZBaiCaiNewestCell", for: indexPath) as! ZZBaiCaiNewestCell
        
        let worthyArticle = self.dataSource?[indexPath.item] as! ZZWorthyArticle
        
        cell.worthyArticle = worthyArticle
        
        return cell
        
    }
}
