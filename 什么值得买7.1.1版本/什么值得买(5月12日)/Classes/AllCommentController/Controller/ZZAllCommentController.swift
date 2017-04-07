//
//  ZZAllCommentController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/3.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

private let kTableViewHeaderReuseID = "tableViewHeaderReuseID"
private let kCommentHeaderView = "kCommentHeaderView"
private let kCommentFooterView = "kCommentFooterView"

class ZZAllCommentController: ZZSecondTableViewController {

    
    var articleID: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "所有评论"
        
        tableView.register(ZZCommentCell.self, forCellReuseIdentifier: kTableViewHeaderReuseID)
        tableView.register(ZZCommentHeaderView.self, forHeaderFooterViewReuseIdentifier: kCommentHeaderView)
        tableView.register(ZZCommentFooterView.self, forHeaderFooterViewReuseIdentifier: kCommentFooterView)
        
        tableView.mj_header.beginRefreshing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print(tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func configureParameters() -> NSMutableDictionary{
        let parameters = NSMutableDictionary()
        parameters.setObject("20", forKey: "limit" as NSCopying)
        parameters.setObject(String(offset), forKey: "offset" as NSCopying)
        parameters.setObject("0", forKey: "atta" as NSCopying)
        parameters.setObject("new", forKey: "cate" as NSCopying)
        parameters.setObject("faxian", forKey: "type" as NSCopying)
        parameters.setObject("1", forKey: "get_total" as NSCopying)
        parameters.setObject("1", forKey: "ishot" as NSCopying)
        parameters.setObject("0", forKey: "smiles" as NSCopying)
        parameters.setObject(articleID!, forKey: "article_id" as NSCopying)
        return parameters
    }

}

extension ZZAllCommentController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let commentLayout = self.dataSource[section] as! ZZAllCommentLayout
        var commentLayouts = commentLayout.limitCommentLayouts
        
        if commentLayout.isUserClickHide {
            commentLayouts = commentLayout.allCommentLayouts
        }
        
        if let commentLayouts = commentLayouts {
            
            return commentLayouts.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewHeaderReuseID, for: indexPath) as! ZZCommentCell
        
        let commentLayout = self.dataSource[indexPath.section] as! ZZAllCommentLayout

        var commentLayouts = commentLayout.limitCommentLayouts
        
        if commentLayout.isUserClickHide {
            commentLayouts = commentLayout.allCommentLayouts
        }
    
        cell.commentLayout = commentLayouts?[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kCommentHeaderView) as! ZZCommentHeaderView
        let commentLayout = self.dataSource[section] as! ZZAllCommentLayout
        headerView.commentLayout = commentLayout
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kCommentFooterView) as! ZZCommentFooterView
        let commentLayout = self.dataSource[section] as! ZZAllCommentLayout
        footerView.commentLayout = commentLayout
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let commentLayout = self.dataSource[section] as! ZZAllCommentLayout
        
        return commentLayout.mainCommentViewHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let commentLayout = self.dataSource[indexPath.section] as! ZZAllCommentLayout
        
        var commentLayouts = commentLayout.limitCommentLayouts
        
        if commentLayout.isUserClickHide {
            commentLayouts = commentLayout.allCommentLayouts
        }
        
        let parentCommentLayout = commentLayouts?[indexPath.row]

        if let height = parentCommentLayout?.height {
            
            return height
        }
        
        return 0
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        return commentConstant.headerViewHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commentLayout = self.dataSource[indexPath.section] as! ZZAllCommentLayout
        
        if !commentLayout.isShouldHidden && indexPath.row == 2 {
            
            commentLayout.isUserClickHide = true
//            tableView.reloadSection(UInt(indexPath.section), with: .none)
            tableView.reloadData()

        }
    }
    
}

extension ZZAllCommentController{
    
    override func loadData() {
        
        offset = 0

        //        https://api.smzdm.com/v1/comments?article_id=6520669&atta=0&cate=new&f=iphone&get_total=1&ishot=1&limit=20&offset=0&smiles=0&type=faxian&v=7.3.3&weixin=1
        ZZAPPDotNetAPIClient.get("v1/comments", parameters: configureParameters()) { (responseObj, error) in
            
            if let _ = error{
                self.tableView.mj_header.endRefreshing()
                return
            }
            if let responseObj = responseObj as? [AnyHashable : Any]
            {
                
                let allComments = NSMutableArray()
    
                if let hotComments = responseObj["hot_comments"] as? [[AnyHashable : Any]]{

                    let commentLayouts = self.handleCommentLayouts(commentDicts: hotComments, isHotComment: true)
                    
                    allComments.addObjects(from: commentLayouts as! [Any])
                }
                
                if let rows = responseObj["rows"] as? [[AnyHashable : Any]]{
            
                    let commentLayouts = self.handleCommentLayouts(commentDicts: rows, isHotComment: false)
                    
                    allComments.addObjects(from: commentLayouts as! [Any])
                }
                
                
                self.dataSource = allComments
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
                
                self.offset = self.dataSource.count
            }
            
        }
    }
    
    
    override func loadMoreData() {
        
        ZZAPPDotNetAPIClient.get("v1/comments", parameters: configureParameters()) { (responseObj, error) in
            if let _ = error{
                self.tableView.mj_footer.endRefreshing()
                return
            }
            
            if let responseObj = responseObj as? [AnyHashable : Any]
            {
                
                // 上拉加载更多, 只需处理rows数据
                let allComments = NSMutableArray()
                
                if let rows = responseObj["rows"] as? [[AnyHashable : Any]]{
                    
                    let commentLayouts = self.handleCommentLayouts(commentDicts: rows, isHotComment: false)
                    
                    allComments.addObjects(from: commentLayouts as! [Any])
                }
 
                self.dataSource.addObjects(from: allComments.copy() as! [Any])
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
                
                self.offset = self.dataSource.count
            }
        }
        
    }
    
    func handleCommentLayouts(commentDicts: [[AnyHashable : Any]], isHotComment: Bool) -> NSArray {
        
        let commentLayouts = NSMutableArray()
        
        for commentDict in commentDicts {
            
            if let commentModel = ZZCommentModel.model(with: commentDict) {
                
                let commentLayout = ZZAllCommentLayout.init(commentModel: commentModel, isHotComment: isHotComment)
                commentLayouts.add(commentLayout)
                
            }
        }
        
        return commentLayouts.copy() as! NSArray
        
    }
    
}

extension ZZAllCommentController {
    override func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return #imageLiteral(resourceName: "error_nodata")
    }
}

