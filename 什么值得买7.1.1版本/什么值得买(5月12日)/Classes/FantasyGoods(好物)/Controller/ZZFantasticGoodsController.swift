//
//  ZZFantasticGoodsController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/19.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit


private let collectionViewHeaderReuseID = "collectionViewHeaderReuseID"
private let collectionViewHeight: CGFloat = 100
private let goodsHeaderItemCount: CGFloat = 4
private let collectionViewTop: CGFloat = 19
private let collectionViewLeft: CGFloat = 10
private let collectionViewRight: CGFloat = 10
private let collectionViewBottom: CGFloat = 15


private let haowuCellOne = "ZZHaoWuCellOne"
private let haowuCellThree = "ZZHaoWuCellThree"

class ZZGoodsHeaderLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 15
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ZZGoodsHeaderCell.self, forCellWithReuseIdentifier: collectionViewHeaderReuseID)
        collectionView.contentInset = UIEdgeInsets.init(top: collectionViewTop, left: collectionViewLeft, bottom: collectionViewBottom, right: collectionViewRight)
        return collectionView
    }()
    
    
    var optionalValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeHolderLabel.text = "相机"
        
        self.tableViewColor = kGlobalLightGrayColor
        tableView.tableHeaderView = collectionView
        
        tableView.register(ZZHaoWuCellOne.self, forCellReuseIdentifier: haowuCellOne)
        tableView.register(ZZHaoWuCellThree.self, forCellReuseIdentifier: haowuCellThree)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - tableView数据源
extension ZZFantasticGoodsController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let haowuLayout = self.dataSource[indexPath.row] as! ZZHaoWuLayout
        
        var reuseIdentifier: String
        
        switch haowuLayout.itemType!
        {
            case .one:
                reuseIdentifier = haowuCellOne
                
            case .three:
                reuseIdentifier = haowuCellThree
        }
        
        let haowuCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ZZHaoWuBaseCell
        
        haowuCell.haowuLayout = haowuLayout
        haowuCell.delegate = self
        haowuCell.indexPathRow = indexPath.row
        return haowuCell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let haowuLayout = self.dataSource[indexPath.row] as! ZZHaoWuLayout
        
        return haowuLayout.rowHeight!
    }
    
    
}

//MARK: - collectionView数据源
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



//MARK: - 上下拉
extension ZZFantasticGoodsController{
    override func loadData() {
        
        offset = 0
        
        //        http://api.smzdm.com/v1/haowu/haowu_category?f=iphone&v=7.3&weixin=1
        ZZAPPDotNetAPIClient.get("v1/haowu/haowu_category", parameters: NSMutableDictionary()) { (responseObj, error) in
            if let _ = error {}
            if let response = responseObj{
                self.headerDataArray = NSArray.modelArray(with: ZZGoodsHeaderModel.self, json: response)! as! [ZZGoodsHeaderModel]
                self.collectionView.reloadData()
            }
        }
        
        //        http://api.smzdm.com/v1/haowu/haowu_topic_list/?f=iphone&limit=20&offset=0&v=7.3&weixin=1
        
        
        
        
        ZZAPPDotNetAPIClient.get("v1/haowu/haowu_topic_list/", parameters: configureParameters()) { (responseObj, error) in
            
            if let _ = error {
                
                self.tableView.mj_header.endRefreshing()
                return
            }
            if let response = responseObj as? [[AnyHashable: Any]]{
                
                let haoWuLayoutArray: NSMutableArray = NSMutableArray()
                for goodsDict in response {
                    if let fantasicGoodsModel = ZZFantasticGoodsModel.model(with: goodsDict) {
                        let haowuLayout = ZZHaoWuLayout.init(fantasicGoodsModel: fantasicGoodsModel)
                        
                        haoWuLayoutArray.add(haowuLayout)
                    }
                    
                }
                
                if haoWuLayoutArray.count > 0 {
                    
                    self.dataSource = haoWuLayoutArray
                    self.tableView.reloadData()
                }
                self.tableView.mj_header.endRefreshing()

            }
        }
        
    }
    
    
    override func loadMoreData() {
        
        self.offset = self.dataSource.count;
        
        ZZAPPDotNetAPIClient.get("v1/haowu/haowu_topic_list/", parameters: configureParameters()) { (responseObj, error) in
            
            if let _ = error {
                
                self.tableView.mj_footer.endRefreshing()
                return
            }
            if let response = responseObj as? [[AnyHashable: Any]]{
                let haoWuLayoutArray: NSMutableArray = NSMutableArray()
                for goodsDict in response {
                    if let fantasicGoodsModel = ZZFantasticGoodsModel.model(with: goodsDict) {
                        let haowuLayout = ZZHaoWuLayout.init(fantasicGoodsModel: fantasicGoodsModel)
                        
                        haoWuLayoutArray.add(haowuLayout)
                    }

                }
                if haoWuLayoutArray.count > 0 {
                    
                    let haoWuLayouts = haoWuLayoutArray.copy() as! [Any]
                    
                    self.dataSource.addObjects(from: haoWuLayouts)
                    
                    self.tableView.reloadData()
                    self.tableView.mj_footer.endRefreshing()
                    
                }else{
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
                
            }
            
        }
    }
    
    
    func configureParameters() -> NSMutableDictionary{
        let parameters = NSMutableDictionary()
        parameters.setObject("20", forKey: "limit" as NSCopying)
        parameters.setObject(String(offset), forKey: "offset" as NSCopying)
        return parameters
        
    }
}


//MARK: - collectionView代理方法
extension ZZFantasticGoodsController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - ZZHaoWuItemDelegate代理方法
extension ZZFantasticGoodsController: ZZHaoWuItemDelegate{
    
    func haoWuItemDidClick(in haoWuCell: ZZHaoWuBaseCell, subItemModel: ZZGoodsSubItemModel) {
        let haowuLayout = haoWuCell.haowuLayout
        
        switch haowuLayout!.itemType!
        {
        case .one:
//            http://api.smzdm.com/v1/haowu/haowu_pro_detail/
//            f=iphone&pro_id=2427994&source_id=486C2009-E0C4-4483-9D37-350C278833D6&token=YTM4MjN8MTQ4MDM5MDMyMnw3NzY4MDY2MDk2fDFiNWQ1YzVhYWVmNTQ3NjM2NmQ1NGI2OGVjNzNjNDNh&v=7.4.1&weixin=1
            
//            let detailTopicVc = ZZDetailTopicViewController()
//            detailTopicVc.channelID = 14
//            detailTopicVc.article_id = subItemModel.redirect_data?.link_val
//            navigationController?.pushViewController(detailTopicVc, animated: true)
            break
        case .three:
            let detailTopicVc = ZZDetailTopicViewController()
            detailTopicVc.channelID = 14
            detailTopicVc.article_id = subItemModel.redirect_data?.link_val
            navigationController?.pushViewController(detailTopicVc, animated: true)
        }
    }

}

