//
//  UIViewController+Jump.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/1.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//
import UIKit

extension UIViewController{
    
    func jumpToDetailArticleViewControllerWithRedirectdata(redirectdata: ZZRedirectData){
        let linkType = redirectdata.link_type;
        
        
        if let model = ZZJumpToNextModel.init(linkType: linkType) {
            
            guard let classStringName = NSClassFromString(model.destionationController) as? UIViewController.Type else {
                return
            }

            let destinationVc = classStringName.init()
            
            if destinationVc.isKind(of: ZZDetailArticleViewController.self) {
                
                let detailArticleVc = destinationVc as! ZZDetailArticleViewController
                detailArticleVc.channelID = model.channelID
                detailArticleVc.article_id = redirectdata.link_val
                navigationController?.pushViewController(detailArticleVc, animated: true)
            }else if destinationVc.isKind(of: ZZDetailTopicViewController.self){
                let detailTopicVc = destinationVc as! ZZDetailTopicViewController
                detailTopicVc.channelID = model.channelID
                detailTopicVc.article_id = redirectdata.link_val
                navigationController?.pushViewController(detailTopicVc, animated: true)
            }else if destinationVc.isKind(of: ZZPureWebViewController.self){
                let webViewController = destinationVc as! ZZPureWebViewController
                webViewController.redirectdata = redirectdata
                navigationController?.pushViewController(webViewController, animated: true)
                
            }
        }
    }
}
