//
//  ZZFantasticGoodsController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/19.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit


private let collectionViewHeaderReuseID = "collectionViewHeaderReuseID"
private let collectionViewHeight: CGFloat = 120
private let goodsHeaderItemCount: CGFloat = 4
private let collectionViewMargin1: CGFloat = 30
private let collectionViewMargin2: CGFloat = 20

class ZZGoodsHeaderLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 0
        minimumInteritemSpacing = collectionViewMargin2
        let itemWidth = ((collectionView?.width)! - (collectionView?.contentInset.left)! - (collectionView?.contentInset.right)! - (goodsHeaderItemCount - 1) * minimumInteritemSpacing ) / goodsHeaderItemCount
        
        let itemHeight = (collectionView?.height)! - (collectionView?.contentInset.top)! - (collectionView?.contentInset.bottom)!
        
        itemSize = CGSize.init(width: itemWidth, height: itemHeight)
    }
}


class ZZFantasticGoodsController: ZZFirstTableViewController {
    
    var headerDataArray: [ZZGoodsHeaderModel] = []
    
    
    lazy var collectionView: UICollectionView = {
    
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.view.width, height: collectionViewHeight), collectionViewLayout: ZZGoodsHeaderLayout())
        
        collectionView.backgroundColor = UIColor.white
//        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ZZGoodsHeaderCell.self, forCellWithReuseIdentifier: collectionViewHeaderReuseID)
        collectionView.contentInset = UIEdgeInsets.init(top: collectionViewMargin1, left: collectionViewMargin1, bottom: collectionViewMargin2, right: collectionViewMargin1)
        return collectionView
    }()
    
    
    var optionalValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = collectionView
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    override  func loadData() {
        
//        http://api.smzdm.com/v1/haowu/haowu_category?f=iphone&v=7.3&weixin=1
        ZZNetworking.get("v1/haowu/haowu_category", parameters: NSMutableDictionary()) { (responseObj, error) in
            
            if let response = responseObj{
                self.headerDataArray = NSArray.modelArray(with: ZZGoodsHeaderModel.self, json: response)! as! [ZZGoodsHeaderModel]
            }

            self.collectionView.reloadData()
            
            self.tableView.mj_header.endRefreshing()
        }
        

        
//        http://api.smzdm.com/v1/haowu/haowu_topic_list/?f=iphone&limit=20&offset=0&v=7.3&weixin=1
        
        let parameters = NSMutableDictionary()
        parameters.setObject("0", forKey: "offset" as NSCopying)
        parameters.setObject("20", forKey: "limit" as NSCopying)
        
        ZZNetworking.get("v1/haowu/haowu_topic_list/", parameters: parameters) { (responseObj, error) in
        
            if let response = responseObj {
                
                let dataArray = NSArray.modelArray(with: ZZFantasticGoodsModel.self, json: response)
                
                
                self.dataSource = NSMutableArray.init(array: dataArray!)
                
            }
        }
        
    }
}

extension ZZFantasticGoodsController:UICollectionViewDataSource{


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return headerDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewHeaderReuseID, for: indexPath) as! ZZGoodsHeaderCell
        
        cell.goodsHeaderModel = headerDataArray[indexPath.item]
        return cell
    }
    
}
