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
    }
    
    override func loadData(loadMoreData: Bool) {
        dataSource.removeAll()
        weak var weakSelf = self
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
                    let model = ZZListModel.init(subItems: choicenessListArray, sectionController: ZZChoicenessListSectionController())
                    weakSelf?.dataSource.append(model!)
                }
            }
            weakSelf?.adapter.performUpdates(animated: true, completion: nil)
        }
    }
    
}

extension ZZGoodArticleViewController {
    
}
