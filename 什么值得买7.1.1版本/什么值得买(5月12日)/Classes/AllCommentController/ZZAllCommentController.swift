//
//  ZZAllCommentController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/3.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit

class ZZAllCommentController: ZZFirstTableViewController {

    var offset: Int = 0
    var articleID: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        https://api.smzdm.com/v1/comments?article_id=6520669&atta=0&cate=new&f=iphone&get_total=1&ishot=1&limit=20&offset=0&smiles=0&type=faxian&v=7.3.3&weixin=1
        title = "所有评论"
        
//        ZZNetworking.get("", parameters: configureParameters(), complectionBlock: HttpComplectionBlcok)
        
//        ZZNetworking.get("/v1/comments", parameters: configureParameters(), complectionBlock: HttpComplectionBlcok)
    }

   
    func configureParameters() -> NSMutableDictionary{
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
