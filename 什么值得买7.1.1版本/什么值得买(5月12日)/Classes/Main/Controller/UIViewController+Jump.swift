//
//  UIViewController+Jump.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/1.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//
import UIKit

extension UIViewController{
    
    func jumpToDetailArticleViewController(redirectdata: ZZRedirectData){
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
    }
    
//    ZZWorthyArticle *article = self.dataArrayM[indexPath.row];
//    NSInteger channelID = [article.article_channel_id integerValue];
//    NSString *articleId = article.article_id;
//    
//    ZZJumpToNextModel *model = [ZZJumpToNextModel modelWithChannelID:channelID];
//    if (channelID == 14) {
//    ZZDetailTopicViewController *detailTopicVc = [[ZZDetailTopicViewController alloc] init];
//    detailTopicVc.channelID = channelID;
//    detailTopicVc.article_id = articleId;
//    detailTopicVc.title = model.title;
//    [self.navigationController pushViewController:detailTopicVc animated:YES];
//    return;
//    }
//    if ([article.tag isEqualToString:@"广告"]) {
//    ZZPureWebViewController *webViewController = [[ZZPureWebViewController alloc] init];
//    webViewController.redirectdata = article.redirect_data;
//    [self.navigationController pushViewController:webViewController animated:YES];
//    
//    return;
//    }
//    
//    ZZDetailArticleViewController *detailArticleVc = [ZZDetailArticleViewController new];
//    detailArticleVc.channelID = channelID;
//    detailArticleVc.article_id = articleId;
//    detailArticleVc.title = model.title;
//    [self.navigationController pushViewController:detailArticleVc animated:YES];
    
    func jumpToDetailArticleViewController(article: ZZWorthyArticle){
        
        guard let channelID = (Int)(article.article_channel_id!) else { return }
        
        let articleId = article.article_id

        guard let model = ZZJumpToNextModel.init(channelID: channelID) else { return }
        
        if channelID == 14 {
            let detailTopicVc = ZZDetailTopicViewController()
            detailTopicVc.channelID = channelID
            detailTopicVc.article_id = articleId;
            detailTopicVc.title = model.title;
            navigationController?.pushViewController(detailTopicVc, animated: true)
            return
        }
    
        
        if article.tag == "广告" {
            let webViewController = ZZPureWebViewController()
            webViewController.redirectdata = article.redirect_data
            navigationController?.pushViewController(webViewController, animated: true)
            return
        }
        
        let detailArticleVc = ZZDetailArticleViewController()
        detailArticleVc.channelID = channelID;
        detailArticleVc.article_id = articleId;
        detailArticleVc.title = model.title;
        navigationController?.pushViewController(detailArticleVc, animated: true)

    }
}
