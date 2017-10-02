//
//  UIViewController+Jump.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/1.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//  控制器逻辑跳转


import UIKit

extension UIViewController {
    
    func jumpToDetailArticleViewController(redirectdata: ZZRedirectData) {
        let linkType = redirectdata.link_type;
        
        guard let model = ZZJumpToNextModel.init(linkType: linkType) else { return }
        
        guard let classStringName = NSClassFromString(model.destionationController) as? UIViewController.Type else {
            return
        }
        let destinationVc = classStringName.init()
        
        if destinationVc.isKind(of: ZZDetailArticleViewController.self) {
            
            let detailArticleVc = destinationVc as! ZZDetailArticleViewController
            detailArticleVc.channelID = model.channelID
            detailArticleVc.article_id = redirectdata.link_val
            detailArticleVc.title = model.title;
            navigationController?.pushViewController(detailArticleVc, animated: true)
        }else if destinationVc.isKind(of: ZZDetailTopicViewController.self){
            let detailTopicVc = destinationVc as! ZZDetailTopicViewController
            detailTopicVc.channelID = model.channelID
            detailTopicVc.article_id = redirectdata.link_val
            detailTopicVc.title = model.title;
            navigationController?.pushViewController(detailTopicVc, animated: true)
        }else if destinationVc.isKind(of: ZZPureWebViewController.self){
            let webViewController = destinationVc as! ZZPureWebViewController
            webViewController.redirectdata = redirectdata
            navigationController?.pushViewController(webViewController, animated: true)
            
        }
    }
    
    func jumpToDetailArticleViewController(article: ZZWorthyArticle) {
        
        let channelID = article.article_channel_id
        guard let model = ZZJumpToNextModel.init(channelID: channelID) else { return }
        let articleId = article.article_id
        if channelID == 14 {
            let detailTopicVc = ZZDetailTopicViewController()
            detailTopicVc.channelID = channelID
            detailTopicVc.article_id = articleId;
            detailTopicVc.title = model.title;
            navigationController?.pushViewController(detailTopicVc, animated: true)
            return
        }
        
        let detailArticleVc = ZZDetailArticleViewController()
        detailArticleVc.channelID = channelID;
        detailArticleVc.article_id = articleId;
        detailArticleVc.title = model.title;
        navigationController?.pushViewController(detailArticleVc, animated: true)
        
        
        if article.tag == "广告" {
            let webViewController = ZZPureWebViewController()
            webViewController.redirectdata = article.redirect_data
            navigationController?.pushViewController(webViewController, animated: true)
            return
        }
    }
    
    
    func jumpToShareViewController(parameters: NSMutableDictionary) {
        
        let shareVc = ZZShareViewController()
        
        shareVc.modalPresentationStyle = .custom
        shareVc.transitioningDelegate = self
        shareVc.shareParams = parameters
        self.present(shareVc, animated: true, completion: nil)
        
    }
}

extension UIViewController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return ZZPopPresentAnimation()
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return ZZPopDimissAnimation()
    }
    
}
