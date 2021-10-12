//
//  ZZBaiCaiTableViewCell.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/29.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

@objc protocol ZZJumpToNextControllerDelegate: NSObjectProtocol {//控制器跳转协议
    
    @objc optional func jumpToNextController(redirectData: ZZRedirectData)
}

@objc protocol ZZBaiCaiTableViewCellDelegate: NSObjectProtocol {
    
    @objc optional func baiCaiNewestItemDidClick(baiCaiCell: ZZBaiCaiTableViewCell, index: NSInteger)
}

class ZZBaiCaiTableViewCell: UITableViewCell {
    
    weak var delegate: ZZBaiCaiTableViewCellDelegate?
    
    lazy var baiCaiCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = baiCaiConstant.itemMargin
        flowLayout.minimumInteritemSpacing = baiCaiConstant.itemMargin
        flowLayout.itemSize = CGSize.init(width: baiCaiConstant.itemWidth2, height: baiCaiConstant.itemHeight2)
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: baiCaiConstant.itemMargin, bottom: baiCaiConstant.itemMargin, right: baiCaiConstant.itemMargin)
        let baiCaiCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        baiCaiCollectionView.backgroundColor = kGlobalLightGrayColor
        baiCaiCollectionView.delegate = self
        baiCaiCollectionView.dataSource = self
        baiCaiCollectionView.register(UINib.init(nibName: "ZZBaiCaiNewestCell", bundle: nil), forCellWithReuseIdentifier: "ZZBaiCaiNewestCell")
        return baiCaiCollectionView
    }()
    
    var dataSource:NSMutableArray? {
        didSet {
            guard let dataSource = dataSource else { return }
            let count1 = dataSource.count / baiCaiConstant.rowCount
            let count2 = dataSource.count % baiCaiConstant.rowCount
            let count = count1 + count2
            baiCaiCollectionView.height = baiCaiConstant.itemMargin + (baiCaiConstant.itemMargin + baiCaiConstant.itemHeight2) * CGFloat(count)
            baiCaiCollectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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


extension ZZBaiCaiTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.baiCaiNewestItemDidClick?(baiCaiCell: self, index: indexPath.row)
    }
}


extension ZZBaiCaiTableViewCell: UICollectionViewDataSource {
    
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
