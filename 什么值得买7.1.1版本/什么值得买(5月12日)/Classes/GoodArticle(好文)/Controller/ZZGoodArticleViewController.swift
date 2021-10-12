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
    fileprivate var listRequest = ZZGoodArticleListRequest()
    fileprivate var listMoreRequest = ZZGoodArticleListMoreRequest()
    fileprivate let bannerRequest = ZZGoodArticleBannerRequest()
    fileprivate var goodArticleRecommendModel:ZZListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initNavBar()
        setupDataSource()
    }
    
    override func initUI() {
        weak var weakSelf = self
        collectionView.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-kZZTabBarH)
        }
        collectionView.mj_header = ZZDIYHeader.init(refreshingBlock: {
            weakSelf?.loadData(loadMoreData: false)
        })
        collectionView.mj_footer = ZZDIYBackFooter.init(refreshingBlock: {
            weakSelf?.loadData(loadMoreData: true)
        })
    }
    
    override func setupDataSource() {
        collectionView.mj_header?.beginRefreshing()
    }
    
    override func loadData(loadMoreData: Bool) {
        weak var weakSelf = self
        if !loadMoreData {
            dataSource.removeAll()
            ZZAPPDotNetAPIClient.shared().get(bannerRequest, completionBlock: { (responseObj, error) in
                guard error == nil else { return }
                let json = JSON.init(responseObj!)
                if let rows = json["rows"].arrayObject {
                    if let datas = NSArray.yy_modelArray(with: ZZLittleBanner.self, json: rows) {
                        let listModel = ZZListModel.init(subItems: datas, sectionController: ZZAdSectionController())
                        weakSelf?.dataSource.append(listModel!)
                    }
                }
                if let rows = json["little_banner"].arrayObject {
                    if let datas = NSArray.yy_modelArray(with: ZZLittleBanner.self, json: rows) {
                        let listModel = ZZListModel.init(subItems: datas, sectionController: ZZLittleBannerSectionController())
                        weakSelf?.dataSource.append(listModel!)
                    }
                }
                
            })
            ZZAPPDotNetAPIClient.shared().get(listRequest) { (responseObj, error) in
                weakSelf?.collectionView.mj_header?.endRefreshing()
                guard error == nil else { return }
                let json = JSON.init(responseObj!)
                if let topicList = json["topic_list"].arrayObject as? [[String : Any]] {
                    for dict in topicList {
                        let model = ZZHaoWenTopicListModel.yy_model(with: dict)
                        model?.sectionController = ZZTopicListSectionController()
                        weakSelf?.dataSource.append(model!)
                    }
                }
                if let choicenessList = json["sns_choiceness_list"]["rows"].arrayObject {
                    if let choicenessListArray = NSArray.yy_modelArray(with: ZZChoicenessListModel.self, json: choicenessList) {
                        let listModel =  ZZListModel.init(subItems: choicenessListArray, sectionController: ZZChoicenessListSectionController())
                        weakSelf?.goodArticleRecommendModel = listModel
                        weakSelf?.dataSource.append(listModel!)
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
            weakSelf?.collectionView.mj_footer?.endRefreshing()
            guard error == nil else { return }
            let json = JSON.init(responseObj!)
            if let rows = json["rows"].arrayObject {
                if let listArray = NSArray.yy_modelArray(with: ZZChoicenessListModel.self, json: rows) {
                    weakSelf?.goodArticleRecommendModel?.subItems.addObjects(from: listArray)
                    weakSelf?.collectionView.reloadData()
                    weakSelf?.listMoreRequest.page += 1
                }
            }
        }
    }
}
