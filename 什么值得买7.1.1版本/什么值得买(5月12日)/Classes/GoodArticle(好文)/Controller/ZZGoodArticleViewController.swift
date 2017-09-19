//
//  ZZGoodArticleViewController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/8/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit
import IGListKit
import SwiftyJSON

class ZZGoodArticleViewController: ZZBasecollectionViewController {
    lazy var listRequest: ZZGoodArticleListRequest = {
        let request = ZZGoodArticleListRequest()
        return request
    }()
    lazy var listMoreRequest: ZZGoodArticleListMoreRequest = {
        let request = ZZGoodArticleListMoreRequest()
        return request
    }()
    var goodArticleRecommendModel:ZZListModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.mj_header.beginRefreshing()
    }
}


extension ZZGoodArticleViewController {

    override func initUI() {
        super.initUI()
        weak var weakSelf = self
        collectionView.mj_header = ZZDIYHeader.init(refreshingBlock: { 
            weakSelf?.loadData(loadMoreData: false)
        })
        collectionView.mj_footer = ZZDIYBackFooter.init(refreshingBlock: { 
            weakSelf?.loadData(loadMoreData: true)
        })
    }
    
    override func loadData(loadMoreData: Bool) {
        weak var weakSelf = self
        if !loadMoreData {
            dataSource.removeAll()
            ZZAPPDotNetAPIClient.shared().get(listRequest) { (responseObj, error) in
                weakSelf?.collectionView.mj_header.endRefreshing()
                guard error == nil else { return }
                let json = JSON.init(responseObj!)
                if let topicList = json["topic_list"].arrayObject as? [[String : Any]] {
                    for dict in topicList {
                        let model = ZZHaoWenTopicListModel.model(with: dict)
                        model?.sectionController = ZZTopicListSectionController()
                        weakSelf?.dataSource.append(model!)
                    }
                }
                if let choicenessList = json["sns_choiceness_list"]["rows"].arrayObject {
                    if let choicenessListArray = NSArray.modelArray(with: ZZChoicenessListModel.self, json: choicenessList) {
                        weakSelf?.goodArticleRecommendModel = ZZListModel.init(subItems: choicenessListArray, sectionController: ZZChoicenessListSectionController())
                        weakSelf?.dataSource.append((weakSelf?.goodArticleRecommendModel)!)
                    }
                }
                weakSelf?.adapter.performUpdates(animated: true, completion: nil)
            }
            return
        }
        if let choicenessListModel = weakSelf?.goodArticleRecommendModel?.subItems.lastObject as? ZZChoicenessListModel {
            listMoreRequest.time_sort = choicenessListModel.time_sort
        }
        ZZAPPDotNetAPIClient.shared().get(listMoreRequest) { (responseObj, error) in
            weakSelf?.collectionView.mj_footer.endRefreshing()
            guard error == nil else { return }
            let json = JSON.init(responseObj!)
            if let rows = json["rows"].arrayObject {
                if let listArray = NSArray.modelArray(with: ZZChoicenessListModel.self, json: rows) {
                    weakSelf?.goodArticleRecommendModel?.subItems.addObjects(from: listArray)
                    weakSelf?.collectionView.reloadData()
                    weakSelf?.listMoreRequest.page += 1
                }
            }
        }
    }
    
}

extension ZZGoodArticleViewController {
    
}
