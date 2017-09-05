//
//  ZZSearchResultController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/5/11.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZSearchResultController: ZZSecondTableViewController {
    var searchModel: ZZSearchModel?
    lazy var searchRequest: ZZSearchRequest = {
        let request = ZZSearchRequest()
        return request
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initNavBar()
        setupDatasource()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ZZSearchResultController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZZListCell.reuseIdentifier(), for: indexPath) as! ZZListCell
        cell.article = dataSource[indexPath.row] as! ZZWorthyArticle
        return cell
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kScreenWidth / 3.0 + 20 + 2
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
}

extension ZZSearchResultController {
    override func initUI() {
        tableView.registerReuseCellNib(ZZListCell.self)
    }
    
    override func initNavBar() {
        
    }
}

extension ZZSearchResultController {
    override func loadData() {
        weak var weakSelf = self
        searchRequest.offset = 0
        ZZAPPDotNetAPIClient.shared().get(searchRequest) { (responseObj, error) in
            weakSelf?.tableView.mj_header.endRefreshing()
            if let responseObj = responseObj as? [AnyHashable: Any],
                let rows = responseObj["rows"],
                let listArray = NSArray.modelArray(with: ZZWorthyArticle.self, json: rows) {
                    weakSelf?.dataSource.removeAllObjects()
                    weakSelf?.dataSource.addObjects(from: listArray)
                    weakSelf?.searchRequest.offset = listArray.count
                    weakSelf?.tableView.reloadData()
            }
        }
    }
    
    override func loadMoreData() {
        weak var weakSelf = self
        ZZAPPDotNetAPIClient.shared().get(searchRequest) { (responseObj, error) in
            weakSelf?.tableView.mj_footer.endRefreshing()
            if let responseObj = responseObj as? [AnyHashable: Any],
                let rows = responseObj["rows"],
                let listArray = NSArray.modelArray(with: ZZWorthyArticle.self, json: rows) {
                    weakSelf?.dataSource.addObjects(from: listArray)
                    weakSelf?.searchRequest.offset = listArray.count + (weakSelf?.searchRequest.offset)!
                    weakSelf?.tableView.reloadData()
            }
        }
    }
    
    override func setupDatasource() {
        searchRequest.channelName = "综合"
        searchRequest.keyword = searchModel?.title
        searchRequest.localtype = "home"
        searchRequest.order = "score"
        searchRequest.type = "home"

    }

}
